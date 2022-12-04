Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C972641C7B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLDLAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiLDLAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:00:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA617E2A;
        Sun,  4 Dec 2022 03:00:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so12275344pjc.3;
        Sun, 04 Dec 2022 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5RvZ8Vs38LcoDYdhjpuheLIk1wyz4IAPRl1hVGL5Y8=;
        b=pC9rjfc52hQ7YqNYUZADvof+jNv8RxO6hOo2T/8RFmUDVjmxEitgiPvvYPZ2Y3+1Ob
         vXBpV7pptvhQ82cb2+Lfrh9WzWvkdmVSqkQiu2K9t3RZuRvYZQ7J0vT2iT1zvZByOxvr
         4YuZIPnu2D4ihZDvwzPlBsfX4XCGh801x4KmWrqeO51UfLx7VeGyhpVuK78VfHkq/4WO
         LcYwtw+uihhLndG2plldp+cJ6FaPsruKLii70ev5PxfXyk9mrhwLkNGwKCi+yE/DPN+V
         JEDFI65gBq5ppa65SIrHArNiFUhQX1K2SKBe+XSrRfp/we1H1T25UySCprm14GadvYG5
         U6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5RvZ8Vs38LcoDYdhjpuheLIk1wyz4IAPRl1hVGL5Y8=;
        b=7YEQVB2kq56G+HydDeb/zySzRk1Mxtge4tvPGKifF/y8X9eX3zzJ7DFjLNr3SgPcgW
         5vXtnKZptvPl78ejBu77gPO4eW9kmfgrp+3TymFRkias9NrwI19RbpaMRi55GHcDTe4C
         MWyu/0lnhNELYuIDMt6iIFqid8nN6LiBZyKSTHP4PGCPUhvjxhO2tw/itySDXxSJWguF
         KgHMDa4E54daFDhlX6vR2TO4iMcm+p4Jmv4rfgSMDQ9IxtBFomAeUb4VEZBZgeXa31yL
         xRrn2K9ERvH9o9YMTq94AjD3rElpgCB3bFCa1/UoGGXuVK+jXZusPju5AsIhFfYW/9gN
         Eptw==
X-Gm-Message-State: ANoB5pmaCYVofBiC/Fc1GPMDAZ7UpQA6xnq7o4yen44hDOQdStdWnbrK
        +URlICr7cVTkuhRSRQpKCYQ=
X-Google-Smtp-Source: AA0mqf6dBECA1RqEePKa9ak1weJ733KYD3BqCW72IMKLgtZ0Yft/njHcR3cMaQXEy8CIHuF/yvfy4w==
X-Received: by 2002:a17:90a:d510:b0:219:2f88:ae3a with SMTP id t16-20020a17090ad51000b002192f88ae3amr36466845pju.106.1670151618595;
        Sun, 04 Dec 2022 03:00:18 -0800 (PST)
Received: from localhost.localdomain ([2409:4071:4d9b:ab7d:bb88:d996:31c0:23b8])
        by smtp.gmail.com with ESMTPSA id 72-20020a62154b000000b0056283e2bdbdsm2484336pfv.138.2022.12.04.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 03:00:18 -0800 (PST)
From:   Sohom Datta <sohomdatta1@gmail.com>
X-Google-Original-From: Sohom Datta <sohomdatta1+git@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Sohom Datta <sohomdatta1+git@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Prevent normalize() from reading into undefined memory
Date:   Sun,  4 Dec 2022 16:28:35 +0530
Message-Id: <20221204105836.1012885-1-sohomdatta1+git@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation does not account for a
trailing backslash followed by a null-byte. If a
null-byte is encountered following a backslash,
normalize() will continue reading (and potentially
writing) into garbage memory ignoring the EOS
null-byte.

Signed-off-by: Sohom Datta <sohomdatta1+git@gmail.com>
---
 tools/perf/util/expr.l | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 0168a9637330..d47de5f270a8 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -42,8 +42,11 @@ static char *normalize(char *str, int runtime)
 	char *dst = str;
 
 	while (*str) {
-		if (*str == '\\')
+		if (*str == '\\') {
 			*dst++ = *++str;
+			if (!*str)
+				break;
+		}
 		else if (*str == '?') {
 			char *paramval;
 			int i = 0;
-- 
2.38.1

