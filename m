Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F14659E54
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiL3Xc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiL3Xc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:32:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327412D20;
        Fri, 30 Dec 2022 15:32:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id co23so21064943wrb.4;
        Fri, 30 Dec 2022 15:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I67DJyMZ2pVBI8781A9LPZqkSNUsohSh0BZqH+JheCc=;
        b=nWx3Otszq8LNvUhzN+GkPHe49rJvZicXb/35lWUQBDolDbDSfowtvv0JzqvXuPnJ0V
         xQICKBGUryYOphQGf6/Bed0u9HTDWwdqPVHbD3vKUK7tR+UV1b/ph8k4SX/cRVT9lvB+
         cB+tfVcg+u5YkwozoBuGwVIUJrahnf+maImB0uyd0FhSBLDbUqgjtshFvtfnBqIrpYcS
         rdosCBYzdycSQ+Ypbv5QKd/8oNWNYCruQLazjyL6J0PQKS9auceBKNja09ecolvjXptz
         UqqBwPQN775CY4NICoBh/69cDhCUw1BswPZPcCklVBB2rKLmezKhDIHaBvazmPDizbsW
         77gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I67DJyMZ2pVBI8781A9LPZqkSNUsohSh0BZqH+JheCc=;
        b=Hs/vzKE8y7nW3DbzTclc7zhtbaIuRANsaSXXEqytc0i9/8HSkYVtcnmvdNszqAuEVJ
         lbZjEIR+j4E0btiM1cRZUINDbpLFd6TOHCdZGi74/ftMxphAtZAHgrS4Il2Up5aWSOgo
         OfPyiaBreZUfSJPsInfx2j+4StEADYLi8yaSEj4Cu/pTCnmE1ryukBQ7pwvG+hQShxAL
         4GJF3WZDj3EPl+eqyeWbwNnIVycYnJslnG4lHqumrY4QTUGMCzfO8JuZ/+URY4CmfnJ2
         vn5hmLFEtVF+OEJNMEOmTmktlkZkXoiZoqnS3GjQ1nbI3vCq8mU5TQcIKxscvYTONdCL
         X4bQ==
X-Gm-Message-State: AFqh2kprMxtyvI2/2SQcTUi+bFOVdwYJ69+2I+NFwcVLX/Npag9BZFrc
        ALLxBcPUjLwFTJ8dulRDfT4=
X-Google-Smtp-Source: AMrXdXuvEzISEd/jtpcHkGpk9jeGiHTZ08jmZJMO986jqYdOIcSx3H7di8izv5YXBGQDXcfCayznbg==
X-Received: by 2002:adf:a50c:0:b0:254:3dcb:dbbc with SMTP id i12-20020adfa50c000000b002543dcbdbbcmr23398533wrb.11.1672443143261;
        Fri, 30 Dec 2022 15:32:23 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y6-20020adfdf06000000b002879c013b8asm8049812wrl.42.2022.12.30.15.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 15:32:22 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf-tools: Fix spelling mistake "lenght" -> "length"
Date:   Fri, 30 Dec 2022 23:32:22 +0000
Message-Id: <20221230233222.45385-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in the variable expansion_lenght. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 86e06f136f40..ccd7923ae802 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3784,7 +3784,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 
 				if (fmt->strtoul(right, right_size, &syscall_arg, &val)) {
 					char *n, expansion[19];
-					int expansion_lenght = scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
+					int expansion_length = scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
 					int expansion_offset = right - new_filter;
 
 					pr_debug("%s", expansion);
@@ -3796,7 +3796,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 					}
 					if (new_filter != evsel->filter)
 						free(new_filter);
-					left = n + expansion_offset + expansion_lenght;
+					left = n + expansion_offset + expansion_length;
 					new_filter = n;
 				} else {
 					pr_err("\"%.*s\" not found for \"%s\" in \"%s\", can't set filter \"%s\"\n",
-- 
2.30.2

