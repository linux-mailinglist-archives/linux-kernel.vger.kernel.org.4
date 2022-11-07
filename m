Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1261F405
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiKGNKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiKGNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:10:22 -0500
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F42193C6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:10:19 -0800 (PST)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198]) by mx-outbound22-4.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 07 Nov 2022 13:10:16 +0000
Received: by mail-oi1-f198.google.com with SMTP id z15-20020a056808048f00b0035a08170a97so4441846oid.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4fuZdwonDphiFwrvDgt+7IrILXPVSlkCWT1e74/3Bg=;
        b=ZmoCFKQiEF4cEtrrlS1gwsKAI75SiO3H/K+CbpY3eiV2rXTN32nwGIhNNLwOA4JPGM
         BlTf0b2OzE1kQEWxoQooFea0ddb+8d7qmUiY62YtFRf81aNsf/AiyrrEgJDs40d6KCDx
         dDDrTIydUtaQAlw6E9HNIMSijd0hpqq+Di+lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4fuZdwonDphiFwrvDgt+7IrILXPVSlkCWT1e74/3Bg=;
        b=olheSmx9tDPNoC7Yhyc6M6gpOe0r/qm243oTZRFy/9npR7nlTakPXSux+zVG7p7o1M
         RYfs8gdDu4uMQqi91e7OC8PBAlTpgWYtSvMLs2LeNKxs26QyDl/oWCr9zi5+zGc3x39K
         srOWXnW4t8NLIcI2zyllxRi8ML1v5o+aA0ND749FiL5vAdzq89MXyRuAv6HpSpTVR52O
         X1J4M9TMTU2TDG/U+pTjGqznDDBhW5jfrinmVDjnNq0JRjvpqgJkR0bmuw/IWW+wFTZk
         X6SaJpXpwnKTgWTAzupjPvslykFWq3BP8VAgv+bhv4UEDtTsuJfzWFzasx12B+odUK1l
         rg+Q==
X-Gm-Message-State: ACrzQf11A5Qhj321Te/9Ig5abdgM7VfdcqpkzzfkJnYozitFAT/vksP9
        Q2YliI56kmj26fRzZlwYGty/1gMo+SK/+6CYzOBFRYQ+inyMhh9ncZ8F8C5RXyT0o4qrH8a3Z3f
        ZQEP2o4Pp2vNSTDGfpdO4cipqwRyZqvXWIP2lVgEVudyrdxU/S97mqWLeB9g7
X-Received: by 2002:a17:90a:ab8e:b0:213:ef84:3bb9 with SMTP id n14-20020a17090aab8e00b00213ef843bb9mr40596375pjq.241.1667824749657;
        Mon, 07 Nov 2022 04:39:09 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4YSrUFxf2aECpLMpC4Y5jWlCk5Om8R/Q4FRtgfc2uFnLWMJbVulgh/30LjvWFolX0jHF2OuA==
X-Received: by 2002:a17:90a:ab8e:b0:213:ef84:3bb9 with SMTP id n14-20020a17090aab8e00b00213ef843bb9mr40596353pjq.241.1667824749373;
        Mon, 07 Nov 2022 04:39:09 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7956b000000b0056bbba4302dsm4400423pfq.119.2022.11.07.04.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:39:08 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Date:   Mon,  7 Nov 2022 18:08:50 +0530
Message-Id: <20221107123852.8063-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221107123852.8063-1-sinthu.raja@ti.com>
References: <20221107123852.8063-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1667826615-305636-5385-13845-1
X-BESS-VER: 2019.1_20221024.2147
X-BESS-Apparent-Source-IP: 209.85.167.198
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.243991 [from 
        cloudscan19-69.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

Changes in V2:
*Addressed review comment
 - added entry in alphabetical order.

V1:https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-2-sinthu.raja@ti.com/

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

