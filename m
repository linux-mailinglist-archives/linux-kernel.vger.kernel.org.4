Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B52461F3F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiKGNHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiKGNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:07:08 -0500
X-Greylist: delayed 1677 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 05:07:07 PST
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CBE19C1A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:07:07 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69]) by mx-outbound46-74.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 07 Nov 2022 13:07:05 +0000
Received: by mail-pj1-f69.google.com with SMTP id r9-20020a17090a2e8900b0021409b8020cso10408751pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJF709bicUUb+8NhhqwXBdF0vLDptkKEpCyX6Snn00E=;
        b=NK0gBe9a5COxZiVsUb05B3wSiwwfGnJ2c9MBNQaq3Js7+szkGO9pP452NQWju1uRB+
         jRNkREtjtjroIMXnyVjMs7PAu/dQOVJjd3qpxP4Madi9bH1KHLiKanxX5wshPvq6cO18
         h71xsyeuRsRbxQPUE3gIIUYBA+gtTp7OxOgbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJF709bicUUb+8NhhqwXBdF0vLDptkKEpCyX6Snn00E=;
        b=mesmixb9zUltC8zW86Bl+NaCVLcUGjxVUUv7zRiLQaBbutwRz+lST6h5gWpYgAgflI
         cOge/CZEnsoULP1qNT87dvj1LgXSV/7VdivIVPbplcFctciP2BQiehyxerSScoUYBLRf
         +QEemNkJsIYddljgEqsgxq7sH5Av8VbvuFi9CTzMnbVhuJQebool4Ch9OxVIZXeyPbRp
         wh8ajLixbo57rt2VgbiCZcp/giLmEepGg4Bq1n/w39S2df1dPAsBrY5mlNRXroz0PxNg
         x+5qnPL+ftrPdKwLs8Hz4k6SFq6MhAf31ATodiFHr4cao0RZi64i8s3xjxgz9fNO+8Zd
         nSVA==
X-Gm-Message-State: ACrzQf1/dHzWfbcb1V71xA7BpQPqY5rc61wUIsiEY2GgvCXfK+oq0DP/
        ADiZgxuj7DHqVEyCG0RPUUVjFw/Qdj27G/VIAJL4iF2K3su0wlNDveWR3RhLVj5Lfex+N4JpCdS
        YlHdaQAkeAoi5SYkAW4karb2uBG2QL21UwVzoR4yz1FSGiJ/YWvL/QZMxHH+F
X-Received: by 2002:a63:4c05:0:b0:46f:3dfb:98a1 with SMTP id z5-20020a634c05000000b0046f3dfb98a1mr44543185pga.30.1667824745526;
        Mon, 07 Nov 2022 04:39:05 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6UEiI0GGPOGHH6U54AKkBHF8oCkkLQ4OU9/768dprcBx141wATMrqu3NMK7jbnWtwBGFSrdA==
X-Received: by 2002:a63:4c05:0:b0:46f:3dfb:98a1 with SMTP id z5-20020a634c05000000b0046f3dfb98a1mr44543160pga.30.1667824745148;
        Mon, 07 Nov 2022 04:39:05 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7956b000000b0056bbba4302dsm4400423pfq.119.2022.11.07.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:39:04 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2 0/3] AM68 SK: Add initial support
Date:   Mon,  7 Nov 2022 18:08:49 +0530
Message-Id: <20221107123852.8063-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1667826424-311850-5384-11247-1
X-BESS-VER: 2019.1_20221024.2147
X-BESS-Apparent-Source-IP: 209.85.216.69
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.243991 [from 
        cloudscan8-52.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_SC0_SA085b, BSF_BESS_OUTBOUND
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

From: Sinthu Raja <sinthu.raja@ti.com>

Hi,
This series of patches add support for AM68 Starter kit(SK). AM68 SK
is a low cost, small form factor board designed for TI’s J721S2/AM68 SoC.

Refer below link to J721S2/AM68 Technical Reference Manual for further details: 
http://www.ti.com/lit/pdf/spruj28

Design files can be referrred from https://www.ti.com/lit/zip/SPRR463

Changes in  V2:
Addressed all the review comments and the changes are captured in seperate patches.
 - Updated the commit description.
 - Updated the regulator nodes: fixedregulator to "regulator-"
 - Updated the commit $subject to align with rest of the commits.
 - Dropped the blank lines
 - Changed the node names that are added with underscore("_") with "-"

V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-1-sinthu.raja@ti.com/t/#mbe43b02221733bb6eb06b203359e90ec08406afc

Sinthu Raja (3):
  dt-bindings: arm: ti: Add binding for AM68 SK
  arm64: dts: ti: Add initial support for AM68 SK System on Module
  arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 447 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    | 127 +++++
 4 files changed, 577 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi

-- 
2.36.1

