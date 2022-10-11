Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569235FB0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJKKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJKKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:49:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57251DEE0;
        Tue, 11 Oct 2022 03:49:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h13so11722612pfr.7;
        Tue, 11 Oct 2022 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE/o/W+5xXJu20wExf/jieHRuV5EEyNjRmK4KW6+ktw=;
        b=VvLEHe7oPVdDLOWYrc/tzOD7YqqCC++zntDzVeVPqO09iNuGLWfSaQVwyg2KcdNwI5
         860qOWCTouO9+EeFsWHWMfxH8sPqsR3z4YrI21PKQUUXTLSJxORlB8tBe1eShtOqHF3i
         yb+R9wS8SXdZRu9kqP2oehOUp6GRhSCzg7zosd16bq8EI+Afh3CEZa1pXORP9VA2A9EP
         JjoUWL2pgtN6rSVIAmW5nchyqfxmQDG9cXHmQ7H8SbGXMtJESd8vH6ordomBSpk0YRKl
         CLSWfpYCnDx6Uq9oXsTb9pw9kImegmgeAI3ap2YlvO/iuzo6hXuVz5+7lQ9VJRCb0Qq9
         N6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE/o/W+5xXJu20wExf/jieHRuV5EEyNjRmK4KW6+ktw=;
        b=SmCtBGhjVJxF18thfDS1aMFOfyuue+COp4yNVzoP+mS6Khn8ZPfkOsHqYG2yPEH/Na
         DLWvl2mU6f5NDCLhsZ63bdDx+QXT/YNZJrYzVklgqf8eC6r48btoE+UbKazH441N5e5K
         ucm9NroLwlXzPQaccXfFj67F9/4VplK2/RX0HIcl1t9eGkkBocESX4f5FDHiqVZjAyou
         UiY1XJcz4/577JWolQclIRyG8lqBJqsnH2Db4XgH96m0Re+D6NZUGiRk/Hi01Dxuy0uZ
         pyQYcvnn/jJAwJu4BdVSSBWJMppb+OgfIoLM1BZUmTAjKth7VKa7Ii0D9CFtgkaDkY8z
         jFAA==
X-Gm-Message-State: ACrzQf2wdXIovXzzjoOg3SEDQxw0ILQ/ELBVZy3kWhH1LJZ3wO/pz/FK
        Tmfu+0FMLQKVPL+9EZqdCoc=
X-Google-Smtp-Source: AMsMyM5YhHb/jfBBAbq6B1g1I7W4zi55K+i57gnbzE0u30KHGJV/fXvkCi50NG6+m6knu8dhfKvoBg==
X-Received: by 2002:a62:6243:0:b0:561:748:94d1 with SMTP id w64-20020a626243000000b00561074894d1mr24622550pfb.33.1665485384827;
        Tue, 11 Oct 2022 03:49:44 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 124-20020a621582000000b005621152c051sm8672786pfv.66.2022.10.11.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:49:44 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Subject: [PATCH V2] mmc: sdhci-sprd: Fix minimum clock limit
Date:   Tue, 11 Oct 2022 18:49:35 +0800
Message-Id: <20221011104935.10980-1-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

v1 -> v2:
 - Address Adrian's suggestions

Our controller supports 100K. During the test, it was found that mmc_rescan
failed to scan the card at 400K, and did not try 300K, 200K, and 100K. After
modifying the minimum clock limit to 100K, the card scan was successful

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
---
 drivers/mmc/host/sdhci-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 46c55ab4884c..b92a408f138d 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -309,7 +309,7 @@ static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
 
 static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
 {
-	return 400000;
+	return 100000;
 }
 
 static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
-- 
2.17.1

