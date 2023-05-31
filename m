Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35817172E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjEaBMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjEaBL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC110A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC69635CB
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914ACC433EF;
        Wed, 31 May 2023 01:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685495517;
        bh=L7vmx3k0L13foFTSG6sEEgottZQqCjEMpZkj1eF386o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jCfFDcy2akosC8dx+YAE2JeEp6yeHUc7Lo0BUN1lTvlkjThF7cqXLN4b4i3zC4M6Q
         MjI1BzbWTnMwgcjheCZdTsaGm+EhRLy0TjTbXcKeNs4UZ9u6mYL8uSW8AO9mgCa6KY
         91Og4Is0D88RLZh1vy7mrNHpn74gPH9JTERMwmoOlDe2/x5tvFjfmIxpuyi0q8bWnl
         ZJSyUPI4/CWSX5AXAdKXYCJf4O5noJ6LwZ/cG2lbSsxUG8X7F6+rkNlSu92I/9KJrj
         lbzsFPuCMOJWZD7SZWjuu+k/X6mYbVyzFLsZiFtD4lVvTHuUGVudBW2w249z/Rt9TT
         xY1YiZ3XJKdsA==
Message-ID: <9f2948cb-a4b0-bced-1d11-cf9fc712ba9b@kernel.org>
Date:   Wed, 31 May 2023 09:11:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Wu Bo <bo.wu@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <20230530012118.74228-1-bo.wu@vivo.com>
 <ZHaHknKmSQIdQzBC@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZHaHknKmSQIdQzBC@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/31 7:32, Jaegeuk Kim wrote:
> On 05/30, Wu Bo wrote:
>> The NULL return of 'd_splice_alias' dosen't mean error. Thus the
>> successful case will also return NULL, which makes the tracepoint always
>> print 'err=-ENOENT'.
>>
>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>> ---
>>   fs/f2fs/namei.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 77a71276ecb1..0c5e4c424eab 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -576,8 +576,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>>   	}
>>   #endif
>>   	new = d_splice_alias(inode, dentry);
>> -	err = PTR_ERR_OR_ZERO(new);
>> -	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
>> +	if (IS_ERR(new))
>> +		err = PTR_ERR(new);
>> +	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);
> 
> Again, new can be an error pointer, and the previous err was supposed to be
> zero or -ENOENT.
> 
> case 1) dentry exists: err (0) with new (NULL) --> dentry, err=0
> case 2) dentry exists: err (0) with new (VALID) --> new, err=0
> case 3) dentry exists: err (0) with new (ERR) --> dentry, err=ERR
> case 4) no dentry exists: err (-ENOENT) with new (NULL) --> dentry, err=-ENOENT
> case 4) no dentry exists: err (-ENOENT) with new (VALID) --> new, err=-ENOENT
> case 5) no dentry exists: err (-ENOENT) with new (ERR) --> dentry, err=ERR
> 
> 	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
> 				ino, IS_ERR(new) ? PTR_ERR(new) : err);

Agreed, could you please add above description in commit message?

Thanks,

> 
> 
>>   	return new;
>>   out_iput:
>>   	iput(inode);
>> -- 
>> 2.35.3
