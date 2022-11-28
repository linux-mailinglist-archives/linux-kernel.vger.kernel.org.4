Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4848163B3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiK1VLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiK1VLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:11:31 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A883C21E09;
        Mon, 28 Nov 2022 13:11:28 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ozlPL-00089m-Gj; Mon, 28 Nov 2022 22:11:19 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Samuel Holland <samuel@sholland.org>, palmer@dabbelt.com,
        Conor Dooley <conor@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v2 12/12] riscv: defconfig: Enable the Allwinner D1 platform and drivers
Date:   Mon, 28 Nov 2022 22:11:18 +0100
Message-ID: <11740765.nUPlyArG6x@diego>
In-Reply-To: <Y4JBa52o4Yemv/uj@spud>
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-13-samuel@sholland.org> <Y4JBa52o4Yemv/uj@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 26. November 2022, 17:40:11 CET schrieb Conor Dooley:
> On Fri, Nov 25, 2022 at 05:46:56PM -0600, Samuel Holland wrote:
> > Now that several D1-based boards are supported, enable the platform in
> > our defconfig. Build in the drivers which are necessary to boot, such as
> > the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
> > and watchdog (which may be left enabled by the bootloader).
> 
> All of that looks good.
> 
> > Other common
> > onboard peripherals are enabled as modules.
> 
> This I am not sure about though. I'll leave that to Palmer since I'm
> pretty sure it was him that said it, but I thought the plan was only
> turning on stuff required to boot to a console & things that are
> generally useful rather than enabling modules for everyone's "random"
> drivers. Palmer?

Isn't the defconfig meant as a starting point to get working systems
with minimal config effort? At least that was always the way to go on arm
so far :-) .

So having boot-required drivers built-in with the rest enabled as modules
for supported boards will allow people to boot theirs without headaches.

Disabling unneeded drivers if you're starved for storage space in a special
project is always easier than hunting down all the drivers to enable for a
specific board. 


Heiko


> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> > (no changes since v1)
> > 
> >  arch/riscv/configs/defconfig | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index 05fd5fcf24f9..8dfe0550c0e6 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -25,6 +25,7 @@ CONFIG_BLK_DEV_INITRD=y
> >  CONFIG_EXPERT=y
> >  # CONFIG_SYSFS_SYSCALL is not set
> >  CONFIG_PROFILING=y
> > +CONFIG_ARCH_SUNXI=y
> >  CONFIG_SOC_MICROCHIP_POLARFIRE=y
> >  CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_STARFIVE=y
> > @@ -118,22 +119,31 @@ CONFIG_VIRTIO_NET=y
> >  CONFIG_MACB=y
> >  CONFIG_E1000E=y
> >  CONFIG_R8169=y
> > +CONFIG_STMMAC_ETH=m
> >  CONFIG_MICROSEMI_PHY=y
> >  CONFIG_INPUT_MOUSEDEV=y
> > +CONFIG_KEYBOARD_SUN4I_LRADC=m
> >  CONFIG_SERIAL_8250=y
> >  CONFIG_SERIAL_8250_CONSOLE=y
> > +CONFIG_SERIAL_8250_DW=y
> >  CONFIG_SERIAL_OF_PLATFORM=y
> >  CONFIG_VIRTIO_CONSOLE=y
> >  CONFIG_HW_RANDOM=y
> >  CONFIG_HW_RANDOM_VIRTIO=y
> > +CONFIG_I2C_MV64XXX=m
> >  CONFIG_SPI=y
> >  CONFIG_SPI_SIFIVE=y
> > +CONFIG_SPI_SUN6I=y
> >  # CONFIG_PTP_1588_CLOCK is not set
> > -CONFIG_GPIOLIB=y
> >  CONFIG_GPIO_SIFIVE=y
> > +CONFIG_WATCHDOG=y
> > +CONFIG_SUNXI_WATCHDOG=y
> > +CONFIG_REGULATOR=y
> > +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> >  CONFIG_DRM=m
> >  CONFIG_DRM_RADEON=m
> >  CONFIG_DRM_NOUVEAU=m
> > +CONFIG_DRM_SUN4I=m
> >  CONFIG_DRM_VIRTIO_GPU=m
> >  CONFIG_FB=y
> >  CONFIG_FRAMEBUFFER_CONSOLE=y
> > @@ -146,19 +156,30 @@ CONFIG_USB_OHCI_HCD=y
> >  CONFIG_USB_OHCI_HCD_PLATFORM=y
> >  CONFIG_USB_STORAGE=y
> >  CONFIG_USB_UAS=y
> > +CONFIG_USB_MUSB_HDRC=m
> > +CONFIG_USB_MUSB_SUNXI=m
> > +CONFIG_NOP_USB_XCEIV=m
> >  CONFIG_MMC=y
> >  CONFIG_MMC_SDHCI=y
> >  CONFIG_MMC_SDHCI_PLTFM=y
> >  CONFIG_MMC_SDHCI_CADENCE=y
> >  CONFIG_MMC_SPI=y
> > +CONFIG_MMC_SUNXI=y
> >  CONFIG_RTC_CLASS=y
> > +CONFIG_RTC_DRV_SUN6I=y
> > +CONFIG_DMADEVICES=y
> > +CONFIG_DMA_SUN6I=m
> >  CONFIG_VIRTIO_PCI=y
> >  CONFIG_VIRTIO_BALLOON=y
> >  CONFIG_VIRTIO_INPUT=y
> >  CONFIG_VIRTIO_MMIO=y
> > +CONFIG_SUN8I_DE2_CCU=m
> > +CONFIG_SUN50I_IOMMU=y
> >  CONFIG_RPMSG_CHAR=y
> >  CONFIG_RPMSG_CTRL=y
> >  CONFIG_RPMSG_VIRTIO=y
> > +CONFIG_PHY_SUN4I_USB=m
> > +CONFIG_NVMEM_SUNXI_SID=y
> >  CONFIG_EXT4_FS=y
> >  CONFIG_EXT4_FS_POSIX_ACL=y
> >  CONFIG_EXT4_FS_SECURITY=y
> 




