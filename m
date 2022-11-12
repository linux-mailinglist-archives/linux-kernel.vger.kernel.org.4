Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF411626A1A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiKLPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKLPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736210040
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso6919861wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr+dmUXwYhk1v9/2O+qCDGm1t9ap655KCmuuETwAAfU=;
        b=MumFOUIT6F0oTqa2MKSIxXzjznyN1d03ngR3WmJmd9nPISSXjX/WnD72h/8SlYoPdj
         oAG1lhUr266zcH3myKW/9IePllNdxFr77xG0kNEN9ut2q8JxwNO0+CGw/a1E3KZ/MikQ
         3+7hOQnu54Vr6BL8aS6OnwQCN+u3oyqWHhqzlZAWa5w7BkhCslsbFBdZOrWpdu663sY1
         90rbkHLdTELKQYVFpHFU895G/Kgq6VQatnHHetG/GJBgAhuTJw7AZepIgjJ90jLrwMJi
         qnQ6pKoDPRFyWP1tJDhdaXjtBKg8ngow/t4MpxuObqJIxll+ho5h8Ja/En29w+Pds/7u
         D4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr+dmUXwYhk1v9/2O+qCDGm1t9ap655KCmuuETwAAfU=;
        b=ecnVZouE7xzDkq+sCcHDuEIvTTEpAft4aVP8rhp7XvDYvXTkZNlavD06e5hYVflOFa
         IR2hnaAov9uGnNYpETc8WBZZWBRSUvvY4L1JwZt6h/juF+QBB/aWS0Vws6vE84gaIelF
         MxfEBvNiLriFCziYyUXJAtw1swoB66kqbz6m+6GbH61mOJNr93N1kC67n182Mm+y3msK
         tqShAexPAGipaM0ffZ1wGsCc7BaJDxtVd3csdQ9zrGxuXA0Yep6xYo9ZehLQSWVQWelz
         RpWmCCJ3YcKESlSYiXS24TMBhrM5PfmaOiZ4TEtElldW4pw/TaATkTaoiTYXBFcUNTiG
         3u8A==
X-Gm-Message-State: ANoB5pm6bZs3D90igS7UK8A240umepVqalJ2zZgoXBrCrS3mcCyXQ2zV
        dmVv1EhsrSrJtLI13vU1iZw=
X-Google-Smtp-Source: AA0mqf4hcLFxf00Mda7WDy2hbjsIkGnilq2AHVMUUHeYNYCqZ7QPY0xot1ukZe9qPg3TpukTAcLy5A==
X-Received: by 2002:a05:600c:d7:b0:3cf:b545:596 with SMTP id u23-20020a05600c00d700b003cfb5450596mr4039671wmm.49.1668266377341;
        Sat, 12 Nov 2022 07:19:37 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id n13-20020adff08d000000b002364c77bcacsm4534160wro.38.2022.11.12.07.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:37 -0800 (PST)
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
Subject: [PATCH 01/18] mfd: 88pm800: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:18 +0000
Message-Id: <20221112151835.39059-2-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/88pm800.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index a30e47b74327..20742793b22d 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -398,9 +398,8 @@ static struct regmap_irq_chip pm800_irq_chip = {
 
 	.num_regs = 4,
 	.status_base = PM800_INT_STATUS1,
-	.mask_base = PM800_INT_ENA_1,
+	.unmask_base = PM800_INT_ENA_1,
 	.ack_base = PM800_INT_STATUS1,
-	.mask_invert = 1,
 };
 
 static int pm800_pages_init(struct pm80x_chip *chip)
-- 
2.38.1

