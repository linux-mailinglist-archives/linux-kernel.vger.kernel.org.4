Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5965EFD8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjAEPT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjAEPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:18:49 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE45C924
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:18:24 -0800 (PST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198]) by mx-outbound9-213.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 05 Jan 2023 15:18:22 +0000
Received: by mail-pl1-f198.google.com with SMTP id l17-20020a170902f69100b001928d6b3efcso17111574plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYLUnxH0vjrnLoCkbQeZBQ9WGOHRGvvwMOMAvZApD/o=;
        b=aRgFUr8zM/vm7LeialByzu4Y6AAR1Xpc4D4iVvv7wP6ktyrOjPLHU35nGMF6bAD/bQ
         Nkv61PCZeqGeEvrnhOo0La9iors0F6jfbohcXZt/Zx0lamBj36qUzuEtdBXJuozznawC
         UbD3Y29tHuXQWMwTFbExWKh0idD77B0Tb32nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYLUnxH0vjrnLoCkbQeZBQ9WGOHRGvvwMOMAvZApD/o=;
        b=3LNzv1NYNMrkdD4jJxeSVTC3CqQu3fhV8SkSL3NAWyHgdbGhOFPZFkO6MVZJj8qZLT
         GglXOKwMoObvICfofIsZgRae5+knZ89/+Q0X45EuvjGGX9s+9tgX6fVOn3nBzUXAUJXi
         /PZuXfNkBo9jch37xg4FO14vkTsRe0d+hSowf+Fwm54PsmaXDsJTSeI3igIieaUgZ62l
         pjF0KNCfiQYtSrzkj228PlOiaQTcsj70faloFQ7Wq3MJ+x+AfmeNgny+jeWRP8WAJqi+
         iPgfNvrbEuHLitZ2ADPn20IJSLordjX1D37r2/DxlgEj8Nino9wlvPhC2wQ8ux3qsbDJ
         2mFg==
X-Gm-Message-State: AFqh2koX9Q8/9ObDevU905aqy8nNNDSE8tSFOPHseqmyQFuuJ6Cr6aj9
        hiyTQG8EdKEnY+kvuMiiWZIb0iEGYHuIKGtXFivRuMDBsJox8TjshwAM8RBHw/au1GhwVrWp1j4
        j7twDxsX1uMaYnp7x75rZElrvZ0JLndyJLgN1/I/wuYOy/zbSZrkHVlr/PYqb
X-Received: by 2002:a05:6a00:1d1f:b0:581:ad48:d480 with SMTP id a31-20020a056a001d1f00b00581ad48d480mr27330057pfx.34.1672931901285;
        Thu, 05 Jan 2023 07:18:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZeIVHp4tcPp0aAc8YwtcMhRZ7cPztewotX87PB8LgkRIZk1N3HZU7snWQHtTp/wqjKlne1w==
X-Received: by 2002:a05:6a00:1d1f:b0:581:ad48:d480 with SMTP id a31-20020a056a001d1f00b00581ad48d480mr27330041pfx.34.1672931901018;
        Thu, 05 Jan 2023 07:18:21 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b0056bc30e618dsm12473040pfq.38.2023.01.05.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:18:20 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Date:   Thu,  5 Jan 2023 20:47:38 +0530
Message-Id: <20230105151740.29436-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230105151740.29436-1-sinthu.raja@ti.com>
References: <20230105151740.29436-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1672931901-302517-5395-21753-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.198
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245267 [from 
        cloudscan8-23.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

AM68 Starter Kit is a low cost, small form factor board designed for
TI's AM68 SoC which is optimized to provide best in class performance
for industrial applications and add binding for the same.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 203faab80142..acbc25108533 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -69,6 +69,7 @@ properties:
       - description: K3 J721s2 SoC
         items:
           - enum:
+              - ti,am68-sk
               - ti,j721s2-evm
           - const: ti,j721s2
 
-- 
2.36.1

