Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A8E750B11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjGLObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjGLObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:31:09 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B01FCE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:31:03 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36CEUfoY100560;
        Wed, 12 Jul 2023 09:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689172241;
        bh=TiLqi4neIdvMeEx8Ey6rTDMm0EpgMumbzJlmjzZnhwg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=j4C3mfTmX8qUzHGtNgo/ymBZyr6iSoVYDcw/xkb/7dJ8mdrZboq4vYk4a/otIPQdj
         Lnkjr/O1P4wpi1eqCm7SA9/ps6gK8JlacJIdbpAxfiQtnr08icCw9fUqwZL7y1HBUQ
         c/XK+9XCsF1wLUYi1HLQG/+k/Z7piKMmCWaDJBT4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36CEUf9Z027673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 09:30:41 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jul 2023 09:30:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jul 2023 09:30:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36CEUeKD091182;
        Wed, 12 Jul 2023 09:30:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        Wadim Egorov <w.egorov@phytec.de>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH V2] firmware: ti_sci: Use system_state to determine polling
Date:   Wed, 12 Jul 2023 09:30:40 -0500
Message-ID: <168917222090.2072307.1618544954491297567.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230620130329.4120443-1-nm@ti.com>
References: <20230620130329.4120443-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Tue, 20 Jun 2023 08:03:29 -0500, Nishanth Menon wrote:
> Commit b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled
> mode during system suspend") aims to resolve issues with tisci
> operations during system suspend operation. However, the system may
> enter a no_irq stage in various other usage modes, including power-off
> and restart. To determine if polling mode is appropriate, use the
> system_state instead.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: Use system_state to determine polling
      commit: 9225bcdedf16297a346082e7d23b0e8434aa98ed

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

