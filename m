Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2357147D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjE2KTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2KSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:18:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB84F1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBDBB61362
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12796C433EF;
        Mon, 29 May 2023 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685355527;
        bh=RkkExfeGgE+dhRU4IGRx6ehNzHPNh6PhoYcLpUyFzMI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EBu2mW4E1yMU8iIDd4Lsgo3CNSYIPG4uTB/mjzlxd2YqoaGca4QM+mdVQ/qTNc/vF
         cWUAaT0p7TiBZkLpAnoXjTeePD16OC1NU32Q2lnnOnrGAU1ZtpGb/vLR4Ic2j/HeBC
         iIjYaeOzE+mj3C69hZB8e+Q2KscKbLuw+XJQUoEP6NUflbUdLXnCuxL+AbQYeDsy4T
         /+9j4eS+H4Kio8/TAVCSwgj9g5K5b4fEN3uTJ2E3ATnThp43OByH8ujoYHRIsYmYep
         10Mle5BiZoD+tFRMmkCqnEnJ2suCWRq01NYGj5NuIfsA/YWMepSyjK5HzGm8rta0GT
         RIC3Va/1Vlnig==
Message-ID: <0c15c662-903c-3504-d502-72f0a3b70cbf@kernel.org>
Date:   Mon, 29 May 2023 18:18:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: fix args passed to
 trace_f2fs_lookup_end
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <2bb05623-9438-3b68-6ac8-4294f9676ff6@kernel.org>
 <20230529041337.36741-1-bo.wu@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230529041337.36741-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/29 12:13, Wu Bo wrote:
> On Sat, May 27, 2023 at 09:01:41AM +0800, Chao Yu wrote:
>> On 2023/5/27 1:21, Jaegeuk Kim wrote:
>>> On 05/24, Wu Bo wrote:
>>>> The NULL return of 'd_splice_alias' dosen't mean error.
>>>>
>>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>>> ---
>>>>    fs/f2fs/namei.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>>> index 77a71276ecb1..e5a3e39ce90c 100644
>>>> --- a/fs/f2fs/namei.c
>>>> +++ b/fs/f2fs/namei.c
>>>> @@ -577,7 +577,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>>>>    #endif
>>>>    	new = c(inode, dentry);
>>>>    	err = PTR_ERR_OR_ZERO(new);
>>>> -	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
>>>> +	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);
>>>
>>> Shouldn't give an error pointer to the dentry field.
>>>
>>> How about just giving the err?
>>>
>>> -       err = PTR_ERR_OR_ZERO(new);
>>> -       trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
>>> +       trace_f2fs_lookup_end(dir, dentry, ino, PTR_ERR_OR_ZERO(new));
>>
>> static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
>> {
>> 	if (IS_ERR(ptr))
>> 		return PTR_ERR(ptr);
>> 	else
>> 		return 0;
>> }
>>
>> For below two cases, PTR_ERR_OR_ZERO(new) will return zero:
>> a) f2fs_lookup found existed dentry
>> b) f2fs_lookup didn't find existed dentry (-ENOENT case)
>>
>> So in below commit, I passed -ENOENT to tracepoint for case b), so we can
>> distinguish result of f2fs_lookup in tracepoint, actually, -ENOENT is expected
>> value when we create a new file/directory.
>>
>> Commit 84597b1f9b05 ("f2fs: fix wrong value of tracepoint parameter")
> I can see this commit is try to distinguish the dentry not existed case.
> But a normal case which dentry is exactly found will also go through
> 'd_splice_alias', and its return is also NULL. This makes the tracepoint always
> print 'err:-2' like the following:
>        ls-11676   [004] .... 329281.943118: f2fs_lookup_end: dev = (254,39), pino = 4451, name:Alarms, ino:7093, err:-2
>        ls-11676   [004] .... 329281.943145: f2fs_lookup_end: dev = (254,39), pino = 4451, name:Notifications, ino:7094, err:-2
>        ls-11676   [004] .... 329281.943172: f2fs_lookup_end: dev = (254,39), pino = 4451, name:Pictures, ino:7095, err:-2
> Even these lookup are acctually successful, this is a bit strange.

Ah, I misunderstand return value's meaning of .lookup.

So, how about this? it only update err if d_splice_alias() returns a negative
value?

if (IS_ERR(new))
	err = PTR_ERR(new);
trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);

Thanks,

>>
>>>
>>>
>>>>    	return new;
>>>>    out_iput:
>>>>    	iput(inode);
>>>> -- 
>>>> 2.35.3
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
