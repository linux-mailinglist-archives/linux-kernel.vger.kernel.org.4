Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED08663047
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbjAIT0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjAIT0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:26:37 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8996B41677;
        Mon,  9 Jan 2023 11:26:36 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id d2-20020a4ab202000000b004ae3035538bso2670723ooo.12;
        Mon, 09 Jan 2023 11:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHSlQOy0DTb5kpZ2VrRAyIMZfdxCwZTHcJtASnW13Hw=;
        b=Asn68QyM6lYSWAJb5xdbEAYQQi13DwUKGN8RhkUntZt3sWNwuj9HjCWG6QqKaOgxsg
         5JCa/x9IQxgCDFiJgX5qbzlXNVXmJFYB1et/YZktEdbHrvE6BSZpWVhPOFjwO2TPQh2E
         tSTsTPpHL/VNH/Uvd/8TLGHr2i1/lSgDWGNCTqzvUr7mFCikiZKElV8XUXCK2Kdbb5hy
         oAdg203S+DCo9AqsNDs6JEEtMaw5zkNAziJbAevkJwldvOmVSXxlqjjvHtYUwjhf96Nj
         QQc2AeKvzS0mV3/isKtkHPds7oLNeb1ArHLVWcKXMlnj2kuWyVpZyDS8OUjznf03DIqR
         ARvw==
X-Gm-Message-State: AFqh2kqtp8UU4q8L+KQxBXB2Ug2ilyHNqZ9Rb4rY+W64DLKruvMN8Dqh
        WceqL8UXcB+qRZYp0pUDsnsAK7WumQ==
X-Google-Smtp-Source: AMrXdXslv2cqi91atU/B1PN1NvgkNq9E8RL7xl+DfP3jhUzhvSFMQFy52Ps3fK8W50Elu43MF7MA+A==
X-Received: by 2002:a4a:e383:0:b0:4f1:e731:3ee3 with SMTP id l3-20020a4ae383000000b004f1e7313ee3mr4328955oov.2.1673292395567;
        Mon, 09 Jan 2023 11:26:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p2-20020a4ab382000000b004d8c6815287sm4542966ooo.17.2023.01.09.11.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:26:35 -0800 (PST)
Received: (nullmailer pid 1483614 invoked by uid 1000);
        Mon, 09 Jan 2023 19:26:31 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 09 Jan 2023 13:26:21 -0600
Subject: [PATCH v4 5/8] perf: arm_spe: Use new PMSIDR_EL1 register enums
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220825-arm-spe-v8-7-v4-5-327f860daf28@kernel.org>
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SPE register definitions include enums for some PMSIDR_EL1
fields, use them in the driver in place of magic values.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
 - Rebase on v6.2-rc1
v3: New patch
---
 drivers/perf/arm_spe_pmu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9b4bd72087ea..af6d3867c3e7 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1006,32 +1006,32 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	/* This field has a spaced out encoding, so just use a look-up */
 	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
 	switch (fld) {
-	case 0:
+	case PMSIDR_EL1_INTERVAL_256:
 		spe_pmu->min_period = 256;
 		break;
-	case 2:
+	case PMSIDR_EL1_INTERVAL_512:
 		spe_pmu->min_period = 512;
 		break;
-	case 3:
+	case PMSIDR_EL1_INTERVAL_768:
 		spe_pmu->min_period = 768;
 		break;
-	case 4:
+	case PMSIDR_EL1_INTERVAL_1024:
 		spe_pmu->min_period = 1024;
 		break;
-	case 5:
+	case PMSIDR_EL1_INTERVAL_1536:
 		spe_pmu->min_period = 1536;
 		break;
-	case 6:
+	case PMSIDR_EL1_INTERVAL_2048:
 		spe_pmu->min_period = 2048;
 		break;
-	case 7:
+	case PMSIDR_EL1_INTERVAL_3072:
 		spe_pmu->min_period = 3072;
 		break;
 	default:
 		dev_warn(dev, "unknown PMSIDR_EL1.Interval [%d]; assuming 8\n",
 			 fld);
 		fallthrough;
-	case 8:
+	case PMSIDR_EL1_INTERVAL_4096:
 		spe_pmu->min_period = 4096;
 	}
 
@@ -1050,10 +1050,10 @@ static void __arm_spe_pmu_dev_probe(void *info)
 		dev_warn(dev, "unknown PMSIDR_EL1.CountSize [%d]; assuming 2\n",
 			 fld);
 		fallthrough;
-	case 2:
+	case PMSIDR_EL1_COUNTSIZE_12_BIT_SAT:
 		spe_pmu->counter_sz = 12;
 		break;
-	case 3:
+	case PMSIDR_EL1_COUNTSIZE_16_BIT_SAT:
 		spe_pmu->counter_sz = 16;
 	}
 

-- 
2.39.0
