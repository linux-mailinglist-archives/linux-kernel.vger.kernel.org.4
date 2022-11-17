Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17562D3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiKQHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKQHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:10:41 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37367139;
        Wed, 16 Nov 2022 23:10:39 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7AORO029362;
        Thu, 17 Nov 2022 01:10:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668669024;
        bh=thJsfgmBOHiiOmA9qjTuo4exVUbI9Olc6EK7VDMm2Is=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tX7ks31ITJXHe9B03V/4e7ImTvBQEjq0BBZkLytchf0r1T9N/4Hasi0/EWVGzNJjY
         LpBYuOeS5/Bj/CodvClT54pD2vnksWxBy4Wo1y+sN0nTfipF1r7SnkGxMHOIOeTNOc
         L7KagmRcXHYGnbXuy0iPBHbh7KQaB9YS8YUp9Voo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AH7AOg4004204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Nov 2022 01:10:24 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 17
 Nov 2022 01:10:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 17 Nov 2022 01:10:24 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7AOCv024012;
        Thu, 17 Nov 2022 01:10:24 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <j-keerthy@ti.com>, <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Fix the interrupt ranges property for main & wkup gpio intr
Date:   Thu, 17 Nov 2022 01:10:23 -0600
Message-ID: <166866872369.15713.12373959686741918117.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922072950.9157-1-j-keerthy@ti.com>
References: <20220922072950.9157-1-j-keerthy@ti.com>
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

Hi Keerthy,

On Thu, 22 Sep 2022 12:59:50 +0530, Keerthy wrote:
> The parent's input irq number is wrongly subtracted with 32 instead of
> using the exact numbers in:
> 
> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/interrupt_cfg.html
> 
> The GPIO interrupts are not working because of that. The toggling works
> fine but interrupts are not firing. Fix the parent's input irq that
> specifies the base for parent irq.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

I have fixed up the commit sha to 12 characters (please do run checkpatch and
usual checkers). I am choosing not to send this to 6.1 merge, since nothing
actively looks broken requiring urgent fixup atm.

[1/1] arm64: dts: ti: k3-j721s2: Fix the interrupt ranges property for main & wkup gpio intr
      commit: b8aa36c22da7d64c5a5d89ccb4a2abb9aeaab2e3

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

