Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88B65B049
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjABLKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjABLKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:10:09 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3BE45
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:10:05 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:513e:34db:6493:4ef7])
        by andre.telenet-ops.be with bizsmtp
        id 3nA22900p2Ef9QR01nA2kX; Mon, 02 Jan 2023 12:10:03 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCIhe-001qS0-Is
        for linux-kernel@vger.kernel.org; Mon, 02 Jan 2023 12:10:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCHw9-0019n4-V7
        for linux-kernel@vger.kernel.org; Mon, 02 Jan 2023 11:20:57 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.2-rc2
Date:   Mon,  2 Jan 2023 11:20:57 +0100
Message-Id: <20230102102057.275919-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
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
v6.2-rc2[1] compared to v6.1[2].

Summarized:
  - build errors: +10/-13
  - build warnings: +13/-10

JFYI, when comparing v6.2-rc2[1] to v6.2-rc1[3], the summaries are:
  - build errors: +0/-1
  - build warnings: +0/-0

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/88603b6dc419445847923fcb7fe5080067a30f98/ (all 152 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e9176028d02ef86f3cf76aa2476/ (all 152 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1b929c02afd37871d5afb9d498426f83432e71c2/ (all 152 configs)


*** ERRORS ***

10 error regressions:
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: error: the frame size of 2224 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 7082:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 7127:1
  + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]:  => 641:28
  + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]:  => 641:28
  + /kisskb/src/include/linux/bitfield.h: error: call to '__field_overflow' declared with attribute error: value doesn't fit into mask:  => 151:3
  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().:  => 358:45
  + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memcpy' offset [0, 127] is out of the bounds [0, 0] [-Werror=array-bounds]:  => 57:33
  + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]:  => 59:33
  + /kisskb/src/kernel/kcsan/kcsan_test.c: error: the frame size of 1680 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 257:1
  + {standard input}: Error: unknown pseudo-op: `.cfi_def_c':  => 1718

13 error improvements:
  - /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]: 239:34 => 
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
  - {standard input}: Error: pcrel too far: 2274, 2232, 2204, 2217, 2293, 2248, 2206, 2229, 2261, 2221, 2215, 2247, 2262, 2216, 2209, 2249, 2231, 2259 => 
  - {standard input}: Error: unknown pseudo-op: `.l': 2305 => 


*** WARNINGS ***

13 warning regressions:
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

10 warning improvements:
  - modpost: WARNING: modpost: "__ashldi3" [lib/zstd/zstd_compress.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/can/pch_can.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/fealnx.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/smsc/smc911x.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/pcs/pcs-altera-tse.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/usb/host/fotg210-hcd.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: vmlinux.o: section mismatch in reference: __trace_event_discard_commit (section: .text.unlikely) -> initcall_level_names (section: .init.data): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
