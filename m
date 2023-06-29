Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF6742646
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjF2MW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjF2MUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:20:54 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA63584;
        Thu, 29 Jun 2023 05:20:17 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-55b85b94bb0so306093eaf.0;
        Thu, 29 Jun 2023 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688041217; x=1690633217;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5mgpWar9cALG/3/0CBITIu5fDttWbH9ujCUUUdrauA=;
        b=d43aXK0abIqFPuvp0NAGONopsVgICCVlIoMD+Cz2FuTMg2hTNcZ0xUyVby0te8gpfy
         5tsoR9S8JxcCEY98uG2KHvTCRpPFY8IT+b3o7atTM5e3YHBzRdrLtWjTLIu8kvh76f+Z
         GeLCjWCVLLyFDDDmGKHJjDhM2/5e1b41pzluEtJrBvaHRjCOp5CStzGLEg/WmxAn0n2m
         xXh0RP12e9nzjnqZdBJbAzg8K/jfy23LekLs/Vsz0xdVBIhA6hrn0XRkZv5rCNJu5VXd
         m0MxCmqDoIId3pHze71h0CGeb0R9ru9b/fUGyMR/MxxD2d3AXXLh1rJV0psS5qDRsYYY
         aaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688041217; x=1690633217;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5mgpWar9cALG/3/0CBITIu5fDttWbH9ujCUUUdrauA=;
        b=KBgidCLkzcFUt/EkAdNiWUFEw8S0M70eZB+h37nPQO8/oum3yIVb8idn0BKF1TWuo8
         3sAvXOwapfTGwOkjRhLXnq+OpJD3z3qTzVP0e+5TV6HpMwE8kmVvplImhpW1orS7J1Cl
         BCKBbTweFsveE1Mcz7nIvDsEFYZq4aPZuHubjPnTlCuDiQM6+/FTzz2ZmOKLyZ6xP+3C
         PqJT778SMWTrrARoS3mHdRGmrag2v7S3W9OVz2nA5OVOr7CD3/yO0RCx7T1rVfYDsnX0
         jLmBVEeIMHNEAhi0Nh5a/I3HixsE8EazZ/aRJYGApAYWE4oN9uU3MzHH/mtPRYUUvFsM
         1Vrw==
X-Gm-Message-State: AC+VfDzfb4x3WyZuF00EfN5egHTnt/AJzpxJV3HfwhiHTvs59/L9zgVE
        F9Iyv4iP+QMIfxZrektyt543ZKdHDrLQ5w==
X-Google-Smtp-Source: ACHHUZ614qq2WrpcublHjqnBhNIlQY7zf2QOG5Pc9ydMDnQSCbWbIOO7wMDoBz25FuFCamzLvFJydA==
X-Received: by 2002:a4a:df09:0:b0:55a:9fc5:c12c with SMTP id i9-20020a4adf09000000b0055a9fc5c12cmr23414726oou.5.1688041216937;
        Thu, 29 Jun 2023 05:20:16 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id v18-20020a4ade92000000b005630547db40sm2876756oou.41.2023.06.29.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:20:16 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     gregkh@linuxfoundation.org, gustavoars@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] usb: host: oxu210hp-hcd: Fix potential deadlock on &oxu->mem_lock
Date:   Thu, 29 Jun 2023 12:19:47 +0000
Message-Id: <20230629121947.59315-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &udc->lock is acquired by watchdog timer oxu_watchdog() under
softirq context, other acquisition of the same lock under process
context should disable irq, otherwise deadlock could happen if the
irq preempt the execution while the lock is held in process context
on the same CPU.

The .urb_enqueue callback oxu_urb_enqueue() acquires the lock without
disabling irq inside the function.

Possible deadlock scenario

oxu_urb_enqueue()
    -> oxu_murb_alloc()
    -> spin_lock(&oxu->mem_lock)
        <timer interrupt>
        -> oxu_watchdog()
        -> ehci_work()
        -> scan_async()
        -> qh_completions()
        -> oxu_murb_free()
        -> spin_lock(&oxu->mem_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock, which reported the above
warning when analyzing the linux kernel 6.4-rc7 release.

The tentative patch fixes the potential deadlock by spin_lock_irqsave().
x86_64 allyesconfig using GCC shows no new warning, the tool does not
report the warnining after the fix. No runtime testing was performed since
I don't have device with OXU210HP host controller.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/usb/host/oxu210hp-hcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index f998d3f1a78a..944011e059e5 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -1120,8 +1120,9 @@ static struct oxu_murb *oxu_murb_alloc(struct oxu_hcd *oxu)
 {
 	int i;
 	struct oxu_murb *murb = NULL;
+	unsigned long flags;
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	for (i = 0; i < MURB_NUM; i++)
 		if (!oxu->murb_used[i])
@@ -1133,7 +1134,7 @@ static struct oxu_murb *oxu_murb_alloc(struct oxu_hcd *oxu)
 		oxu->murb_used[i] = 1;
 	}
 
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 
 	return murb;
 }
-- 
2.17.1

