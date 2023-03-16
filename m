Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2F6BCE93
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCPLlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCPLlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:41:22 -0400
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D216AE1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:41:18 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197]) by mx-outbound10-239.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 16 Mar 2023 11:41:15 +0000
Received: by mail-pf1-f197.google.com with SMTP id l19-20020a056a0016d300b006257255adb4so997546pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1678966872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MA9+uwBzdbKG1z6NwJHm1FDpFGQQBO7dyUaxsPMF/d0=;
        b=KXAliz6qjF/MIvSnN5/QVtg5miZFwjpFSDhtY/TqbntTAv9KQR3hQZXDeaxmiD4+E2
         K1HHHhXmsDSADU1yWGITH60gW17PX6Sz3pp4k9BnNa58ToyFBTwCSTmc14kxpsqnYEZX
         m2aRqyRkD5mqj2RBkcOymy3mfu/82kt0Naqdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA9+uwBzdbKG1z6NwJHm1FDpFGQQBO7dyUaxsPMF/d0=;
        b=iXWjA2hLV43y7lDtYXj2Qvnx+YbZC/wc0g+dwj8RGMcCO50XxLyjotbV4PrUDD7Mx+
         0r/miowrpSEM4bWK0g5Gp3E/v1nFD3GH48ynGif8JLFLcLelEXuYGw6gwFnxOUCMbGWu
         JCNuDSx1VjyYGLEzGvhNTVOwGR9O8AMuRV5RyELStL00rWeZgKkwpoRnxqs8JrNIBRKX
         ngTLaK4S8Z0dD5RViM0RFR/I/ZFxnD8WV1tNrnjICmpbioRj0yGxZEO5pbz7pBTwh368
         u2wOZ5wL1ZjWN+ZHIH4QIQZUuupW/er4nQsaXn2SIPJQpZoIBz3nhpJnlfvahjK2d8dH
         BFBQ==
X-Gm-Message-State: AO0yUKWnwyp6QfHyMqJz+oHPbRxc8kT1cA5qaNdGCiOLZmYg+AujbzV6
        OiZ+e8XkqGd7MlEw7bMl7Sw+2+MlSPt/bzjuvGsxF7wt3NTXJyMOwkuTzBkCsw5WQAfB11r9hs5
        ySUGEKKzXIoSSto8tMr5SBSrKqKktmNfbk5rnxTwlTPlWqTO4WXaXcjHmgBdBj2SGwndh
X-Received: by 2002:a62:640b:0:b0:5a8:beb3:d55f with SMTP id y11-20020a62640b000000b005a8beb3d55fmr2391838pfb.32.1678966872351;
        Thu, 16 Mar 2023 04:41:12 -0700 (PDT)
X-Google-Smtp-Source: AK7set8yo/e83SGioAK45ds3ZgbU5QwJnUL+E+ap1OX/rx3Wbuy3gjX9mhOLjplXyr/yus6M3upDjA==
X-Received: by 2002:a62:640b:0:b0:5a8:beb3:d55f with SMTP id y11-20020a62640b000000b005a8beb3d55fmr2391824pfb.32.1678966871854;
        Thu, 16 Mar 2023 04:41:11 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.20])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78dc9000000b00571f66721aesm5284534pfr.42.2023.03.16.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:41:11 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 0/2] Fix WKUP domain IO PADCONFIG size issue and RPi header support
Date:   Thu, 16 Mar 2023 17:11:00 +0530
Message-Id: <20230316114102.3602-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1678966874-302799-32626-3819-1
X-BESS-VER: 2019.1_20230310.1716
X-BESS-Apparent-Source-IP: 209.85.210.197
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrKysDAHMjKAYmnGhkYmycZmBm
        ZpximJacZmhqbJqUlpaWaJqSZJlqbGSrWxABcykRBAAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.246833 [from 
        cloudscan10-37.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
This patch series fix the incorrect IO PADCONFIG offset size of the
wakeup domain for J721S2 SoC and add RPi expansion header support for
AM68 SK.

Changes in V3:
- Add Fixes tag.

Changes in V2:
- Update commit description.
- Update the offset value to 0x194 as 0x190 is the last register of the
  IO PADCONFIG register set.

V1: https://lore.kernel.org/all/20230123135831.4184-1-sinthu.raja@ti.com/
V2: https://lore.kernel.org/lkml/20230124120311.7323-1-sinthu.raja@ti.com/T/

Sinthu Raja (2):
  arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix IO PADCONFIG size for wakeup
    domain
  arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 70 ++++++++++++++++++-
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  2 +-
 2 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.36.1

