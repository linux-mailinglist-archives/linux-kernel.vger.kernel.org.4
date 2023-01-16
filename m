Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9766BDD2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjAPM3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAPM3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:29:31 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA91CF73
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:29:27 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:ca8:1fb3:6247:f214])
        by laurent.telenet-ops.be with bizsmtp
        id 9QVR290013ai2CG01QVRgJ; Mon, 16 Jan 2023 13:29:25 +0100
Received: from rox.of.borg ([192.168.97.57] helo=rox)
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pHOc4-005TQP-Ab
        for linux-kernel@vger.kernel.org;
        Mon, 16 Jan 2023 13:29:24 +0100
Received: from geert by rox with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pHOc8-000UNA-RA
        for linux-kernel@vger.kernel.org;
        Mon, 16 Jan 2023 13:29:24 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.2-rc4
Date:   Mon, 16 Jan 2023 13:29:24 +0100
Message-Id: <20230116122924.116745-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.2-rc4[1] compared to v6.1[2].

Summarized:
  - build errors: +7/-14
  - build warnings: +30/-9

JFYI, when comparing v6.2-rc4[1] to v6.2-rc3-8-g1fe4fd6f5cad346e[3], the summaries are:
  - build errors: +1/-5
  - build warnings: +21/-3

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5dc4c995db9eb45f6373a956eb1f69460e69e6d4/ (all 152 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e9176028d02ef86f3cf76aa2476/ (all 152 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1fe4fd6f5cad346e598593af36caeadc4f5d4fa9/ (all 152 configs)


*** ERRORS ***

7 error regressions:
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: error: the frame size of 2224 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 7082:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 7127:1
  + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]:  => 641:28
  + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]:  => 641:28
  + /kisskb/src/include/linux/bitfield.h: error: call to '__field_overflow' declared with attribute error: value doesn't fit into mask:  => 151:3
  + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]:  => 57:33
  + {standard input}: Error: unknown pseudo-op: `.cfi_def_c':  => 1718

14 error improvements:
  - /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]: 239:34 => 
  - /kisskb/src/arch/sparc/kernel/irq_32.c: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]: 259:14, 263:14, 258:14, 261:46, 262:14 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function): 149:37 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor': 149:22 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]: 150:1 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size': 88:22 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]: 89:1 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]: 100:2 => 
  - /kisskb/src/drivers/net/ethernet/marvell/prestera/prestera_flower.c: error: 'rule' is used uninitialized [-Werror=uninitialized]: 480:34 => 
  - {standard input}: Error: displacement to undefined symbol .L377 overflows 12-bit field: 2286 => 
  - {standard input}: Error: displacement to undefined symbol .L378 overflows 8-bit field : 2302 => 
  - {standard input}: Error: displacement to undefined symbol .L382 overflows 8-bit field : 2213 => 
  - {standard input}: Error: pcrel too far: 2274, 2221, 2232, 2293, 2217, 2206, 2216, 2249, 2231, 2209, 2262, 2204, 2215, 2259, 2247, 2248, 2261, 2229 => 
  - {standard input}: Error: unknown pseudo-op: `.l': 2305 => 


*** WARNINGS ***

30 warning regressions:
  + /kisskb/src/arch/s390/kernel/setup.c: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]:  => 526:9
  + modpost: WARNING: modpost: "__ashldi3" [drivers/block/drbd/drbd.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/bus/mhi/host/mhi_pci_generic.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/extcon/extcon-fsa9480.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/md/dm-zoned.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/media/cec/core/cec.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/media/usb/hdpvr/hdpvr.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/misc/habanalabs/habanalabs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/wireless/ath/wil6210/wil6210.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-sifive.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/scsi/hptiop.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/block/drbd/drbd.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ndelay" [drivers/gpio/gpio-latch.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/iio/adc/max11410.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/input/keyboard/tegra-kbc.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/mmc/host/sunplus-mmc.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/renesas/rswitch_drv.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt7996/mt7996e.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtw89/rtw89_8852b.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/phy/renesas/r8a779f0-ether-serdes.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ptp/ptp_idt82p33.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/usb/fotg210/fotg210.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [fs/xfs/xfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "empty_zero_page" [net/rxrpc/rxperf.ko] has no CRC!:  => N/A

9 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memset' offset [0, 11] is out of the bounds [0, 0] [-Warray-bounds]: 68:25 => 
  - /kisskb/src/arch/s390/kernel/setup.c: warning: 'memcpy' offset [0, 127] is out of the bounds [0, 0] [-Warray-bounds]: 524:9 => 
  - /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]: 989:108, 989:122 => 989:108
  - modpost: WARNING: modpost: "__ashldi3" [lib/zstd/zstd_compress.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/can/pch_can.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/fealnx.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/smsc/smc911x.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/pcs/pcs-altera-tse.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/usb/host/fotg210-hcd.ko] has no CRC!: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
