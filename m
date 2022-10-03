Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293325F31E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJCOYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJCOYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:24:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7196C4A83F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 07:24:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u10so16870847wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yOJHVQ3dF73qxDimMRkk9B34BzBwv1cpVNfV2MLrsA=;
        b=D9VGZTan1HL2NIWYEqPV2MPHUHWl81EulVPIktGGwvrlNcXQuQH4G2frhfNd1tGb4F
         22Q96g2FaXwx0G5xNeQzRYltqOhIy7UPWmqmsAowrlboOrKS39XO9Rhn75I13Bt3fnG0
         iwZYN0sL69kTrHcIznx/VhLP6gUHfJCzfuiNisjdRQUEyUOMnyJxUJkUrD9acim8KCnh
         vDJM+dBmXxFd8h+d5Da4nVvuUVLZYb1qsYXAzwsNBXEiIJf/hCJE3H7qX4chaa3EGs3r
         sYOjmLrtuCzWqpZ4Y6Max1r0QCMYIuGusgzTVw9wOqVUEKeGWBeuAr18f3dFatp4gKke
         Vh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yOJHVQ3dF73qxDimMRkk9B34BzBwv1cpVNfV2MLrsA=;
        b=uqKPQPUwwnew6boJUIOn9tqDRc2tlE/JJocs1xc6Mc+WfZZD1sewNk8f1l9vMPwlu+
         lbCJ4THgoUIQcxbeBBdWxMD+NzbU4jWNFEvk4E9bHRZ9ApzYjlcozhq4D2cmuABZPOGU
         PYydqRw0oI6MqKyKi378MbFTOScvq9H0nst5OGmXb3WXwtmY7FREY7Ld7wyavB1fUaWx
         p+JS3RMEdNXpI+OfF7SnWcCwZtIEp213JgpfMegUpgWrJk3yfhvbtGaEzYpg3Ywu94Jd
         C3lCMzPLeo7s/z8t3C0qYDOJi1K2nXmDEdrvKy/lpIBgMDgCi9x/2snU3Hf3zhcaBGQd
         FHCA==
X-Gm-Message-State: ACrzQf2+1JiP7N6a/Po6HVrbBkw14V/HqffVCCbZrUPyr3Ps8H5UbD+P
        n8a79p+c/G4G8ooPKFFeXQA=
X-Google-Smtp-Source: AMsMyM7uqbc7RW5xeRcAfk7cKCI8R5NYd3ZfGLDER7qgW/fVasGj2RGSRHTUUJy3b/CRChR3fR/MrA==
X-Received: by 2002:a5d:47a4:0:b0:226:e547:b602 with SMTP id 4-20020a5d47a4000000b00226e547b602mr13584509wrb.406.1664807046827;
        Mon, 03 Oct 2022 07:24:06 -0700 (PDT)
Received: from laptop.crto.in ([2a01:e0a:b14:c1f0:8b27:f5b6:ab16:4a19])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05600c3ca100b003a5f4fccd4asm17436086wmb.35.2022.10.03.07.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 07:24:06 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     erwanaliasr1@gmail.com, Erwan Velu <e.velu@criteo.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware/dmi: Print product serial number if any
Date:   Mon,  3 Oct 2022 16:24:00 +0200
Message-Id: <20221003142400.1177057-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the boot sequence, the kernel prints a string to identify the
running host. This is pretty handy to estimate the underlying hardware
in case of early crash.

This patch add the product serial number in this reporting if any got found,
or keep the current string. In a large fleet of servers, this
information could be useful to identify the host that generated a given trace.

Test ran with the following command : qemu-system-x86_64 -kernel arch/x86/boot/bzImage --enable-kvm -m 512  -serial stdio  -append 'console=ttyS0' -smbios type=1,serial=R90YT7WC

Prior the patch:
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014

With the patch:
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014, SN: R90YT7WC

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/firmware/dmi_scan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 0eb6b617f709..601e003c67f4 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -536,6 +536,7 @@ static void __init dmi_format_ids(char *buf, size_t len)
 {
 	int c = 0;
 	const char *board;	/* Board Name is optional */
+	const char *product_serial; /* Product serial is optional */
 
 	c += print_filtered(buf + c, len - c,
 			    dmi_get_system_info(DMI_SYS_VENDOR));
@@ -554,6 +555,14 @@ static void __init dmi_format_ids(char *buf, size_t len)
 	c += scnprintf(buf + c, len - c, " ");
 	c += print_filtered(buf + c, len - c,
 			    dmi_get_system_info(DMI_BIOS_DATE));
+
+	product_serial = dmi_get_system_info(DMI_PRODUCT_SERIAL);
+	if (product_serial) {
+		if (strlen(product_serial)) {
+			c += scnprintf(buf + c, len - c, ", SN: ");
+			c += print_filtered(buf + c, len - c, product_serial);
+		}
+	}
 }
 
 /*
-- 
2.37.3

