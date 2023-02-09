Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED10690F08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjBIRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBIRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:18:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269A233D2;
        Thu,  9 Feb 2023 09:18:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1A2B61B5D;
        Thu,  9 Feb 2023 17:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA07BC433D2;
        Thu,  9 Feb 2023 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675963088;
        bh=wmXQ0cTE7lPdPdDXXpxXBNSjk97SwRGAiaX+nio/rtM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kp5GV/qLeQ/MCfebtu6BojPHHn3QFgCnTyK0YMJgdR9L1YJLOyU+sOEuxNqLmuVew
         C+htEVYOCpoUAPHy4n5+Qjv5aj6lhfi2GI9EEPQ4Uo4SSTcOSmhSu9D/w3oC788uv8
         xPnb1KygkUZUbRhErxxjRjupIlO3qIdQjXYazONE4lMIfGLT5V3j0dsvMDYHFMqTGn
         T1lcuW6QpxqoemoyTdg0+ZiFQSoRPRASqK9wMtqXj5BP/Eo0+z2q0CSVI2QxnBKViE
         N0EATTvw6qFQqw2lTdqdGv+2HhvBJMONS4q73KqrdQzS9zgtXQQM2uOxQ/yPr1xlWi
         awguzBVch5C/A==
From:   Mark Brown <broonie@kernel.org>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230207065826.285013-1-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
Subject: Re: [PATCH v3 00/15] spi: bcm63xx-hsspi: driver and doc updates
Message-Id: <167596308461.673456.2324521897149973878.b4-ty@kernel.org>
Date:   Thu, 09 Feb 2023 17:18:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 22:58:11 -0800, William Zhang wrote:
> This patch series include the accumulative updates and fixes for the
> driver from Broadcom. It also added a new driver for the updated SPI
> controller found in the new BCMBCA SoC. The device tree document is
> converted to yaml format and updated accordingly.
> 
> Changes in v3:
> - Clean up spi-controller.yaml and update the example
> - Drop the generic compatible string brcm,bcmbca-hsspi from the document
>   and dts files
> - Port the cs_change and cs_off logic from SPI core
>   spi_transfer_one_message function to both controller drivers.
> - Factor dummy cs workaround into a function, adjust the logic for
>   different xfer modes and fine tune message level in bcm63xx-hsspi
>   controller driver
> - Replace hard-coded opcode with SPINOR_OP definition
> - Add a new patch to export export spi_transfer_cs_change_delay_exec
>   function in the spi core
> - Add a new patch to include compatible string brcm,bcmbca-hsspi-v1.0 in
>   bcm63xx-hsspi controller driver
> - Minor coding style fix in bcmbca-hsspi controller driver
> - Add Acked-by and Reviewed-by tag
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/15] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
        commit: fff948a44b44a628c81294af5498226cb66a2594
[02/15] dt-bindings: spi: Add bcmbca-hsspi controller support
        commit: 0ba979f995324417fd773881bc5a39910a9f2362
[03/15] ARM: dts: broadcom: bcmbca: Add spi controller node
        (no commit info)
[04/15] arm64: dts: broadcom: bcmbca: Add spi controller node
        (no commit info)
[05/15] spi: bcm63xx-hsspi: Add new compatible string support
        commit: 99d7428ac94bf67d6e9df81dd3b4bf3046196ad6
[06/15] spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
        commit: 85a84a61699990db6a025b5073f337f49933a875
[07/15] spi: bcm63xx-hsspi: Add polling mode support
        commit: 50a6620dd1fbc810476422a965b041f1839f8eac
[08/15] spi: export spi_transfer_cs_change_delay_exec function
        (no commit info)
[09/15] spi: bcm63xx-hsspi: Handle cs_change correctly
        (no commit info)
[10/15] spi: bcm63xx-hsspi: Fix multi-bit mode setting
        (no commit info)
[11/15] spi: bcm63xx-hsspi: Add prepend mode support
        (no commit info)
[12/15] spi: spi-mem: Allow controller supporting mem_ops without exec_op
        (no commit info)
[13/15] spi: bcm63xx-hsspi: Disable spi mem dual io read op support
        (no commit info)
[14/15] spi: bcmbca-hsspi: Add driver for newer HSSPI controller
        (no commit info)
[15/15] MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers
        (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

