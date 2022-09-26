Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE67F5EB2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiIZVGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiIZVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541B5FC7;
        Mon, 26 Sep 2022 14:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 553D961425;
        Mon, 26 Sep 2022 21:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D51C433C1;
        Mon, 26 Sep 2022 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664226396;
        bh=RBrse4Sei8MmA3z7vnxSngbZSjyQs4qr0n3FYjw9Lsg=;
        h=From:To:Cc:Subject:Date:From;
        b=SXF6iTpuiVYvQ53eW64qOzgf2dd4pnei+ajNtqDFrClygpCxAoUbzGCOCjamnB8UP
         99BUZ298OigVXDbN6954BxePzzjmfeXfr4Ng2v/bsacNwCsR+lCKjdR1P5RfuwBUZV
         BXPCu+T2JRVLkwPJtxukoNvGyjGSBAvCJcFP+vQmnNEAhXNxRq876lAtM0FPWANtlJ
         CTlrlXg3hYAIfvdXw1UUXl7W1lymYy2iJGVFVAgyKHYIrhEu1dTygvAyp3RTjTLq1U
         FT7VMXYhbeJP8p19OtpMt4h54PF3Nk1HOuFQBVWsTknA69g7eheV/zVza7g7T5sLNl
         nxVwxt6RP3kxg==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>
Cc:     =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manfred Spraul <manfred.spraul@de.bosch.com>
Subject: linux-next: manual merge of the driver-core tree with the jc_docs tree
Date:   Mon, 26 Sep 2022 22:06:31 +0100
Message-Id: <20220926210631.657728-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  Documentation/process/magic-number.rst

between commit:

  32ba63d4b2e1a ("Doc update: Correct magic values from nbd protocol, V2")

from the jc_docs tree and commits:

  82805818898dd ("Documentation: NBD_REPLY_MAGIC isn't a magic number")
  bd5926220ffe0 ("nbd: remove define-only NBD_MAGIC, previously magic number")

from the driver-core tree (and probably more for context).

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Documentation/process/magic-number.rst
index 133ecfa106070,f420fa2d7f8b8..0000000000000
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@@ -88,54 -77,10 +77,11 @@@ TTY_MAGIC             0x5401           
  MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
  TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
  MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
- USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
- FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
- USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
- RFCOMM_TTY_MAGIC      0x6d02                                    ``net/bluetooth/rfcomm/tty.c``
- USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/usb/serial/usb-serial.h``
- CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/linux/ufs_fs.h``
- LSEMAGIC              0x05091998       lse                      ``drivers/fc4/fc.c``
- RIEBL_MAGIC           0x09051990                                ``drivers/net/atarilance.c``
- RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.c``
- BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
- ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/isdn/isdn_x25iface.h``
- ECP_MAGIC             0x21504345       cdkecpsig                ``include/linux/cdk.h``
 -NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/linux/nbd.h``
 +NBD_REQUEST_MAGIC     0x25609513       nbd_request              ``include/uapi/linux/nbd.h``
- LSOMAGIC              0x27091997       lso                      ``drivers/fc4/fc.c``
- LSMAGIC               0x2a3b4d2a       ls                       ``drivers/fc4/fc.c``
- WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/linux/wanpipe.h``
- CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/oss/cs46xx.c``
- LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/asm/ia64/sn/labelcl.h``
- ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/linux/isdn.h``
- CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/s390/net/ctctty.c``
- ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/isdn/i4l/isdn_net_lib.h``
- SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/amiga/config.c``
- CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/oss/cs46xx.c``
- SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.c``
- COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/drivers/ubd_user.c``
- I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/oss/i810_audio.c``
- TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/oss/trident.c``
- ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanrouter.h`` pre 3.9]
- SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/amiga/config.c``
- GDA_MAGIC             0x58464552       gda                      ``arch/mips/include/asm/sn/gda.h``
- RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.c``
- EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/atm/lanai.c``
+ BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/linux/hdlcdrv.h``
- PCXX_MAGIC            0x5c6df104       channel                  ``drivers/char/pcxx.h``
  KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
