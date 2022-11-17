Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7993D62D3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiKQHRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiKQHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:16:54 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23DE63B6;
        Wed, 16 Nov 2022 23:16:52 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7GkSn038211;
        Thu, 17 Nov 2022 01:16:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668669406;
        bh=5VM4aWOkz5+XO4tzIi2rU6c1IzyiTyCQi3xl++r7yzw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N2qwBp/kLsO2eeY72wb8YCAauiz2lljSEMeknjd2OqpGxXkmQ/e2HdHvdsUZmg7Mr
         OJUWtNL9TNUqtq7scRQcb932UgsSCBJAIKRz9BItO2GKLagCy+xER9iih4QPhyhp0X
         SxNyHgrnNlv9iolg2FjMyR+TKW0tDlV6j6hV5dBY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AH7GkO3057084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Nov 2022 01:16:46 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 17
 Nov 2022 01:16:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 17 Nov 2022 01:16:46 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7GkX9063673;
        Thu, 17 Nov 2022 01:16:46 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <j-choudhary@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <j-keerthy@ti.com>, <s-anna@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <afd@ti.com>, <kristo@kernel.org>
Subject: Re: [PATCH v2 0/3] RNG clock property cleanup
Date:   Thu, 17 Nov 2022 01:16:45 -0600
Message-ID: <166866922717.18115.2072838771228935448.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221107110607.59216-1-j-choudhary@ti.com>
References: <20221107110607.59216-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh Choudhary,

On Mon, 7 Nov 2022 16:36:04 +0530, Jayesh Choudhary wrote:
> This series removes the clock property from the rng node of
> K3 devices for TI SoCs as that clock is not dedicated to RNG
> module and it cannot be controlled by the rng driver.
> 
> DT binding fix:
> <https://lore.kernel.org/all/20220901171041.32056-1-afd@ti.com/>
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

Couple of minor things:
a) cover letter suggestion: for the usual arm64: dts: ti: ... convention - it
  is useful for folks who are'nt aware to understand which subsystem the series
  goes to..
b) Follow the stable-rules for using Fixes or not. I chose to drop it since it
   serves no functional purpose anyways (and I would'nt call a regression esp
   on a disabled node).

[1/3] arm64: dts: ti: k3-am65-main: drop RNG clock
      commit: cfc75a93d7256d65c7b463620e7c13bd8219707b
[2/3] arm64: dts: ti: k3-j721e-main: drop RNG clock
      commit: a315097a23eb1976e8eac397c02ada82618858bb
[3/3] arm64: dts: ti: k3-am64-main: drop RNG clock
      commit: c1e56c8250a234d9bcd9e2f060da229688dfd9eb

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

