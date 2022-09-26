Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA175EB335
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiIZVeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiIZVeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41698A2875;
        Mon, 26 Sep 2022 14:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72D506145A;
        Mon, 26 Sep 2022 21:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700B7C433C1;
        Mon, 26 Sep 2022 21:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664228058;
        bh=U8u7djBV3txbnmWy6HqwYkPNTKgcPkvVvL0ocRv+9oY=;
        h=From:To:Cc:Subject:Date:From;
        b=Og0BoFhOLtCc7FpuNe56c89Pinv3RokJ+zx7XFwXIah88uy2B6SMKiPbPn8vY/0z+
         cHHpKqErqiZ6aZXf42EpW0qr2qkn/69QmGFoK+wVrVlCBlvoD/xP3nn5p0bP9Cbu7d
         eCqaXnhSgTpyMdF4x4bXOcTMWE1fSpb4taque/7uJnxZl7sGgnB2/8QuI35bvP6VXn
         M3BBBvZShnsn8PNgqbO2mFB1b7YHcftgHkDCr0wV5QGPQ5iGjI7My9wQHtcBa3YWO7
         wbXddTS5jyA/VtFQjWuV3zRorXNtZ1yILpsPGgeTpQyPR/P/FyItQLMRU83p6LgOK8
         sHPBTTKO+PG8g==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>
Cc:     =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the drivers-misc tree
Date:   Mon, 26 Sep 2022 22:34:14 +0100
Message-Id: <20220926213414.792065-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Today's linux-next merge of the tty tree got a conflict in:

  Documentation/process/magic-number.rst

between commits:

  766c5a3ecb319 ("Documentation: remove nonexistent magic numbers")
  53c2bd6790172 ("a.out: remove define-only CMAGIC, previously magic number")

from the drivers-misc tree and commits:

  7a4e0d2c7fb8e ("tty: remove TTY_MAGIC")
  5052df99d3bc3 ("tty: remove TTY_DRIVER_MAGIC")
  14f9ed6153705 ("tty: n_hdlc: remove HDLC_MAGIC")
  0e6357c3b61d6 ("tty: synclink_gt: remove MGSL_MAGIC")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Documentation/process/magic-number.rst
index 0387e8014074a,2326c3be94fc6..0000000000000
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@@ -69,19 -69,69 +69,15 @@@ Changelog:
  Magic Name            Number           Structure                File
  ===================== ================ ======================== ==========================================
  PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
- HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
 -CMAGIC                0x0111           user                     ``include/linux/a.out.h``
 -MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/net/mkiss.h``
  APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
 -DB_MAGIC              0x4442           fc_info                  ``drivers/net/iph5526_novram.c``
 -DL_MAGIC              0x444d           fc_info                  ``drivers/net/iph5526_novram.c``
  FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 -FF_MAGIC              0x4646           fc_info                  ``drivers/net/iph5526_novram.c``
 -PTY_MAGIC             0x5001                                    ``drivers/char/pty.c``
 -PPP_MAGIC             0x5002           ppp                      ``include/linux/if_pppvar.h``
 -SSTATE_MAGIC          0x5302           serial_state             ``include/linux/serial.h``
  SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
