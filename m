Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8844F626A1F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiKLPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiKLPTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE9112AAB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so4882061wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaXPTSTfVAjT3RnVq8UtQeB7ybyxfMU88BI11sZ0ri4=;
        b=NuIqoadpk7a6YuPwcL2jBzcSRnizeRBdvdMOwXhqv0QhYjXNBoZcWgQbSk4hxC25Jr
         VqQM+NpB3lsDhIe3ul6BOKcJE16jotTUbG4v7eHHlZN70s46tDMoI9bXlWW+l0lG4Qcz
         G1mFPUovYKpz8d7efaIHwFJtD7Qp1wDYLobfkDiQzwhuq35ltpXIZfKg7OOqEyGFyh5B
         oYcO1U4KbFR98+DQKRwMRqZAdItqqaYY7M4LkXXL1ZAHuaqPi4MWhTFn+4Ce0a4x9Sek
         HFIozN8h6Ti+uObJ9Ye5aKmHNUiE7oJ4dLgeKmYLrSbJmS1DWRH5jEZFi4XcVvaJI6bs
         T94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaXPTSTfVAjT3RnVq8UtQeB7ybyxfMU88BI11sZ0ri4=;
        b=MKeG4kGpKX8Z/MuG+CCbHqctEh4DO1+P/946bGQnEHVZ2X+ADG9oof1j4o13zO+m3B
         hI/CsZXVYlbLNK3XebtH070zpQEnpmFLgo3LVHtQeHc7/MP5LqeUiLirMUjJC8OcJdaK
         1TkTGG0epaOj5Il6BaoycAcDGTUE5wcXI1KYq+BS/M0VUggWBmf1TlCqT2oo1nBbeUh+
         IiMTxzuMbrv/4cw3c2LX0sK6whpAhdspa8DiWjYtb/9HlSWQPMWQqURlYu3IFkg9nVaV
         mGy8qAgXn2C7Wr3ACzAKbDWm2XWlE8aUh9b5Vv5e2vDKQz1JSlY7RU7IuhapiH3G0H9T
         B92A==
X-Gm-Message-State: ANoB5plcV6leXJGUjyfKeGQfzyCCPcu8NIBdtApHz7qSHxwet1h7A+Pm
        ue/ErlrT8SFuXcODWDLqHbs=
X-Google-Smtp-Source: AA0mqf4aVlgv4NKIQNHEtLgESCS976StOAwTb8iQKtN/zZUevBAxm6R/3osOCE4mMmRvPsjMGogm8w==
X-Received: by 2002:a05:600c:54c3:b0:3cf:70a0:f689 with SMTP id iw3-20020a05600c54c300b003cf70a0f689mr4195425wmb.161.1668266382338;
        Sat, 12 Nov 2022 07:19:42 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003cfaae07f68sm13192790wmb.17.2022.11.12.07.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:42 -0800 (PST)
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
Subject: [PATCH 06/18] mfd: max77650: Remove useless type_invert flag
Date:   Sat, 12 Nov 2022 15:18:23 +0000
Message-Id: <20221112151835.39059-7-aidanmacdonald.0x0@gmail.com>
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

The type_invert flag does nothing when type_in_mask is set, and
it's part of deprecated functionality in regmap-irq. Remove it.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/max77650.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
index 777485a33bc0..3c07fcdd9d07 100644
--- a/drivers/mfd/max77650.c
+++ b/drivers/mfd/max77650.c
@@ -138,7 +138,6 @@ static const struct regmap_irq_chip max77650_irq_chip = {
 	.status_base		= MAX77650_REG_INT_GLBL,
 	.mask_base		= MAX77650_REG_INTM_GLBL,
 	.type_in_mask		= true,
-	.type_invert		= true,
 	.init_ack_masked	= true,
 	.clear_on_unmask	= true,
 };
-- 
2.38.1

