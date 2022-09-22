Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B505E677F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiIVPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIVPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:47:08 -0400
X-Greylist: delayed 1078 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 08:47:04 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73310B56DA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:47:01 -0700 (PDT)
X-ASG-Debug-ID: 1663860542-1cf439169517d3d0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id a7k4Z7g3FghNomFD; Thu, 22 Sep 2022 11:29:02 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=5U2RBudcjywn4CTHzyszUL0A5NmB4r+q6fespbQn9io=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=gkR260TX+WWpGwir/3+k
        j0CLCkcxJVnAPoCaM4rsHSGTlVwf242le1gfjPUrkfVqbwbdht8zgo87ApthBB/CT8vk58LCSq7kx
        Vc+62lpNYMv7561WFL4RPLRveGK1f1Xd/dYMz3xDOyVZJPjmJj+BwG1grc/0lrfhIIoD0+xJww=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12221171; Thu, 22 Sep 2022 11:29:02 -0400
Message-ID: <404508f8-37bb-a3bd-4319-6b6d7a7e076e@cybernetics.com>
Date:   Thu, 22 Sep 2022 11:29:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: KASAN: use-after-free Read in sg_release
Content-Language: en-US
X-ASG-Orig-Subj: Re: KASAN: use-after-free Read in sg_release
To:     Rondreis <linhaoguo86@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
References: <CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1663860542
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2052
X-Barracuda-BRTS-Status: 1
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 10:46, Rondreis wrote:
> Hello,
>
> When fuzzing the Linux kernel driver v6.0-rc6, the following crash was
> triggered.
>
> HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
> git tree: upstream
>
> kernel config: https://pastebin.com/raw/hekxU61F
> console output: https://pastebin.com/raw/73a8RzBY
>
> Sorry for failing to extract the reproducer. But on other versions of
> Linux, I also triggered this crash.
>
> I would appreciate it if you have any idea how to solve this bug.
>
sg_release() calls "kref_put(&sfp->f_ref, sg_remove_sfp)" which
eventually does "kref_put(&sdp->d_ref, sg_device_destroy)" which does
"kfree(sdp)", but sg_release() continues to access sdp afterward.  Try
the following patch.

From 82ca6785c40eded6229183a53752fc5e43db4a94 Mon Sep 17 00:00:00 2001
From: Tony Battersby <tonyb@cybernetics.com>
Date: Thu, 22 Sep 2022 11:05:30 -0400
Subject: [PATCH] scsi: sg: fix memory-use-after-free on device removal

Fix memory-use-after-free race when closing a sg fd to a removed device.

Link: https://lore.kernel.org/linux-scsi/CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com/
Reported-by: Rondreis <linhaoguo86@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/scsi/sg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 340b050ad28d..f44cbe42dba9 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -388,6 +388,7 @@ sg_release(struct inode *inode, struct file *filp)
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp, "sg_release\n"));
 
+	kref_get(&sdp->d_ref);
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
@@ -402,6 +403,7 @@ sg_release(struct inode *inode, struct file *filp)
 		wake_up_interruptible(&sdp->open_wait);
 	}
 	mutex_unlock(&sdp->open_rel_lock);
+	kref_put(&sdp->d_ref, sg_device_destroy);
 	return 0;
 }
 
-- 
2.25.1

