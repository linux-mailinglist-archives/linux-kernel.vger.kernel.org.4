Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9272474DB72
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGJQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGJQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:47:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F919E3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:47:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso52808395e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689007636; x=1691599636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irZH5XR1T/qwnIyZTduD5l9vw+nb1uCdEROQyV19vtI=;
        b=Dz9FexAqOifkjtZ0/rZjnlB5kjjRexvmEsWnAVPg/iyKY4fBWOoIDGAJ72A/gzSeV9
         n12cbYDmLsHYlGcMHUtPT0NF0kB2QZ3a1GrFGw3PEia7lbaSzPD3NPN1Z2Jw1tzYUvLU
         oRoO9N7hXYtlB1f9DNxsKEBZ5QSG11l3z/9xuj6tY0oLla5mL84Ld+dC3I3O61EFIpkN
         kDXugtGMgKTyqdhBvkQUsdnqmms85BVNbIRBdYWZfcV40scneK1z0SOspwHMUW/O030O
         ryHNVk7KnTFAAS629I4ry84ab2I8H7q3icoV+9MeFQxF5+TGS2ROtTGsF+0LKfj1TJ2E
         Axig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689007636; x=1691599636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irZH5XR1T/qwnIyZTduD5l9vw+nb1uCdEROQyV19vtI=;
        b=PAgpKPbV5BlHxQwomeC2tSh2Nbp5oHH9LGFw95rLyK9RaoWtIGiQzQnq801DexGBMT
         Ykke3aVnyvZHuPQxnEEyfp5kumq0X0Ep2udAenIz2bS9uYfk3ebvW7GJkY62sWUWWcuZ
         gGpZbB0zW3TcLFDe14K2ohUD4kHMLP8lZ61nDT7qlO8Zg1b6Exisp48vTNOPiCzTjl9u
         fZxliX3Rk6nQYni1k+WjJ9/eDL0CHCR8fr+3Q6spPgAWuMUnc6w0pGhG1YWNfnmsahVB
         QQTsKyd0UdJnHvGWaB4dNxqJP6l0s/Occg4hEnyZId7TlUVR7fSdFYryKo0XTHQWjBRs
         goAw==
X-Gm-Message-State: ABy/qLaAsaaLtKkTcvOoEfJ2l4cjbdFU0CYgFKLA1LCztvSAcSo7v4WJ
        V8efPiHlU0dZUo/nsY/mvJSJKzffWDUQvjTZhVIWvA==
X-Google-Smtp-Source: APBJJlGKH+jb9DaxU3qp5wI2jxJU1bnePW8y+5lpEySQhjtJAUag+JT6QNsQeAz72lQDztMSe/9YUw==
X-Received: by 2002:a05:600c:364c:b0:3fb:b5cb:1130 with SMTP id y12-20020a05600c364c00b003fbb5cb1130mr12897496wmq.34.1689007636636;
        Mon, 10 Jul 2023 09:47:16 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003fbe791a0e8sm394704wmd.0.2023.07.10.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:47:16 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 2/2] hwmon: (dimmtemp) Add Sapphire Rappids support
Date:   Mon, 10 Jul 2023 18:47:04 +0200
Message-ID: <20230710164705.3985996-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710164705.3985996-1-Naresh.Solanki@9elements.com>
References: <20230710164705.3985996-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch extends the functionality of the hwmon (dimmtemp) to include
support for Sapphire Rappids platform.

Sapphire Rappids can accommodate up to 8 CPUs, each with 16 DIMMs. To
accommodate this configuration, the maximum supported DIMM count is
increased, and the corresponding Sapphire Rappids ID and threshold code
are added.

The patch has been tested on a 4S system with 64 DIMMs installed.
Default thresholds are utilized for Sapphire Rappids, as accessing the
threshold requires accessing the UBOX device on Uncore bus 0, which can
only be achieved using MSR access. The non-PCI-compliant MMIO BARs are
not available for this purpose.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/hwmon/peci/dimmtemp.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index ce89da3937a0..ea4ac5a023cf 100644
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
 
@@ -534,6 +536,15 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
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
@@ -576,6 +587,13 @@ static const struct dimm_info dimm_icxd = {
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
@@ -601,6 +619,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
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

