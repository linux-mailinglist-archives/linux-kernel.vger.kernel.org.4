Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E318713112
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbjE0BBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0BBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:01:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94FB135
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E5F61226
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC40C433D2;
        Sat, 27 May 2023 01:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149304;
        bh=nag5934esDPVXTyIbFFm2NHW+4RouxV1DOgNY/Z5Oi8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rftd8zu3MmsgHSfYm4E/Qwaqf6OlsnC3mIHgRpjPddRQc2xWF81G7s7+X6Ebb/qRw
         Nnpp61F7BF+R7PKHvl6Ri9pmvZSGVoPpjrvOP4Cl5jX4lyTKzXaXuMd+HNMN+z2AGU
         jBp3UTFIIe2+hbtHLk9EV8Xi4F4msJRsnVmB4EaTgXGtuxs1t3oBqjG8vLC8EDYCET
         T5VxpDf9LWzOZaubA+kx7Drt3R1uawePFV5jpP6TrS2qRqjFMoFoCM80RTlxZKKbOo
         u98XOgG2jzKsV+Y1meganojDSmAOjk6gw0WB29wOtfsVRlzoVfaK3hJETXTh5BGARd
         svFnJ0Mbl3erg==
Message-ID: <2bb05623-9438-3b68-6ac8-4294f9676ff6@kernel.org>
Date:   Sat, 27 May 2023 09:01:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Wu Bo <bo.wu@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <20230524100812.80741-1-bo.wu@vivo.com>
 <ZHDqhy4E9iSnneLa@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZHDqhy4E9iSnneLa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/27 1:21, Jaegeuk Kim wrote:
> On 05/24, Wu Bo wrote:
>> The NULL return of 'd_splice_alias' dosen't mean error.
>>
>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>> ---
>>   fs/f2fs/namei.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 77a71276ecb1..e5a3e39ce90c 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -577,7 +577,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>>   #endif
>>   	new = c(inode, dentry);
>>   	err = PTR_ERR_OR_ZERO(new);
>> -	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
>> +	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);
> 
> Shouldn't give an error pointer to the dentry field.
> 
> How about just giving the err?
> 
> -       err = PTR_ERR_OR_ZERO(new);
> -       trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
> +       trace_f2fs_lookup_end(dir, dentry, ino, PTR_ERR_OR_ZERO(new));

static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
{
	if (IS_ERR(ptr))
		return PTR_ERR(ptr);
	else
		return 0;
}

For below two cases, PTR_ERR_OR_ZERO(new) will return zero:
a) f2fs_lookup found existed dentry
b) f2fs_lookup didn't find existed dentry (-ENOENT case)

So in below commit, I passed -ENOENT to tracepoint for case b), so we can
distinguish result of f2fs_lookup in tracepoint, actually, -ENOENT is expected
value when we create a new file/directory.

Commit 84597b1f9b05 ("f2fs: fix wrong value of tracepoint parameter")

> 
> 
>>   	return new;
>>   out_iput:
>>   	iput(inode);
>> -- 
>> 2.35.3
