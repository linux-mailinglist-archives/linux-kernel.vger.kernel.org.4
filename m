Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D95639549
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKZKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKZKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:24:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE525284;
        Sat, 26 Nov 2022 02:24:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10DAAB80937;
        Sat, 26 Nov 2022 10:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4A0C433C1;
        Sat, 26 Nov 2022 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669458247;
        bh=AkDR3oNI7rYW8PrF+zx6xgX1DzCDcfyJR4GUZe9yXrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boT6wd1t0uPTV/gqYWlt7gAI1wyVyxWPb4Xjm9HaGtz3ppPMB1rjF7q7zROBgxTAA
         BsDWfN8JEhg91m20UDlHrC0SB+/uI1tjY6yn9pcQVo4e0yrBMoF7vd+AsAYiXy7iq9
         pYIi/onxuWKLWTAYnc+BHfP4srYj+KvBVwYHdaSp6aWUEOd9X09059kWqZUQtVI+3L
         oUmFh95ksY+8zGOsH5+3PERqUVLriAkSi9rXNyq6F4WDDiWuwQ5W6FLy/qzKFlsXnl
         6dAXRdAGw6C71T26zlJARniNJ0JPlnJt9WHfDYJ7x919G+Fg+yc2cqkye5DuOZj68n
         ybnbR8G40f8jw==
Date:   Sat, 26 Nov 2022 10:24:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: Re: [PATCH v2 00/12] riscv: Allwinner D1/D1s platform support
Message-ID: <Y4HpQCw74uuVWjSE@spud>
References: <20221125234656.47306-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125234656.47306-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Samuel,

On Fri, Nov 25, 2022 at 05:46:44PM -0600, Samuel Holland wrote:
> This series adds the Kconfig/defconfig plumbing and devicetrees for a
> range of Allwinner D1 and D1s-based boards. Many features are already
> enabled, including USB, Ethernet, and WiFi.
> 
> The devicetrees use bindings from the following series which have not
> yet been merged:
>  - In-package LDO regulators:
>    https://lore.kernel.org/lkml/20221125040112.18160-1-samuel@sholland.org/
>  - Ethernet MAC binding fixes (not a new issue with D1):
>    https://lore.kernel.org/lkml/20221125202008.64595-1-samuel@sholland.org/
>  - RTL8723DS Bluetooth (has driver support, missing documentation):
>    https://lore.kernel.org/lkml/20221125040956.18648-1-samuel@sholland.org/
>  - TI ADC101C ADC (has driver support, missing documentation):
>    https://lore.kernel.org/lkml/20221125220903.8632-1-samuel@sholland.org/
> 
> $ make ARCH=riscv CROSS_COMPILE=riscv64-linux-musl- dtbs_check
>   SYNC    include/config/auto.conf.cmd
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dtb

Ran this last night, so before I go mess with your timer stuff & forget
there were a good few warnings about surplus-to-requirements address &
size cells. Other than that,

sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sun20i-d1-lichee-rv-86-panel.dtsi:24.32-36.5: Warning (unit_address_vs_reg): /dmic-sound/simple-audio-card,dai-link@0: node has a unit name, but no reg or ranges property
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sun20i-d1-lichee-rv-86-panel.dtsi:18.13-37.4: Warning (avoid_unnecessary_addr_size): /dmic-sound: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sun20i-d1-lichee-rv-dock.dts:30.32-42.5: Warning (unit_address_vs_reg): /dmic-sound/simple-audio-card,dai-link@0: node has a unit name, but no reg or ranges property
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sun20i-d1-lichee-rv-dock.dts:24.13-43.4: Warning (avoid_unnecessary_addr_size): /dmic-sound: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sun20i-d1-lichee-rv-86-panel.dtsi:24.32-36.5: Warning (unit_address_vs_reg): /dmic-sound/simple-audio-card,dai-link@0: node has a unit name, but no reg or ranges property
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sun20i-d1-lichee-rv-86-panel.dtsi:18.13-37.4: Warning (avoid_unnecessary_addr_size): /dmic-sound: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sunxi-d1s-t113.dtsi:616.20-636.5: Warning (avoid_unnecessary_addr_size): /soc/dsi@5450000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
sunxi-d1s-t113.dtsi:666.32-675.7: Warning (graph_child_address): /soc/tcon-top@5460000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary

> The only remaining DT validation issue is that gpio-fan is missing a
> YAML conversion, although one is on the list here:
> https://lore.kernel.org/lkml/20220126200350.3633576-1-clabbe@baylibre.com/
> arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb:0:0: /fan: failed to match any schema with compatible: ['gpio-fan']

Documentation/devicetree/bindings/hwmon/gpio-fan.yaml

I actually didn't see this error on next-20221122 :)

