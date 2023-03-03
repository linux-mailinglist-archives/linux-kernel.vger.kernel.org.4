Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D046D6A9122
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCCGhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCCGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:37:28 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA234C6C7;
        Thu,  2 Mar 2023 22:37:07 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n6so1733090plf.5;
        Thu, 02 Mar 2023 22:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677825427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4P2Gtj5voz2AvXPNtKglz66q8024rYl9baxTyNpUVU=;
        b=I58DVR3ZkpufsMpFPu8HBJQSctYJDzdZYy2bPl6NpVdhXfkp556X4bYC3xYQQma672
         OX5CXQ54v+ddd2mzH9wJp1tr5e0u+6N4lLITeFM2H37rbrPK7nBWQSdGUbq8FPGm84KU
         k98DJ7ENPfkGicXSu3c99luYIe/eyQ97WLOCpRY8LZZ1yfhm8bZj7g2fUZ+sDrBf1rMB
         QUQzJWaqEKgNjuGfjxexXNg2MqThnjUI1+I63yHOTvCN4T35AUuJNVtsDwb/qejYdAEJ
         t3B4GzrIGNrSaYBWuDhw+wdGO6xeUHEuguYF0h12i4T6AFj+csMf/rRssQ3SCKIuuBUg
         LHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677825427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4P2Gtj5voz2AvXPNtKglz66q8024rYl9baxTyNpUVU=;
        b=wEXaeV7oxX1VbN280QURjUvN8PDiSZ6lxMt3iUCLv0eo9dJbdc6H2KO/I2xDeZFpvm
         BnH55gr1c1t41LCCw0/fc4tdJExf04acdh7j1S3LvhVA4RORE4WzfuU3eaCD/TD7s8aD
         PvMQQJOyY6kwSyiale1llFhxm2Fadh/HHruvDJg+GnDxxm+mVfOpF2ehDL7wT4c9pEur
         sIiyAPRniKBPu7kTzugXKad0YyOiyB0Asq0mPzvmw8SMTX31QoLI+Kw7acDpYmmxwe++
         O4Ocz27IBhHDEn8AOIAU7gVXPssaN+jq2r8dLAv1tXbvB/B94bDkDcsvkIDpxbQNXK62
         +9Cg==
X-Gm-Message-State: AO0yUKWpWrFRvigIc78JdIfK5nJq0crIDe8LzHFYdDvcVCaQowK71CEI
        xaiKsYGFP1STsYuUwvrFEGM=
X-Google-Smtp-Source: AK7set9SihwApQZyw9Nh5YizzXYCQiwk6r3kApgwNF1x1wistEFc3Fk429ZCAu01fQxVRaueOScvGw==
X-Received: by 2002:a05:6a20:7883:b0:cc:8a62:d0da with SMTP id d3-20020a056a20788300b000cc8a62d0damr987051pzg.12.1677825426931;
        Thu, 02 Mar 2023 22:37:06 -0800 (PST)
Received: from davidwang.dhcpserver.bu9bmc.local (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id l30-20020a635b5e000000b004ff6b744248sm736348pgm.48.2023.03.02.22.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 22:37:06 -0800 (PST)
From:   David Wang <tomato1220@gmail.com>
X-Google-Original-From: David Wang <davidwang@quantatw.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        fran.hsu@quantatw.com, David Wang <davidwang@quantatw.com>
Subject: [PATCH 7/7] ARM: dts: nuvoton: gsj: Remove ethernet aliases
Date:   Fri,  3 Mar 2023 14:34:35 +0800
Message-Id: <20230303063435.803097-7-davidwang@quantatw.com>
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
 arch/arm/boot/dts/nuvoton-npcm730-gsj.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
index 48110f8aa3ca..2b3e0af5b928 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
@@ -12,7 +12,6 @@ / {
 	compatible = "nuvoton,npcm750";
 
 	aliases {
-		ethernet1 = &gmac0;
 		serial3 = &serial3;
 		udc9 = &udc9;
 		i2c1 = &i2c1;
-- 
2.25.1

