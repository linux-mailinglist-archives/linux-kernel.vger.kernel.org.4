Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D46EC812
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjDXIrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjDXIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:47:07 -0400
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FADC212D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:47:01 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70]) by mx-outbound8-18.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 24 Apr 2023 08:46:19 +0000
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24708bfb463so4253251a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1682325978; x=1684917978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+w6H8+2vxQqFn0Hvz2o0jVbixmOY2mXaRQjoywAneI=;
        b=Dc/Ua0KcPXp/HFHlAia+JTnHGHawClpPVWyEAg1zpmNReKGNJOTthSwkAKnZT2Vwqg
         4MHcNZ8fSJ1BizF3W2rS6gC6nVicmaxGzr2iirypQvbB56MEA1FLpjyx68DDOZyXfkb2
         cR9s0z001lY1zGxvyHS454ecGoVs3Hup6y024=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682325978; x=1684917978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+w6H8+2vxQqFn0Hvz2o0jVbixmOY2mXaRQjoywAneI=;
        b=ThKpq1LNcM5GSHfrvLE8MRmx83bIiNf+3ykI8MhrIsb5NO1CxJZFEQ+OmP1g8LrpZl
         zAhZxMGoQUGCUXKV2I8U7rBeRtd2Z6kSU5dm7Kes81jVmplL+11WeesFGeCw2mnG7bv3
         O+3VO2r/MkqGOQEZGxiNT2iGycX0mW5AzY/KlBloCTEBkXP4fF8qj0x5gZfYSYS3yhkg
         brzX9pyDf2zu3oMPqogQDKxJAG1ALnVyr5upxgG9vILYRIj5nG4pyvBfbjD+/ur+FgFh
         4M4UImksKVT5DZNXGQ2Pq+c8eBgEqK0QyCu6AbEtVLz1TW3rCHTrk/SrGh4/4v5IqxI4
         R4Fw==
X-Gm-Message-State: AAQBX9eYtDq/TmXCCdPivU8qPNyhGGtOohZO3lxnvTP5+rWaOOB3iLHo
        BK54K1IFGI7YKRZ4LZk7X5aFyttHH4Gma5f5PwguMDeSgqvkwal7Tr+DBdCBbf5UbfWyhANAv/O
        Ep6Pmbw9USskZSOHABEhYYZrS4Ug0UqMRZTt8dNXw8MKJx/YSw1rnfqqVZHRCr7HKMWS+
X-Received: by 2002:a17:902:d2cf:b0:1a5:34c2:81ca with SMTP id n15-20020a170902d2cf00b001a534c281camr15367938plc.60.1682324145036;
        Mon, 24 Apr 2023 01:15:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350bDB9FNnLZc1kh9VA8g2rLjR/XLlgWBjeICne16PmR96WsmmhpHXJZq7oJ+gtxKVP98E4hKEA==
X-Received: by 2002:a17:902:d2cf:b0:1a5:34c2:81ca with SMTP id n15-20020a170902d2cf00b001a534c281camr15367916plc.60.1682324144640;
        Mon, 24 Apr 2023 01:15:44 -0700 (PDT)
Received: from localhost.localdomain ([49.207.195.237])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709029a4a00b001a9293597efsm6089868plv.246.2023.04.24.01.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 01:15:43 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 0/3] Fix Main & WKUP domain IO PADCONFIG size issue and add RPi header support 
Date:   Mon, 24 Apr 2023 13:45:33 +0530
Message-Id: <20230424081536.12123-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1682325978-302066-5427-3804-1
X-BESS-VER: 2019.1_20230419.1731
X-BESS-Apparent-Source-IP: 209.85.216.70
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNDYyBrIygIJJZkZphhamlm
        aplimWpsbGBpbmhmnmKabGKUamBilpFkq1sQBMekyiQQAAAA==
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
This patch series fix the incorrect IO PADCONFIG offset size of the
main and wakeup domain for J721S2 SoC and add RPi expansion header support 
for the AM68 SK.

---
Changes in V4:
- Address review comments
  * Update main and wakeup domain IO padconfig
  * Correct the pinctrl node offsets as per the newly split wkup_pmx*
    and main_pmx* nodes.

Changes in V3:
- Add Fixes tag.

Changes in V2:
- Update commit description.
- Update the offset value to 0x194 as 0x190 is the last register of the
  IO PADCONFIG register set.

V1: https://lore.kernel.org/all/20230123135831.4184-1-sinthu.raja@ti.com/
V2: https://lore.kernel.org/lkml/20230124120311.7323-1-sinthu.raja@ti.com/T/
V3: https://lore.kernel.org/linux-arm-kernel/20230316114102.3602-2-sinthu.raja@ti.com/T/

Sinthu Raja (3):
  arm64: dts: ti: k3-j721s2: fix main pinmux range
  arm64: dts: ti: k3-j721s2: fix wkup pinmux range
  arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 134 ++++++++++++++----
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  92 ++++++------
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  11 +-
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  29 +++-
 4 files changed, 195 insertions(+), 71 deletions(-)

-- 
2.36.1

