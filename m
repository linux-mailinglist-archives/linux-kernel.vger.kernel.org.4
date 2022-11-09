Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2116222D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKIDuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKIDug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:50:36 -0500
X-Greylist: delayed 136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 19:50:18 PST
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net (p3plsmtpa12-04.prod.phx3.secureserver.net [68.178.252.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF2424978
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:50:18 -0800 (PST)
Received: from b1ack ([183.15.91.189])
        by :SMTPAUTH: with ESMTPSA
        id sc4BoeVsGvZSHsc4Eobf01; Tue, 08 Nov 2022 20:48:00 -0700
X-CMAE-Analysis: v=2.4 cv=KIScTnJo c=1 sm=1 tr=0 ts=636b22f1
 a=T8SDJmazftFS371Os7amgg==:117 a=T8SDJmazftFS371Os7amgg==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=8XuHljR6AAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=_twTT5zqAAAA:8 a=iEMgYgck2XEmVY7No8UA:9 a=QEXdDO2ut3YA:10
 a=zb2z3UklSVnEaoLbSHUe:22 a=AjGcO6oz07-iQ99wixmX:22 a=ILoXdGDbYT3DTB7Z0gVI:22
X-SECURESERVER-ACCT: dhu@hodcarrier.org
Date:   Wed, 9 Nov 2022 03:47:54 +0000
From:   Du Huanpeng <dhu@hodcarrier.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Sean Anderson <seanga2@gmail.com>, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yang Ling <gnaygnil@gmail.com>
Subject: Re: [RFT PATCH] clk: ls1c: Fix PLL rate calculation
Message-ID: <Y2si6jgQCW0ZKf+E@b1ack>
References: <20220419051114.1569291-1-seanga2@gmail.com>
 <CAJhJPsUM=LrgrKcoA8xT=4JWt8uxjn6yDxP9vjuZmvb4WvjPZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsUM=LrgrKcoA8xT=4JWt8uxjn6yDxP9vjuZmvb4WvjPZQ@mail.gmail.com>
X-CMAE-Envelope: MS4xfLGcmHTsJ9sx9GHRNSc9s0ZJVQ+gAsUMvfWLXibo+NUKZCcQNvz2TFw3Z0vQeFs43jPk+OoSNn+MSJ3vjGHX7Pskt3X23V6O1s7CXYMrgtUsgJll7VFQ
 ZMEhMlcE/v0PXrIC+ec1XTqf0ZTkKyo78dEJrSPYmwdZKp6Tu9dVkT7u+JJjDhdkXW730qCPvXr5gt6P1JKC9U3dFhY6TnrqztTp2TD73JzLjUjIM1EQ3A+l
 /VLl/nLD4thCWYKusIg8W+UgssMBukQtAFg1I1XNZnzijUM+daeKb8KtAsmI3kRMcFJKT13jgWxRYZIfLDHIj4zbx+LTywFOsoMnEZeWlPQx9U8UdigB8gas
 L3gsLiQ9TsjooU/ZX5/qfor09CA6E/aSDBnutREGCw1wl1VwS24=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:36:02AM +0800, Kelvin Cheung wrote:
Hi,
> Sean, Du,
> I saw you are discussing the PLL rate calculation issue.
> My question is whether the upstream kernel works on your ls1c300?
> For me, it never works, even the earliest version which LS1C support was merged.
> After the kernel is loaded by PMON, there is no console output at all.
> I also confirm this issue with Yang.
> BTW, my board is 1C300B.
> Are your board is different from me? Or your bootloader?
the upstream kernel works for my board(1C300B v3.42) with diferent config,
1. base on the loongson1c_defconfig
  $ make loongson1c_defconfig

2. change some options
  $ make menuconfig
disable:
	# CONFIG_RTC_DRV_LOONGSON1 is not set
enable:
	CONFIG_BLK_DEV_INITRD=y
	CONFIG_INITRAMFS_SOURCE="rootfs.cpio"
(or try this: https://github.com/hodcarrier/linux/blob/loongson-ls1c300b/arch/mips/configs/ls1c300_defconfig)

3. prepare rootfs.cpio and place it to
  $ cp rootfs.cpio linux/

4. load the kernel image by pmon from TFTP server
  PMON> set al "tftp://192.168.1.253/vmlinuz"
  PMON> set append "earlycon=uart,0x1fe48000,ttyS2,115200 console=ttyS2,115200 root=/dev/ram0 rw mem=128M init=linuxrc"

or try my homebrew buildroot:
  $ git clone https://github.com/hodcarrier/buildroot.git
  $ cd buildroot
  $ make loongson_ls1c300_defconfig
  $ make
  $ ls output/images/vmlinuz

load the vmlinuz image like above steps[4].

> 
> Thanks!
> 
> Sean Anderson <seanga2@gmail.com> 于2022年4月19日周二 13:11写道：
> >
> > While reviewing Dhu's patch adding ls1c300 clock support to U-Boot [1], I
> > noticed the following calculation, which is copied from
> > drivers/clk/loongson1/clk-loongson1c.c:
> >
> > ulong ls1c300_pll_get_rate(struct clk *clk)
> > {
> >         unsigned int mult;
> >         long long parent_rate;
> >         void *base;
> >         unsigned int val;
> >
> >         parent_rate = clk_get_parent_rate(clk);
> >         base = (void *)clk->data;
> >
> >         val = readl(base + START_FREQ);
> >         mult = FIELD_GET(FRAC_N, val) + FIELD_GET(M_PLL, val);
> >         return (mult * parent_rate) / 4;
> > }
> >
> > I would like to examine the use of M_PLL and FRAC_N to calculate the multiplier
> > for the PLL. The datasheet has the following to say:
> >
> > START_FREQ 位    缺省值      描述
> > ========== ===== =========== ====================================
> > FRAC_N     23:16 0           PLL 倍频系数的小数部分
> >
> >                  由          PLL 倍频系数的整数部分
> > M_PLL      15:8  NAND_D[3:0] (理论可以达到 255，建议不要超过 100)
> >                  配置
> >
> > which according to google translate means
> >
> > START_FREQ Bits  Default       Description
> > ========== ===== ============= ================================================
> > FRAC_N     23:16 0             Fractional part of the PLL multiplication factor
> >
> >                  Depends on    Integer part of PLL multiplication factor
> > M_PLL      15:8  NAND_D[3:0]   (Theoretically it can reach 255, [but] it is
> >                  configuration  recommended not to exceed 100)
> >
> > So just based on this description, I would expect that the formula to be
> > something like
> >
> >         rate = parent * (255 * M_PLL + FRAC_N) / 255 / 4
> >
> > However, the datasheet also gives the following formula:
> >
> >         rate = parent * (M_PLL + FRAC_N) / 4
> >
> > which is what the Linux driver has implemented. I find this very unusual.
> > First, the datasheet specifically says that these fields are the integer and
> > fractional parts of the multiplier. Second, I think such a construct does not
> > easily map to traditional PLL building blocks. Implementing this formula in
> > hardware would likely require an adder, just to then set the threshold of a
> > clock divider.
> >
> > I think it is much more likely that the first formula is correct. The author of
> > the datasheet may think of a multiplier of (say) 3.14 as
> >
> >         M_PLL = 3
> >         FRAC_N = 0.14
> >
> > which together sum to the correct multiplier, even though the actual value
> > stored in FRAC_N would be 36.
> >
> > I suspect that this has slipped by unnoticed because when FRAC_N is 0, there is
> > no difference in the formulae. The following patch is untested, but I suspect
> > it will fix this issue. I would appreciate if anyone with access to the
> > hardware could measure the output of the PLL (or one of its derived clocks) and
> > determine the correct formula.
> >
> > [1] https://lore.kernel.org/u-boot/20220418204519.19991-1-dhu@hodcarrier.org/T/#u
> >
> > Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
> > Signed-off-by: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> >  drivers/clk/loongson1/clk-loongson1c.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
> > index 703f87622cf5..2b98a116c1ea 100644
> > --- a/drivers/clk/loongson1/clk-loongson1c.c
> > +++ b/drivers/clk/loongson1/clk-loongson1c.c
> > @@ -21,9 +21,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
> >         u32 pll, rate;
> >
> >         pll = __raw_readl(LS1X_CLK_PLL_FREQ);
> > -       rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
> > +       rate = (pll & 0xff00) + ((pll >> 16) & 0xff);
> >         rate *= OSC;
> > -       rate >>= 2;
> > +       rate >>= 10;
> >
> >         return rate;
> >  }
> > --
> > 2.35.1
> >
> 
> 
> -- 
> Best regards,
> 
> Kelvin Cheung
