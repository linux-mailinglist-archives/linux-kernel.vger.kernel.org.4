Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4155B54CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiILGvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiILGuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:50:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB022A259
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:50:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so7398689pgb.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=6Xe3R/apOfj9yPTgHstXk1duLFBJjDM/Rtwt0f9H5Eo=;
        b=LanQLFvf6RQo3FztPxAXUGZuOt8XUCf0383mzuu7l36i5lBuVM7bi3iPqfx+wzmfyi
         uAlDr3GoCXquZqHzwvBrhDMXi0YtylvsZwA7YId+/ApLY1U5XJj0rN/I5QmWb3MuF4mC
         m9sgzjS2xK2t+nt4fHR7dRPUE0LxTuedAV6S5+a94szVmhw/tch7jvfdX5N8jMUoRye8
         xz0O7JnDIoV3PayCrYsZ7jYT5OP6Jd7Kh3ndLlupvIYW7p5AByJ1ucJyzKvsKrhNusWC
         NcDZRyT4fxBkMHfgo6RQKyXC7/+Yo59BMEgUpZLNG2E3VKWnxuV+cKwjSztuqIOtiR48
         ElmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6Xe3R/apOfj9yPTgHstXk1duLFBJjDM/Rtwt0f9H5Eo=;
        b=EMib+5nc+GBJ/W59lovyy1jewG1URxFhWbxB5sN9PmrFV1Nbdxkuv57YCUvCt3lNpG
         xH+j/x33WBKkCx1FYmUN+u5OK5N3f9VKPDRqIDA5sM0qcGAQs2O/2o7rW8VzBEU3aCzI
         YJTHmYonzVja89yrhFdMZXZeeP1OLlFH/coc6jjzpz6z7tKAOs8x7CEZbAaKdd4lUPVX
         qFi1Scn1etR83Ah47IuimSW8bSZ5CLau0x/TVxHeXYkdGQBMGEd1oW+fsXi5ECLXD5vA
         e1Jx2Gaw0gFVl3a1hFLdmgkk8vHOciOSy280VqcZAChy8DDxmmGLtmyu/V1m8fkgX/hl
         YqKw==
X-Gm-Message-State: ACgBeo19LaO+GmoM1rLMl58yLTg4fLzeACzVpLzZ7l4E/XEda8ubg888
        ql0sYKJVUarcsgCRTTO90KCfyA==
X-Google-Smtp-Source: AA6agR4JOxDScrdlY2QeBhFk8ibiBQ+YL8tlBtJH7FnoTf9lRCe8Mq0poUexl6SesZaolsHcCoBjjA==
X-Received: by 2002:a65:6cc4:0:b0:412:35fa:5bce with SMTP id g4-20020a656cc4000000b0041235fa5bcemr21758036pgw.466.1662965448405;
        Sun, 11 Sep 2022 23:50:48 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b00430c6fd7ffbsm4705716pgv.84.2022.09.11.23.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:50:47 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 4/6] soc: sifive: ccache: reduce printing on init
Date:   Mon, 12 Sep 2022 06:50:27 +0000
Message-Id: <20220912065029.1793-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912065029.1793-1-zong.li@sifive.com>
References: <20220912065029.1793-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@sifive.com>

The driver prints out 6 lines on startup, which can easily be redcued
to two lines without losing any information.

Note, to make the types work better, uint64_t has been replaced with
ULL to make the unsigned long long match the format in the print
statement.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index b361b661ea09..17080af7dfa0 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -81,20 +81,17 @@ static void setup_sifive_debug(void)
 
 static void ccache_config_read(void)
 {
-	u32 regval, val;
-
-	regval = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
-	val = regval & 0xFF;
-	pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
-	val = (regval & 0xFF00) >> 8;
-	pr_info("CCACHE: No. of ways per bank: %d\n", val);
-	val = (regval & 0xFF0000) >> 16;
-	pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
-	val = (regval & 0xFF000000) >> 24;
-	pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
-
-	regval = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
-	pr_info("CCACHE: Index of the largest way enabled: %d\n", regval);
+	u32 cfg;
+
+	cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
+
+	pr_info("CCACHE: %u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
+		(cfg & 0xff), (cfg >> 8) & 0xff,
+		BIT_ULL((cfg >> 16) & 0xff),
+		BIT_ULL((cfg >> 24) & 0xff));
+
+	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
+	pr_info("CCACHE: Index of the largest way enabled: %u\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
-- 
2.17.1

