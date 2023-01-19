Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E4673ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjASNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjASNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:55:14 -0500
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278974958
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:55:12 -0800 (PST)
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197]) by mx-outbound23-43.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 19 Jan 2023 13:55:09 +0000
Received: by mail-vk1-f197.google.com with SMTP id v190-20020a1f2fc7000000b003e1db6f41deso586958vkv.19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6zkev0JIFiEPvI2nPxwx8i8t5FDgQlGRipodj6u7CI=;
        b=XgjFckN1eaHdywiIyFQw5k/tzZRPYvVPZaFqCRIXTmXAW/n0IaWwNYeHE29WtA1C2A
         fiy9m7p3Q8M2djOLFh2J18ZPAHrPG6RK6SLGlPCr4SWL+lFQQXMQzoRRD3lbtC4+WUUD
         wSkGEcHAGhNJQi8xDBooOiUPEjLHNP9PLKdVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6zkev0JIFiEPvI2nPxwx8i8t5FDgQlGRipodj6u7CI=;
        b=HexmR2ICaXij28JLFJ5lQ1oPOgkyZGI564vaNr5GJvITzFa9vLB74Dy02QAsN8lr9s
         jRawhX2czct2uGiiZBMwPyy+o3EMG3Z6GaxgGCq8BNf1mw1WoWgZO+Fu0NmDnV8HaBpa
         QiPKLWCpdh6AtbHqjyECqCfsi0bJ3u0Zy/fgorDbtxFNdQSmf051lWN7RBBri4yO4TMl
         zJRS/FmhMRhrzuZ2TK0TSfsX8iGu5mZ9OBjeKPLipMujXoys4C+H8z3QnbY1dBcXZ0mY
         Uksgw+gWpLTMeNRwMR5KHRg/ssTYpNkwDUzRj3ytas2vKekGtXOb0UrmKZhZnbTKlrL9
         h2kw==
X-Gm-Message-State: AFqh2kqt1EG9Bg3VA1uyNpnAnNPo8AQRNn2iteTVX/Au8qSz8/9NDSBU
        jQZYRFsVXKgs0rMPNsA2g86Y+B9CAE/2DP4Q+N7dXgPxq5h+5HTbJBXyCixxNY+1a1BVVnj3WUJ
        oDPpPp5s8Nju3S47GGazSvoO4A9ZYQqZ++mc+AAJXC0gqgb0gbWKT32DSqAxW
X-Received: by 2002:a62:1615:0:b0:587:df0a:804d with SMTP id 21-20020a621615000000b00587df0a804dmr11925370pfw.27.1674135060907;
        Thu, 19 Jan 2023 05:31:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv8YfViyfEk8kzS4n7BrYaeR08667Rj8DYwEIaQzzZs6i2TWPXXNXYiH0FO0zKAU5+QcVd5Lw==
X-Received: by 2002:a62:1615:0:b0:587:df0a:804d with SMTP id 21-20020a621615000000b00587df0a804dmr11925336pfw.27.1674135060566;
        Thu, 19 Jan 2023 05:31:00 -0800 (PST)
Received: from LAP789U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id l123-20020a622581000000b005818d429d98sm23949210pfl.136.2023.01.19.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:31:00 -0800 (PST)
From:   sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 1/2] dt-bindings: arm: ti: Add binding for AM69 Starter Kit
Date:   Thu, 19 Jan 2023 18:59:57 +0530
Message-Id: <20230119132958.124435-2-sabiya.d@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119132958.124435-1-sabiya.d@ti.com>
References: <20230119132958.124435-1-sabiya.d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1674136508-305931-5378-9901-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.221.197
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245567 [from 
        cloudscan22-80.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, NO_REAL_NAME
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 Starter Kit is a single board designed for TI AM69 SoC.
The AM69 SoC belongs to the K3 Multicore SoC architecture platform,
providing advanced system integration in automotive ADAS applications,
autonomous mobile robot and edge AI applications.

Add DT binding for AM69 Starter Kit.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index b28cce4a9157..d5fd058e4aa9 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -81,6 +81,7 @@ properties:
       - description: K3 J784s4 SoC
         items:
           - enum:
+              - ti,am69-sk
               - ti,j784s4-evm
           - const: ti,j784s4
 
-- 
2.25.1