- I810_STATE_MAGIC      0x63657373       i810_state               ``sound/oss/i810_audio.c``
- TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/oss/trident.c``
- M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/oss/maestro3.c``
- FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/atm/fore200e.h``
- SLOT_MAGIC            0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
- SLOT_MAGIC            0x67267322       slot                     ``drivers/hotplug/acpiphp.h``
 +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``include/uapi/linux/nbd.h``
- LO_MAGIC              0x68797548       nbd_device               ``include/linux/nbd.h``
- M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/oss/maestro3.c``
- VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/core/memory.c``
- KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/core/memory.c``
- PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/usb/media/pwc.h``
- ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/eni.h``
  CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
  YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/net/hamradio/yam.c``
  CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/scsi/ncr53c8xx.c``
diff --cc Documentation/translations/it_IT/process/magic-number.rst
index 17401994f2e84,fa7f926649d2f..0000000000000
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@@ -94,54 -83,10 +83,61 @@@ TTY_MAGIC             0x5401           
  MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
  TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
  MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
++<<<<<<< HEAD
 +USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
 +FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
 +USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
 +RFCOMM_TTY_MAGIC      0x6d02                                    ``net/bluetooth/rfcomm/tty.c``
 +USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/usb/serial/usb-serial.h``
 +CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/linux/ufs_fs.h``
 +LSEMAGIC              0x05091998       lse                      ``drivers/fc4/fc.c``
 +RIEBL_MAGIC           0x09051990                                ``drivers/net/atarilance.c``
 +RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.c``
 +BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
 +ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/isdn/isdn_x25iface.h``
 +ECP_MAGIC             0x21504345       cdkecpsig                ``include/linux/cdk.h``
 +NBD_REQUEST_MAGIC     0x25609513       nbd_request              ``include/uapi/linux/nbd.h``
 +LSOMAGIC              0x27091997       lso                      ``drivers/fc4/fc.c``
 +LSMAGIC               0x2a3b4d2a       ls                       ``drivers/fc4/fc.c``
 +WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/linux/wanpipe.h``
 +CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/oss/cs46xx.c``
 +LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/asm/ia64/sn/labelcl.h``
 +ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/linux/isdn.h``
 +CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/s390/net/ctctty.c``
 +ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/isdn/i4l/isdn_net_lib.h``
 +SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/amiga/config.c``
 +CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/oss/cs46xx.c``
 +SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.c``
 +COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/drivers/ubd_user.c``
 +I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/oss/i810_audio.c``
 +TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/oss/trident.c``
 +ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanrouter.h`` pre 3.9]
 +SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/amiga/config.c``
 +GDA_MAGIC             0x58464552       gda                      ``arch/mips/include/asm/sn/gda.h``
 +RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.c``
 +EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/atm/lanai.c``
++=======
+ NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/linux/nbd.h``
+ BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
++>>>>>>> driver-core/driver-core-next
  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/linux/hdlcdrv.h``
- PCXX_MAGIC            0x5c6df104       channel                  ``drivers/char/pcxx.h``
  KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
++<<<<<<< HEAD
 +I810_STATE_MAGIC      0x63657373       i810_state               ``sound/oss/i810_audio.c``
 +TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/oss/trident.c``
 +M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/oss/maestro3.c``
 +FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/atm/fore200e.h``
 +SLOT_MAGIC            0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
 +SLOT_MAGIC            0x67267322       slot                     ``drivers/hotplug/acpiphp.h``
 +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``include/uapi/linux/nbd.h``
 +LO_MAGIC              0x68797548       nbd_device               ``include/linux/nbd.h``
 +M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/oss/maestro3.c``
 +VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/core/memory.c``
 +KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/core/memory.c``
 +PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/usb/media/pwc.h``
 +ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/eni.h``
++=======
++>>>>>>> driver-core/driver-core-next
  CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
  YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/net/hamradio/yam.c``
  CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/scsi/ncr53c8xx.c``
