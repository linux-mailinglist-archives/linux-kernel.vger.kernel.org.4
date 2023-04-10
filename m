Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A355F6DC60D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDJLIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDJLIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:08:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4705245;
        Mon, 10 Apr 2023 04:08:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id px4so1659735pjb.3;
        Mon, 10 Apr 2023 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681124892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auWwFgc18uZBdz+Z2zX6VHvbovXO8Ck0I+nsGAMXZ1g=;
        b=Yj8yUmMA8uZz52Ph8klP9yERACCTGTeiLp0Ngyfi3DHkq+/Ga71UgBP+R5r7dG8zcw
         U0VE07wJ9Y6NvMN0XtMPjSlwKo9VuklZjXpPS8/c6rarEhoBKGKNZSgIB46PKK2r7SON
         94BibRq9nYpEhZeAtfOrJJ8BBcuhjb/AKs0S2lk48JCo6yTNTyKtxO/D7+QL67JoXvXq
         DIipz7m7njKGcn3IbHJOVpRfQdAMUT0e380Owkskw79av+Q8oJUmf0YnAAaFgKSzjF5g
         uTKwNzWrDSqk3qWZQi2DOuv6FIAP///sMZywLU65H1t/y5AKIzr4U/bpAK8aTGOTyme0
         TBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auWwFgc18uZBdz+Z2zX6VHvbovXO8Ck0I+nsGAMXZ1g=;
        b=PI4adJbUWqlIpJekv/NlUL+jl+sJlqeGK13M3MZ6FqcEWHQjuzlI0Tx8tcqfkciW6n
         +3FE1pjG+RszNcxgHIEDJ/OqP5V1GmhTSRTN/RtWHuM2n4QWVNZvl7oqvG4jJ3YwgX7C
         3y7neslvQKeBM0BnJnKwCnUZhIxoAI5Ks+LDZgglN189BkgzPZuicxr6WnlIgD6NmAko
         xFW23Ud4XSANj4iHBTe6wHNxpPwi5r+nuaGIM04sBWcmY0b9C4y951wKmoaPjEAiLsRW
         SJ7eb172hdItyK/smDBSs7GSFS+ZElIgyDUcq8OAzQ8pqOz4KpOLTX+AHBdRnW3bRDbO
         aByA==
X-Gm-Message-State: AAQBX9dhM3ROotzsaMyGKQMrJTQYoWm5jP2Q50bU7pKpnCkqASovFrhV
        rVPuQJWsTeWsi1BIyAqMN8/6+Hh3wqOOb8AWntc=
X-Google-Smtp-Source: AKy350Z9t3dCCDK/xiehnSpWUR+BoIhJUFqAxGpq/n4euCR45DYDjG26F9T8gjKsNwYP/brYthCwSw==
X-Received: by 2002:a17:90b:3803:b0:23d:3931:7b49 with SMTP id mq3-20020a17090b380300b0023d39317b49mr12598238pjb.35.1681124891706;
        Mon, 10 Apr 2023 04:08:11 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:08:11 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] clk: hisilicon: Rename hisi_clk_unregister macro
Date:   Mon, 10 Apr 2023 19:07:14 +0800
Message-Id: <20230410110733.192151-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410110733.192151-1-mmyangfl@gmail.com>
References: <20230410110733.192151-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hisi_clk_unregister is not a function corresponding to hisi_clk_register,
rename it to avoid misunderstanding.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index c373d7c14ed5..cc580915d058 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -179,7 +179,7 @@ int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks);
 int hisi_clk_probe(struct platform_device *pdev);
 int hisi_clk_remove(struct platform_device *pdev);
 
-#define hisi_clk_unregister(type) \
+#define hisi_clk_unregister_fn(type) \
 static inline \
 void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
 				int nums, struct hisi_clock_data *data) \
@@ -193,10 +193,10 @@ void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
 	} \
 }
 
-hisi_clk_unregister(fixed_rate)
-hisi_clk_unregister(fixed_factor)
-hisi_clk_unregister(mux)
-hisi_clk_unregister(divider)
-hisi_clk_unregister(gate)
+hisi_clk_unregister_fn(fixed_rate)
+hisi_clk_unregister_fn(fixed_factor)
+hisi_clk_unregister_fn(mux)
+hisi_clk_unregister_fn(divider)
+hisi_clk_unregister_fn(gate)
 
 #endif	/* __HISI_CLK_H */
-- 
2.39.2

