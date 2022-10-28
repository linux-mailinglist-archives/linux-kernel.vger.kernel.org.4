Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D826112B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiJ1N2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJ1N2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:28:19 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA41D0D44;
        Fri, 28 Oct 2022 06:28:17 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SDSAHr100896;
        Fri, 28 Oct 2022 08:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666963690;
        bh=QkyP5J7SVUTHUOruF7vqp7qNnqtW8fIEOgyIzFof/l8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pdezWEPsU/cRe7bfq5wAblHepMLPgUTrF4V32xg/+Sc//JKxgQdlDTUe24m/RrT/R
         9g+8XbbJTko36BVSYUjB0BdvLHOkUeV46dVXXLA4LCvsuTOSI/RReDoyubLRTaGJgN
         NmrMB479EekigZ5zKrEqkEX4HKFIFANn7FEJyC3I=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SDSAei041589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 08:28:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 08:28:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 08:28:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SDS957087239;
        Fri, 28 Oct 2022 08:28:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>, <kristo@kernel.org>,
        <christophe.jaillet@wanadoo.fr>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] firmware: ti_sci: Use the bitmap API to allocate bitmaps
Date:   Fri, 28 Oct 2022 08:28:08 -0500
Message-ID: <166696365259.11507.9089493958831154682.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <3ee11e9e83f7c1552d237f5c28f554319fcbbf1f.1657308216.git.christophe.jaillet@wanadoo.fr>
References: <3ee11e9e83f7c1552d237f5c28f554319fcbbf1f.1657308216.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe JAILLET,

On Fri, 8 Jul 2022 21:23:46 +0200, Christophe JAILLET wrote:
> Use devm_bitmap_zalloc() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/2] firmware: ti_sci: Use the bitmap API to allocate bitmaps
      commit: 2f9b0402755c1320420825ea8cda27a5f18e0ac4
[2/2] firmware: ti_sci: Use the non-atomic bitmap API when applicable
      commit: 4dc3883203736dcd979672ac8d9f086dbd4d2140

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

