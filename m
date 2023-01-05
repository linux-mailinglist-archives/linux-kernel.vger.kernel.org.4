Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCB65EFD5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjAEPTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjAEPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:18:49 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB75E09F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:18:23 -0800 (PST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197]) by mx-outbound9-213.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 05 Jan 2023 15:18:21 +0000
Received: by mail-pg1-f197.google.com with SMTP id e184-20020a6369c1000000b0049de6cfcc40so9046414pgc.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6X+691siEqN4skGdU5S4Z9b5pWmhX1OKjnMk5C8EJM0=;
        b=hDTfuN6qZ65+fLCZ4eWB0SHzzBwNhzMAl3t+2xzMtndMWahkcduaJi5FbhttVAPWSh
         ReUiYAFzsaKcQqFGS/VZ5X1dcsTugC2hQJqh10hh4ewr5xexCouMTOJYmnMtr3LS+kqo
         DTpFa2pIs9xqTeDZHroyMy5tI+sD7VbwMX1s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6X+691siEqN4skGdU5S4Z9b5pWmhX1OKjnMk5C8EJM0=;
        b=QQzHFkY0uXWBn4lwqlzizfxLxoeCZfEqRUnc/vn0ycDFUvsH5iYqwm9wdeCdH3Y3Zj
         F9/ltsqVOlobmHtnHAm7AJ4mBu8djWbXIPhWdyXOlQSTDKKV+q7WSbNK+ETC2oOUMYqE
         FduqIWUuPZ8eRtQzdDC99s+XMryzgNojlhDDKUrb63ahdWm28gaQudv1VDY5dgnaLYEc
         wBM8vJGvj3kYtiXHb8QMH6MxK+BHb5AacQSdxaqEJpvEfU3ac7TEaf4ki7duKUczouQl
         yg/rPzqEVjqcYNOzg7U8/DtEeppREFqSZzqxKDKRr1Ll1cv79j3ysNatMiARZlueMdNm
         1Slw==
X-Gm-Message-State: AFqh2kpjohZdkXPUOYpCVxrM61IhvNMi7UrR4ZcpcIHTXvQtIsZEFiIk
        kHjNMWCMtl8rO9Rv1UISqNe8JrbpsnP1CIt3AT/i0WfmHGQXEXxMYsk+ger+vDAs/q6Zcd7apay
        Wb/WYConbOxFCH6X2LknMiBX4xA94bmr74jSTZaaSSlzDDA39mBR7JrEuxDjf
X-Received: by 2002:a62:6442:0:b0:581:eca5:12a3 with SMTP id y63-20020a626442000000b00581eca512a3mr24782824pfb.10.1672931896881;
        Thu, 05 Jan 2023 07:18:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtQuO9oOSOQYeYDtuRA0FU9Q1Z3/PbElbvvXJgID4I8mFO/sXH2ApWEGstNoVoJMOJkotQL1Q==
X-Received: by 2002:a62:6442:0:b0:581:eca5:12a3 with SMTP id y63-20020a626442000000b00581eca512a3mr24782802pfb.10.1672931896546;
        Thu, 05 Jan 2023 07:18:16 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b0056bc30e618dsm12473040pfq.38.2023.01.05.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:18:15 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 0/3] AM68 SK: Add initial support
Date:   Thu,  5 Jan 2023 20:47:37 +0530
Message-Id: <20230105151740.29436-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1672931900-302517-5394-21753-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.215.197
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245267 [from 
        cloudscan12-98.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_SC0_SA085b, BSF_BESS_OUTBOUND
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

Hi All,
Respinning this series after rebasing to 6.2.rc1.
This series of patches add support for AM68 Starter kit(SK). AM68 SK
is a low cost, small form factor board designed for TI’s AM68 SoC.

Refer below link to AM68 Technical Reference Manual for further details: 
http://www.ti.com/lit/pdf/spruj28

Design files can be referrred from https://www.ti.com/lit/zip/SPRR463

Changes in V4:
=============
Repost after rebasing to 6.2 rc1

Changes in  V3:
==============
Addressed all the review comments and the changes are captured in separate patches.
 - Removed the unused nodes that are disabled by default.
 - Updated the gpio regulator node: gpio-regulator-tlv to "regulator-tlv".

V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-1-sinthu.raja@ti.com/t/#mbe43b02221733bb6eb06b203359e90ec08406afc
V2: https://lore.kernel.org/lkml/20221107123852.8063-1-sinthu.raja@ti.com/
V3: https://lore.kernel.org/linux-arm-kernel/20221115154832.19759-1-sinthu.raja@ti.com/

Sinthu Raja (3):
  dt-bindings: arm: ti: Add binding for AM68 SK
  arm64: dts: ti: Add initial support for AM68 SK System on Module
  arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 335 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    |  31 ++
 4 files changed, 369 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi

-- 
2.36.1

