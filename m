Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED926732F82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjFPLLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344143AbjFPLL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD671A3;
        Fri, 16 Jun 2023 04:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01CE560AB0;
        Fri, 16 Jun 2023 11:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BAFC433C0;
        Fri, 16 Jun 2023 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686913886;
        bh=GKTab9L2VWdXdRBZM/fEy5PbfOwIRgbSHgrdzlJCr9M=;
        h=From:Subject:Date:To:Cc:From;
        b=O4eqVxLn/H806pDJrVdHDxLHL4iDEw041a3vg/UMEXb5xz8KJvzNKw+h+3Ag7xy6D
         WXpg9mLuIPhHw26hOK6qIbOOJxboD8DCTlauxpk/iw4JfTn26G1wYVDP8rcBnTyz/J
         k8RJcVplot28eZgEpvo1u+4ib4zdHLd8WqELK+c6SAWSjdUdR/RdwDH+e5jrVgXnmb
         E1tTySH10GYrje8PbcQDZhkrYRbD61ES8YZElJadLcDux1fsh3T2YdYVdkwxQZKFxb
         QuQFE/RkJlUlTOpchMzFlCKopCRSvmcGYfe/z48kHVrM6Ff1TbV8ZwYZgnhwsu4+7l
         OhJwvXJETB6Eg==
From:   Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/2] arm64: sl28: fetch the ethernet addresses from its
 EEPROM
Date:   Fri, 16 Jun 2023 13:11:20 +0200
Message-Id: <20230616-feature-sl28-vpd-dt-v1-0-c5458016ba85@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFhDjGQC/x2N0QrCMAwAf2Xk2UBT2RR/RXxI19QVtI6kDmHs3
 +32eBzHrWCiWQxu3QoqS7b8KQ3o1ME4cXkK5tgYvPNnN9CASbh+VdBe/orLHDFWpAv3gZynmCK
 0MrAJBuUyTnv7Zquiu5hVUv4du/tj2/7zbVqnfgAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After years, NVMEM layouts finally made it into the kernel. The network
devices on the Kontron sl28 boards can now fetch their MAC addresses by
reading the onboard VPD EEPROM. Yay :)

First enable the layout driver (as a module) in the defconfig and then
add the dt fragments.

The second commit was already applied once in commit b203e6f1e833
("arm64: dts: ls1028a: sl28: get MAC addresses from VPD") but had to be
reverted in commit 916508c30e22 ("Revert "arm64: dts: ls1028a: sl28: get
MAC addresses from VPD") because the NVMEM layouts series was dropped.
NVMEM layouts will be included in v6.4, so we can now safely add the
device tree fragments for v6.5.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Michael Walle (2):
      arm64: defconfig: enable SL28VPD NVMEM layout
      arm64: dts: ls1028a: sl28: get MAC addresses from VPD

 .../dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts | 12 ++++++++++++
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts     |  2 ++
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts     |  8 ++++++++
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts     |  2 ++
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts     | 17 +++++++++++++++++
 arch/arm64/configs/defconfig                            |  1 +
 6 files changed, 42 insertions(+)
---
base-commit: f7efed9f38f886edb450041b82a6f15d663c98f8
change-id: 20230616-feature-sl28-vpd-dt-17a5b1021dfd

