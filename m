Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231387319FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbjFONad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245679AbjFONaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:30:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE0272D;
        Thu, 15 Jun 2023 06:30:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDUEo1014792;
        Thu, 15 Jun 2023 08:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686835814;
        bh=Aw5FsNFw9nqi8Vpg9HRWv8o5b1W6GIetxXxH+jN0qj0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NHubE+Fae8YJoDw3SfUT/lK5UGVEm2497YQLfdRi2tqLTf8itHxYMRPOLXrm0kQUH
         o5kR8Eo3w706iInPR9c/spocQBVEPJF2ko/tKL+KdFKDE/CXqsqmyTRnvG6FQKfz48
         83H81/b+UQGlNi622QdKXQ3fRPsqxCoN3jA9EsYI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDUEDZ008529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:30:14 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:30:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:30:13 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDUAGU023498;
        Thu, 15 Jun 2023 08:30:11 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Neha Malcom Francis <n-francis@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v6 0/3] Add support for ESM
Date:   Thu, 15 Jun 2023 19:00:08 +0530
Message-ID: <168681817159.2098323.16745476643883270591.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504080526.133149-1-n-francis@ti.com>
References: <20230504080526.133149-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neha Malcom Francis,

On Thu, 04 May 2023 13:35:23 +0530, Neha Malcom Francis wrote:
> ESM (Error Signaling Module) is a fundamental IP responsible for
> handling safety events. The driver currently present in U-Boot is
> responsible for configuring ESM. This patch series adds dt-binding and
> nodes for J721E and J7200. This goes towards end goal of having DTB sync
> with that of U-Boot as well as ensuring completeness of hardware
> description in devicetree.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: misc: esm: Add ESM support for TI K3 devices
      commit: 444f312a73f789bb9f10bbb423f7ae6c3aa76198
[2/3] arm64: dts: ti: k3-j721e: Add ESM support
      commit: 19bfd51845d551c6f4e39969c13c6b8285b94d1c
[3/3] arm64: dts: ti: k3-j7200: Add ESM support
      commit: e3d1f2768853f375b87a1c6fc00501165ddae49d

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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

