Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58885BD4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiISSWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiISSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:22:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B643E4F;
        Mon, 19 Sep 2022 11:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAA08B81FBD;
        Mon, 19 Sep 2022 18:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F320C433D6;
        Mon, 19 Sep 2022 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663611752;
        bh=U1+SDYKggiG8jAFpjC++cQPT78CN9my3T9nFCzeYXmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRx9/KWPJhJxfSFZGsoHudD/h0kFRSOHLcAzPSeVZBatKL03gAH8vD3cygOGjuKhi
         DceFV4xj40t6W/BGkvlhUeZ7rYZjMujKhu2c7UGdcBcgzU8E8ci1uMbieHbdeTGVlf
         +vHuvXECmcBx2cLITyhFpK7r7A6PUnmEUHzfdVG3aL95UHNHDG4VBgklunZ/BedAj3
         My4dZCKPSkWn+KfMs8U2Q8/PDMY5lSC1fYw0/ymn9wOlRw2sflBA9szU4kHlkpuAkE
         okeNojUoaSFvuJw0QSfTj9EHpRz5+X5/JpIo66uHfXXTRy6L8dtvw3IOAGPJUYKHBA
         yTBnz+4L31ukQ==
Date:   Mon, 19 Sep 2022 19:22:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] New PolarFire SoC devkit devicetrees & 22.09
 reference design updates
Message-ID: <YyizYqHFG3vKrKFU@spud>
References: <20220916112645.567794-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916112645.567794-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:26:36PM +0100, Conor Dooley wrote:
> Hey all,
> 
> Some 6.1 targeted changes here.
> Firstly, two new dev kits (one first-party & one from Aries Embedded).
> They've been sitting in our vendor tree, so are being sent where they
> belong.
> 
> Secondly, another release of our reference design for the Icicle kit
> is due in September. Usually these do not really change much for the
> devicetree, but this time around a pair of changes impact the memory
> map.
> 
> The first of these is adding dma-ranges to the pcie controller. The
> controller had some issues to begin with & with the current reference
> design (v2022.05) would not work with mainline Linux nor has it since
> reference design v2021.08. A combination of the property, a change
> to the FPGA design & a small fix to the driver will get it working
> with mainline again. The other non-backwards compatible change to the
> reference design is moves of the peripherals instantiated in the
> fabric. Currently they are fairly spread out & a common complaint has
> been that this leaves little room in the fic3 section of the memory map
> for custom peripherals without removing the existing ones.
> 
> This series depends on [0] so as not to add dtbs_check warnings. The
> fabric clock support is added by [1].

I've pushed this series to dt-for-next:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=dt-for-next

There's a minor conflict with dt-fixes as that branch deletes a property
from the pcie dt node which is moved in this series. I deleted the
property as I moved it in this series so the fix will be to take the
version in dt-for-next instead.

> 
> Thanks,
> Conor.
> 
> Changes since v4:
> - fix the incompatible interrupts on m100pfsevp
> 
> Changes since v3:
> - add an extra patch reducing the fic3 clock rate
> 
> Changes since v2:
> - drop the sd & emmc versions of the aries devicetree
> - remove a extra newline
> 
> Changes since v1:
> - made the polarberry part of an enum in patch 1
> 
> 0 - https://lore.kernel.org/linux-gpio/20220825143522.3102546-1-conor.dooley@microchip.com/
> 1 - https://lore.kernel.org/linux-clk/20220824093342.187844-1-conor.dooley@microchip.com/
> 
> Conor Dooley (8):
>   dt-bindings: riscv: microchip: document icicle reference design
>   dt-bindings: riscv: microchip: document the aries m100pfsevp
>   riscv: dts: microchip: add pci dma ranges for the icicle kit
>   riscv: dts: microchip: move the mpfs' pci node to -fabric.dtsi
>   riscv: dts: microchip: icicle: update pci address properties
>   riscv: dts: microchip: icicle: re-jig fabric peripheral addresses
>   riscv: dts: microchip: reduce the fic3 clock rate
>   riscv: dts: microchip: add a devicetree for aries' m100pfsevp
> 
> Shravan Chippa (1):
>   dt-bindings: riscv: microchip: document the sev kit
> 
> Vattipalli Praveen (1):
>   riscv: dts: microchip: add sevkit device tree
> 
>  .../devicetree/bindings/riscv/microchip.yaml  |  20 +-
>  arch/riscv/boot/dts/microchip/Makefile        |   2 +
>  .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  44 ++++-
>  .../boot/dts/microchip/mpfs-icicle-kit.dts    |   3 +-
>  .../dts/microchip/mpfs-m100pfs-fabric.dtsi    |  45 +++++
>  .../boot/dts/microchip/mpfs-m100pfsevp.dts    | 179 ++++++++++++++++++
>  .../dts/microchip/mpfs-polarberry-fabric.dtsi |  29 +++
>  .../dts/microchip/mpfs-sev-kit-fabric.dtsi    |  45 +++++
>  .../riscv/boot/dts/microchip/mpfs-sev-kit.dts | 145 ++++++++++++++
>  arch/riscv/boot/dts/microchip/mpfs.dtsi       |  29 ---
>  10 files changed, 499 insertions(+), 42 deletions(-)
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts
> 
> -- 
> 2.36.1
> 
