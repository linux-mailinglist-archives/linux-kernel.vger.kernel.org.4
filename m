Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEC766B81A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjAPHWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjAPHWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:22:38 -0500
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEB893D8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:22:37 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69]) by mx-outbound21-48.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 16 Jan 2023 07:22:34 +0000
Received: by mail-pj1-f69.google.com with SMTP id oa8-20020a17090b1bc800b002292ab4cc4cso5254604pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6SZCK2C9Gd1gEZl8NQFe5W6URcLd4Ip4mOBTLwJwFY=;
        b=l0pTEzVQezVrCri07m6JUCLAWd7W8Lu3xuYgVmuZsrFx5HSZGSLCyo9wobqufeGr1D
         l5zZMXbaFOrYsEaKlU3L5uZ+KAKE5ijI/H9OIxZLtwlfEw626nEDmk3/tdRzbcJx95Xn
         e4YzOC4/PVzzRtXbpFGoq7G3EmCaA81TXGxxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6SZCK2C9Gd1gEZl8NQFe5W6URcLd4Ip4mOBTLwJwFY=;
        b=MKwmdb6ec+lk/X88EASBu9zcCKtZ/jjX/WWQTmGSJ/72Gg3bNHez0T/gMI8x1ldGw1
         wUmDXImjG0ATg3jGXlRlrrjKxAfLPaRuYsJVh8jTDh8D3uLUtygLwMKry2BfcRMc+lbt
         +d1VNzd+7QWgzkM9aqtpsUyPQ4v0Kl9uBNgdsBqglKHna5l6f9DVw/DLYyjL+geejcU+
         h42VJXKNrt9C66ltm8U5CrteLN29sFEvBGXCd9CKjWcUxEo6d/W3BotEpN4U7PbCXPDb
         rw3cFzWC403MtysIhTQ/eLWsukZMnURxGEBH4IfLBCO7ztQt1HZPhjQvG7hCQ20my3i1
         Klaw==
X-Gm-Message-State: AFqh2krD2efE0ZM1NQ22//f3NZ7crOJ0pN9Z1RfYCcc8US898ApmgvWt
        lI5XmHnhIedrB9kmesrhMCl27Ghnq2Xhs1FPJLN7K/DpY+xir04Ipjx7jtmnh0gzTVHTEGCIoED
        lNJMhrooWMR7IQ/Vgyd03qlAEyOyFAle9zCn/mCP4YmmKGTdjylZgcuBAChSA
X-Received: by 2002:a17:902:8d95:b0:192:8d17:78e0 with SMTP id v21-20020a1709028d9500b001928d1778e0mr66157100plo.42.1673853753739;
        Sun, 15 Jan 2023 23:22:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuGUvTWCiQl6TPUsgRtz0bopvoECC0NymQp0myuWs4te8uRj2OaH1AIGJ5I4q0Ym7LQ9NYyDQ==
X-Received: by 2002:a17:902:8d95:b0:192:8d17:78e0 with SMTP id v21-20020a1709028d9500b001928d1778e0mr66157089plo.42.1673853753423;
        Sun, 15 Jan 2023 23:22:33 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001895f7c8a71sm1770346plg.97.2023.01.15.23.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 23:22:32 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V5 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Date:   Mon, 16 Jan 2023 12:44:44 +0530
Message-Id: <20230116071446.28867-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230116071446.28867-1-sinthu.raja@ti.com>
References: <20230116071446.28867-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673853754-305424-5383-505-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.216.69
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245498 [from 
        cloudscan23-233.eu-central-1b.ess.aws.cudaops.com]
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

No changes in V4 & V5

Changes in V3:
=============
Add Acked-by tag.

Changes in V2:
=============
*Address review comment
 - add entry in alphabetical order.

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

