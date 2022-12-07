Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09428645B97
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLGN5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLGN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:56:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BCC5BD72;
        Wed,  7 Dec 2022 05:56:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h12so28163299wrv.10;
        Wed, 07 Dec 2022 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYrYY/fm6aX39Ixp9LpWPNUVB2qUa51Mk5FBV63lR/s=;
        b=GCVATqAgYI6b2pNpJJm2LfaW175fXxR+izq/VPTFa8KVQ1yOnR5IrWn3C80fnuN0Wd
         +/aw3SUKtWyLIhiB2VjVXAmbWiZ4jlvKIA8ZWGdxIYCNpcrE1f9WSD7Sx84CqATK9gmN
         5qs+AihyZvqGSKKlr7le7x1WDk7tiCZmJ8ltAvXSIOTa5y8VUdkSQm6BLx7GUIuImeeo
         PFCkCA7KhwWyX1uo6ZHwIfAGOcFC3wnt5qC1YtX2ahEylh6w80BUkvd79NeBw7a/kAv6
         QNVpfsyEUPsCyw27ltDWSPqQc+/Ox05FGtAUrssnOiDhh/fYFOfSBYA2k4iEW38KPzzR
         H+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYrYY/fm6aX39Ixp9LpWPNUVB2qUa51Mk5FBV63lR/s=;
        b=LDu/9S4VK3sVGTg+2LGliSBMNq6NS2C6I1rzRgl8gWABZySryQVd3f9zoBrMiGx8uh
         HmCT6F65OYKNQTZ2FkeUtP8oAlMSjh2kxjWXdk/0Tzx6muwvekj7zwlzZPk4cb7aBQp/
         OirEXA6hHUe4VUPXXwLDkUjEgd4N9H3Y/7qSyIr/o+ogg9ZpvavA43ZiAvha4i5errKm
         hpukETTh+no6TcczCoJPO/JY7Dmq9D7ftQIi144T9FsHJMPLhUIdtcfp46qZ9yS1Oth+
         O4H6H0ageV8ZzVuqmN3q7nZBix/LWVkxPOxTJIMeDvCC0AtgD0lAQf2zUliv09hVdgQm
         KZVw==
X-Gm-Message-State: ANoB5pnbKbqWd9ajzljHOazKzRRNSqczhT9Y1fVSVk3pQUwORQZDTFz1
        OK7z8Ft44nYfx9wzanN0CTg=
X-Google-Smtp-Source: AA0mqf78tDp/NbW5pJ5zC7IruwhOp2apHPbj5OpwxqwSxL3nqgqQ5BfEHvDHxyaoryVf9MFVK8FeDg==
X-Received: by 2002:adf:ebc5:0:b0:241:6c90:79e9 with SMTP id v5-20020adfebc5000000b002416c9079e9mr39623325wrn.642.1670421406257;
        Wed, 07 Dec 2022 05:56:46 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c1c0a00b003b49bd61b19sm2130825wms.15.2022.12.07.05.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:56:45 -0800 (PST)
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
Subject: [PATCH] perf vendor events powerpc: Fix spelling mistake "fpr" -> "for"
Date:   Wed,  7 Dec 2022 13:56:45 +0000
Message-Id: <20221207135645.2327224-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
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

There is a spelling mistake in the description text. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/pmu-events/arch/powerpc/power8/other.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index f1f2965f6775..6de8c472ec99 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -2996,7 +2996,7 @@
   {
     "EventCode": "0x308e",
     "EventName": "PM_SWAP_COMPLETE_GPR",
-    "BriefDescription": "swap cast in completed fpr gpr",
+    "BriefDescription": "swap cast in completed for gpr",
     "PublicDescription": ""
   },
   {
-- 
2.38.1

