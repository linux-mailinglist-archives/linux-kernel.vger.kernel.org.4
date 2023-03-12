Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A996B674E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCLOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCLOt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6379E3524D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 07:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD0E560F2D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 14:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54A4C433EF;
        Sun, 12 Mar 2023 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678632564;
        bh=6YJ6cvkJ5xWO1cgzrT+bExN3B0TW5zJoLw4RKLfHXoU=;
        h=Date:From:To:Cc:Subject:From;
        b=mUAMrES+WtZdPLxuXea8aRlP1cja48utorYKa/tdMZ6WZF3qWFkP+xbALVbXsTwal
         wv1/nAVKc5SsQv4Rks1hIgXb557mdDmn6whdnOPmFxjS8LwKxfK68HojTIOXDsshz0
         lvAiMquG74uymc1rzIty7aQIdz0+6MqeJ/NxrElI=
Date:   Sun, 12 Mar 2023 15:49:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes and removal for 6.3-rc2
Message-ID: <ZA3mcVDC3sMrgTxE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.3-rc2

for you to fetch changes up to fdf6c2309f425509cddd002f278c650ad0b7e34b:

  staging: r8188eu: delete driver (2023-03-09 10:06:28 +0100)

----------------------------------------------------------------
Staging driver fixes and removal for 6.3-rc2

Here are 4 small staging driver fixes, and one big staging driver
deletion for 6.3-rc2.

The fixes are:
  - rtl8192e driver fixes for where the driver was attempting to execute
    various programs directly from the disk for unknown reasons
  - rtl8723bs driver fixes for issues found by Hans in testing

The deleted driver is the removal of the r8188eu wireless driver as now
in 6.3-rc1 we have a "real" wifi driver for one that includes support
for many many more devices than this old driver did.  So it's time to
remove it as it is no longer needed.  The maintainers of this driver all
have acked its removal.  Many thanks to them over the years for working
to clean it up and keep it working while the real driver was being
developed.

All of these have been in linux-next this week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      staging: r8188eu: delete driver

Hans de Goede (2):
      staging: rtl8723bs: Fix key-store index handling
      staging: rtl8723bs: Pass correct parameters to cfg80211_get_bss()