- TTY_MAGIC             0x5401           tty_struct               ``include/linux/tty.h``
- MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
- TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
 -STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
 -SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
 -AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
  MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
 -USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
 -FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
 -USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
 -RFCOMM_TTY_MAGIC      0x6d02                                    ``net/bluetooth/rfcomm/tty.c``
 -USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/usb/serial/usb-serial.h``
 -CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/linux/ufs_fs.h``
 -LSEMAGIC              0x05091998       lse                      ``drivers/fc4/fc.c``
 -RIEBL_MAGIC           0x09051990                                ``drivers/net/atarilance.c``
 -NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/linux/nbd.h``
 -RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.c``
 +NBD_REQUEST_MAGIC     0x25609513       nbd_request              ``include/uapi/linux/nbd.h``
  BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
 -ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/isdn/isdn_x25iface.h``
 -ECP_MAGIC             0x21504345       cdkecpsig                ``include/linux/cdk.h``
 -LSOMAGIC              0x27091997       lso                      ``drivers/fc4/fc.c``
 -LSMAGIC               0x2a3b4d2a       ls                       ``drivers/fc4/fc.c``
 -WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/linux/wanpipe.h``
 -CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/oss/cs46xx.c``
 -LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/asm/ia64/sn/labelcl.h``
 -ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/linux/isdn.h``
 -CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/s390/net/ctctty.c``
 -ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/isdn/i4l/isdn_net_lib.h``
 -SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/amiga/config.c``
 -CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/oss/cs46xx.c``
 -SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.c``
 -COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/drivers/ubd_user.c``
 -I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/oss/i810_audio.c``
 -TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/oss/trident.c``
 -ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanrouter.h`` pre 3.9]
 -SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/amiga/config.c``
 -GDA_MAGIC             0x58464552       gda                      ``arch/mips/include/asm/sn/gda.h``
 -RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.c``
 -EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/atm/lanai.c``
  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/linux/hdlcdrv.h``
 -PCXX_MAGIC            0x5c6df104       channel                  ``drivers/char/pcxx.h``
  KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
 -I810_STATE_MAGIC      0x63657373       i810_state               ``sound/oss/i810_audio.c``
 -TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/oss/trident.c``
 -M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/oss/maestro3.c``
 -FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/atm/fore200e.h``
 -SLOT_MAGIC            0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
 -SLOT_MAGIC            0x67267322       slot                     ``drivers/hotplug/acpiphp.h``
 -LO_MAGIC              0x68797548       nbd_device               ``include/linux/nbd.h``
 -M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/oss/maestro3.c``
 -VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/core/memory.c``
 -KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/core/memory.c``
 -PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/usb/media/pwc.h``
 -NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/linux/nbd.h``
 -ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/eni.h``
 +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``include/uapi/linux/nbd.h``
  CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
  YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/net/hamradio/yam.c``
  CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/scsi/ncr53c8xx.c``
diff --cc Documentation/translations/it_IT/process/magic-number.rst
index cfb8d69768aae,1803497816f1e..0000000000000
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@@ -75,15 -75,21 +75,26 @@@ Registro dei cambiamenti:
  Nome magico           Numero           Struttura                File
  ===================== ================ ======================== ==========================================
  PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
++<<<<<<< HEAD
 +HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
++=======
+ CMAGIC                0x0111           user                     ``include/linux/a.out.h``
+ MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/net/mkiss.h``
++>>>>>>> tty/tty-next
  APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
 -DB_MAGIC              0x4442           fc_info                  ``drivers/net/iph5526_novram.c``
 -DL_MAGIC              0x444d           fc_info                  ``drivers/net/iph5526_novram.c``
  FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 -FF_MAGIC              0x4646           fc_info                  ``drivers/net/iph5526_novram.c``
 -PTY_MAGIC             0x5001                                    ``drivers/char/pty.c``
 -PPP_MAGIC             0x5002           ppp                      ``include/linux/if_pppvar.h``
 -SSTATE_MAGIC          0x5302           serial_state             ``include/linux/serial.h``
  SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
++<<<<<<< HEAD
 +TTY_MAGIC             0x5401           tty_struct               ``include/linux/tty.h``
 +MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
 +TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
++=======
+ STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
+ SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
+ AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
++>>>>>>> tty/tty-next
  MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
 +<<<<<<< HEAD
  USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
  FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
  USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
diff --cc Documentation/translations/zh_CN/process/magic-number.rst
index 2df729592547f,9780bf710eebc..0000000000000
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@@ -58,15 -58,21 +58,26 @@@ Linux é­æ¯æ
  é­æ¯æ°å              æ°å­             ç»æ                     æä»¶
  ===================== ================ ======================== ==========================================
  PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
++<<<<<<< HEAD
 +HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
