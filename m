Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F56D2F2B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDAJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDAJGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F26E99
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 02:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9978E60B93
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 09:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736D1C433EF;
        Sat,  1 Apr 2023 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680339974;
        bh=/HuSHUr8owYF23WRb08NIeGCkmdnHcUQfovRQ2q67Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDGj1MTQG/uHatjBlv56Lx5tt4LxKn9Bjym/ETyMbhzoH3nL3QkBe9PIATglnnbrW
         ywFdDZ4EqBo0TzbHTxDFzCqc+i/XSWbKV8Dzv4JwpswulkkGt2KzZu9CpTOE4a1twB
         Qm/zNdFr0gD4KY1QpHipiKVk/cWvQowZl5LUKWAs=
Date:   Sat, 1 Apr 2023 11:06:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 class_register
Message-ID: <2023040150-mooned-gizzard-962a@gregkh>
References: <00000000000062649c05f841e476@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000062649c05f841e476@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 01:12:51AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    198925fae644 Add linux-next specific files for 20230329
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f9a03ec80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91e70627549fd509
> dashboard link: https://syzkaller.appspot.com/bug?extid=41d665317c811d4d88aa
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105d5a2ec80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ab4895c80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/53c685bee82f/disk-198925fa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/45e82baa3bc5/vmlinux-198925fa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7c31fbc6acb9/bzImage-198925fa.xz
> 
> The issue was bisected to:
> 
> commit dcfbb67e48a2becfce7990386e985b9c45098ee5
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Fri Mar 24 10:01:31 2023 +0000
> 
>     driver core: class: use lock_class_key already present in struct subsys_private
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173f4ab9c80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14bf4ab9c80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10bf4ab9c80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com
> Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")


Reference: https://syzkaller.appspot.com/bug?extid=41d665317c811d4d88aa

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/ driver-core-next


diff --git a/drivers/base/class.c b/drivers/base/class.c
index 2991936c80db..ac1808d1a2e8 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -103,6 +103,7 @@ static void class_release(struct kobject *kobj)
 		pr_debug("class '%s' does not have a release() function, "
 			 "be careful\n", class->name);
 
+	lockdep_unregister_key(&cp->lock_key);
 	kfree(cp);
 }
 

