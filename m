Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E915B8009
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiINEIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiINEIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:08:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F7C52FE3;
        Tue, 13 Sep 2022 21:08:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e5so13689650pfl.2;
        Tue, 13 Sep 2022 21:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=vkTUPelBaMMS0AcNTHv6inlXSwf/g/n3Muib02HR8rw=;
        b=WUX/WTfxD1Cj8P2Uh0cheahPn65msmTsmjW/hWShrPlhFXIhw9qevIm3HCvtRNwR2W
         nR8HP1qtD5sgGZmKXR2HMIqdZl3WH1WzTuLegDPTqhcSmJtARFc6UxH+J6GayJQhO3UA
         5P5MTkUcgv8MrwgQK7nI8UKFc+8NBmVqsvomWpSkfTRumuBjri0Nto/hhrGI+I9y6TEy
         P7sa6tBkQWp51MH336kfEPNEZmz4YJ/6TJT9mWPbEdGXdfHCoEisdrLDU97Ze3G6cpzD
         tm5g0t/FHDvySmhQYZVv7USw90X4X+tDpvOSuh7gbL87a4uEyunn9D2E/P2HPmlmYqw4
         9hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=vkTUPelBaMMS0AcNTHv6inlXSwf/g/n3Muib02HR8rw=;
        b=rmrBKpDiWcMuErYd2Zm8QVN5K4KXtQeodReA97VtgLlsckEuvcWTr7PQFDIdcvwncP
         5kXiAUdett1zpS/sUJYmaNHJsXQZ54CtJy/yDuhqpEp94rBpmmuOv8i2EG0ZzMun/1kA
         c6UikCigtMGcPqoB2hA/K89Rxo1JH2ouSImzbdTjKwB8CaeykOHNVarPPYfqHesF6hMg
         TedVeJ5cmXo4hTZKSCCCINTszx0B8eRcIn2g3n1c4E4ow+kckuNkAehLPjD1NVnywE/b
         qx6FRlEw9V98iivVLBByPIIdpXDJWBFDX/u2YQpE05NqGS++4xZ22uoaESeHhq3D/yLl
         0itQ==
X-Gm-Message-State: ACgBeo1BC58pdzQyr0eNv3AYRwa1eWmbxivMX6ewHOhIELSw783g0NCv
        +3XPzxS8PEj3UOtnqahj7XY=
X-Google-Smtp-Source: AA6agR5rkYRReg8evD/ll0BCDiTQLVJ6PU6iZSe83H2295gLmDZQd6QJBR57pE7x2mmRkPlSbyd/Cg==
X-Received: by 2002:a63:8843:0:b0:439:3c8e:c2c0 with SMTP id l64-20020a638843000000b004393c8ec2c0mr6010674pgd.404.1663128528050;
        Tue, 13 Sep 2022 21:08:48 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:d82e:84ee:b2c9:9acd])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0016d773aae60sm9423662plg.19.2022.09.13.21.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 21:08:47 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf inject: Clarify build-id options a little bit
Date:   Tue, 13 Sep 2022 21:08:44 -0700
Message-Id: <20220914040844.352514-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation of --build-id and --buildid-all options to
clarify the difference between them.  The former requires full sample
processing to find which DSOs are actually used.  While the latter simply
injects every DSO's build-id from MMAP{,2} records, skipping SAMPLEs.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-inject.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index 70e2ac3cc91a..c972032f4ca0 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -25,10 +25,12 @@ OPTIONS
 -------
 -b::
 --build-ids::
-        Inject build-ids into the output stream
+	Inject build-ids of DSOs hit by samples into the output stream.
+	This means it needs to process all SAMPLE records to find the DSOs.
 
 --buildid-all::
-	Inject build-ids of all DSOs into the output stream
+	Inject build-ids of all DSOs into the output stream regardless of hits
+	and skip SAMPLE processing.
 
 --known-build-ids=::
 	Override build-ids to inject using these comma-separated pairs of
-- 
2.37.2.789.g6183377224-goog

