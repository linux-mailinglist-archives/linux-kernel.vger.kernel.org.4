Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601E867F001
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjA0U4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjA0U4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:56:39 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107284FA7;
        Fri, 27 Jan 2023 12:56:35 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 25so1640057oij.13;
        Fri, 27 Jan 2023 12:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8VMvEIlksojIPK+k+dQrshS7s0qt34621V8kUWytFU=;
        b=hsLMgXh/SBJxX5YtaL2yTDP8HoLAMseQfp3gdvZ/8o7GEU6HxS66pXHBQxK20/mWNj
         YHrYPFVVd6xyr6G+x3D5xamR/5cYs9fkpAkUXE7B8pMJ5nmmi2elBvxgfxbCUhHVmUvO
         UVuvBa9vKvm404eJMxzrqXzLj8vbjK2/O9dPxACXeaOgskU9PvxGPpguwXjXFFSp+GnP
         uUe6Une3nAEuXGl2QiegMChGWI06MZCUHxTdenlywjsLGORCwVY6nte1E7ggqA6moMt8
         ubww3EkRawnskZuVJbkCldmcZGJDYPDoScf4nkBNoD0ae5CDzLWopnsPO3vUNvgAjmfX
         +6+A==
X-Gm-Message-State: AFqh2kqU4e1Jv5knTrNpFwNexpOwus1ej12eLf3+7Mi7k1TmY2ZzQAhG
        1dtzKYlrr+kQoWUTwQ1LL46FqAk7Jw==
X-Google-Smtp-Source: AMrXdXs/OCh6QKC+GiDIJTQxk+b6Mswhyo37IPis43vdZ2dPaji5FVVdjT0F5Mebp7rDPuocpruYNQ==
X-Received: by 2002:a05:6808:b37:b0:36e:b267:4d16 with SMTP id t23-20020a0568080b3700b0036eb2674d16mr13761487oij.6.1674852995068;
        Fri, 27 Jan 2023 12:56:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r132-20020acac18a000000b0035c422bb303sm1985437oif.19.2023.01.27.12.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:56:34 -0800 (PST)
Received: (nullmailer pid 668789 invoked by uid 1000);
        Fri, 27 Jan 2023 20:56:33 -0000
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
Subject: [PATCH] perf arm-spe: Only warn once for each unsupported address packet
Date:   Fri, 27 Jan 2023 14:55:46 -0600
Message-Id: <20230127205546.667740-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unknown address packet indexes are not an error as the Arm architecture
can (and has with SPEv1.2) define new ones and implementation defined
ones are also allowed. The error message for every occurrence of the
packet is needlessly noisy as well. Change the message to print just
once for each unknown index.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 091987dd3966..40dcedfd75cd 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -68,7 +68,11 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
 		/* Clean highest byte */
 		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 	} else {
-		pr_err("unsupported address packet index: 0x%x\n", index);
+		static u32 seen_idx = 0;
+		if (!(seen_idx & BIT(index))) {
+			seen_idx |= BIT(index);
+			pr_warning("ignoring unsupported address packet index: 0x%x\n", index);
+		}
 	}
 
 	return payload;
-- 
2.39.0