diff --cc Documentation/translations/zh_CN/process/magic-number.rst
index 1b376fe087b54,4371f16836936..0000000000000
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@@ -77,57 -66,11 +66,63 @@@ TTY_MAGIC             0x5401           
  MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
  TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
  MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
++<<<<<<< HEAD
 +USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
 +FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
 +USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
 +RFCOMM_TTY_MAGIC      0x6d02                                    ``net/bluetooth/rfcomm/tty.c``
 +USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/usb/serial/usb-serial.h``
 +CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/linux/ufs_fs.h``
 +LSEMAGIC              0x05091998       lse                      ``drivers/fc4/fc.c``
 +GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/scsi/gdth_ioctl.h``
 +RIEBL_MAGIC           0x09051990                                ``drivers/net/atarilance.c``
 +RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.c``
 +BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
 +ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/isdn/isdn_x25iface.h``
 +ECP_MAGIC             0x21504345       cdkecpsig                ``include/linux/cdk.h``
 +NBD_REQUEST_MAGIC     0x25609513       nbd_request              ``include/uapi/linux/nbd.h``
 +LSOMAGIC              0x27091997       lso                      ``drivers/fc4/fc.c``
 +LSMAGIC               0x2a3b4d2a       ls                       ``drivers/fc4/fc.c``
 +WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/linux/wanpipe.h``
 +CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/oss/cs46xx.c``
 +LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/asm/ia64/sn/labelcl.h``
 +ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/linux/isdn.h``
 +CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/s390/net/ctctty.c``
 +ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/isdn/i4l/isdn_net_lib.h``
 +SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/amiga/config.c``
 +CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/oss/cs46xx.c``
 +SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.c``
 +COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/drivers/ubd_user.c``
 +I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/oss/i810_audio.c``
 +TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/oss/trident.c``
 +ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanrouter.h`` pre 3.9]
 +SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/amiga/config.c``
 +GDA_MAGIC             0x58464552       gda                      ``arch/mips/include/asm/sn/gda.h``
 +RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.c``
 +EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/atm/lanai.c``
++=======
+ NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/linux/nbd.h``
+ BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
++>>>>>>> driver-core/driver-core-next
  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/linux/hdlcdrv.h``
- PCXX_MAGIC            0x5c6df104       channel                  ``drivers/char/pcxx.h``
  KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
++<<<<<<< HEAD
 +I810_STATE_MAGIC      0x63657373       i810_state               ``sound/oss/i810_audio.c``
 +TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/oss/trident.c``
 +M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/oss/maestro3.c``
 +FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/atm/fore200e.h``
 +SLOT_MAGIC            0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
 +SLOT_MAGIC            0x67267322       slot                     ``drivers/hotplug/acpiphp.h``
 +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``include/uapi/linux/nbd.h``
 +LO_MAGIC              0x68797548       nbd_device               ``include/linux/nbd.h``
 +M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/oss/maestro3.c``
 +VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/core/memory.c``
 +KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/core/memory.c``
 +PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/usb/media/pwc.h``
 +ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/eni.h``
++=======
++>>>>>>> driver-core/driver-core-next
  CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
- DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drivers/scsi/gdth.h``
  YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/net/hamradio/yam.c``
  CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/scsi/ncr53c8xx.c``
  QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/scsi/arm/queue.c``
diff --cc Documentation/translations/zh_TW/process/magic-number.rst
index ff385a369c7b4,3e83f18b9c18e..0000000000000
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@@ -80,57 -69,11 +69,63 @@@ TTY_MAGIC             0x5401           
  MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
  TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
  MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
