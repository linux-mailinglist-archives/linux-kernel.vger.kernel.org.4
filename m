Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3F64C191
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiLNBAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiLNBAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:00:16 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 803B4222AC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:00:15 -0800 (PST)
Received: (qmail 908581 invoked by uid 1000); 13 Dec 2022 20:00:14 -0500
Date:   Tue, 13 Dec 2022 20:00:14 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, hbh25y@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Write in gadgetfs_kill_sb
Message-ID: <Y5kgHgl2dU6fkr3p@rowland.harvard.edu>
References: <Y5iiwlZm8hgj8S0W@rowland.harvard.edu>
 <0000000000008ca17805efbbc87f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008ca17805efbbc87f@google.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:51:26PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: rcu detected stall in corrupted
> 
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4116 } 2668 jiffies s: 2777 root: 0x0/T
> rcu: blocking rcu_node structures (internal RCU debug):
> 
> 
> Tested on:
> 
> commit:         830b3c68 Linux 6.1
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> console output: https://syzkaller.appspot.com/x/log.txt?x=12066e8b880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a194ed4fc682723
> dashboard link: https://syzkaller.appspot.com/bug?extid=33d7ad66d65044b93f16
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=16793e8f880000

Let's see if this is related to the patch or something completely 
independent.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 830b3c68c1fb

 drivers/usb/gadget/legacy/inode.c |   39 +++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

Index: usb-devel/drivers/usb/gadget/legacy/inode.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/legacy/inode.c
+++ usb-devel/drivers/usb/gadget/legacy/inode.c
@@ -229,6 +229,7 @@ static void put_ep (struct ep_data *data
  */
 
 static const char *CHIP;
+static DEFINE_MUTEX(sb_mutex);		/* Serialize superblock maintenance */
 
 /*----------------------------------------------------------------------*/
 
@@ -2010,13 +2011,23 @@ gadgetfs_fill_super (struct super_block
 {
 	struct inode	*inode;
 	struct dev_data	*dev;
+	int		rc;
 
-	if (the_device)
-		return -ESRCH;
+	printk(KERN_INFO "fill_super A\n");
+	mutex_lock(&sb_mutex);
+
+	if (the_device) {
+		rc = -ESRCH;
+		goto Done;
+	}
+	printk(KERN_INFO "fill_super B\n");
 
 	CHIP = usb_get_gadget_udc_name();
-	if (!CHIP)
-		return -ENODEV;
+	if (!CHIP) {
+		rc = -ENODEV;
+		goto Done;
+	}
+	printk(KERN_INFO "fill_super C\n");
 
 	/* superblock */
 	sb->s_blocksize = PAGE_SIZE;
@@ -2029,6 +2040,7 @@ gadgetfs_fill_super (struct super_block
 	inode = gadgetfs_make_inode (sb,
 			NULL, &simple_dir_operations,
 			S_IFDIR | S_IRUGO | S_IXUGO);
+	printk(KERN_INFO "fill_super D\n");
 	if (!inode)
 		goto Enomem;
 	inode->i_op = &simple_dir_inode_operations;
@@ -2039,11 +2051,13 @@ gadgetfs_fill_super (struct super_block
 	 * user mode code can use it for sanity checks, like we do.
 	 */
 	dev = dev_new ();
+	printk(KERN_INFO "fill_super E\n");
 	if (!dev)
 		goto Enomem;
 
 	dev->sb = sb;
 	dev->dentry = gadgetfs_create_file(sb, CHIP, dev, &ep0_operations);
+	printk(KERN_INFO "fill_super F\n");
 	if (!dev->dentry) {
 		put_dev(dev);
 		goto Enomem;
@@ -2053,13 +2067,18 @@ gadgetfs_fill_super (struct super_block
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
+	printk(KERN_INFO "fill_super G\n");
+	mutex_unlock(&sb_mutex);
+	return rc;
 }
 
 /* "mount -t gadgetfs path /dev/gadget" ends up here */
@@ -2081,13 +2100,19 @@ static int gadgetfs_init_fs_context(stru
 static void
 gadgetfs_kill_sb (struct super_block *sb)
 {
+	printk(KERN_INFO "kill_sb A\n");
+	mutex_lock(&sb_mutex);
+	printk(KERN_INFO "kill_sb B\n");
 	kill_litter_super (sb);
+	printk(KERN_INFO "kill_sb C\n");
 	if (the_device) {
 		put_dev (the_device);
 		the_device = NULL;
 	}
 	kfree(CHIP);
 	CHIP = NULL;
+	printk(KERN_INFO "kill_sb D\n");
+	mutex_unlock(&sb_mutex);
 }
 
 /*----------------------------------------------------------------------*/

