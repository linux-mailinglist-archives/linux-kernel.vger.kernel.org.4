Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F263674F45E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGKQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGKQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:05:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE34E60
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:05:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-314417861b9so5947888f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689091514; x=1691683514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ6zIJuacID5DOSHqnnoP33bErwpH8EdehQ+RhKIoRY=;
        b=cqjF8kmNdfLVDPdvvG0sxY2ov+69drHqon+x5ZIHqNYWu2KVbRJ2ZOezhBVyUdUP7O
         1S7rGwrbbM3zMg4RrJCNLPTb4HLyAZUehEJ1byJE+MTryZPOFsKn81ZXDGyoPgn71IPx
         dZrzv/Ky7QoyympNY6vi1vEL0GBc6Nkh9L3fKN5TuwlRmFfmeaQTKSIAt/QPb5jItfjm
         CzeYstqAhC7uow8E7tB1MRWWrfeg4AtsYmkKwaB6EsxzrsbtoiiNB7pg3CNbF159CuU9
         F1/QJJGQMM88ap0e9rzz2bzim2XhajupwwwB1su6u8GY4+sM39VByq2VOIFrFpAhhDPb
         ZnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091514; x=1691683514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJ6zIJuacID5DOSHqnnoP33bErwpH8EdehQ+RhKIoRY=;
        b=IqN5vP1G8FkigrmgKLRPLU0pwk0xj9hxrp5j+hXmv3nNSIYWmVCWHmPjj2/BA3aS2q
         hHAoHT+fR7V65EInM6yezhdHr/xgQvjEhJkugH+ade4uptgsMC3v7ZbZuHtxMUp5J5GL
         A3E85FPJ6xpFmynL4UDMWa07u0S8qgJlJmyFvEOgmlcV/TR6fP/GV1cmvgdfSORYJElK
         Ic7lFmmaCqwXUeYDmAQmd8V4Hunqh59mU/pWQ43I+N1+EUGvMd1foiRCLi/i2nuHNB3e
         piabA0HIWZ7uPb95jmkwt+CQy4ZOw0pFcw3cFgi1Cpl9wqB1ApmE/cAE+4O4FCg9RrIr
         OGhg==
X-Gm-Message-State: ABy/qLb2CraWE/nw5m76NCtyB0mii1ZVH0AxM9NmRyJ0o+AKanhxE3bZ
        CiJH6Tccry3gJwJjZETAAaEibA6/PQfHwfINmuofUg==
X-Google-Smtp-Source: APBJJlFBlmktdcZYIUZKA4HPuooXWyZXhV79B7dghEn80d1rlfC9GDjz+NJ8H2jGbQTKlzdbL6NX6A==
X-Received: by 2002:a5d:58cf:0:b0:313:f399:6cea with SMTP id o15-20020a5d58cf000000b00313f3996ceamr16513594wrf.4.1689091513872;
        Tue, 11 Jul 2023 09:05:13 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b003159d2dabbasm2590377wrr.94.2023.07.11.09.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:05:13 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 2/3] hwmon: (peci/cputemp) Add Intel Sapphire Rapids support
Date:   Tue, 11 Jul 2023 18:04:50 +0200
Message-ID: <20230711160452.818914-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711160452.818914-1-Naresh.Solanki@9elements.com>
References: <20230711160452.818914-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support to read DTS for reading Intel Sapphire Rapids platform.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/hwmon/peci/cputemp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
index e5b65a382772..a812c15948d9 100644
--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -363,6 +363,7 @@ static int init_core_mask(struct peci_cputemp *priv)
 	switch (peci_dev->info.model) {
 	case INTEL_FAM6_ICELAKE_X:
 	case INTEL_FAM6_ICELAKE_D:
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
 					     reg->func, reg->offset + 4, &data);
 		if (ret)
@@ -531,6 +532,13 @@ static struct resolved_cores_reg resolved_cores_reg_icx = {
 	.offset = 0xd0,
 };
 
+static struct resolved_cores_reg resolved_cores_reg_spr = {
+	.bus = 31,
+	.dev = 30,
+	.func = 6,
+	.offset = 0x80,
+};
+
 static const struct cpu_info cpu_hsx = {
 	.reg		= &resolved_cores_reg_hsx,
 	.min_peci_revision = 0x33,
@@ -549,6 +557,12 @@ static const struct cpu_info cpu_icx = {
 	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
 };
 
+static const struct cpu_info cpu_spr = {
+	.reg		= &resolved_cores_reg_spr,
+	.min_peci_revision = 0x40,
+	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
+};
+
 static const struct auxiliary_device_id peci_cputemp_ids[] = {
 	{
 		.name = "peci_cpu.cputemp.hsx",
@@ -574,6 +588,10 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
 		.name = "peci_cpu.cputemp.icxd",
 		.driver_data = (kernel_ulong_t)&cpu_icx,
 	},
+	{
+		.name = "peci_cpu.cputemp.spr",
+		.driver_data = (kernel_ulong_t)&cpu_spr,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, peci_cputemp_ids);
-- 
2.41.0

