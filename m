Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B15A699FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjBPWWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjBPWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:22:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2884BE9F;
        Thu, 16 Feb 2023 14:22:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id z12-20020a1c4c0c000000b003e21e018039so975903wmf.3;
        Thu, 16 Feb 2023 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxhw9+oUu19wOC1+A4ZrVTxRyv+NLoeQFK80oVeop4s=;
        b=iMFdSryN/WfsKpTkbgLLnFLI2GjaPgj6aSHCpT3zK8GEyFw3bmU69EVAekRV1jHjLt
         2kEBOZ/q43QhBQSSepQL5hYnqlenJNeyD9mL8alR7SvEmYD09KSIplylrmiBJamTFhHs
         0TVIO1Wvc1tut2djcgu7NOnyTY13B4GhY35FjZtBaa5vo45ZlGq2GWuI5I49eUPffb+6
         qgjef5kn1Oi9idnALkk517TzmTFQX58S5ZvXDySCGK3FlZm1nEmrLHZuliXrZUa4+pBt
         +iDSlt1/qDRw8VaHk/aLkI8ombAohCbkNVNuf2cleFzyEVgPRpe5OIpjhVoEg6OOs0yv
         E2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxhw9+oUu19wOC1+A4ZrVTxRyv+NLoeQFK80oVeop4s=;
        b=dcW9xLjfRXWje8bDYGPBqKNL/W6a7OMX4t7+YFzxkR37NSQKUq3rajEiKucpn8JWxq
         +nV7BQvepCFstaIQx0To3SndoUUfFkyNv68kEYA3ykj5vWsIhD+Dafk1U6R+UrF6LCTj
         VAiX+Jmlj2l8gDsc3C590Zg9qsoD0UMojou+FttaOWDUgEW9UkukyzPSnsaUxMMoRBy1
         1xDuUSpXQy5YBdISBgwPehdyn9pwt4CGTeB6XjggRWfrdWxuq9x7n2AQXRNN7fCqEpKl
         a6AhPlvoxaPOK++BXoM+c3D1duHMFM5Ez5M+FDyGPoeqodW9MXFAwqSZVvYgfg/ypmVr
         O6gA==
X-Gm-Message-State: AO0yUKU4jJ+mmujLEWG6t3IsRTkvtBLtxvM8VZnpE6zbeRohRXraJ+X7
        hzzxBGwI1Elms3cQpyyzh0Y=
X-Google-Smtp-Source: AK7set9P+n9xeeJ1muql+NrnXvWhAdA7igFEO6i/oBjk8Sl/z0HUDlCe9i8rpIvxYP04FfsA5ZkW7A==
X-Received: by 2002:a05:600c:188a:b0:3e2:589:2512 with SMTP id x10-20020a05600c188a00b003e205892512mr5090655wmp.21.1676586161234;
        Thu, 16 Feb 2023 14:22:41 -0800 (PST)
Received: from localhost (94.197.187.145.threembb.co.uk. [94.197.187.145])
        by smtp.gmail.com with ESMTPSA id d21-20020a05600c34d500b003daffc2ecdesm6794420wmq.13.2023.02.16.14.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:22:41 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, lee@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] mfd: qcom-pm8008: Fix swapped mask/unmask in irq chip
Date:   Thu, 16 Feb 2023 22:22:11 +0000
Message-Id: <20230216222214.138671-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
References: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
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

The PM8008 appears to rely on the inverted behavior. It has
separate set & clear registers for a register called INT_EN,
which presumably enables interrupts by writing '1's. Opt in
to the new non-inverted behavior & swap mask_base/unmask_base.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 9f3c4a01b4c1..39fd2a792e73 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -45,8 +45,8 @@ enum {
 #define PM8008_GPIO2_ADDR	PM8008_PERIPH_3_BASE
 
 #define PM8008_STATUS_BASE	(PM8008_PERIPH_0_BASE | INT_LATCHED_STS_OFFSET)
-#define PM8008_MASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_SET_OFFSET)
-#define PM8008_UNMASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_CLR_OFFSET)
+#define PM8008_MASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_CLR_OFFSET)
+#define PM8008_UNMASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_SET_OFFSET)
 #define PM8008_TYPE_BASE	(PM8008_PERIPH_0_BASE | INT_SET_TYPE_OFFSET)
 #define PM8008_ACK_BASE		(PM8008_PERIPH_0_BASE | INT_LATCHED_CLR_OFFSET)
 #define PM8008_POLARITY_HI_BASE	(PM8008_PERIPH_0_BASE | INT_POL_HIGH_OFFSET)
@@ -131,6 +131,7 @@ static struct regmap_irq_chip pm8008_irq_chip = {
 	.status_base		= PM8008_STATUS_BASE,
 	.mask_base		= PM8008_MASK_BASE,
 	.unmask_base		= PM8008_UNMASK_BASE,
+	.mask_unmask_non_inverted = true,
 	.type_base		= PM8008_TYPE_BASE,
 	.ack_base		= PM8008_ACK_BASE,
 	.virt_reg_base		= pm8008_virt_regs,
-- 
2.39.2

