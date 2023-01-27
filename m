Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCAF67DE78
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjA0HYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjA0HY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:24:27 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9564FADA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:24:26 -0800 (PST)
Received: from [192.168.0.105] (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7CE2E44C100F;
        Fri, 27 Jan 2023 07:24:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7CE2E44C100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1674804262;
        bh=Ov8b+N0rxFBQ1mJI28Uiq6+JbKshYC6f8YcFIGSyt4w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ob0Q92OhLBuQF1U7Yj54lbEVLdP2iDNTCLFYlv1eUzprXhDFI2HtTR904qSTi/r2A
         KdpRzexkWLsA+aBfkxKCLic1JBfzGhe8/1vv7LtBlE93O7R0UjhJmwAdOWaRtG4sIg
         P8H+z79G9CpUIqDRrlOniNpFuXjeFW1RxUk2VkbQ=
Message-ID: <7603920e-e5ac-b88f-667b-efd8f928ba97@ispras.ru>
Date:   Fri, 27 Jan 2023 10:24:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/1] squashfs: harden sanity check in
 squashfs_read_xattr_id_table
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+082fa4af80a5bb1a9843@syzkaller.appspotmail.com
References: <20230117105226.329303-1-pchelkin@ispras.ru>
 <20230117105226.329303-2-pchelkin@ispras.ru>
 <68f15d67-8945-2728-1f17-5b53a80ec52d@squashfs.org.uk>
Content-Language: en-US
From:   Fedor Pchelkin <pchelkin@ispras.ru>
In-Reply-To: <68f15d67-8945-2728-1f17-5b53a80ec52d@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply. Actually, I made a proposal about '*xattr_ds' type
being unsigned in 0/1 patch of the series, but in the end tried to fix
the issue in-place, and that was definitely a wrong decision. I'm sorry
for the misleading patch.

On 27.01.2023 09:20, Phillip Lougher wrote:
> On 17/01/2023 10:52, Fedor Pchelkin wrote:
>  > While mounting a corrupted filesystem, a signed integer '*xattr_ids' can
>  > become less than zero. This leads to the incorrect computation of 'len'
>  > and 'indexes' values which can cause null-ptr-deref in 
> copy_bio_to_actor()
>  > or out-of-bounds accesses in the next sanity checks inside
>  > squashfs_read_xattr_id_table().
>  >
> 
> NACK
> 
> Thanks for sending the patch, but, you have unfortunately identified and
> fixed the wrong sanity check.  In effect you're fixing the symptom and
> not the cause.
> 
> The Sysbot corrupted filesystem has an xattr_ids value of 4294967071,
> which as you point out is treated as negative due to xattr_ids being a
> signed int.
> 
> But 4294967071 even though it is a large number could be a perfectly
> legitimate number because in theory the filesystem layout supports up
> to 2^32 xattr_ids.
> 
> By extending the wrong sanity check from
> 
>  >    if (*xattr_ids == 0)
> 
> to
> 
>  >    if (*xattr_ids <= 0)
> 
> You are using the fact that the number has gone negative to reject the
> filesystem.  But you are not fixing the real issues.
> 
> You have not discovered if or why the negative number is the
> cause of the failure, or whether there are extra flaws.
> 
> With syzkiller fuzzer generated exploits, it is essential to analyze the
> issue throughly, because these exploits often rely on over-looked
> dependencies/assumptions, and it can be difficult to produce a patch
> that fixes all the issues and without introducing regressions.
> 
> Phillip
> 
>  >
>  > Fixes: 506220d2ba21 ("squashfs: add more sanity checks in xattr id 
> lookup")
>  > Reported-by: syzbot+082fa4af80a5bb1a9843@syzkaller.appspotmail.com
>  > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>  > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>  > ---
>  >   fs/squashfs/xattr_id.c | 2 +-
>  >   1 file changed, 1 insertion(+), 1 deletion(-)
>  >
>  > diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
>  > index 087cab8c78f4..f6d78cbc3e74 100644
>  > --- a/fs/squashfs/xattr_id.c
>  > +++ b/fs/squashfs/xattr_id.c
>  > @@ -76,7 +76,7 @@ __le64 *squashfs_read_xattr_id_table(struct 
> super_block *sb, u64 table_start,
>  >       /* Sanity check values */
>  >
>  >       /* there is always at least one xattr id */
>  > -    if (*xattr_ids == 0)
>  > +    if (*xattr_ids <= 0)
>  >           return ERR_PTR(-EINVAL);
>  >
>  >       len = SQUASHFS_XATTR_BLOCK_BYTES(*xattr_ids);