++=======
+ CMAGIC                0x0111           user                     ``include/linux/a.out.h``
+ MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/net/mkiss.h``
++>>>>>>> tty/tty-next
  APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
 -DB_MAGIC              0x4442           fc_info                  ``drivers/net/iph5526_novram.c``
 -DL_MAGIC              0x444d           fc_info                  ``drivers/net/iph5526_novram.c``
  FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 -FF_MAGIC              0x4646           fc_info                  ``drivers/net/iph5526_novram.c``
 -PTY_MAGIC             0x5001                                    ``drivers/char/pty.c``
 -PPP_MAGIC             0x5002           ppp                      ``include/linux/if_pppvar.h``
 -SSTATE_MAGIC          0x5302           serial_state             ``include/linux/serial.h``
  SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
++<<<<<<< HEAD
 +TTY_MAGIC             0x5401           tty_struct               ``include/linux/tty.h``
 +MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
 +TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
++=======
+ STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
+ SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
+ AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
++>>>>>>> tty/tty-next
  MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
 +<<<<<<< HEAD
  USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
  FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
  USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
diff --cc Documentation/translations/zh_TW/process/magic-number.rst
index 4cbb93dadef78,933545e92137a..0000000000000
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@@ -61,15 -61,21 +61,26 @@@ Linux é­è¡æ
  é­è¡æ¸å              æ¸å­             çµæ§                     æä»¶
  ===================== ================ ======================== ==========================================
  PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
++<<<<<<< HEAD
 +HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
++=======
+ CMAGIC                0x0111           user                     ``include/linux/a.out.h``
+ MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/net/mkiss.h``
++>>>>>>> tty/tty-next
  APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
 -DB_MAGIC              0x4442           fc_info                  ``drivers/net/iph5526_novram.c``
 -DL_MAGIC              0x444d           fc_info                  ``drivers/net/iph5526_novram.c``
  FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 -FF_MAGIC              0x4646           fc_info                  ``drivers/net/iph5526_novram.c``
 -PTY_MAGIC             0x5001                                    ``drivers/char/pty.c``
 -PPP_MAGIC             0x5002           ppp                      ``include/linux/if_pppvar.h``
 -SSTATE_MAGIC          0x5302           serial_state             ``include/linux/serial.h``
  SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
++<<<<<<< HEAD
 +TTY_MAGIC             0x5401           tty_struct               ``include/linux/tty.h``
 +MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
 +TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
++=======
+ STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
+ SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
+ AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
++>>>>>>> tty/tty-next
  MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
 +<<<<<<< HEAD
  USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
  FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
  USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
diff --cc drivers/usb/serial/ftdi_sio.c
index 31b9b36f3a1cb,0a1da579ead52..0000000000000
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@@ -1107,8 -1078,29 +1107,9 @@@ static const char *ftdi_chip_name[] = 
  #define FTDI_STATUS_B1_MASK	(FTDI_RS_BI)
  /* End TIOCMIWAIT */
  
 -/* function prototypes for a FTDI serial converter */
 -static int  ftdi_sio_probe(struct usb_serial *serial,
 -					const struct usb_device_id *id);
 -static int  ftdi_sio_port_probe(struct usb_serial_port *port);
 -static void ftdi_sio_port_remove(struct usb_serial_port *port);
 -static int  ftdi_open(struct tty_struct *tty, struct usb_serial_port *port);
 -static void ftdi_dtr_rts(struct usb_serial_port *port, int on);
 -static void ftdi_process_read_urb(struct urb *urb);
 -static int ftdi_prepare_write_buffer(struct usb_serial_port *port,
 -						void *dest, size_t size);
  static void ftdi_set_termios(struct tty_struct *tty,
- 			struct usb_serial_port *port, struct ktermios *old);
+ 			     struct usb_serial_port *port,
+ 			     const struct ktermios *old_termios);
 -static int  ftdi_tiocmget(struct tty_struct *tty);
 -static int  ftdi_tiocmset(struct tty_struct *tty,
 -			unsigned int set, unsigned int clear);
 -static int  ftdi_ioctl(struct tty_struct *tty,
 -			unsigned int cmd, unsigned long arg);
 -static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss);
 -static int set_serial_info(struct tty_struct *tty,
 -				struct serial_struct *ss);
 -static void ftdi_break_ctl(struct tty_struct *tty, int break_state);
 -static bool ftdi_tx_empty(struct usb_serial_port *port);
  static int ftdi_get_modem_status(struct usb_serial_port *port,
  						unsigned char status[2]);
  
