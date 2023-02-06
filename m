Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811468BCC3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBFM0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:26:02 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40CD1EFC5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:26:00 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:5f4c:1e23:9c34:1a39])
        by laurent.telenet-ops.be with bizsmtp
        id HoRx2900h3XDBUl01oRxX0; Mon, 06 Feb 2023 13:25:57 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pP0Z2-008DEu-LT
        for linux-kernel@vger.kernel.org;
        Mon, 06 Feb 2023 13:25:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pP0ZJ-00Ejg6-Jr
        for linux-kernel@vger.kernel.org;
        Mon, 06 Feb 2023 13:25:57 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.2-rc7
Date:   Mon,  6 Feb 2023 13:25:57 +0100
Message-Id: <20230206122557.3512171-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=whSVeeQN9vO-WSxFkNs0zbUJEBqND-1VO8OJtmu_sn_nw@mail.gmail.com>
References: <CAHk-=whSVeeQN9vO-WSxFkNs0zbUJEBqND-1VO8OJtmu_sn_nw@mail.gmail.com>
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
v6.2-rc7[1] compared to v6.1[2].

Summarized:
  - build errors: +10/-14
  - build warnings: +30/-10

JFYI, when comparing v6.2-rc7[1] to v6.2-rc6[3], the summaries are:
  - build errors: +1/-1
  - build warnings: +0/-1

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4ec5183ec48656cec489c49f989c508b68b518e3/ (all 152 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e9176028d02ef86f3cf76aa2476/ (all 152 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6d796c50f84ca79f1722bb131799e5a5710c4700/ (all 152 configs)


*** ERRORS ***

10 error regressions:
  + /kisskb/src/arch/powerpc/kexec/file_load_64.c: error: implicit declaration of function 'memory_hotplug_max' [-Werror=implicit-function-declaration]:  => 993:33
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: error: the frame size of 2224 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 7082:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 7127:1
  + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]:  => 641:28
  + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]:  => 641:28
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: 'gimple_call_addr_fndecl' was not declared in this scope:  => 2790:10
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: 'is_gimple_reg' was not declared in this scope:  => 2556:18
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field 'call_clobbered' has incomplete type 'pt_solution':  => 284:22
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field 'call_used' has incomplete type 'pt_solution':  => 283:22
  + {standard input}: Error: unknown pseudo-op: `.cfi_def_c':  => 1718

14 error improvements:
  - /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]: 239:34 => 
  - /kisskb/src/arch/sparc/kernel/irq_32.c: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]: 259:14, 258:14, 263:14, 261:46, 262:14 => 
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
  - {standard input}: Error: pcrel too far: 2232, 2249, 2216, 2231, 2204, 2209, 2206, 2248, 2221, 2259, 2247, 2217, 2229, 2215, 2262, 2261, 2274, 2293 => 
  - {standard input}: Error: unknown pseudo-op: `.l': 2305 => 


*** WARNINGS ***

30 warning regressions:
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
  + modpost: WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mux-meson-g12a.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt7996/mt7996e.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtw89/rtw89_8852b.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/phy/renesas/r8a779f0-ether-serdes.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ptp/ptp_idt82p33.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/usb/fotg210/fotg210.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [fs/xfs/xfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "empty_zero_page" [net/rxrpc/rxperf.ko] has no CRC!:  => N/A

10 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memset' offset [0, 11] is out of the bounds [0, 0] [-Warray-bounds]: 68:25 => 
  - /kisskb/src/arch/s390/kernel/setup.c: warning: 'memcpy' offset [0, 127] is out of the bounds [0, 0] [-Warray-bounds]: 524:9 => 
  - /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]: 989:108, 989:122 => 989:108
  - /kisskb/src/fs/coredump.c: warning: 'dump_emit_page' defined but not used [-Wunused-function]: 834:12 => 
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
