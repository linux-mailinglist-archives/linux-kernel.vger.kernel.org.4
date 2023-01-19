Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5371D673208
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjASHCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:02:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6726A5;
        Wed, 18 Jan 2023 23:02:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q10so893836wrs.2;
        Wed, 18 Jan 2023 23:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVejuSpufQoHVCnyKKrCfjSO3sMF3yvPZTzZzBmN5U4=;
        b=Lb5M9rUW4h0g7yi2Ye4TdWod0MffWK72w3BHfPesKWM7UnwjSjEQTscE83rJwQCUGr
         WYALQ3EIgERt4u5/lNxio9ooP2S+TNckJAW3o6KnaXiDpkRngDw0irxgAT6N3e3rAxX3
         5ayWBFxlxqNDNAPoPdoPunjbd/lXpgLbc7FIXboxcha0YvXhJ2A2u9Qpup39Z7RNzUGN
         7MZ6SFuCKs2ZHTvTIipvbc51t6zGaREKIQ4evduo1KAKT7xmQsGYzokqY6sH9VPKOS2e
         dmCpmbwIx6PKYNvSqFIqsD9LFGglcCQAzE1ja83L06BGXG/KKIg/+vomGr7QFg7Drn4W
         MCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVejuSpufQoHVCnyKKrCfjSO3sMF3yvPZTzZzBmN5U4=;
        b=qZH7in5GsWAlm3BZp/P+gR3jjxznefY78T0dtqtWd/KFLOI9haSG+LP6rqBKFJlY9R
         kiXNyIHfjaS6GJRtswVR3wCkrlnBV4z9gJKf/bvJawOtUyZFFRuXmhTGfi0UN4SiBbf2
         qDa7RNeuNb9uLsFXywXrchQfOgbBbvrfsBvLH3YslVFequc6ayNAasHSffI6yEM4vdVR
         rLXGB00Sp4gTq0KmF7Y3MtFfVe2HIMzvIaOWWhFv5iRprGzyG9Rn64olIjbZpoH94ObW
         A8XlwVWpIHEqIZ8JnJRc4uBHzApS2mKc0qFHgu+5A6c8x0ts3o3bqvrcrr5LqODe1TY4
         dzxQ==
X-Gm-Message-State: AFqh2kqSY7DYqX2donj5jfBXS4fOCvDVONKxKdMWmAWcLKGRRF5Ib+sU
        +uaK37v3IVBxxTTZBwad/Uw=
X-Google-Smtp-Source: AMrXdXsOg+jK73ghQeVgFHO14gSXLMD5c2D3ROLHrCQQaaxekrtRrZltX8L/tCEmMipKUTtuQJCj6w==
X-Received: by 2002:a05:6000:608:b0:28f:29b3:1a7f with SMTP id bn8-20020a056000060800b0028f29b31a7fmr9628995wrb.36.1674111729960;
        Wed, 18 Jan 2023 23:02:09 -0800 (PST)
Received: from skynet.lan (198.red-79-146-135.dynamicip.rima-tde.net. [79.146.135.198])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6402000000b00297dcfdc90fsm32735943wru.24.2023.01.18.23.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 23:02:09 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] intel_idle: Add RaptorLake support
Date:   Thu, 19 Jan 2023 08:02:05 +0100
Message-Id: <20230119070205.90047-1-noltari@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds RaptorLake support to the intel_idle driver.

Since RaptorLake and AlderLake C-state are characteristics the same, we use
AlderLake C-states tables for RaptorLake as well.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/idle/intel_idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cfeb24d40d37..1a35b98d9bae 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1429,6 +1429,9 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&idle_cpu_adl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&idle_cpu_adl_l),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&idle_cpu_adl_n),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&idle_cpu_adl),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&idle_cpu_adl_n),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&idle_cpu_adl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
@@ -1867,6 +1870,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
 	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_RAPTORLAKE:
+	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
 		adl_idle_state_table_update();
 		break;
 	}
-- 
2.34.1

