Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB167F00A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjA0VAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjA0U77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:59:59 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212078AC7;
        Fri, 27 Jan 2023 12:59:58 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-15085b8a2f7so8143232fac.2;
        Fri, 27 Jan 2023 12:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgCIzyZ1uXoig+M3du7hOj+YSCBLDMUCra02vD8O8os=;
        b=BHtDZ/DddZTTKlp2i3zDeFyrJXEfigDbsrSLvL+cEwjBBBEfjwNag256Mkl8l0MO/4
         4OPiAUP3g1guKWzQmnCYFQzQM6kzl89NZJ3+QtfI0tR+QPjXz09v88tICLOeYmTUFhgp
         Zce2XkDjHRWAnCTbL3j4Uwv6LWkQHrOqgWnZwLDwJ5BaVVcld9B09FPDqDtAdE9w/wFR
         2VE6GoM6ibZcGZJNl5/0S9rkoMmhrSB3AvrXpETkKDkm34U2RILUpk341XzwsLubXPc5
         S1RNre2wibQvt+tFprqhv3HIxFVEGnAqLyUsjv4245Wbx4q/8cbh8b62qTcbTIC8cUY4
         DypQ==
X-Gm-Message-State: AO0yUKVjC6xMihqLYxJr444qRHPn1VPGzJOu9qDUHAj3x3jDhb6BJ0h9
        8V0rOkYdYixfHghPt2rqSg==
X-Google-Smtp-Source: AK7set9yiHwcCjUqkk9qrXPSP2PS8fDIfxq4G9mbG19hiKCSbd8EpZfLDrnJm/GFw1JgRGB1IDQkPg==
X-Received: by 2002:a05:6870:3312:b0:163:4aa1:a92a with SMTP id x18-20020a056870331200b001634aa1a92amr4569506oae.10.1674853197128;
        Fri, 27 Jan 2023 12:59:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p1-20020a4aa241000000b004fde329b944sm2082031ool.28.2023.01.27.12.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:59:56 -0800 (PST)
Received: (nullmailer pid 673390 invoked by uid 1000);
        Fri, 27 Jan 2023 20:59:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf arm-spe: Add raw decoding for SPEv1.2 previous branch address
Date:   Fri, 27 Jan 2023 14:59:51 -0600
Message-Id: <20230127205951.673253-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPEv1.2 adds a new optional address packet type: previous branch
target. The recorded address is the target virtual address of the most
recently taken branch in program order.

Add support for decoding the address packet in raw dumps.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 +++-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 2f311189c6e8..e92e1a7c8a8e 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -422,16 +422,18 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	int ch, pat;
 	u64 payload = packet->payload;
 	int err = 0;
+	static const char *idx_name[] = {"PC", "TGT", "VA", "PA", "LBR" };
 
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

