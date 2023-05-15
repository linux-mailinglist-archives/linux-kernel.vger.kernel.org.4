Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AEF70272C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbjEOIbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbjEOIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:31:02 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064E1702
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:26:59 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:3f77:5127:1ef7:f210])
        by baptiste.telenet-ops.be with bizsmtp
        id wwSx2900L5WeK8L01wSxLV; Mon, 15 May 2023 10:26:57 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pyTXb-002Dyu-CU
        for linux-kernel@vger.kernel.org;
        Mon, 15 May 2023 10:26:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pyTXl-00D8B1-7l
        for linux-kernel@vger.kernel.org;
        Mon, 15 May 2023 10:26:57 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.4-rc2
Date:   Mon, 15 May 2023 10:26:57 +0200
Message-Id: <20230515082657.3129685-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wj3jDtVCi2LqyijGzut2cq=AkPrAMfF0+6gtZ1WB6ruWQ@mail.gmail.com>
References: <CAHk-=wj3jDtVCi2LqyijGzut2cq=AkPrAMfF0+6gtZ1WB6ruWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.4-rc2[1] compared to v6.3[2].

Summarized:
  - build errors: +5/-8
  - build warnings: +30/-12

JFYI, when comparing v6.4-rc2[1] to v6.4-rc1[3], the summaries are:
  - build errors: +8/-4
  - build warnings: +1456/-0

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6/ (all 152 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/457391b0380335d5e9a5babdec90ac53928b23b4/ (all 152 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ac9a78681b921877518763ba0e89202254349d1b/ (all 152 configs)


*** ERRORS ***

5 error regressions:
  + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 364:27, 495:27
  + /kisskb/src/fs/xfs/scrub/scrub.h: error: initializer element is not constant:  => 111:28
  + error: modpost: "__floatunsidf" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] undefined!:  => N/A
  + error: modpost: "__gedf2" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] undefined!:  => N/A
  + error: modpost: "__ltdf2" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] undefined!:  => N/A

8 error improvements:
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: 'struct cpuinfo_um' has no member named 'apicid': 2157:48, 2157:41 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]: 2161:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 7086:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 7131:1 => 
  - /kisskb/src/drivers/gpu/drm/msm/msm_mdss.c: error: case label does not reduce to an integer constant: 296:2, 299:2, 300:2 => 
  - /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]: 641:28 => 
  - /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]: 641:28 => 
  - /kisskb/src/fs/btrfs/send.c: error: 'right_gen' may be used uninitialized in this function [-Werror=maybe-uninitialized]: 1902:23, 1909:13 => 


*** WARNINGS ***

30 warning regressions:
  + /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1128 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 400:1
  + modpost: WARNING: modpost: "__ashldi3" [drivers/input/joystick/sidewinder.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/xilinx/xilinx_emac.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/virtio_net.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/wireless/ath/ath10k/ath10k_core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [fs/hfsplus/hfsplus.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashldi3" [net/mac80211/mac80211.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashrdi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ashrdi3" [fs/xfs/xfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/md/dm-writecache.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/md/dm-zoned.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/scsi/hpsa.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/ext2/ext2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/ext4/ext4.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/gfs2/gfs2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/ntfs3/ntfs3.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [net/mac80211/mac80211.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [net/sched/act_police.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/hwmon/sfctemp.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/platform/nxp/imx8-isi/imx8-isi.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-cadence.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ptp/ptp_dfl_tod.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/spi/spi-davinci.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/thermal/mediatek/auxadc_thermal.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: suppressed 1 unresolved symbol warnings because there were too many):  => N/A

12 warning improvements:
  - /kisskb/src/fs/btrfs/send.c: warning: 'right_gen' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1909:13, 1909:27, 1902:23 => 
  - /kisskb/src/fs/btrfs/volumes.c: warning: 'seed_devices' may be used uninitialized in this function [-Wmaybe-uninitialized]: 2524:2, 2524:9 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 404:1 => 
  - /kisskb/src/include/linux/list.h: warning: 'seed_devices' may be used uninitialized in this function [-Wmaybe-uninitialized]: 74:19, 74:12 => 
  - modpost: WARNING: modpost: "__udelay" [drivers/char/pcmcia/cm4000_cs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/char/pcmcia/synclink_cs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/media/i2c/noon010pc30.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/media/i2c/vs6624.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/intel/ixgb/ixgb.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-thunderbay-emmc.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/usb/host/u132-hcd.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/usb/misc/ftdi-elan.ko] has no CRC!: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
