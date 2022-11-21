Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339B9632F63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKUV4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKUV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:56:08 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D80E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:56:04 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ALLtucq112493;
        Mon, 21 Nov 2022 15:55:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669067756;
        bh=WyQj+iN9ttJzj4bWmIVrFKKv38JzekYtV15q96B7ADw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qGOurVoFOV6oI8ZdSw2K11Uf2NmP4Gb/8QwXWblJYw5V234MdRkoF4Glf9Nc3Q5Dn
         PCXx4057ylRXwrL2vEj/fDN2fB63OEVAjnosEyss30oFAsB6SCtoCasYvhE6Gcl5Os
         IToYsz5qLRhMBzOXmjgFVljSpBaC5gbDMt26qYyQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ALLtuub112303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 15:55:56 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 21
 Nov 2022 15:55:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 21 Nov 2022 15:55:56 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ALLtu4w097550;
        Mon, 21 Nov 2022 15:55:56 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nfrayer@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <glaroque@baylibre.com>,
        <khilman@baylibre.com>
Subject: Re: [PATCH v6 0/2] soc: ti: k3-socinfo: Add module build support to the k3 socinfo driver
Date:   Mon, 21 Nov 2022 15:55:55 -0600
Message-ID: <166906774215.20855.4956750581421635106.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221117095419.171906-1-nfrayer@baylibre.com>
References: <20221117095419.171906-1-nfrayer@baylibre.com>
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

Hi Nicolas Frayer,

On Thu, 17 Nov 2022 10:54:17 +0100, Nicolas Frayer wrote:
> In order for the TI K3 SoC info driver to be built as a module, the
> following changes have been made:
> - Converted memory allocations to devm and added the remove callback
> - Added necessary code to build the driver as a module
> 
> v2->v3:
> dropped module conversion part of this series while other driver
> dependencies on socinfo are worked out.
> A dependency issue is introduced by changing subsys_initcall()
> to module_platform_driver(). Some drivers using the socinfo information
> probe before the socinfo driver itself and it makes their probe fail.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/2] soc: ti: k3-socinfo: Convert allocations to devm
      commit: 6ae5071b6a53844da27fddddf026c01eb4088c85
[2/2] soc: ti: k3-socinfo: Add module build support
      commit: 79480500de33a6a702f7188fc3ecd7164e897639

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

