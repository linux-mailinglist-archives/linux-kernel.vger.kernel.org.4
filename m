Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABECC74F45D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjGKQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGKQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:05:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8B133
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:05:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-314172bb818so6368065f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689091515; x=1691683515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VNB55+Kj0EnFZI/6YA+WsjU8eHtTcvYjmA+69rBlFU=;
        b=V0CL4KppxA7FXEGPQn5AbE9Edqfb6QVfaGTeFJsRyl8EZbGVgDnQzmuUl4+YIE1+98
         bzrrNWKjYbZXYHxau15yEYhtx5dK1vVKgt5Vg7gVjtoqTi3w0/nwVpoMf/He50w1pVhM
         BtWqlGKXO2nEyElPGsSTRb99Kr5ws5yT5Z/+oEKVDFxscTJY5ffZCF/r9rjIhQZDN5DS
         MzlWZVejVnDzX3TmXQrnl1kS35ImQ7V8IvUE+Xdr5A7FHq8o81OYNPEZ4VjfS22yEssT
         f4Nl26KoNxPDRqfxsJmoy3fBkcubmuwmQNToFHbJbjBx5yNXqsZH+Q3k2DQQQYAc6ZCR
         XcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091515; x=1691683515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VNB55+Kj0EnFZI/6YA+WsjU8eHtTcvYjmA+69rBlFU=;
        b=DlacvX1QgFVZQboAYQikWfQI/xJHDKErxkD9iOMZQWIABmBP3tAOdHDuvSuHkwjGtk
         CUU4ov6nZL7cCXpGWeN6NdpEaOKxhoY+EvE4jw4XZLHL+juwhBgTHSSw8BU01qvPeYsr
         mMgcnw+TrpLZUrGiFqBq5Em8QYR80LPF4iwSZrXENEHzetv4n7wqtEULi+SbzI8kQg0h
         dOB3BG13WZWRN/bJ+DEv821aQGkF0VICG7EfLqfa+AvMp55/Qd3Hnwgea1HDXmHXzyOP
         KHeQEZhNlF55BDgqgT8WvgcWK72sK4DQbhYOgw0JbI8APgftDh9mWwXI2CtQN/xWVc7Q
         FRGg==
X-Gm-Message-State: ABy/qLYcwhMstrn2GDld9CSBrDGXp0xaFFBwVDVUfniSvh1RPzA98vbU
        o9qbBX1BGIXIFlRR9pdV06NNIKm3ISdoaFPNrkitvg==
X-Google-Smtp-Source: APBJJlFSmv5mhuu2nFtdTbkI81Uwo9zlsf1jpmKSUjRjHpww7prtSSW2+g+SpsfUtRyvqpDnRFEnTg==
X-Received: by 2002:adf:ce01:0:b0:314:36c5:e4c0 with SMTP id p1-20020adfce01000000b0031436c5e4c0mr16432328wrn.11.1689091515075;
        Tue, 11 Jul 2023 09:05:15 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b003159d2dabbasm2590377wrr.94.2023.07.11.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:05:14 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 3/3] hwmon: (dimmtemp) Add Sapphire Rapids support
Date:   Tue, 11 Jul 2023 18:04:51 +0200
Message-ID: <20230711160452.818914-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711160452.818914-1-Naresh.Solanki@9elements.com>
References: <20230711160452.818914-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch extends the functionality of the hwmon (dimmtemp) to include
support for Sapphire Rapids platform.

Sapphire Rapids can accommodate up to 8 CPUs, each with 16 DIMMs. To
accommodate this configuration, the maximum supported DIMM count is
increased, and the corresponding Sapphire Rapids ID and threshold code
are added.

The patch has been tested on a 4S system with 64 DIMMs installed.
Default thresholds are utilized for Sapphire Rapids, as accessing the
threshold requires accessing the UBOX device on Uncore bus 0, which can
only be achieved using MSR access. The non-PCI-compliant MMIO BARs are
not available for this purpose.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/hwmon/peci/dimmtemp.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index ed968401f93c..edafbfd66fef 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -30,8 +30,10 @@
 #define DIMM_IDX_MAX_ON_ICX	2
 #define CHAN_RANK_MAX_ON_ICXD	4
 #define DIMM_IDX_MAX_ON_ICXD	2
+#define CHAN_RANK_MAX_ON_SPR	128
+#define DIMM_IDX_MAX_ON_SPR	2
 
-#define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_HSX
+#define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_SPR
 #define DIMM_IDX_MAX		DIMM_IDX_MAX_ON_HSX
 #define DIMM_NUMS_MAX		(CHAN_RANK_MAX * DIMM_IDX_MAX)
 
@@ -530,6 +532,15 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 	return 0;
 }
 
+static int
+read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u32 *data)
+{
+	/* Use defaults */
+	*data = (95 << 16) | (90 << 8);
+
+	return 0;
+}
+
 static const struct dimm_info dimm_hsx = {
 	.chan_rank_max	= CHAN_RANK_MAX_ON_HSX,
 	.dimm_idx_max	= DIMM_IDX_MAX_ON_HSX,
@@ -572,6 +583,13 @@ static const struct dimm_info dimm_icxd = {
 	.read_thresholds = &read_thresholds_icx,
 };
 
+static const struct dimm_info dimm_spr = {
+	.chan_rank_max	= CHAN_RANK_MAX_ON_SPR,
+	.dimm_idx_max	= DIMM_IDX_MAX_ON_SPR,
+	.min_peci_revision = 0x40,
+	.read_thresholds = &read_thresholds_spr,
+};
+
 static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
 	{
 		.name = "peci_cpu.dimmtemp.hsx",
@@ -597,6 +615,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
 		.name = "peci_cpu.dimmtemp.icxd",
 		.driver_data = (kernel_ulong_t)&dimm_icxd,
 	},
+	{
+		.name = "peci_cpu.dimmtemp.spr",
+		.driver_data = (kernel_ulong_t)&dimm_spr,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, peci_dimmtemp_ids);
-- 
2.41.0

