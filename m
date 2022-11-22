Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F162634807
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiKVUXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiKVUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:22:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD0120B1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso12197801wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6ixxc2JktITODbODtyQY200IGkrgKvZ3B6FgIPgSe0=;
        b=IOjpV+920dN7SimDyXdKUn6ssc+38LAtzPhLLbVMxrdDksdRTkH9UZ4FIgKxgKhAqt
         iSjc2Pj3MtnKl7aNSzjP4mJ+/JvL0r5At4mIJeuiyXlCg6BJE9T8yd15Dm2S4r4DVltv
         FnFvL1Xe29c9OWiopLiNeGm/wq6AKJFTkiUkTYReZM1zpgY3con01TJ91xO65o5bwnde
         bI6SM2XPlMvRvfegB5Un1sUXza7R06/Bx63wWe9cyz8X4aVolcdfeDNDluy5dFvOSBkw
         seixXsLE5w+8Pp5fdwfoxFhXRrOra+vrWi47LtCYrCRrsAJ0zAB14Pal6LpzKUeUH80w
         sTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6ixxc2JktITODbODtyQY200IGkrgKvZ3B6FgIPgSe0=;
        b=P2iJhtCTzG2GxXDSeWAwqgiyxalrRPiwlC8jJNoavm/pdzLaJczwF5/glm3gka43bY
         dBrNJowq+FXFuEREKJ7yQHWkniip7LiEBDZeeul/n7WrcM0xp/cuM8gbMawzqfXX8Fqm
         nEj6ifCTZGgmaNdOCSgRebSt5A7ING8IPTN0sKwVusLqhJ5FLckD1MtHG/0DFvy5gGhJ
         s5bk0YNFGXkn4iUA55roT/NN8rS29FznsE9lj+0gY9uayKXfliIHN2xG/rnKGpdGpswU
         Nv2BKOQfUe/T6MTIR4ixlRvaFskH7v3r0E1cZI5Kf64+5iLiGpjIL3SESVlU9vdoEQOT
         6dnA==
X-Gm-Message-State: ANoB5pnVKL3u4J6IGKxToW34/5k3DevGzS0wAZoMbqIkrp3v5x7QfkUD
        SwQMca3EUORAf1uKXRmE0Wp1Zw==
X-Google-Smtp-Source: AA0mqf4VZg5VUa0//3wgJkU0CLKryJxPOSdotN24ByTHO/HVZLKKm/f5wRvo/pm0/SE1Qw95CdA1sg==
X-Received: by 2002:a05:600c:2e51:b0:3cf:8a3a:9996 with SMTP id q17-20020a05600c2e5100b003cf8a3a9996mr21798064wmf.89.1669148574433;
        Tue, 22 Nov 2022 12:22:54 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:53ef:17fc:fb98:916b])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm25718555wmg.46.2022.11.22.12.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:22:54 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH 2/3] mailbox: config: ti-msgmgr: Default set to ARCH_K3 for TI msg manager
Date:   Tue, 22 Nov 2022 21:22:44 +0100
Message-Id: <20221122202245.449198-3-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122202245.449198-1-nfrayer@baylibre.com>
References: <20221122202245.449198-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defaulting the build to ARCH_K3 for the TI message manager driver.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index d7af896cbd7b..04c442532b70 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -136,6 +136,7 @@ config STI_MBOX
 config TI_MESSAGE_MANAGER
 	tristate "Texas Instruments Message Manager Driver"
 	depends on ARCH_KEYSTONE || ARCH_K3
+	default ARCH_K3
 	help
 	  An implementation of Message Manager slave driver for Keystone
 	  and K3 architecture SoCs from Texas Instruments. Message Manager
-- 
2.25.1

