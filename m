Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176386C515F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCVQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCVQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:58:10 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39719C6B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:58:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5A95120007;
        Wed, 22 Mar 2023 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679504287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0DSwTWAElJZIp9DwGFl/1GywW/Rxfgdyjr2ORr+Pfg=;
        b=Z5TvrXxNV0wxhQzJOnIzKjpE6LYsWW6wTMX9cbWkLhE7diKjrxyRKV5JlleTj+fhND15Du
        lnKHDCpa4M2lYSvYzyOFkvLVKF9QWScA1heAIWiFyf3IkO4XeHmg+A1i4coeeCrcj06BM0
        dcLFRHIZ56T4W/KUXQ2gyIFLPtx/uzmJponeFMx7gE41VVaVqK6B+2iGn76bT6UrSmRmnL
        HkfVcDYGWhDsuG29DNgOk6dYsnxU8TqQovB1bnw3HZUt+5XE0ZQfTEUj7F1otjNR/KdSbE
        bz6DPNNfDea20ED49KHhE12XmjhYI5cGUNSRlUvlqbYlYOjxdvNNn0gJBLDFXg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 1/4] nvmem: Add macro to register nvmem layout drivers
Date:   Wed, 22 Mar 2023 17:58:01 +0100
Message-Id: <20230322165804.2240285-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
References: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a module_nvmem_layout_driver() macro at the end of the
nvmem-provider.h header to reduce the boilerplate when registering nvmem
layout drivers.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/nvmem-provider.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0cf9f9490514..3e97c8315c45 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_NVMEM_PROVIDER_H
 #define _LINUX_NVMEM_PROVIDER_H
 
+#include <linux/device/driver.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
@@ -240,4 +241,9 @@ nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 }
 
 #endif /* CONFIG_NVMEM */
+
+#define module_nvmem_layout_driver(__layout_driver)		\
+	module_driver(__layout_driver, nvmem_layout_register,	\
+		      nvmem_layout_unregister)
+
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.34.1

