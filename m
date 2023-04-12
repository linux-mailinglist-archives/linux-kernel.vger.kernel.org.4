Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2256DEB64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDLFkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDLFje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:39:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71595B93;
        Tue, 11 Apr 2023 22:39:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g3so11617261pja.2;
        Tue, 11 Apr 2023 22:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681277947; x=1683869947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s51HmEEtHMKdmRzk+XEjkr30t4p7PpVLBWJZRJVCHjI=;
        b=oHraIzXSazRgwcBGJC3EF4pI8SV1kDt3tAsJFVxZBZc21PNnjo9yQ4tlLmGp51XVyw
         XAOAcTlLuaulsubDE/VxWZkkQn0D4asqF0E2Y2st6sV7POoAl2TOp2220g1eDDez+oRt
         YHvpG2n2PTdR76s2QMdjXYEL6jdUWhws6xak5YqY3ZwBUun3rSx0BMh/bnfJBmC/XTfT
         JM4yzxdxmgKnBzU4K9RTVLdrOTqbDaJdkPkvM786FAr5ReGIoX8iNwJYX+F8h/6Tdlyi
         fv8PqO68iCVc6sH5U/x6vTm5zOkA8fs0+dkELEByhAZwHJ/YUIbIpDfcmKnE10XU0gch
         ioig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277947; x=1683869947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s51HmEEtHMKdmRzk+XEjkr30t4p7PpVLBWJZRJVCHjI=;
        b=uozGdabbf5qPZv7fMry20YWPAxOXoeDtt89f2GuAji8FVQAq+6jhY6v/xogo37KuO5
         Ap66gM6XudpOGD9ZoNSBIVc+2jOcD+XL6QXuuMQaTnye/+QC4IQqnhhzcWlkpEKh24+U
         /7ecxDeYuvXE6Ky98sg/Uof6XHecvcOLiiedaksIzXrgWW4kraVBDE/SkeHKy3ciTpq+
         ew9ZxpLzl0qp7mFuTiidRGn/wnaIia6iaqdtSkHP4IXOEXmJ+Sta8et+4tF96kTKGVCi
         TorNffSdKdg1yemwN5GovJrUh9izrejxgleWvpEXeXMH5ET5avQ8WTM4zkrV8ko1amdI
         T68w==
X-Gm-Message-State: AAQBX9eX3LlVsI68onVYFTDlFXpcdWnJmgR8uspNrYtzsVXZiSqv3gEK
        KBzQ7YVG/xg8ryA1B8DQp1go/iIxAM9FGA==
X-Google-Smtp-Source: AKy350aRJDGPlI84QdOsKv+LRWuIJvjrUmuJX+6N7X7B7qcLw/XWXoi47nIFuQNJPcJWxj9zMHC9PQ==
X-Received: by 2002:a17:903:805:b0:1a0:50bd:31c0 with SMTP id kr5-20020a170903080500b001a050bd31c0mr16687129plb.24.1681277947261;
        Tue, 11 Apr 2023 22:39:07 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm619640plb.36.2023.04.11.22.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:39:06 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v7 12/12] MAINTAINERS: Add entry for NUVOTON MA35
Date:   Wed, 12 Apr 2023 05:38:24 +0000
Message-Id: <20230412053824.106-13-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412053824.106-1-ychuang570808@gmail.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
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

From: Jacky Huang <ychuang3@nuvoton.com>

Add entry for Nuvoton ma35d1 maintainer and files.
In addition, update board binding paths of NUVOTON NPCM.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 MAINTAINERS | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e64787aace8..4194bc500aac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2501,6 +2501,16 @@ F:	drivers/rtc/rtc-ab8500.c
 F:	drivers/rtc/rtc-pl031.c
 F:	drivers/soc/ux500/
 
+ARM/NUVOTON MA35 ARCHITECTURE
+M:	Jacky Huang <ychuang3@nuvoton.com>
+M:	Shan-Chun Hung <schung@nuvoton.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/*ma35*
+F:	Documentation/devicetree/bindings/arm/nuvoton/*ma35*
+F:	arch/arm64/boot/dts/nuvoton/*ma35*
+K:	ma35d1
+
 ARM/NUVOTON NPCM ARCHITECTURE
 M:	Avi Fishman <avifishman70@gmail.com>
 M:	Tomer Maimon <tmaimon77@gmail.com>
@@ -2512,7 +2522,8 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
-F:	Documentation/devicetree/bindings/arm/npcm/*
+F:	Documentation/devicetree/bindings/arm/nuvoton/*npcm*
+F:	Documentation/devicetree/bindings/soc/nuvoton/*npcm*
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
-- 
2.34.1

