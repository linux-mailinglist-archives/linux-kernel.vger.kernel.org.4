Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61856663EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAJLGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjAJLF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:05:26 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C332EB3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:04:31 -0800 (PST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199]) by mx-outbound42-10.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 10 Jan 2023 11:04:29 +0000
Received: by mail-pl1-f199.google.com with SMTP id h2-20020a170902f54200b0018e56572a4eso8159424plf.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1cp8jCdQ8KsQOpsNoitZvF17OZbfaow8wAgHnEao4U=;
        b=Kk2+FBJlUY3FvR8JNtq3Ak2OPXW1faD1LjkiRCV0Eg4DlMr0anJXId0Eb2Ho1O6NTW
         bRevGq63OC+3C0AgfL651pL+fcvcY3lkgqSGylXOrTf0+izZa3HTqJhegmiBJMvGq4IH
         xi+SfUFqfGmNuHaKS7WxRf+6eZmmkHDDRB5+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1cp8jCdQ8KsQOpsNoitZvF17OZbfaow8wAgHnEao4U=;
        b=ltvfxmjdroq9DZ9g7Q2nx8rUhMI1dWO0Ne2myeDM0rvuqLVexJc6umt4v06QvgTYDe
         rLVVH7ALiRn/3PtqeWFyMfin8hRSBiVmqnoAqKt3XD9Jf7ssMyrjj0QJ5iySaujq/XlE
         pX10oqXRF7gcJ+MBSEYW94A967+EmMzadpxH7rymgmvyQ7cgMA/7Be7uyQqKVsUAybQp
         CosJWZ7nRMAhTe9fX5uZsE3S9iJQ3Xank6ZOuD1V2CXCT3h3IcBYUjddeCOSe5IQjrmF
         KqzOeMVageSqw9OBlX4sRY3hzrwqV0T6x8u0XYGZIO9je/gDNGe6gJ7hRRXx0EAl4PHt
         qCYg==
X-Gm-Message-State: AFqh2kozZOadc6rlJc+m1Gir/rEgJMNtxIubjzT21Twjp02Sz+zckcfT
        LmjNJAvIQ3OFqCH4BE1iDV/AQDSKDkCM5VxKqxLs9PAwO9re91/IslxKBQkFVhyT7LG9BresdEk
        lssQQ3/w56EG0GpTqff8mPiee2WaX6cDoId/G9p1UfTlic+Rjo53h7pZwTQ28
X-Received: by 2002:a17:903:330b:b0:193:30be:d146 with SMTP id jk11-20020a170903330b00b0019330bed146mr6759938plb.63.1673348665752;
        Tue, 10 Jan 2023 03:04:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsiPYorXTBxJPBfm+kQEHgdYnnSMAvQMS8w0p1opFko5B6Xju0p5g5Lc2qUP9tIZRfHYM6zpg==
X-Received: by 2002:a17:903:330b:b0:193:30be:d146 with SMTP id jk11-20020a170903330b00b0019330bed146mr6759916plb.63.1673348665319;
        Tue, 10 Jan 2023 03:04:25 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001897a8b537asm7840206plr.221.2023.01.10.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:04:24 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [RESEND PATCH V3 0/3] AM68 SK: Add initial support
Date:   Tue, 10 Jan 2023 16:30:49 +0530
Message-Id: <20230110110052.14851-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673348668-310762-5388-3255-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.199
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245372 [from 
        cloudscan10-75.eu-central-1a.ess.aws.cudaops.com]
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
Respinning this series after rebasing to 6.2.rc1. Added all the tags.

This series of patches add support for AM68 Starter kit(SK). AM68 SK
is a low cost, small form factor board designed for TI’s J721S2/AM68 SoC.

Refer below link to J721S2/AM68 Technical Reference Manual for further 
details:
http://www.ti.com/lit/pdf/spruj28

Design files can be referrred from https://www.ti.com/lit/zip/SPRR463

Changes in  V3:
Address all the review comments.
 - Remove the unused nodes that are disabled by default.
 - Update the gpio regulator node: gpio-regulator-tlv to "regulator-tlv".

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

