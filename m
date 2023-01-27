Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2750067DD68
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjA0GXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjA0GXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:23:06 -0500
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Jan 2023 22:23:05 PST
Received: from p3plwbeout17-06.prod.phx3.secureserver.net (p3plsmtp17-06-2.prod.phx3.secureserver.net [173.201.193.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0B72D5A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:23:05 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id LI5zpgcQCMKZLLI60pZ9Ps; Thu, 26 Jan 2023 23:20:20 -0700
X-CMAE-Analysis: v=2.4 cv=VesygHl9 c=1 sm=1 tr=0 ts=63d36d24
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=RvmDmJFTN0MA:10 a=hSkVLCK3AAAA:8
 a=xjQjg--fAAAA:8 a=VJ6naE4wvLo_NqA_W6QA:9 a=QEXdDO2ut3YA:10
 a=cQPPKAXgyycSBL8etih5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  LI5zpgcQCMKZL
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1pLI5z-0003kq-7E; Fri, 27 Jan 2023 06:20:19 +0000
Message-ID: <68f15d67-8945-2728-1f17-5b53a80ec52d@squashfs.org.uk>
Date:   Fri, 27 Jan 2023 06:20:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] squashfs: harden sanity check in
 squashfs_read_xattr_id_table
To:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+082fa4af80a5bb1a9843@syzkaller.appspotmail.com
References: <20230117105226.329303-1-pchelkin@ispras.ru>
 <20230117105226.329303-2-pchelkin@ispras.ru>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20230117105226.329303-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfAUXse3AXkEd3n4ZBv5VH4cTjsvqLRExI/WBks5YvLOwfNP6DBYRLlUU7TF4UYUDi3NTEA7ZKtb9jEyZwaotpY3SqMiNGuuAKhk8sF5js8zbtgXW16wo
 TnIqHuRMAu74kLhYXY3IFzmcnK/SmaPoabsiwU1SHr+021rampAJOaLjZSN3mKXMLbFuRzcIPkjaaOnikRCzecSagIBwQHyedsY=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 10:52, Fedor Pchelkin wrote:
 > While mounting a corrupted filesystem, a signed integer '*xattr_ids' can
 > become less than zero. This leads to the incorrect computation of 'len'
 > and 'indexes' values which can cause null-ptr-deref in 
copy_bio_to_actor()
 > or out-of-bounds accesses in the next sanity checks inside
 > squashfs_read_xattr_id_table().
 >

NACK

Thanks for sending the patch, but, you have unfortunately identified and
fixed the wrong sanity check.  In effect you're fixing the symptom and
not the cause.

The Sysbot corrupted filesystem has an xattr_ids value of 4294967071,
which as you point out is treated as negative due to xattr_ids being a
signed int.

But 4294967071 even though it is a large number could be a perfectly
legitimate number because in theory the filesystem layout supports up
to 2^32 xattr_ids.

By extending the wrong sanity check from

 >	if (*xattr_ids == 0)

to

 >	if (*xattr_ids <= 0)

You are using the fact that the number has gone negative to reject the
filesystem.  But you are not fixing the real issues.

You have not discovered if or why the negative number is the
cause of the failure, or whether there are extra flaws.

With syzkiller fuzzer generated exploits, it is essential to analyze the
issue throughly, because these exploits often rely on over-looked
dependencies/assumptions, and it can be difficult to produce a patch
that fixes all the issues and without introducing regressions.

Phillip

 >
 > Fixes: 506220d2ba21 ("squashfs: add more sanity checks in xattr id 
lookup")
 > Reported-by: syzbot+082fa4af80a5bb1a9843@syzkaller.appspotmail.com
 > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
 > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
 > ---
 >   fs/squashfs/xattr_id.c | 2 +-
 >   1 file changed, 1 insertion(+), 1 deletion(-)
 >
 > diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
 > index 087cab8c78f4..f6d78cbc3e74 100644
 > --- a/fs/squashfs/xattr_id.c
 > +++ b/fs/squashfs/xattr_id.c
 > @@ -76,7 +76,7 @@ __le64 *squashfs_read_xattr_id_table(struct 
super_block *sb, u64 table_start,
 >   	/* Sanity check values */
 >
 >   	/* there is always at least one xattr id */
 > -	if (*xattr_ids == 0)
 > +	if (*xattr_ids <= 0)
 >   		return ERR_PTR(-EINVAL);
 >
 >   	len = SQUASHFS_XATTR_BLOCK_BYTES(*xattr_ids);
