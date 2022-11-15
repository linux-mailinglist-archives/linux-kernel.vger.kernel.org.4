Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF4A629E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKOPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:50:44 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F728D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:50:42 -0800 (PST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199]) by mx-outbound15-12.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 15 Nov 2022 15:50:40 +0000
Received: by mail-pl1-f199.google.com with SMTP id k15-20020a170902c40f00b001887cd71fe6so11519469plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AKk/iHxlRyPsei0kf0ul5R2X5r1GkRebYS9OplFI6w=;
        b=R/Ch57dNpGhLRTiFS/EDyZXyBSMFfT/2wuO4XuDBUMj61Zk0a9fcYJYOtUeC02otPm
         LEBoaK+dbqptFwrnytjx12SG0DdyFJQEKFpiiH932OEFd3wVvlOfs8lD03Tw0rhjXOiz
         Ps6DLRwQsaboHtWg5qhnYLpHBuunTQZRqg5IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AKk/iHxlRyPsei0kf0ul5R2X5r1GkRebYS9OplFI6w=;
        b=RFQCe3e5ZLUNiYoTC0PRwFq8n21G9/mwOVuJfbBr54YEjdfwnezwupMqFD+8mlxtsz
         n30nSrdixgJ4hCAdR3xu5AunT4tGBCDdsRfRBrOfeUT/WRAFmxO/5TFpxMy6AWbMwQDS
         lufzhZ/FykTDuyzuqio8J7nXZk2WaHG9JVubUdO2kaxBIh7GDcTK3Xd5uIcaIRV/M7sj
         K2w9n7BXhupsLjHFA/RrTqpHh7K4V6drErfOcdtCk+LiZoBtDXvcT1GiiXs7cl1JgmUs
         u4ZOUimO9nLM5QIhRgoFhq5hnIP+edS10DV+Pu2IhZ/gotgiDogUj0TXhTgD7mucNYoO
         RaXg==
X-Gm-Message-State: ANoB5plGyLDQDkGEzbNsxQtE+UflHFy5R1PCg3ng5VqZAwOSPsb6m1Kv
        t6tS+O9QKCMzwDFGnPWStZ71J9fviUjRmkqoUO9R/oSAJ5RW6SzmUljNXtzYsQUHA7EaRSvd7q8
        C1UHhae6bIoy+1c3CV3w4qUN57e0JIe/9CTNIKqi3wjTpftwTxt9zFjpUKvWQ
X-Received: by 2002:a63:550b:0:b0:46a:f665:ed96 with SMTP id j11-20020a63550b000000b0046af665ed96mr16442919pgb.486.1668527437370;
        Tue, 15 Nov 2022 07:50:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7nanjVbNOu0c9YMBYkuDrnfggk1H1OIyW4wrG8UFQdPwfUgwaY+3oyRu/o2ccWOpZ7VzuQYA==
X-Received: by 2002:a63:550b:0:b0:46a:f665:ed96 with SMTP id j11-20020a63550b000000b0046af665ed96mr16442903pgb.486.1668527437033;
        Tue, 15 Nov 2022 07:50:37 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b00178b6ccc8a0sm10018478pli.51.2022.11.15.07.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:50:36 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 0/3] AM68 SK: Add initial support
Date:   Tue, 15 Nov 2022 21:18:29 +0530
Message-Id: <20221115154832.19759-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1668527439-303852-5540-3110-1
X-BESS-VER: 2019.1_20221114.2026
X-BESS-Apparent-Source-IP: 209.85.214.199
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.244167 [from 
        cloudscan16-48.eu-central-1b.ess.aws.cudaops.com]
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

Hi,
This series of patches add support for AM68 Starter kit(SK). AM68 SK
is a low cost, small form factor board designed for TI’s J721S2/AM68 SoC.

Refer below link to J721S2/AM68 Technical Reference Manual for further details: 
http://www.ti.com/lit/pdf/spruj28

Design files can be referrred from https://www.ti.com/lit/zip/SPRR463

Changes in  V3:
Addressed all the review comments and the changes are captured in seperate patches.
 - Removed the unused nodes that are disabled by default.
 - Updated the gpio regulator node: gpio-regulator-tlv to "regulator-tlv".

V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-1-sinthu.raja@ti.com/t/#mbe43b02221733bb6eb06b203359e90ec08406afc
V2: https://lore.kernel.org/lkml/20221107123852.8063-1-sinthu.raja@ti.com/

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