++<<<<<<< HEAD
 +USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
 +FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
 +USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
 +RFCOMM_TTY_MAGIC      0x6d02                                    ``net/bluetooth/rfcomm/tty.c``
 +USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/usb/serial/usb-serial.h``
 +CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/linux/ufs_fs.h``
 +LSEMAGIC              0x05091998       lse                      ``drivers/fc4/fc.c``
 +GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/scsi/gdth_ioctl.h``
 +RIEBL_MAGIC           0x09051990                                ``drivers/net/atarilance.c``
 +RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.c``
 +BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
 +ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/isdn/isdn_x25iface.h``
 +ECP_MAGIC             0x21504345       cdkecpsig                ``include/linux/cdk.h``
 +NBD_REQUEST_MAGIC     0x25609513       nbd_request              ``include/uapi/linux/nbd.h``
 +LSOMAGIC              0x27091997       lso                      ``drivers/fc4/fc.c``
 +LSMAGIC               0x2a3b4d2a       ls                       ``drivers/fc4/fc.c``
 +WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/linux/wanpipe.h``
 +CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/oss/cs46xx.c``
 +LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/asm/ia64/sn/labelcl.h``
 +ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/linux/isdn.h``
 +CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/s390/net/ctctty.c``
 +ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/isdn/i4l/isdn_net_lib.h``
 +SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/amiga/config.c``
 +CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/oss/cs46xx.c``
 +SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.c``
 +COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/drivers/ubd_user.c``
 +I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/oss/i810_audio.c``
 +TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/oss/trident.c``
 +ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanrouter.h`` pre 3.9]
 +SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/amiga/config.c``
 +GDA_MAGIC             0x58464552       gda                      ``arch/mips/include/asm/sn/gda.h``
 +RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.c``
 +EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/atm/lanai.c``
++=======
+ NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/linux/nbd.h``
+ BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
++>>>>>>> driver-core/driver-core-next
  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/linux/hdlcdrv.h``
- PCXX_MAGIC            0x5c6df104       channel                  ``drivers/char/pcxx.h``
  KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
++<<<<<<< HEAD
 +I810_STATE_MAGIC      0x63657373       i810_state               ``sound/oss/i810_audio.c``
 +TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/oss/trident.c``
 +M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/oss/maestro3.c``
 +FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/atm/fore200e.h``
 +SLOT_MAGIC            0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
 +SLOT_MAGIC            0x67267322       slot                     ``drivers/hotplug/acpiphp.h``
 +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``include/uapi/linux/nbd.h``
 +LO_MAGIC              0x68797548       nbd_device               ``include/linux/nbd.h``
 +M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/oss/maestro3.c``
 +VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/core/memory.c``
 +KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/core/memory.c``
 +PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/usb/media/pwc.h``
 +ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/eni.h``
++=======
++>>>>>>> driver-core/driver-core-next
  CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
- DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drivers/scsi/gdth.h``
  YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/net/hamradio/yam.c``
  CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/scsi/ncr53c8xx.c``
  QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/scsi/arm/queue.c``
diff --cc drivers/gpu/drm/Kconfig
index 198ba846d34bf,2438e0dccfa16..0000000000000
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@@ -51,9 -50,22 +51,28 @@@ config DRM_DEBUG_M
  
  	  If in doubt, say "N".
  
++<<<<<<< HEAD
 +config DRM_KUNIT_TEST
 +	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
 +	depends on DRM && KUNIT
++=======
+ config DRM_USE_DYNAMIC_DEBUG
+ 	bool "use dynamic debug to implement drm.debug"
+ 	default y
+ 	depends on DRM
+ 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
+ 	depends on JUMP_LABEL
+ 	help
+ 	  Use dynamic-debug to avoid drm_debug_enabled() runtime overheads.
+ 	  Due to callsite counts in DRM drivers (~4k in amdgpu) and 56
+ 	  bytes per callsite, the .data costs can be substantial, and
+ 	  are therefore configurable.
+ 
+ config DRM_DEBUG_SELFTEST
+ 	tristate "kselftests for DRM"
+ 	depends on DRM
+ 	depends on DEBUG_KERNEL
++>>>>>>> driver-core/driver-core-next
  	select PRIME_NUMBERS
  	select DRM_DISPLAY_DP_HELPER
  	select DRM_DISPLAY_HELPER
