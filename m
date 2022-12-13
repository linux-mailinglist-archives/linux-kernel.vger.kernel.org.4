Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C764B940
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiLMQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiLMQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:05:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 37F4820F45
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:05:23 -0800 (PST)
Received: (qmail 891916 invoked by uid 1000); 13 Dec 2022 11:05:22 -0500
Date:   Tue, 13 Dec 2022 11:05:22 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, hbh25y@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Write in gadgetfs_kill_sb
Message-ID: <Y5iiwlZm8hgj8S0W@rowland.harvard.edu>
References: <0000000000009f6b9c05efb5b59c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009f6b9c05efb5b59c@google.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 05:36:38AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    830b3c68c1fb Linux 6.1
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=137401b7880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a194ed4fc682723
> dashboard link: https://syzkaller.appspot.com/bug?extid=33d7ad66d65044b93f16
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176d36b7880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109371b7880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/955d55d85d6c/disk-830b3c68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7ef0e1f6a0c3/vmlinux-830b3c68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/27601eb5ff0b/bzImage-830b3c68.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
> BUG: KASAN: use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:176 [inline]
> BUG: KASAN: use-after-free in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
> BUG: KASAN: use-after-free in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
> BUG: KASAN: use-after-free in refcount_dec_and_test include/linux/refcount.h:333 [inline]
> BUG: KASAN: use-after-free in put_dev drivers/usb/gadget/legacy/inode.c:159 [inline]
> BUG: KASAN: use-after-free in gadgetfs_kill_sb+0x33/0x100 drivers/usb/gadget/legacy/inode.c:2086
> Write of size 4 at addr ffff8880276d7840 by task syz-executor126/18689

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 830b3c68c1fb

 drivers/usb/gadget/legacy/inode.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

Index: usb-devel/drivers/usb/gadget/legacy/inode.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/legacy/inode.c
+++ usb-devel/drivers/usb/gadget/legacy/inode.c
@@ -229,6 +229,7 @@ static void put_ep (struct ep_data *data
  */
 
 static const char *CHIP;
+static DEFINE_MUTEX(sb_mutex);		/* Serialize superblock operations */
 
 /*----------------------------------------------------------------------*/
 
@@ -2010,13 +2011,20 @@ gadgetfs_fill_super (struct super_block
 {
 	struct inode	*inode;
 	struct dev_data	*dev;
+	int		rc;
 
-	if (the_device)
-		return -ESRCH;
+	mutex_lock(&sb_mutex);
+
+	if (the_device) {
+		rc = -ESRCH;
+		goto Done;
+	}
 
 	CHIP = usb_get_gadget_udc_name();
-	if (!CHIP)
-		return -ENODEV;
+	if (!CHIP) {
+		rc = -ENODEV;
+		goto Done;
+	}
 
 	/* superblock */
 	sb->s_blocksize = PAGE_SIZE;
@@ -2053,13 +2061,17 @@ gadgetfs_fill_super (struct super_block
 	 * from binding to a controller.
 	 */
 	the_device = dev;
-	return 0;
+	rc = 0;
+	goto Done;
 
-Enomem:
+ Enomem:
 	kfree(CHIP);
 	CHIP = NULL;
+	rc = -ENOMEM;
 
-	return -ENOMEM;
+ Done:
+	mutex_unlock(&sb_mutex);
+	return rc;
 }
 
 /* "mount -t gadgetfs path /dev/gadget" ends up here */
@@ -2081,6 +2093,7 @@ static int gadgetfs_init_fs_context(stru
 static void
 gadgetfs_kill_sb (struct super_block *sb)
 {
+	mutex_lock(&sb_mutex);
 	kill_litter_super (sb);
 	if (the_device) {
 		put_dev (the_device);
@@ -2088,6 +2101,7 @@ gadgetfs_kill_sb (struct super_block *sb
 	}
 	kfree(CHIP);
 	CHIP = NULL;
+	mutex_unlock(&sb_mutex);
 }
 
 /*----------------------------------------------------------------------*/
