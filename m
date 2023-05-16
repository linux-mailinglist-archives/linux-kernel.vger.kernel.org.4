Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513F4704FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjEPNzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjEPNy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E0212F;
        Tue, 16 May 2023 06:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D8C6106C;
        Tue, 16 May 2023 13:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B10C43445;
        Tue, 16 May 2023 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684245289;
        bh=7hO0wxivdPOSFemSK4iAuWKSXV/MOYXS0sCdNmjdjOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSQN24GQkZ9IAFB891bzAFzxcbDnsg/U4nQcnMmNlLykRUzIavVgBOWsQDR2pwTy1
         Z9dIQeXr2OhXBl6yRnLLmexPJ67uaW07Hr8RI9qyPg1a9zjjeSOFvjbdlSliP6wF2P
         HQdHp+Ur/twnFjFPteGJzJojKBC0f1+B2or+OKds=
Date:   Tue, 16 May 2023 15:54:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] memory leak in class_create
Message-ID: <2023051628-thumb-boaster-5680@gregkh>
References: <00000000000077472605faa4aad5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000077472605faa4aad5@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 09:53:45AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    22b8cc3e78f5 Merge tag 'x86_mm_for_6.4' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16fc7958280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5046ebeca744dd40
> dashboard link: https://syzkaller.appspot.com/bug?extid=e7afd76ad060fa0d2605
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599a2b4280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14eb395fc80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3ad2088c196b/disk-22b8cc3e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/61919a5b89c6/vmlinux-22b8cc3e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a7adb5503ac8/bzImage-22b8cc3e.xz

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 22b8cc3e78f5


diff --git a/drivers/base/class.c b/drivers/base/class.c
index ac1808d1a2e8..9b44edc8416f 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -320,6 +322,7 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 		start_knode = &start->p->knode_class;
 	klist_iter_init_node(&sp->klist_devices, &iter->ki, start_knode);
 	iter->type = type;
+	iter->sp = sp;
 }
 EXPORT_SYMBOL_GPL(class_dev_iter_init);
 
@@ -361,6 +364,7 @@ EXPORT_SYMBOL_GPL(class_dev_iter_next);
 void class_dev_iter_exit(struct class_dev_iter *iter)
 {
 	klist_iter_exit(&iter->ki);
+	subsys_put(iter->sp);
 }
 EXPORT_SYMBOL_GPL(class_dev_iter_exit);
 
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 9deeaeb457bb..abf3d3bfb6fe 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -74,6 +74,7 @@ struct class {
 struct class_dev_iter {
 	struct klist_iter		ki;
 	const struct device_type	*type;
+	struct subsys_private		*sp;
 };
 
 int __must_check class_register(const struct class *class);
