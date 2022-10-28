Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D86112D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJ1NcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJ1NcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:32:05 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2891C4938;
        Fri, 28 Oct 2022 06:32:03 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SDVvNB012813;
        Fri, 28 Oct 2022 08:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666963917;
        bh=tOgS5P5mWnRIUdlI9htAdpHl4sc42ZePAf+hlPCtk6A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lA6WRNq6e+ZS7dYvTROFMIxEZ9R2Zl9SB6BbGoN+Ug/xejlXQTZ9EkmDZuUnlIwkG
         Ne8/ZVgbjmAmLXBEosR6I8hsI5wyFi99mw5PRtFEQjCeZA6vfSXXIK1P/vSYTFUzHs
         zccm1a6Y5MRK6TGlQiTRBBuLUXJUjFi73skAssqI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SDVvG4032586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 08:31:57 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 08:31:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 08:31:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SDVvsB021017;
        Fri, 28 Oct 2022 08:31:57 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <afd@ti.com>, <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <bb@ti.com>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/12] TI J7x Disable Incomplete DT Nodes
Date:   Fri, 28 Oct 2022 08:31:56 -0500
Message-ID: <166696389197.13875.2738230115869646167.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020160305.18711-1-afd@ti.com>
References: <20221020160305.18711-1-afd@ti.com>
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

Hi Andrew Davis,

On Thu, 20 Oct 2022 11:02:53 -0500, Andrew Davis wrote:
> Same story as for AM64x[0] and AM62x[1], this time for J7x.
> 
> This one was a little more involved that the last 2 rounds as some IP
> (like UART) are pinned out using the default pinmux. Perhaps we should be
> explicit here and have pinmux nodes that simply restate the defaults. I
> can go solve that in a follow up series if we think that is what we
> want to do.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/12] arm64: dts: ti: k3-j721e: Enable UART nodes at the board level
        commit: fe17e20fde14c6cbaf1cae97aef370b6f4c73518
[02/12] arm64: dts: ti: k3-j721e: Enable I2C nodes at the board level
        commit: 282c4ad3b8c1da99095e0edbbe617cdf4dcb138b
[03/12] arm64: dts: ti: k3-j721e: Enable MCASP nodes at the board level
        commit: 256596ad158c80c8e4104a6310a411ec8829f9eb
[04/12] arm64: dts: ti: k3-j721e: Enable MCAN nodes at the board level
        commit: 39e7758b94e31071a87489364c723afe92849ae7
[05/12] arm64: dts: ti: k3-j7200: Enable UART nodes at the board level
        commit: dae322f8a7ef11a06bfb61bada4ebbcac219783e
[06/12] arm64: dts: ti: k3-j7200: Enable I2C nodes at the board level
        commit: a9ed915cd55c883fed72e50b45988fa4305496a7
[07/12] arm64: dts: ti: k3-j721s2: Enable UART nodes at the board level
        commit: 0e63f35a9c6acf1d74bd693c492f8955bb16c89a
[08/12] arm64: dts: ti: k3-j721e: Enable Mailbox nodes at the board level
        commit: 7e48b665100ee84bdaa163dece6d40351077f664
[09/12] arm64: dts: ti: k3-j7200: Enable Mailbox nodes at the board level
        commit: 74f0f58d3122c3e2cc313dd6311b9742dbfd54e0
[10/12] arm64: dts: ti: k3-j721s2: Enable Mailbox nodes at the board level
        commit: 3fb0402f65959edc9a14842dc36828d2c7109ae2
[11/12] arm64: dts: ti: k3-j721s2: Enable MCAN nodes at the board level
        commit: 06639b8ae0e9be0cf0195209e6b69f4e254687b0
[12/12] arm64: dts: ti: k3-j721s2: Enable I2C nodes at the board level
        commit: 0aef5131380628e2a9bfcbbcfed5d6477c8f9651

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

