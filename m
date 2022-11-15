Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742F8629E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKOPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKOPuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:50:46 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9475F28D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:50:45 -0800 (PST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71]) by mx-outbound40-192.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 15 Nov 2022 15:50:43 +0000
Received: by mail-pj1-f71.google.com with SMTP id o15-20020a17090aac0f00b00212e93524c0so12435632pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNJppNvxg9XQ1DZWlwntbSgTxRDnFbDURjIFvFATTDU=;
        b=CujJ3uiQDBgXJk9SDLvy3AjxrcNmwRSiTBFL8KS257bjyocTQwFaQcvtesebB9xKtA
         EjkCNQDzn+kP1xaOj3pUngr8rd0DGVIH2ksOq99RBvmO506TvsalF7S3oXUWEvSQxG9E
         v43Ps7E2MtO4c+doCQzKw5255pFbK7qlTnMaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNJppNvxg9XQ1DZWlwntbSgTxRDnFbDURjIFvFATTDU=;
        b=NtaysntAObW/8XEe26Wk8GriEw+9PIwQ4C3XNbUEgpxRY6hMREoclG1z7Qupdx/YDc
         pw8NzH1iRCXtfa7rKT5lEVRfQu55Nr0eeoN/ZffkaKDWbYyaPM5IUXLOvl2d6XjrSfwl
         IfErh69G1Cj99XNuQYtgKGl6r4CllFkeKUL2HoWp5sXjZYJ+V0ikS4XBL3eino7G/Q+G
         5WL+dbyXYLm5n/Et7CGuyBmBP8giR3LlnQ7D483GijrRk8B6AkdJUeU6TrfXVVxGij/p
         ASfoZEjTpJufZV3PXpM+zSOHo5eN+p3Lw4RbP4ktWbQhSx9WsbnEeV1+XUxwAgGWj5j3
         x5yQ==
X-Gm-Message-State: ANoB5pnAFcrIsptmqN+7EoCaFPX29q5CjtBEVZAvagxBaQdvM+/Gjqw0
        sPMcjMUEV8reYzqg/o+O29m0DJxq7SWDd0s0gGMJyydo7DYg/eNujzcetwrOKNM6pjA+t0ZkUmo
        ZlQzfQqsuX+L6tFwcWBed1zLSSnLCXIeH6dR5WYLfy7AY8C+lr3W+/Weke/QK
X-Received: by 2002:a17:90a:b10b:b0:213:16d2:4d4c with SMTP id z11-20020a17090ab10b00b0021316d24d4cmr2943909pjq.70.1668527441995;
        Tue, 15 Nov 2022 07:50:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf77wilQjZRsipVqFLFlNCIVtx7bPf/cMOjc9+N8np3LWCVOP5Vh1xOdjhDsIZ5iGKNeMRQojQ==
X-Received: by 2002:a17:90a:b10b:b0:213:16d2:4d4c with SMTP id z11-20020a17090ab10b00b0021316d24d4cmr2943888pjq.70.1668527441665;
        Tue, 15 Nov 2022 07:50:41 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b00178b6ccc8a0sm10018478pli.51.2022.11.15.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:50:41 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Date:   Tue, 15 Nov 2022 21:18:30 +0530
Message-Id: <20221115154832.19759-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221115154832.19759-1-sinthu.raja@ti.com>
References: <20221115154832.19759-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1668527442-310432-5619-3174-1
X-BESS-VER: 2019.1_20221114.2026
X-BESS-Apparent-Source-IP: 209.85.216.71
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.244167 [from 
        cloudscan15-107.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 28b8232e1c5b..072d1215a113 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -68,6 +68,7 @@ properties:
       - description: K3 J721s2 SoC
         items:
           - enum:
+              - ti,am68-sk
               - ti,j721s2-evm
           - const: ti,j721s2
 
-- 
2.36.1

