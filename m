Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC926A911A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCCGhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjCCGhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:37:04 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5355059;
        Thu,  2 Mar 2023 22:36:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so5165260pjb.3;
        Thu, 02 Mar 2023 22:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677825418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVsweOV5Fj7dNrLOlFZRp9kTopvKPiRPfqHp7y5J/DA=;
        b=m8eECwzrQBfNMqoIkcDa+kFKYHUPtYFc4DCR16BTgCK+6eCS1X2gZooW86+1c04cwV
         yBWB5OXlZY978Kzj+33XiRpVG/49YC/JlWbWIfdc0i+28QAGBI6Nby6E5EeQb4O7Q6jL
         i6oC+7wk+TEMfvGZt0eIx+6GpREU+idzWhKFkAiH8A+C2dAoQ4AflFHGB1yMBdanJPYs
         h7gkDR6TmnydZo2OSNezNeVIeZNeO79kYtYb2BWm5VP79iJgeQDoa8vZRQMf7t2VfflX
         GlAT7FZgsnHpv44Gh/LxTQHkYxWYwd4pwjgPjjFbL67ZzHr04XIlYHzeHiDxm5i6pihl
         EDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677825418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVsweOV5Fj7dNrLOlFZRp9kTopvKPiRPfqHp7y5J/DA=;
        b=HL+RMkSWEnURNSKbP2gA4RHnX1mcLRpcrDhzFqVLjGg7HvAoLSeBmHRC0CGDiglUyd
         7cIjA/PYAXdPcaxYGGN0AUQ07wGLYrot09B7hbrRqqm1+2YwAb6OiSGJOOPoDm2ToC/m
         hcJwamg1yW+xfScE8rG+SwwC6D7sUnz+1IA8JoMMm30T5i0SpX+XApU+sZJdOxpjCiyZ
         12UvKOcnKvl63qSTyTiMviuRFvWOwJPqL31/zfyF6F+ihCeg0yPjlpl6g4Nvlr00qwNa
         snDCdQ2/1OyzdkDjAH0CCC+4WrjOtE9File0WnM1ByoQyyL6npKciGfBe0zlENd1HDBH
         TT+g==
X-Gm-Message-State: AO0yUKXIcf4vXCEcPGP/1a0CycLl+ennz2qo17ydhW5B+9gLU3lz+W2I
        3BXZI/uwc+9jS4PguW2dG1s=
X-Google-Smtp-Source: AK7set9PZFvojaiikRHm2IkFZ4HkcMxqxGOw5ocputE+L4/QnNnEgrR5RGzSmjhJadJ52rbXEqKAnA==
X-Received: by 2002:a17:90b:1b52:b0:237:b64c:6bb3 with SMTP id nv18-20020a17090b1b5200b00237b64c6bb3mr653916pjb.11.1677825418152;
        Thu, 02 Mar 2023 22:36:58 -0800 (PST)
Received: from davidwang.dhcpserver.bu9bmc.local (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id l30-20020a635b5e000000b004ff6b744248sm736348pgm.48.2023.03.02.22.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 22:36:57 -0800 (PST)
From:   David Wang <tomato1220@gmail.com>
X-Google-Original-From: David Wang <davidwang@quantatw.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        fran.hsu@quantatw.com, David Wang <davidwang@quantatw.com>
Subject: [PATCH 4/7] ARM: dts: nuvoton: gbs: Remove ethernet aliases
Date:   Fri,  3 Mar 2023 14:34:32 +0800
Message-Id: <20230303063435.803097-4-davidwang@quantatw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303063435.803097-1-davidwang@quantatw.com>
References: <20230303063435.803097-1-davidwang@quantatw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alias "ethernet" in dts conflicted with systemd v252 naming rules and
caused a rename. Remove the aliases to avoid renaming.

Signed-off-by: David Wang <davidwang@quantatw.com>
---
 arch/arm/boot/dts/nuvoton-npcm730-gbs.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
index a33766e430d7..b27fe12e3962 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
@@ -10,7 +10,6 @@ / {
 	compatible = "quanta,gbs-bmc","nuvoton,npcm730";
 
 	aliases {
-		ethernet1 = &gmac0;
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
-- 
2.25.1