Philipp Hortmann (2):
      staging: rtl8192e: Remove function ..dm_check_ac_dc_power calling a script
      staging: rtl8192e: Remove call_usermodehelper starting RadioPower.sh

 MAINTAINERS                                        |    7 -
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/r8188eu/Kconfig                    |   16 -
 drivers/staging/r8188eu/Makefile                   |   48 -
 drivers/staging/r8188eu/TODO                       |   16 -
 drivers/staging/r8188eu/core/rtw_ap.c              | 1181 ---
 drivers/staging/r8188eu/core/rtw_br_ext.c          |  658 --
 drivers/staging/r8188eu/core/rtw_cmd.c             | 1529 ----
 drivers/staging/r8188eu/core/rtw_efuse.c           |   74 -
 drivers/staging/r8188eu/core/rtw_fw.c              |  335 -
 drivers/staging/r8188eu/core/rtw_ieee80211.c       | 1150 ---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |  479 --
 drivers/staging/r8188eu/core/rtw_iol.c             |  160 -
 drivers/staging/r8188eu/core/rtw_led.c             |  255 -
 drivers/staging/r8188eu/core/rtw_mlme.c            | 2067 ------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        | 7817 --------------------
 drivers/staging/r8188eu/core/rtw_p2p.c             | 1918 -----
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |  445 --
 drivers/staging/r8188eu/core/rtw_recv.c            | 2010 -----
 drivers/staging/r8188eu/core/rtw_rf.c              |   29 -
 drivers/staging/r8188eu/core/rtw_security.c        | 1374 ----
 drivers/staging/r8188eu/core/rtw_sta_mgt.c         |  490 --
 drivers/staging/r8188eu/core/rtw_wlan_util.c       | 1551 ----
 drivers/staging/r8188eu/core/rtw_xmit.c            | 2179 ------
 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c |  654 --
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c     |  733 --
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c    |  212 -
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c     |  269 -
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       |  900 ---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c         |  149 -
 drivers/staging/r8188eu/hal/hal_com.c              |  139 -
 drivers/staging/r8188eu/hal/hal_intf.c             |   50 -
 drivers/staging/r8188eu/hal/odm.c                  |  821 --
 drivers/staging/r8188eu/hal/odm_HWConfig.c         |  349 -
 drivers/staging/r8188eu/hal/odm_RTL8188E.c         |  264 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |  694 --
 drivers/staging/r8188eu/hal/rtl8188e_dm.c          |  146 -
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    |  922 ---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |  705 --
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c      |  405 -
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c      |  161 -
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |  627 --
 drivers/staging/r8188eu/hal/usb_halinit.c          | 1069 ---
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |  476 --
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h   |   97 -
 drivers/staging/r8188eu/include/Hal8188EPhyReg.h   | 1072 ---
 .../staging/r8188eu/include/Hal8188ERateAdaptive.h |   49 -
 drivers/staging/r8188eu/include/HalHWImg8188E_BB.h |   27 -
 .../staging/r8188eu/include/HalHWImg8188E_MAC.h    |   12 -
 drivers/staging/r8188eu/include/HalHWImg8188E_RF.h |   13 -
 drivers/staging/r8188eu/include/HalPhyRf_8188e.h   |   36 -
 drivers/staging/r8188eu/include/HalPwrSeqCmd.h     |   18 -
 drivers/staging/r8188eu/include/HalVerDef.h        |   42 -
 drivers/staging/r8188eu/include/drv_types.h        |  224 -
 drivers/staging/r8188eu/include/hal_com.h          |  146 -
 drivers/staging/r8188eu/include/hal_intf.h         |   44 -
 drivers/staging/r8188eu/include/ieee80211.h        |  817 --
 drivers/staging/r8188eu/include/odm.h              |  416 --
 drivers/staging/r8188eu/include/odm_HWConfig.h     |   69 -
 drivers/staging/r8188eu/include/odm_RTL8188E.h     |   35 -
 drivers/staging/r8188eu/include/odm_RegDefine11N.h |   47 -
 drivers/staging/r8188eu/include/osdep_intf.h       |   30 -
 drivers/staging/r8188eu/include/osdep_service.h    |  153 -
 drivers/staging/r8188eu/include/rtl8188e_cmd.h     |   90 -
 drivers/staging/r8188eu/include/rtl8188e_dm.h      |   28 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h     |  181 -
 drivers/staging/r8188eu/include/rtl8188e_recv.h    |   40 -
 drivers/staging/r8188eu/include/rtl8188e_rf.h      |   18 -
 drivers/staging/r8188eu/include/rtl8188e_spec.h    | 1142 ---
 drivers/staging/r8188eu/include/rtl8188e_xmit.h    |  130 -
 drivers/staging/r8188eu/include/rtw_ap.h           |   34 -
 drivers/staging/r8188eu/include/rtw_br_ext.h       |   43 -
 drivers/staging/r8188eu/include/rtw_cmd.h          |  925 ---
 drivers/staging/r8188eu/include/rtw_eeprom.h       |   15 -
 drivers/staging/r8188eu/include/rtw_efuse.h        |   11 -
 drivers/staging/r8188eu/include/rtw_event.h        |   97 -
 drivers/staging/r8188eu/include/rtw_fw.h           |   17 -
 drivers/staging/r8188eu/include/rtw_ht.h           |   28 -
 drivers/staging/r8188eu/include/rtw_io.h           |   33 -
 drivers/staging/r8188eu/include/rtw_ioctl.h        |   13 -
 drivers/staging/r8188eu/include/rtw_ioctl_set.h    |   25 -
 drivers/staging/r8188eu/include/rtw_iol.h          |   55 -
 drivers/staging/r8188eu/include/rtw_led.h          |   57 -
 drivers/staging/r8188eu/include/rtw_mlme.h         |  574 --
 drivers/staging/r8188eu/include/rtw_mlme_ext.h     |  753 --
 drivers/staging/r8188eu/include/rtw_p2p.h          |  118 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h      |  111 -
 drivers/staging/r8188eu/include/rtw_recv.h         |  347 -
 drivers/staging/r8188eu/include/rtw_rf.h           |   80 -
 drivers/staging/r8188eu/include/rtw_security.h     |  231 -
 drivers/staging/r8188eu/include/rtw_xmit.h         |  334 -
 drivers/staging/r8188eu/include/sta_info.h         |  313 -
 drivers/staging/r8188eu/include/usb_ops.h          |   57 -
 drivers/staging/r8188eu/include/usb_osintf.h       |   21 -
 drivers/staging/r8188eu/include/wifi.h             |  773 --
 drivers/staging/r8188eu/include/wlan_bssdef.h      |  272 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       | 3775 ----------
 drivers/staging/r8188eu/os_dep/os_intfs.c          |  807 --
 drivers/staging/r8188eu/os_dep/osdep_service.c     |  227 -
 drivers/staging/r8188eu/os_dep/usb_intf.c          |  445 --
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c     |  136 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |   35 -
 drivers/staging/rtl8723bs/include/rtw_security.h   |    8 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   32 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |   33 +-
 106 files changed, 39 insertions(+), 51308 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/Kconfig
 delete mode 100644 drivers/staging/r8188eu/Makefile
 delete mode 100644 drivers/staging/r8188eu/TODO
 delete mode 100644 drivers/staging/r8188eu/core/rtw_ap.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_br_ext.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_cmd.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_efuse.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_fw.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_ieee80211.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_ioctl_set.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_iol.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_led.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_mlme.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_mlme_ext.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_p2p.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_pwrctrl.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_recv.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_rf.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_security.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_sta_mgt.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_wlan_util.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_xmit.c
 delete mode 100644 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
 delete mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
 delete mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
 delete mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
 delete mode 100644 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
 delete mode 100644 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
 delete mode 100644 drivers/staging/r8188eu/hal/hal_com.c
 delete mode 100644 drivers/staging/r8188eu/hal/hal_intf.c
 delete mode 100644 drivers/staging/r8188eu/hal/odm.c
 delete mode 100644 drivers/staging/r8188eu/hal/odm_HWConfig.c
 delete mode 100644 drivers/staging/r8188eu/hal/odm_RTL8188E.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_cmd.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_dm.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
 delete mode 100644 drivers/staging/r8188eu/hal/usb_halinit.c
 delete mode 100644 drivers/staging/r8188eu/hal/usb_ops_linux.c
 delete mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
 delete mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyReg.h
 delete mode 100644 drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
 delete mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
 delete mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
 delete mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
 delete mode 100644 drivers/staging/r8188eu/include/HalPhyRf_8188e.h
 delete mode 100644 drivers/staging/r8188eu/include/HalPwrSeqCmd.h
 delete mode 100644 drivers/staging/r8188eu/include/HalVerDef.h
 delete mode 100644 drivers/staging/r8188eu/include/drv_types.h
 delete mode 100644 drivers/staging/r8188eu/include/hal_com.h
 delete mode 100644 drivers/staging/r8188eu/include/hal_intf.h
 delete mode 100644 drivers/staging/r8188eu/include/ieee80211.h
 delete mode 100644 drivers/staging/r8188eu/include/odm.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_HWConfig.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_RTL8188E.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11N.h
 delete mode 100644 drivers/staging/r8188eu/include/osdep_intf.h
 delete mode 100644 drivers/staging/r8188eu/include/osdep_service.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_cmd.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_dm.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_hal.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_recv.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_rf.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_spec.h
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_xmit.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_ap.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_br_ext.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_cmd.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_eeprom.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_efuse.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_event.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_fw.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_ht.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_io.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_ioctl.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_set.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_iol.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_led.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_mlme.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_mlme_ext.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_p2p.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_pwrctrl.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_recv.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_rf.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_security.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_xmit.h
 delete mode 100644 drivers/staging/r8188eu/include/sta_info.h
 delete mode 100644 drivers/staging/r8188eu/include/usb_ops.h
 delete mode 100644 drivers/staging/r8188eu/include/usb_osintf.h
 delete mode 100644 drivers/staging/r8188eu/include/wifi.h
 delete mode 100644 drivers/staging/r8188eu/include/wlan_bssdef.h
 delete mode 100644 drivers/staging/r8188eu/os_dep/ioctl_linux.c
 delete mode 100644 drivers/staging/r8188eu/os_dep/os_intfs.c
 delete mode 100644 drivers/staging/r8188eu/os_dep/osdep_service.c
 delete mode 100644 drivers/staging/r8188eu/os_dep/usb_intf.c
 delete mode 100644 drivers/staging/r8188eu/os_dep/usb_ops_linux.c
