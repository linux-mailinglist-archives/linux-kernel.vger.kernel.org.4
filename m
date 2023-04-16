Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEBB6E362F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjDPIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDPIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B42189;
        Sun, 16 Apr 2023 01:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E396190E;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6F24C433EF;
        Sun, 16 Apr 2023 08:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681634829;
        bh=0sQ5Iq98n+mxaGb0YStWQ/VUWUYAE/Xrg0I1JcaVCyQ=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=Be643/NlwMCcf0G7LGBggv05xxxXKL8rk1b5wiKp0Ae/+iM1k9Lesf2W7VwRcfij/
         P5EpJ84ej+4RztSxrps/04E1sxhjEiCH22KW6n1ZJJrqphoJ+bZ1GPlWe9Hokb0enR
         cUn7ZlhIoYOnGcwykkdFp9cTj2ndvXnFMHHUaT1wwZxogWV2KcvAowdiKFzquiy41U
         pnBo3JZut78OB0rdBIvCEYckioXP87AWm4jMs+nH/m5SZmq81pZd0FfIpTe/Nn3xpL
         uj5/BnsOdMn+4s9i6RRxnHoI42HHC0QqAeKUDTz53G2HoeCUnsFBJEckTpUWgLOrzE
         9U2xGZa26sahA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC9C7619A;
        Sun, 16 Apr 2023 08:47:08 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC v3 0/4] mmc: add support for the dw-mmc controller on
 Hi3798MV200
Date:   Sun, 16 Apr 2023 16:45:58 +0800
Message-Id: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMa1O2QC/4WNywrCMBREf6VkbSSPvuJKEPwAt+Iij1sbNI0kN
 Sil/27anQtxOTPMOROKECxEtCsmFCDZaP2QA98USPdyuAK2JmfECOOkpBV2TuPe8ka0LjFCsAZ
 agVCibusa5ZeSEbAKctD98nMyjhCW4RGgs69VdUan4wFdctnbOPrwXvWJrtNPU6KYYKMqJagRX
 Jhy75/j3fvbVnu30hL7Q2CZQA1ryk6ohhr5TZjn+QP8PXQEEAEAAA==
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681634825; l=1631;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=0sQ5Iq98n+mxaGb0YStWQ/VUWUYAE/Xrg0I1JcaVCyQ=;
 b=D55txwwxgeSrlPeGPvuNAqQRqhPAvGXoXwO2884t6hXV9ekgguYY9R1Eb3Z2X3421vZTh4G2J
 sCjWowK4MqyDtLJAC+KpJ/GW3rDPEdGwMzxy+L3x+22tXnTQqKH8lQD
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dw-mmc controller found on Hi3798MV200 is like the one found on
Hi3798CV200, but has some tweaks.
Also refreshed the dt binding and converted it to YAML.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v3:
- split dt-binding commit into 2 parts, one for renaming, the other for
  new compatible string.
- some other fixes to dt-binding document.
- Link to v2: https://lore.kernel.org/r/20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com

Changes in v2:
- add DDR52 support
- edit dt-binding, substitude all hi3798cv200 with histb
- send email to more people
- Link to v1: https://lore.kernel.org/r/20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com

---
Yang Xiwen (4):
      mmc: dw_mmc: hi3798cv200: rename to dw_mmc-histb
      mmc: dw_mmc: histb: add support for hi3798mv200
      dt-binding: mmc: hi3798cv200-dw-mshc: convert to YAML and rename to histb-dw-mshc
      dt-binding: mmc: histb-dw-mshc: Add Hi3798MV200 compatible string

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ---
 .../devicetree/bindings/mmc/histb-dw-mshc.yaml     |  85 ++++++
 drivers/mmc/host/Kconfig                           |   8 +-
 drivers/mmc/host/Makefile                          |   2 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              | 206 -------------
 drivers/mmc/host/dw_mmc-histb.c                    | 339 +++++++++++++++++++++
 6 files changed, 429 insertions(+), 251 deletions(-)
---
base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
change-id: 20230415-mmc-hi3798mv200-ce15e9b96866

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

