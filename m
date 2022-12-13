Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26064AD53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiLMBqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiLMBqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:46:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806EB15FC9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:46:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228216119B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C08C433EF;
        Tue, 13 Dec 2022 01:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670896006;
        bh=b492jcWSHExPhifU02diqtfeCSUJqNIU0MHaeSHNsgs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tCWz3ghvT7KvybgeJgSPd5ymmNqE2Q2l7U6FpjpqZqjYFxSrln54n805iVzdfQ/Q9
         NYsCvwvrXJNGunFUaXHbwUAKRMsxJ5KK0e4Bj4oMbuWTzIBaMuyo77Ujlcchi1ASjw
         /AvBW6vZhmt3K59u1fmGaEPE31GulLwOSE31u2Zo5RWs69LKBVwZh5Jxn3aU3oRBz9
         TOz3cPPOSNTyGIno2TWpxINHSyEju9zL2u2+f7RWlhMIbU34VRI9JA9Y9WYxv+sDdK
         DUKpk67UhORQK41+dTa4s8ud5p43UpUOaiBszuslozDhGttUUIy/0Dl53eMRWusTCW
         oFscnuwbkruAg==
Message-ID: <ddf243c9-f557-7f11-1964-8d2324f84092@kernel.org>
Date:   Tue, 13 Dec 2022 09:46:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: fix iostat parameter for discard
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221205145603.70779-1-frank.li@vivo.com>
 <38ab73c5-4865-188f-9554-6bcaec7cc78b@kernel.org>
 <Y5eyPe7Yqz2xpluU@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y5eyPe7Yqz2xpluU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/13 6:59, Jaegeuk Kim wrote:
> On 12/11, Chao Yu wrote:
>> On 2022/12/5 22:56, Yangtao Li wrote:
>>> Just like other data we count uses the number of bytes as the basic unit,
>>> but discard uses the number of cmds as the statistical unit. In fact the
>>> discard command contains the number of blocks, so let's change to the
>>> number of bytes as the base unit.
>>>
>>> Fixes: b0af6d491a6b ("f2fs: add app/fs io stat")
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>    fs/f2fs/segment.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 9486ca49ecb1..bc262e17b279 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1181,7 +1181,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>    		atomic_inc(&dcc->issued_discard);
>>> -		f2fs_update_iostat(sbi, NULL, FS_DISCARD, 1);
>>> +		f2fs_update_iostat(sbi, NULL, FS_DISCARD, len * F2FS_BLKSIZE);
>>
>> In order to avoid breaking its usage of application, how about keeping
>> FS_DISCARD as it is, and add FS_DISCARD_IO to account discard bytes?
> 
> I picked this to match the f2fs_update_iostat() definition. Do we know
> how many applications will be affected? I don't have any at a glance in
> Android tho.

I guess there is some private scripts in OEM rely on this, and I don't
see any non-Android users using this.

> 
> void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
>                          enum iostat_type type, unsigned long long io_bytes)

What do you think of extending this function to support io_counts?

void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
			enum iostat_type type, unsigned long long io_bytes,
			unsigned long long io_counts)

Thanks,

> 
> 
>>
>> Thanks,
>>
>>>    		lstart += len;
>>>    		start += len;
