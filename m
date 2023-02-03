Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841D689F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjBCQYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBCQYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:24:20 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62197A145A;
        Fri,  3 Feb 2023 08:24:19 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so1499328otj.4;
        Fri, 03 Feb 2023 08:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLYnCQyeaEFRYpdwDRzWM+QNJiylMM8MiQQoWzGLB1E=;
        b=1H7GvAVV/ZRPXsYfiZkqRiNsUzYUXORxcQBABncir4lMvKSBcCTZGjniWqU9r+HXbI
         S6wy4XPzUZHzuTIAbtf/QPTIjP7RNRbBRJAvhnRJP3113OBnsQimSkW2A05CKI6WG4G1
         0Xbv3JEBCtEt4oXKGptqSPWIfO64AOhSQhUmfv+qMh0sKcdc4nSig7dfcL4d1REjuGXr
         Cjnv8yP8Y1CpS9Mb9ml2xRTWqMFCRxG29fsQ0e+YiOKj5JRkh+2HKYmP+4ZCIfd3Wn8u
         pRTN4hezYQvMM+Q7X6touRL0Jys9dPrWhpSCGkRVThYjh2HtjULr7FeVLaTth/HLGXyI
         F7qA==
X-Gm-Message-State: AO0yUKV918JjcXdSwzfxA7G8xBDOwCkPtHwAdCirVsaJBGZ9t9Kiuxju
        2C+Me4QiB8sW6LiilB8S4g==
X-Google-Smtp-Source: AK7set9QioEE/PM5u0iYo9g/U2ZPZTBowfiB9/BrKUMguMO9j2THXRLKmTwSGAMdI7jsdBHUJKjsIA==
X-Received: by 2002:a9d:4a4:0:b0:675:fef1:e2a6 with SMTP id 33-20020a9d04a4000000b00675fef1e2a6mr2106366otm.35.1675441458581;
        Fri, 03 Feb 2023 08:24:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l28-20020a056830335c00b00684ccbfe012sm1276802ott.27.2023.02.03.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:24:18 -0800 (PST)
Received: (nullmailer pid 133229 invoked by uid 1000);
        Fri, 03 Feb 2023 16:24:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf arm-spe: Add raw decoding for SPEv1.2 previous branch address
Date:   Fri,  3 Feb 2023 10:24:01 -0600
Message-Id: <20230203162401.132931-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPEv1.2 adds a new optional address packet type: previous branch
target. The recorded address is the target virtual address of the most
recently taken branch in program order.

Add support for decoding the address packet in raw dumps.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Use "PBT" instead of "LBR"
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 +++-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 2f311189c6e8..fed4741f372e 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -422,16 +422,18 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	int ch, pat;
 	u64 payload = packet->payload;
 	int err = 0;
+	static const char *idx_name[] = {"PC", "TGT", "VA", "PA", "PBT"};
 
 	switch (idx) {
 	case SPE_ADDR_PKT_HDR_INDEX_INS:
 	case SPE_ADDR_PKT_HDR_INDEX_BRANCH:
+	case SPE_ADDR_PKT_HDR_INDEX_PREV_BRANCH:
 		ns = !!SPE_ADDR_PKT_GET_NS(payload);
 		el = SPE_ADDR_PKT_GET_EL(payload);
 		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 		arm_spe_pkt_out_string(&err, &buf, &buf_len,
 				"%s 0x%llx el%d ns=%d",
-				(idx == 1) ? "TGT" : "PC", payload, el, ns);
+				idx_name[idx], payload, el, ns);
 		break;
 	case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
 		arm_spe_pkt_out_string(&err, &buf, &buf_len,
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 9b970e7bf1e2..f75ed3a8a050 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -65,6 +65,7 @@ struct arm_spe_pkt {
 #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		0x1
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	0x2
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	0x3
+#define SPE_ADDR_PKT_HDR_INDEX_PREV_BRANCH	0x4
 
 /* Address packet payload */
 #define SPE_ADDR_PKT_ADDR_BYTE7_SHIFT		56
-- 
2.39.0

