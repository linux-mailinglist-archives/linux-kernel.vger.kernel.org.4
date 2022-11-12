Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18156626A28
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiKLPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiKLPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA91A39A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o4so10060774wrq.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX7cCKuVYb8T0bIdtXYMmu42sGmoqadgzkdHQD0y+QY=;
        b=eMyqe5Ay3U0wx77cQ/2gz16NxyYV5gWp8dMGPLYd9UsNDB518c0JqQ/QtTZpKnI31X
         IoAI34NvLVvN0KI1CfpoSXv6729k7RN2VeXlJL13E7LN/6svqM5aclRuyq//KTwFH2CD
         aS9bLX11utnhq6bBz61ASU9LGuLxhL9cDNEh6l0Yfu/03oaJ6wV6UYXq23xZ3kYBw6va
         a79VzdA/bVZ0+2iBTrrm9Sb2suzAVwbzMTup7FNFaDNuZTqIBI6mKHUarjKm/zbgJIBQ
         GxNlxqo0BmWEyZ/VrBOgGGrBVigZ730ESoor8AKfy9uZCGziypR5dRZXXOCS7P6LawR1
         vTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rX7cCKuVYb8T0bIdtXYMmu42sGmoqadgzkdHQD0y+QY=;
        b=J06Z0P6E+mvGHfTVdXV6LvQhh+02k3Dd4mWVZQUctupLI5vKkiId7f9zBu1VJRSyUG
         iaK3nhFEZNOa+iWhl+anv6HBJkJM9N1ENg6MUnAkzB8Py0eM5lJgBFtQz3HUOqhWvduJ
         9A1gSN7QEdAeIDfsgrLgqMlsHBno7CqNUtuWcv2leYnewuuOu3Vxd+wsU5Dx7j1kz6Kq
         YIWYnBgby+lJ5ZOtiSkN9Ujj5PKNWbUANAjXOZOPHuzfc93vx6PdAqSegHZaInUVFdDQ
         KhZzQjiBgwBv9Sy7US4zDbDJSozBWNiQ+QeR7zo4RdMAAhHutP6k8q5Vb8MEYNUc+f0e
         Uvng==
X-Gm-Message-State: ANoB5pmfsetfzcINvANx33DYMe3nFpg/YpD/HFzTyXgtZViETciqlMFz
        sn9L0a9q/JgvwrHesiSFT94=
X-Google-Smtp-Source: AA0mqf6DGdBLmjCdoPNIF+QK2rhnA4Ir3Q2CgoggBEI6nhnn/MHKp3Dwjc6/isBGSN4KhmU5r3eSyg==
X-Received: by 2002:adf:fd41:0:b0:236:6de4:27b6 with SMTP id h1-20020adffd41000000b002366de427b6mr3453371wrs.601.1668266388127;
        Sat, 12 Nov 2022 07:19:48 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id co19-20020a0560000a1300b0022e66749437sm4675867wrb.93.2022.11.12.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:47 -0800 (PST)
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
Subject: [PATCH 12/18] mfd: rt5033: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:29 +0000
Message-Id: <20221112151835.39059-13-aidanmacdonald.0x0@gmail.com>
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

Remove use of the deprecated mask_invert flag. Inverted mask
registers (where a '1' bit enables an IRQ) can be described more
directly as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/rt5033.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index f1236a9acf30..dc9bf4057a09 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -29,8 +29,7 @@ static const struct regmap_irq rt5033_irqs[] = {
 static const struct regmap_irq_chip rt5033_irq_chip = {
 	.name		= "rt5033",
 	.status_base	= RT5033_REG_PMIC_IRQ_STAT,
-	.mask_base	= RT5033_REG_PMIC_IRQ_CTRL,
-	.mask_invert	= true,
+	.unmask_base	= RT5033_REG_PMIC_IRQ_CTRL,
 	.num_regs	= 1,
 	.irqs		= rt5033_irqs,
 	.num_irqs	= ARRAY_SIZE(rt5033_irqs),
-- 
2.38.1

