Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1F619C45
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiKDPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiKDPza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:55:30 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E5A31230;
        Fri,  4 Nov 2022 08:55:28 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id v81so5593020oie.5;
        Fri, 04 Nov 2022 08:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXxvA5Cmwe9nSMxNL2yH3Amn9qhEZ+Ppqa0CVXQahDM=;
        b=U5UbxaBfThQJ39oJqQdTdI2p+ZQIub5m6zMuOmnFaFq09GZaQc5YSYFG+sXxDhfsqG
         2PZUNnohR5t3csC5mK/hv/mB7Rz6cQXY6Ias2vCqs8a/8zXIIv5s7hSQeeUSjiLSHXSb
         /wpwImNReSt3PdlO9vYA7/ogU52tOqZ4xJqLEeogHU+FcCySge7PKMusji2ue4f4kmTF
         98vxlmIIGQY2PD6aq8AzzpWWg6X5mx5xaLFi6npJae08JhcrEwSOR/XIoGsn64OE9qdv
         HGXDNqtIsCd0fhaG3QpohBTR0+BZwClCgfZUkRqtmiBh1rSfqLfk6WZcwoxR6PY3bvZl
         ksXw==
X-Gm-Message-State: ACrzQf0oGtbwstFQbFU7t9JkkgTnkamHoozSgNlK6TbL/ZI2FhqQ89hx
        qCJ8aOJSRhtLgVhWzVw0z3gHfzuoSA==
X-Google-Smtp-Source: AMsMyM7j75hsQAjfZIMDag+E+uxVO086sbySFKGpZQmxBHGiFVlWgpE6vfapy3lhNwjdU+847kbdBg==
X-Received: by 2002:a05:6808:2023:b0:359:c826:8085 with SMTP id q35-20020a056808202300b00359c8268085mr19906327oiw.156.1667577328221;
        Fri, 04 Nov 2022 08:55:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h4-20020a9d2f04000000b00661a3f4113bsm1532860otb.64.2022.11.04.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:55:27 -0700 (PDT)
Received: (nullmailer pid 1880418 invoked by uid 1000);
        Fri, 04 Nov 2022 15:55:18 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Nov 2022 10:55:05 -0500
Subject: [PATCH v3 5/8] perf: arm_spe: Use new PMSIDR_EL1 register enums
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v3-5-87682f78caac@kernel.org>
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SPE register definitions include enums for some PMSIDR_EL1
fields, use them in the driver in place of magic values.

Signed-off-by: Rob Herring <robh@kernel.org>
---
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
b4 0.11.0-dev
