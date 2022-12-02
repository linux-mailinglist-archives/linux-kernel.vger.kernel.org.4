Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7BD6407F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiLBNv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiLBNvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:51:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694EDD37B2;
        Fri,  2 Dec 2022 05:51:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay27-20020a05600c1e1b00b003d070f4060bso4318392wmb.2;
        Fri, 02 Dec 2022 05:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWlDcjGgnAwV5AhhQY0c9xEZjV7f4pAJ9IxwcYm/C1g=;
        b=AWF4Uw+bEl7zxw9oqtV4Cj3gE4mAmvXQGxAV6i9IZbLn2Jy6kqA7QVVF4KhSe+W2kT
         Yq2cGy+y7f2mXGmbR9f7kTC3q9IaXtRy9B5tqq/nHjOEx0Rica1iSwIO953fNSksn5Nl
         /WCJBSLAZ2xSjxPaBQlxs0s7/iFluMs3DK6H7sI2bHMPX8J8WDulxB89bRuZSt0pgcED
         sRKRZuiFOL+g75u+JavFwmB/RKsS6QZJ5K96gUNX/t5FQ/yDK2+xtm+LBarKAwsWtxOt
         xb5+GshnIrRsaNpvz9BOLHlLZXgnWiGUtRM5CuEDOlC+XlNgaZ4qzF/g+/ONlhU0TzUb
         2iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWlDcjGgnAwV5AhhQY0c9xEZjV7f4pAJ9IxwcYm/C1g=;
        b=SjYqwnwHqR9Yju2+tnHKKUNlkoTERjWNvBcA9I5Sb3j+MLXGwQdUIdNxgvt+7hVHn8
         EkmNhFz87XJBN/ySyjWn4gG0s83UI70iJ7XeNX7SGo/2A4f9MYs2AVxA+NPRZkWMV+ie
         alho/D6C9WSEYufCvCVw4cUckowhqp0Hu/mXpmPBNQ1GuLEuCt1CFqJuN1/6v6d5At7X
         ECFOXZI5DXchUdoa8hNvvngf97ZW27+J+k3urlfhlFPZDg+xTs+ke446JTsSsNpL8sgq
         19r7kJ5IEmQYa0GQHTAqDevGxi0cNMx3G+RdKNGlesaTmoncZFJLF5fMGqmrhiSv4nJ6
         GEJQ==
X-Gm-Message-State: ANoB5plbQd3dmTDxnM+SX1cZc/QVqkNFLMws1Zk6bTxa5KnXcSFmqXOv
        eLDAD672X11fqsdIQLBMJ6E=
X-Google-Smtp-Source: AA0mqf6M++g+XcURroNqfnBej8iKSs6zfT7iIivQZNdlSF2zYeT9gOhXID9g1lut59vhvH9QjUoMfA==
X-Received: by 2002:a05:600c:4f44:b0:3b4:7a99:b22c with SMTP id m4-20020a05600c4f4400b003b47a99b22cmr15002007wmq.11.1669989111808;
        Fri, 02 Dec 2022 05:51:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o35-20020a05600c512300b003a3442f1229sm13619528wms.29.2022.12.02.05.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 05:51:50 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf/x86/amd: fix potential integer overflow on shift of a int
Date:   Fri,  2 Dec 2022 13:51:49 +0000
Message-Id: <20221202135149.1797974-1-colin.i.king@gmail.com>
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

The left shift of int 32 bit integer constant 1 is evaluated using 32 bit
arithmetic and then passed as a 64 bit function argument. In the case where
i is 32 or more this can lead to an overflow.  Avoid this by shifting
using the BIT_ULL macro instead.

Fixes: 471af006a747 ("perf/x86/amd: Constrain Large Increment per Cycle events")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d6f3703e4119..4386b10682ce 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1387,7 +1387,7 @@ static int __init amd_core_pmu_init(void)
 		 * numbered counter following it.
 		 */
 		for (i = 0; i < x86_pmu.num_counters - 1; i += 2)
-			even_ctr_mask |= 1 << i;
+			even_ctr_mask |= BIT_ULL(i);
 
 		pair_constraint = (struct event_constraint)
 				    __EVENT_CONSTRAINT(0, even_ctr_mask, 0,
-- 
2.38.1

