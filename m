Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281126E83E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDSVmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDSVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:42:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3A1725
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:42:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j6-20020a255506000000b00b8ef3da4acfso732277ybb.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681940569; x=1684532569;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QFk3NDBSTwsf46CD7CCGYv7KNF2ituHS8Syu4/I42IA=;
        b=TPgvQQOkU7C2IRDFXO2Tvb+o3vbeurUDCo89PNRoJ/gyh72TudRR0kGvTkOq3PQm9A
         Ob9WhzlHTolqp5jZXt4a7hkm94lP1ZCmFvJmcvt0kY8bRusXEIX9d/5yzrY+einBMbmu
         92fYGg1HYNxxfshZOhEhN/kxGSvu8t1iieJ++fQnHirs2D5ZapN169j9F0FF4vJurc77
         5NPUxkVYTs79DNn7fuH8OI08RQmVHO2aqIy3o2jRaxrJMleK7GILIwGDxYHkvAIFavIQ
         RAQGVO8Z2wvdu/ZAFyfPskTFnsip01GZabhZBk30P09egUdANl1+rCu+MUaYKcBjyNUL
         SBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681940569; x=1684532569;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFk3NDBSTwsf46CD7CCGYv7KNF2ituHS8Syu4/I42IA=;
        b=Js6YhdBy7E+oJT1Uxhij/RuXpOApdJdEaVEYHk4a7l5YHtRFLV5NVoEILRCcU6h2GI
         CDDy0tlgmy3msS/0rtZjw892knPosVuve+4eONH0eNh6FvrtABz5M7KdfVHebngEApGl
         zXbBoEu0R4imIURpKGU4S09ejrTz3KlDGS3ZOLBoUgzQ2VUsU62i3XYPYrDJQiSeT6Qz
         c1B7ibcpv8suLuqJY5h002wTirNDnR9dggD62z+pPlSjuh6Qn96cjmyjuFUyR6iXZCKG
         jeWLCKe3hZxp7UjnTJ/4nbJg4+u7NAsnVIWaNLr2qnle6kvGdCjVc6zuI6NyQgb8iwLl
         G2Aw==
X-Gm-Message-State: AAQBX9eeJGmkWdHlHv4rC36LwDGfh3Xq4/IUyV/p69NDvnYdoZdWgyAP
        v+zu8Pi45cHgZ9qZ1C+MrfE66C59YMyhSpVS4bu4HOYAcd5QPlZDbXt5+xacn0PsA3OQ/QDEe90
        z/mXMx0u5CdfuiwbhQsMrHnrtEzBiGPP6zcvE9LZuO8bfJBoYybTOR5dKq31Wfv0yvA+S5Oou
X-Google-Smtp-Source: AKy350YVZv81Nrxp+WJlpAyKa/Em9olmxGhYDjV93fytvetbi9F+mIB8l59ihAsXgroqIA9LNGe7HP0GcMTu
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:393f:d33d:fa63:7e9])
 (user=eranian job=sendgmr) by 2002:a81:4426:0:b0:54f:ae82:3f92 with SMTP id
 r38-20020a814426000000b0054fae823f92mr2823318ywa.2.1681940569271; Wed, 19 Apr
 2023 14:42:49 -0700 (PDT)
Date:   Wed, 19 Apr 2023 14:42:41 -0700
Message-Id: <20230419214241.2310385-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Subject: [PATCH] perf/x86/intel/uncore: add events for Intel SPR IMC PMU
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kan.liang@intel.com, ak@linux.intel.com,
        namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clockticks and cas_count_* events for Intel SapphireRapids IMC
PMU. These events are useful to measure memory bandwidth.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 7d1199554fe3..fa9b209a11fa 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6068,6 +6068,17 @@ static struct intel_uncore_ops spr_uncore_mmio_ops = {
 	.read_counter		= uncore_mmio_read_counter,
 };
 
+static struct uncore_event_desc spr_uncore_imc_events[] = {
+	INTEL_UNCORE_EVENT_DESC(clockticks,      "event=0x01,umask=0x00"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read,  "event=0x05,umask=0xcf"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write, "event=0x05,umask=0xf0"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write.unit, "MiB"),
+	{ /* end: all zeroes */ },
+};
+
 static struct intel_uncore_type spr_uncore_imc = {
 	SPR_UNCORE_COMMON_FORMAT(),
 	.name			= "imc",
@@ -6075,6 +6086,7 @@ static struct intel_uncore_type spr_uncore_imc = {
 	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
 	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
 	.ops			= &spr_uncore_mmio_ops,
+	.event_descs		= spr_uncore_imc_events,
 };
 
 static void spr_uncore_pci_enable_event(struct intel_uncore_box *box,
-- 
2.40.0.634.g4ca3ef3211-goog

