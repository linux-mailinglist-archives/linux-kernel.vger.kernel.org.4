Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135060EF88
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiJ0FeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ0FeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:34:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DE497D65
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:34:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r18so244007pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ac/dPXfdapcJi6R++ywswTtoxteB6ZZ2SeSnB/OESj8=;
        b=ExryRHGS58d0xSXrGRgUqru2wfTVzxXR3VRekqMuVbOPiqaslNUEpqI+m7WuvJDyq8
         0r49s21EiIK0nS5bsQgiBMChfXYKV7mCRCRBkb6/emmvZlbzLSMsfMtC6qFhclwL9zg3
         nm8o6FfN+ts/Hrruvi53sWfnzJFQDBKaeDRKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ac/dPXfdapcJi6R++ywswTtoxteB6ZZ2SeSnB/OESj8=;
        b=L6cn/ce3R9ZdHcTu7NwdqD+X7ScdPY/XqgEKHq6z3wsr1yAmnBMSmerlDi1MBND0HJ
         WBqd+HIYwivC1uYDTzrBeiMZArKAYV6d2TzAwAVQZAxwdc5UqoMGalXXooalTgUritTy
         puRi9qWACAieLKH/DEMXCHjXyox+Cv0514ToGFL6n7gJV1f5AIiiZSWEpP03fzwm2tUD
         Dpzx73MeKD3YMr5u2ecX5fjbVphnQwgZ0/9Wt8eNH5yeKGmnPqsiafJAXlIiYn/1lAMz
         hPNpJy8uTl3X+ZrfcnD05Iged64bqmaUnvsvTFzI6MaQiFs1ekObvkhzYSZtxx3GMxx3
         okkg==
X-Gm-Message-State: ACrzQf1wxOxcJvL0zkFiQ0SiDDbgZjzzS6KXV8HKj0ysBpKXTU0Bn1h2
        iw0o70aL3Oa39uH/6ANxxEKP7g==
X-Google-Smtp-Source: AMsMyM4IRJfSWcHdgMX+5M2VG7pQG8tnNKBJxJwoLxbBdkq5EUKumYJM9SAARxYwMi3qa0P41Hho7A==
X-Received: by 2002:a63:2a8b:0:b0:46e:9fda:2171 with SMTP id q133-20020a632a8b000000b0046e9fda2171mr31209479pgq.106.1666848861019;
        Wed, 26 Oct 2022 22:34:21 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:b007:7d32:6096:a655])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709026f1700b0017e232b6724sm278540plk.69.2022.10.26.22.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 22:34:20 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Reka Norman <rekanorman@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] xhci: Apply XHCI_RESET_TO_DEFAULT quirk to ADL-N
Date:   Thu, 27 Oct 2022 16:34:07 +1100
Message-Id: <20221027053407.421783-1-rekanorman@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADL-N systems have the same issue as ADL-P, where a large boot firmware
delay is seen if USB ports are left in U3 at shutdown. So apply the
XHCI_RESET_TO_DEFAULT quirk to ADL-N as well.

This patch depends on "xhci: Add quirk to reset host back to default
state at shutdown".

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 7bccbe50bab15..f98cf30a3c1a5 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -59,6 +59,7 @@
 #define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
+#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
 
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
@@ -246,7 +247,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_MISSING_CAS;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
-	    pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI)
+	    (pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI))
 		xhci->quirks |= XHCI_RESET_TO_DEFAULT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
-- 
2.38.0.135.g90850a2211-goog

