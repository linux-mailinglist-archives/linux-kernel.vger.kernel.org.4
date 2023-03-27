Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC96CAA72
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjC0QVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjC0QV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:21:29 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9D1703;
        Mon, 27 Mar 2023 09:21:27 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id r17-20020a05683002f100b006a131458abfso2250867ote.2;
        Mon, 27 Mar 2023 09:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUchPzCfEDoAcWSUXsrvq0YAKCI8zZA5EOxLOkeJdPo=;
        b=1CI9jaOR5hjxN8cdANpQvZcm2vRHiyL6VLXyMf47J/demhsTaZRdseUOZFYNinlWBk
         o5d25R3RoiRP1vKotzyRNZTFEeXcDs4Uw74Mt5atqX7EPnAbF5DohdJSKC9aH+tSw/jh
         R75xFsV7qASiB6V2HkpGlB8E5fphl7h+oKkkKpmEvGHT2wbH0o3f0BdoE/xYSsI5x19m
         O3g5FsAsVA2mNRKejpJBPQCNHwuqsmxMBMPctWYKuqWC4kZOC4qm0dhWVLp3X1s+cGh+
         yH4kL4xBW3ChTje/pQbkPj0bpc3e7XA8ryn7QA7SyUBnn7qO15DkM8PLo0s9jbW199nQ
         arEw==
X-Gm-Message-State: AO0yUKXm1gDvBCJAGkI0Uo0Olwatyr6VVh4sFzW5Lq804exBSJet9lff
        CxR77e8bDBjd+Jfm2hUNcw==
X-Google-Smtp-Source: AK7set/dIPQXXeKARh/aAwV2/iPpvDtCnrJz0HfzuajCYb/+mzV1/ksarPBKikAo25FgOtXLd5MQBA==
X-Received: by 2002:a05:6830:1bc5:b0:694:39d1:a225 with SMTP id v5-20020a0568301bc500b0069439d1a225mr6428507ota.17.1679934086977;
        Mon, 27 Mar 2023 09:21:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d4b04000000b0069f509ad088sm2682943otf.65.2023.03.27.09.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:21:22 -0700 (PDT)
Received: (nullmailer pid 4057633 invoked by uid 1000);
        Mon, 27 Mar 2023 16:21:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf arm-spe: Add raw decoding for SPEv1.3 MTE and MOPS load/store
Date:   Mon, 27 Mar 2023 11:20:57 -0500
Message-Id: <20230327162057.4057188-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPEv1.3 adds new load/store operation subclasses for Memory Tagging
Extension (MTE) and memory operations (MOPS). The memory operations
are memcpy and memset. Add support for decoding these new subclasses in
the raw decoding.

Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 9 +++++++++
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index fed4741f372e..a454c6737563 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -381,6 +381,15 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " NV-SYSREG");
 			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG:
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MTE-TAG");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_MEMCPY:
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MEMCPY");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_MEMSET:
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MEMSET");
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index f75ed3a8a050..464a912b221c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -123,6 +123,9 @@ enum arm_spe_events {
 #define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	0x4
 #define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG	0x10
 #define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG	0x30
+#define SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG	0x14
+#define SPE_OP_PKT_LDST_SUBCLASS_MEMCPY		0x20
+#define SPE_OP_PKT_LDST_SUBCLASS_MEMSET		0x25
 
 #define SPE_OP_PKT_IS_LDST_ATOMIC(v)		(((v) & (GENMASK_ULL(7, 5) | BIT(1))) == 0x2)
 
-- 
2.39.2

