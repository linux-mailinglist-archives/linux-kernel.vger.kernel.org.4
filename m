Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28D7047AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjEPIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjEPIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:23:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810A19A6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:23:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a516fb6523so129204335ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20221208.gappssmtp.com; s=20221208; t=1684225422; x=1686817422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67XVNM+xzhTLgRyOqL3vjZr6HvTN9ueEze0zHvprI78=;
        b=pcNfoKsSzcEndn/kdj6D/6d5Zb5M+3IpTOG5/Cu+LoWA0tlS5RhMvcJdLVx49SHjhH
         GqtwEAsiMv8tC1dh77JUKVsdU9jNv4MW6CjIayAhbBXmgCnNZNEyhRb13JfiCg/R3n19
         Ddhz2bw51wblyl2mV/43HdDkLyIGgZNEIfg3jk06dqo+fCQ76IFzNgjmjm7PaHaYjLMw
         8XgfiHcjlali3GDaonarhfo7lSfu/fShGDRKqKnAT9ATycFKk3G1U6Ep2S3aky1frMGz
         Wj9KNarOzQhyGzeEmesnsmnATB4Pr5Z6kr5+hxEcxvGlZtjAH1Dp2wXPGuanzfqi+D6m
         vvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225423; x=1686817423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67XVNM+xzhTLgRyOqL3vjZr6HvTN9ueEze0zHvprI78=;
        b=e67wv0aXNtcxkEieL3fa5oFNqR2bYv4DvN9/fqUEwDJzJwn5nAUEFAaGXy6CJB/SHz
         8OTPSb3Dnv5WDdzD6JWeYdREwBoFEnkRzJR/vDREsFXlDl9yDH7Fw3zs529tDmjNOqIB
         9NLNSI2zneJKq6uFbUev6a/zGba4Putwx0Utqqx3qNq3fSKXyoQU2tdF6e4UPdmQ+dCw
         i6s/z8cXdtEsVcZ+7SiLDhn43Dt7819i0YCg8r6LkCMbIk0ro5dZwPalfq1LgAGrhCzb
         crItbtI7iaLU6TzOoV8We0xziipYVxn3n/PL99Gfp6K4bsd7pr2URgTqjnZ5RMPOYRKw
         Ux6A==
X-Gm-Message-State: AC+VfDzgNKFkpZ8ConSMiL53AVCVlHG/5XRDbPREPtASzCvf+iifBqb6
        wAYLZ4xRlRcMk/KBztIOmyOVPGobM0IcB1OeazE=
X-Google-Smtp-Source: ACHHUZ6MwmJeIDtnDum9Iq5bzXkyvZiHvSw8YL6K/4GeqNTu/cRvz913e0vPN/+OCvgmW+771EEGYQ==
X-Received: by 2002:a17:902:eccc:b0:1ac:b449:3528 with SMTP id a12-20020a170902eccc00b001acb4493528mr26389097plh.46.1684225422767;
        Tue, 16 May 2023 01:23:42 -0700 (PDT)
Received: from alpha.. (122-117-181-52.hinet-ip.hinet.net. [122.117.181.52])
        by smtp.googlemail.com with ESMTPSA id d7-20020a170903230700b001a661000398sm14900841plh.103.2023.05.16.01.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:23:42 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: tps6287x: Fix missing .n_voltages setting
Date:   Tue, 16 May 2023 16:23:33 +0800
Message-Id: <20230516082333.466429-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, regulator_list_voltage() will return -EINVAL.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps6287x-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index d7fc82175493..870e63ce3ff2 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -119,6 +119,7 @@ static struct regulator_desc tps6287x_reg = {
 	.ramp_mask = TPS6287X_CTRL1_VRAMP,
 	.ramp_delay_table = tps6287x_ramp_table,
 	.n_ramp_values = ARRAY_SIZE(tps6287x_ramp_table),
+	.n_voltages = 256,
 	.linear_ranges = tps6287x_voltage_ranges,
 	.n_linear_ranges = ARRAY_SIZE(tps6287x_voltage_ranges),
 	.linear_range_selectors = tps6287x_voltage_range_sel,
-- 
2.34.1

