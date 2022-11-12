Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA2626A26
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKLPUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiKLPUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:20:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537019281
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w14so10030458wru.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQfO9aSpyZwa7Ernl6ZzSUxBAyKCA7qTGVn6Uz2Hc38=;
        b=dkbbqtnqh33JkWn3vU4tGurrQNHv5Vn4+vFX207hgLEVq8Q3Zobjjdb/2kXhILQfSc
         PAbXN+1QwkaAntcWkzAvwynmfttmz07onNAzZmdZUdpVV/O3lyY7ru09rYF5bHh1WLSW
         NVxValVxzw3Ss9KAyhtlixhHJbil9fgyvuysEtG7K/CHaAwG4qrML3mpSDPkj4H/sJ3r
         Wo6WmsE8L3u75t0tnp8ULrPSuDwAiY7DPygcKa4bvbyfsCAiXazoZ8Spuz3J/yEB1X5E
         fDx81WH98jgf0ckE8S8DrtCEm1eDFswHQQIkNyifLHMK5r/oeQSCfBaE4YlwjR9R87b6
         i4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQfO9aSpyZwa7Ernl6ZzSUxBAyKCA7qTGVn6Uz2Hc38=;
        b=btdjc3h+QIJ6t4eravC5c1l4o2e3MheyLK+aTO/Q6IqlZ4+iPqcbK0God8VAvqV0CJ
         +gi7ZwNkHiXLrvc0bKOSt+bvKAEitVPCPV8m23hqltuWQVThwvYm8WVtzNQU+oVIA/h4
         iDOb5XCZlshQEHxniI0UuSuBu4U55MgPCp4plgJNN5HrqIzteIWbEYaqOlbIkUXLJzFV
         bUJxgq+5dwUmhWSJSYIv9SFpD6N7ekML+ZLGRiJ6wvEoAqmYNoFJeENLM3+sP2cPCZzS
         /jZvuTa6gr8fey9VuhcRO/83CWBzehamkDHQDCrxZX/RkZHv76CAC/J1ahD9mbYcn1Of
         2l4Q==
X-Gm-Message-State: ANoB5pkbZmEVwK6mpvONtBPvDHogxwZTchozwrw4cINLDYrb5j5Lb/rX
        X3kOaIxut/WnqkvNHPl/tEs=
X-Google-Smtp-Source: AA0mqf7O3izOCW+iaDgPQL58lh7yc12QK0xgKzsNfqmkr7Lnd+IZ9oKF5C97xqdy/F5kRAMpzPthlg==
X-Received: by 2002:a5d:4ecf:0:b0:236:5655:1393 with SMTP id s15-20020a5d4ecf000000b0023656551393mr3666679wrv.626.1668266391110;
        Sat, 12 Nov 2022 07:19:51 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d540b000000b0022cdeba3f83sm4567636wrv.84.2022.11.12.07.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:50 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 15/18] mfd: stpmic1: Fix swapped mask/unmask in irq chip
Date:   Sat, 12 Nov 2022 15:18:32 +0000
Message-Id: <20221112151835.39059-16-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
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

The usual behavior of mask registers is writing a '1' bit to
disable (mask) an interrupt; similarly, writing a '1' bit to
an unmask register enables (unmasks) an interrupt.

Due to a longstanding issue in regmap-irq, mask and unmask
registers were inverted when both kinds of registers were
present on the same chip, ie. regmap-irq actually wrote '1's
to the mask register to enable an IRQ and '1's to the unmask
register to disable an IRQ.

This was fixed by commit e8ffb12e7f06 ("regmap-irq: Fix
inverted handling of unmask registers") but the fix is opt-in
via mask_unmask_non_inverted = true because it requires manual
changes for each affected driver. The new behavior will become
the default once all drivers have been updated.

The STPMIC1 has a normal mask register with separate set and
clear registers. The driver intends to use the set & clear
registers with regmap-irq and has compensated for regmap-irq's
inverted behavior, and should currently be working properly.
Thus, swap mask_base and unmask_base, and opt in to the new
non-inverted behavior.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/stpmic1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index eb3da558c3fb..ee0469d5d435 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -108,8 +108,9 @@ static const struct regmap_irq stpmic1_irqs[] = {
 static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
 	.name = "pmic_irq",
 	.status_base = INT_PENDING_R1,
-	.mask_base = INT_CLEAR_MASK_R1,
-	.unmask_base = INT_SET_MASK_R1,
+	.mask_base = INT_SET_MASK_R1,
+	.unmask_base = INT_CLEAR_MASK_R1,
+	.mask_unmask_non_inverted = true,
 	.ack_base = INT_CLEAR_R1,
 	.num_regs = STPMIC1_PMIC_NUM_IRQ_REGS,
 	.irqs = stpmic1_irqs,
-- 
2.38.1

