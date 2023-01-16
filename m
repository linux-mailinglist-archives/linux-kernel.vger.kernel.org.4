Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F166B819
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjAPHWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjAPHWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:22:35 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619593DD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:22:34 -0800 (PST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199]) by mx-outbound13-161.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 16 Jan 2023 07:22:32 +0000
Received: by mail-pl1-f199.google.com with SMTP id c17-20020a170902d49100b00192be705f76so19698531plg.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5jUZVFUgQ1jNK7mGkTIT+2MJMyk/ce05Kzqa9tsw84=;
        b=c52kjKvmkuWMgxR2AQXf8TZW8GTIPC0PcMa3EpWHtNsVC/k8nk6QZBjczkmemnXoKr
         d6WeVwQsv+Ql/bI1EzaIussMMusRYeeNXwuz23Y21ug7tWvjCd/0gAadW41W2ai+bAEk
         rinIEq9LOX9e3eDThd5ESU98zA659+gGN+qBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5jUZVFUgQ1jNK7mGkTIT+2MJMyk/ce05Kzqa9tsw84=;
        b=u1YEAJ+RmWubSnmM1mQVB7ssuwjpaRUJZbBViCFQKQxQ50ReaNn3mQith/lVjk8gI9
         Hae3JG6Kx1accS+9GVceRTs+iT1gh9DUnYRjr1ZDLbRkgcodFUQOesUnV5DGrc8ANAXS
         oekRkllt2svb9oYpxB9RNEITCQjuMU64Ez2f4CkQKdJH0ehJrei2dCyqlsLVRdrLrCGP
         lKIc5xd9aNIBVkbPWZ41AIlsvw/BWqKvECadzM0AKl4zGnLY2j8b54g/SvkbloqS8Eiy
         MMkDT45LAL2EQ7xnc/6l9rQoNM7M0Yu1h2H2uHA4V9NgBa9gFaNrp64hBUcaxLUnv7rQ
         0XAA==
X-Gm-Message-State: AFqh2kq7oynW20TVCPyWCTFLbAx42YMSrH1MabpWgFvOjgVUXllAoOjf
        h5hP0xweQ3GYemilJBbXZ2/DW5L45dUqlJPl2XSk/gi67BiDgK7rXCD7EpEncowmPaceG7su+dX
        dHRK391kadoQdUb9qaS6rYYFRNWKysltJVUX1ephgUIsB3HHVh1a0pOl1i+vi
X-Received: by 2002:a17:902:b7cc:b0:194:6409:b54a with SMTP id v12-20020a170902b7cc00b001946409b54amr15645457plz.49.1673853749491;
        Sun, 15 Jan 2023 23:22:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu+QHrte+sGRXfz8yXCa1OhmxtYnFl2NP/QEzJomF8WsFNCjRJxm3loeYGGtAweKBpwC2rfIA==
X-Received: by 2002:a17:902:b7cc:b0:194:6409:b54a with SMTP id v12-20020a170902b7cc00b001946409b54amr15645432plz.49.1673853749144;
        Sun, 15 Jan 2023 23:22:29 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001895f7c8a71sm1770346plg.97.2023.01.15.23.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 23:22:28 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V5 0/3] AM68 SK: Add initial support
Date:   Mon, 16 Jan 2023 12:44:43 +0530
Message-Id: <20230116071446.28867-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673853752-303489-5388-462-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.199
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245498 [from 
        cloudscan21-83.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b, BSF_SC0_MISMATCH_TO
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

Hi All,
This series of patches add support for AM68 Starter kit(SK). AM68 SK
is a low cost, small form factor board designed for TI’s AM68 SoC.

Refer below link to AM68 Technical Reference Manual for further details: 
http://www.ti.com/lit/pdf/spruj28

Design files can be referrred from https://www.ti.com/lit/zip/SPRR463

Changes in V5:
=============
Address review comments:
- Remove the unessential comment.
- Remove alignment property from secure-ddr node, as no memory is allocated out
  of this region.

Changes in V4:
=============
Repost after rebasing to 6.2 rc1

Changes in  V3:
==============
Address all the review comments and the changes are captured in separate patches.
 - Remove the unused nodes that are disabled by default.
 - Update the gpio regulator node: gpio-regulator-tlv to "regulator-tlv".

V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-1-sinthu.raja@ti.com/t/#mbe43b02221733bb6eb06b203359e90ec08406afc
V2: https://lore.kernel.org/lkml/20221107123852.8063-1-sinthu.raja@ti.com/
V3: https://lore.kernel.org/lkml/20230110110052.14851-1-sinthu.raja@ti.com/
V4: https://lore.kernel.org/lkml/20230105151740.29436-1-sinthu.raja@ti.com/

Sinthu Raja (3):
  dt-bindings: arm: ti: Add binding for AM68 SK
  arm64: dts: ti: Add initial support for AM68 SK System on Module
  arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 335 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    |  29 ++
 4 files changed, 367 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi

-- 
2.36.1

