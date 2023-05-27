Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF67130D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 02:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjE0AQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 20:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjE0AQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 20:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103EBA4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0DE165485
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFCFC433EF;
        Sat, 27 May 2023 00:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685146585;
        bh=uXodg+c3MWiGRK02PSAnRVOXRm4oRfT1pXHIZJVJ+YQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FYk+F9+TuWHM4rZFehuwIX29NzUWcD0U2on3qFWAUeRR1fWHNbvdGFsfF+Nhs49z7
         f20gZxGYHv65j5LqrQ3zpR/75dWEjSCOXxGXRRED5bJPw16nTEt2ORsE2fyKGkcp/U
         MUsb/6u/N9dAV51tfCuU9TVDvNYyfvKzp6hrRmXqDwuh1w35BW38QDdoefNie+TOUO
         ixMYeJeEYZ4t6XKPeQaJQJvC7pND/lGVvw4BaO+EFyMTQXUSk2DAnCh7Cffth0vnP+
         GY4IAlnZ5ceYiUZPM62KnG7w3oodInwSbctiHmAnIaj8b8zvCZcfVig2n8w1jeQfrd
         sJraVXQKvyOUg==
Message-ID: <49d9db82-5400-48a6-e578-36567620332a@kernel.org>
Date:   Sat, 27 May 2023 08:16:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] f2fs: fix to set noatime and immutable flag for quota
 file
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230525082508.2320763-1-chao@kernel.org>
 <ZHDmv2hLR9WZ16Pl@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZHDmv2hLR9WZ16Pl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/27 1:05, Jaegeuk Kim wrote:
> On 05/25, Chao Yu wrote:
>> We should set noatime bit for quota files, since no one cares about
>> atime of quota file, and we should set immutalbe bit as well, due to
>> nobody should write to the file through exported interfaces.
>>
>> Meanwhile this patch use inode_lock to avoid race condition during
>> inode->i_flags, f2fs_inode->i_flags update.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - fix to detect i_flags status correctly.
>>   fs/f2fs/super.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 51812f459581..1cf84c993d7c 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2763,7 +2763,17 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
>>   	}
>>   
>>   	/* Don't account quota for quota files to avoid recursion */
>> +	inode_lock(qf_inode);
>>   	qf_inode->i_flags |= S_NOQUOTA;
>> +
>> +	if (!(F2FS_I(qf_inode)->i_flags & F2FS_NOATIME_FL) ||
>> +		!(F2FS_I(qf_inode)->i_flags & F2FS_IMMUTABLE_FL)) {
> 
> What about this?
> 
> if ((F2FS_I(qf_inode)->i_flags & qf_flag) != qf_flag)

Ah, better, and updated in v3.

Thanks,

> 
>> +		F2FS_I(qf_inode)->i_flags |=
>> +				F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
>> +		f2fs_set_inode_flags(qf_inode);
>> +	}
>> +	inode_unlock(qf_inode);
>> +
>>   	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
>>   	iput(qf_inode);
>>   	return err;
>> -- 
>> 2.40.1
