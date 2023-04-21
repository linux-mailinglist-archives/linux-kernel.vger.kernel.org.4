Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142446EA6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjDUJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjDUJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:13:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A91BE3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:13:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94ed301bba0so224987066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682068399; x=1684660399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsvjETPrSb0GWQ9sM/isFsteBwM2pPLGbwlCMDf8cJ0=;
        b=VoxFnSfNnwsiWr1ptqTWWm+K9ejzFS9hfugiOPnQMWYCzOivvb1jjHf0C/l7I0N/Jb
         3kHZbYx0DNxcprD5Q+3cQQoGsFp8vf6IZO52VGtg4m7gilNRdhbLeCjAePWXazekukSJ
         oVixvaBQX/6mxBjy6p21GE89t1k7E294Or28K4V51uHA4PXSQ1KOzBBt34UZy+vx8660
         XXAgzJRn0uXPK7325LZ4IKP7U5vh4Z9VMoXWNGJLTsJG/ES4mBjXJ1izk6zonCmxTiyE
         J9yIV35quGrC+CpKg2VWw/FUy9FtlCB4JlBWje0z55HCmRZ/mcTv032X7SRsQo1zsU7j
         9kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682068399; x=1684660399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsvjETPrSb0GWQ9sM/isFsteBwM2pPLGbwlCMDf8cJ0=;
        b=V16ySRXUJ4/05Eg7K0lhzveku8Ve5XIaGcqqLm6aoMbe3+rN1vat1Dr0PFeVvrlUop
         Lb49lZhkcAdvtm74ip+DJXzejm1iJLHTyulQQI2PPX308+TzgrAMvW6iVNJePLgg3EcZ
         7BHF51Ns/4n1BimY5QIIuGzKer/4hAS8bi1svlj3IfGNBi++6TCdoHu4HCz2iay4uu5K
         WcmJs0CUEI5P2wY+4u3m38IGN/u+19tNJzASB2xCBGr8HRWPHkPmtxd5xzd/S/3Zaah2
         PnuQtfaED7NwCkDCWelGTf0CWE3zMGCdU6H1IZ6hUO8AZulgyTZQfmsNKyG8oxlqs7gD
         MuJA==
X-Gm-Message-State: AAQBX9eQN92C9WnKO0B2/OO7KtqXwOCINSPgtX5xnn2dAxfmjwz/gknM
        iW4BY9Zo+OYZo7AIXCPbGRNjVJXR6n+Qb/MP
X-Google-Smtp-Source: AKy350YGpqDTKeFNfnN4Qluc5ERf07kq2FSx7YQ3Ph95dGocKdY5U8RZH4fX5c+T4K2aSxrBdBD8zg==
X-Received: by 2002:a17:906:cc5b:b0:94e:c43f:316b with SMTP id mm27-20020a170906cc5b00b0094ec43f316bmr1661374ejb.19.1682068399351;
        Fri, 21 Apr 2023 02:13:19 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id lc21-20020a170906dff500b0094ef10eceb3sm1766775ejc.185.2023.04.21.02.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:13:19 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 21 Apr 2023 11:13:07 +0200
Subject: [PATCH RFC v2 2/2] regulator: da9063: disable monitoring while
 regulator is off
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v2-2-c303bcc75ebc@skidata.com>
References: <20230419-dynamic-vmon-v2-0-c303bcc75ebc@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v2-0-c303bcc75ebc@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, support.opensource@diasemi.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The PWR_OK state of the da9063 indicates whether all monitored voltages
are within the expected range. When a regulator is disabled without
disabling its voltage monitor before, the PWR_OK state becomes false. On
our board, this invalid state leads to a hard reset.

Therefore, prevent the invalid state by disabling the monitor before the
regulator is disabled.

This still requires to explicitly enable the voltage monitor in the
device tree and has no impact otherwise.

TODO: clarify if a MODE change has impact on the voltage monitor

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 82f52a2a031a..13a6b189f23a 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -99,6 +99,7 @@ struct da9063_regulator_info {
 	.desc.vsel_reg = DA9063_REG_V##regl_name##_A, \
 	.desc.vsel_mask = DA9063_V##regl_name##_MASK, \
 	.desc.linear_min_sel = DA9063_V##regl_name##_BIAS, \
+	.desc.mon_disable_while_reg_off = 1, \
 	.sleep = BFIELD(DA9063_REG_V##regl_name##_A, DA9063_LDO_SL), \
 	.suspend = BFIELD(DA9063_REG_##regl_name##_CONT, DA9063_LDO_CONF), \
 	.suspend_sleep = BFIELD(DA9063_REG_V##regl_name##_B, DA9063_LDO_SL), \
@@ -124,6 +125,7 @@ struct da9063_regulator_info {
 	.desc.vsel_reg = DA9063_REG_V##regl_name##_A, \
 	.desc.vsel_mask = DA9063_VBUCK_MASK, \
 	.desc.linear_min_sel = DA9063_VBUCK_BIAS, \
+	.desc.mon_disable_while_reg_off = 1, \
 	.sleep = BFIELD(DA9063_REG_V##regl_name##_A, DA9063_BUCK_SL), \
 	.suspend = BFIELD(DA9063_REG_##regl_name##_CONT, DA9063_BUCK_CONF), \
 	.suspend_sleep = BFIELD(DA9063_REG_V##regl_name##_B, DA9063_BUCK_SL), \

-- 
2.34.1

