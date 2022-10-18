Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C21602C69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJRNGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJRNGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:06:31 -0400
X-Greylist: delayed 1282 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 06:06:27 PDT
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960AC5897
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:06:26 -0700 (PDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197]) by mx-outbound42-3.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 18 Oct 2022 13:06:24 +0000
Received: by mail-il1-f197.google.com with SMTP id f15-20020a056e020b4f00b002fa34db70f0so11908365ilu.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z1rGp2v9mEwXt8YXEuSWE0c803I39TsUvISP9jq4E8=;
        b=D2pYHZ/+8B138uAPKr/q23TuJOUTgkZk1gh4ZiN12mRtS6ICUEtsquemwKVZyHrNTt
         UHKsP+KHrI3MZ1X3zF6dkq7mlgoxtHDKXDDyUyx2Kysh/xDLDtFa8Mi+Wgh0k4Z2KHsA
         /lro36w88gNNsi3c3kGttAKRle+rdlRL5XqIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z1rGp2v9mEwXt8YXEuSWE0c803I39TsUvISP9jq4E8=;
        b=WCwey2GZhsi2W8yp9JOo6zYf31YZ6ErMKHXYIOTX27a/zD3E+jUMqjirHaT/a3ktmo
         OyG6IvogwHaObnVkoRxHFmkPgOWtRxz9/cb4Z6KWznuIgOKvDSkZnCiilgkV+Tn6ocNv
         Jf0NtkxiEq+0+Yd8+DkgL/5nPoAz/5oettwfYTi5lqq8aUy0l30V0cs0DU0pcTzP5/jX
         IUk0hkRvrLUTbJQCWGYDGk3LvMR4DxamM4hW5CB//lFObMw7ja0jNlQwRWwXL+j7lc9C
         J0gb6XdW4Jj938tlvMn23g8IO0xSDx90O0UmDkhbQZAdb7I0Hh92GSdMU4QpOdVG1auy
         9svw==
X-Gm-Message-State: ACrzQf1fKQi+CMN+swqg+whfULousBPxl03IZDV2kutxcCGRt/YD7YlU
        XO/YZpubO/0tmfw0oUHlBleGEGiO4j3QvdAiX61TF6EpWgeUDlbgzaPljgXZew/ey1oP5hFt5Ve
        6SHshlOTsvVjpkig6tjtrUx9VAfoDg9zxGMLtd3XVfq65lhKUs+Z9K+oJcN+A
X-Received: by 2002:a63:698a:0:b0:41c:8dfa:e622 with SMTP id e132-20020a63698a000000b0041c8dfae622mr2427448pgc.465.1666097105366;
        Tue, 18 Oct 2022 05:45:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6WLNGtemWWOTpn1A26+M2NZ6XE82Ng3zU2G5qw9ynCu48j6nP1iE7+68asC4pzw5S8dxsg4w==
X-Received: by 2002:a63:698a:0:b0:41c:8dfa:e622 with SMTP id e132-20020a63698a000000b0041c8dfae622mr2427428pgc.465.1666097105093;
        Tue, 18 Oct 2022 05:45:05 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:330a:c5d2:e90c:db79:45c8:3513])
        by smtp.gmail.com with ESMTPSA id a17-20020a621a11000000b00563ce1905f4sm9110102pfa.5.2022.10.18.05.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:45:04 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Date:   Tue, 18 Oct 2022 18:08:47 +0530
Message-Id: <20221018123849.23695-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221018123849.23695-1-sinthu.raja@ti.com>
References: <20221018123849.23695-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1666098383-310755-17559-920-1
X-BESS-VER: 2019.1_20221004.2324
X-BESS-Apparent-Source-IP: 209.85.166.197
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.243545 [from 
        cloudscan9-124.eu-central-1a.ess.aws.cudaops.com]
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
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 28b8232e1c5b..54f983fb23cf 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -69,6 +69,7 @@ properties:
         items:
           - enum:
               - ti,j721s2-evm
+              - ti,am68-sk
           - const: ti,j721s2
 
 additionalProperties: true
-- 
2.36.1

