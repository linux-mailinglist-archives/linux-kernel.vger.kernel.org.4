Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B583A6C24F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCTWww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCTWwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:52:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5DB2FCCC;
        Mon, 20 Mar 2023 15:52:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KMqgHg022739;
        Mon, 20 Mar 2023 17:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679352762;
        bh=Wrl+pdsJ7Yy8iawkVu9UhlYUAMXjyKrDWM6jikSpajY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iOu7k7sWpWlqQSE/uL8oofFsTHcLh/WYGXAdlwwv75JO4lEOes6bRkKt9IQHnOOqH
         31F0ttLmMRlY9YBB4bwdN/y70uiuPPR3rbn3MOmfW+A2FV984gfrkBwW4ysfgjkKEN
         s/sRRItADT0MB9MMnEaRCNBHoFjmJAy+9JcM01VA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KMqgBI042584
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 17:52:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 17:52:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 17:52:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KMqgDm016833;
        Mon, 20 Mar 2023 17:52:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <a-nandan@ti.com>, <hnagalla@ti.com>, <vaishnav.a@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH v2 0/2] Add Crypto Support for J784S4 SoC
Date:   Mon, 20 Mar 2023 17:52:41 -0500
Message-ID: <167935272979.212397.5705926679911778715.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230314152611.140969-1-j-choudhary@ti.com>
References: <20230314152611.140969-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh Choudhary,

On Tue, 14 Mar 2023 20:56:09 +0530, Jayesh Choudhary wrote:
> This series adds the crypto node for sa2ul for j784s4 platform.
> 
> First patch adds the device-id for NAVSS without which the probe
> for dma-controller fails due to 'ti,sci-dev-id' read failure.
> Second patch adds the crypto node.
> 
> This series has functional dependency on j784s4 k3_soc_id[1] and
> PSIL-thread support[2] but it does not affect the boot.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
This takes care of the missing patch for actually enabling crypto.

Thank you!

[2/2] arm64: dts: ti: k3-j784s4-main: Enable crypto accelerator
      commit: a43f0ac3851833302174567dadd60f58e24d0f30

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

