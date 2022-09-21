Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E45BF5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiIUFLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIUFLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:11:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD387B282;
        Tue, 20 Sep 2022 22:11:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXRMg6JsBz4xFs;
        Wed, 21 Sep 2022 15:11:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663737072;
        bh=PaSKc4ExqjCRMS7Mr4AUjBNv+5pmPkf31/2GVfNG1po=;
        h=Date:From:To:Cc:Subject:From;
        b=l8sT1HX2LcYTNsjfkYpYVZBAXAXJyJRGm3kYBJuIIgiqela2VclerbPUqsFCs5+tw
         V+Iqmqfo0dWME/T9aKKfsvFiywL2aliG4BZ1JUM+MS7vG6AzcicRN+a7JLkSMad9nZ
         fsTpyJISIgSTK8z88r49vBNmcizQPOrXANsCaNgR6w+XbCz3km8iUNF2AKVux/mrpJ
         5GNj3l0MNQRWDToH1z/dPq7JCjb0NKSEOXgayDzW5XhkiBouprEvat2S/ssU2xS1yA
         wGsAxuMXbCLV6K0emfZZAw4+/OWNSlhi/7l8FuIJ6xQa3oVs/bIAv8iTNXtoIQ633e
         L5wp0tlfTeEdw==
Date:   Wed, 21 Sep 2022 15:11:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?UTF-8?B?SsOk?= =?UTF-8?B?cnZpbmVu?= 
        <ilpo.jarvinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the usb-serial tree
Message-ID: <20220921151109.174cad24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qoON3TObHWLZWXJHJY9btDR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qoON3TObHWLZWXJHJY9btDR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  drivers/usb/serial/ftdi_sio.c

between commit:

  a8619505a778 ("USB: serial: ftdi_sio: move driver structure")

from the usb-serial tree and commit:

  f6d47fe5921a ("usb: serial: Make ->set_termios() old ktermios const")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/serial/ftdi_sio.c
index 31b9b36f3a1c,0a1da579ead5..000000000000
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@@ -1107,8 -1078,29 +1107,9 @@@ static const char *ftdi_chip_name[] =3D=20
  #define FTDI_STATUS_B1_MASK	(FTDI_RS_BI)
  /* End TIOCMIWAIT */
 =20
 -/* function prototypes for a FTDI serial converter */
 -static int  ftdi_sio_probe(struct usb_serial *serial,
 -					const struct usb_device_id *id);
 -static int  ftdi_sio_port_probe(struct usb_serial_port *port);
 -static void ftdi_sio_port_remove(struct usb_serial_port *port);
 -static int  ftdi_open(struct tty_struct *tty, struct usb_serial_port *por=
t);
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
 -static void get_serial_info(struct tty_struct *tty, struct serial_struct =
*ss);
 -static int set_serial_info(struct tty_struct *tty,
 -				struct serial_struct *ss);
 -static void ftdi_break_ctl(struct tty_struct *tty, int break_state);
 -static bool ftdi_tx_empty(struct usb_serial_port *port);
  static int ftdi_get_modem_status(struct usb_serial_port *port,
  						unsigned char status[2]);
 =20

--Sig_/qoON3TObHWLZWXJHJY9btDR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMqnO0ACgkQAVBC80lX
0GwikAgAkN/qO5CjejfQfUujz2RhS1MJasEkfm9I+XvVQiVYYLto455FKaQEMGhj
mT9jBS9UQad2WK4f1MYeQRl+V5nkNqv7q6PJhEuRLBFXTj+KMKtrshnZY+eEWwIV
7oIfZN1NFjbP8C/pCRbu+7YpyHMobsGuAwSkcloP2LvesE3thTvt1QFI1A8mosAA
YrKrZTFRshUmyVAiH4t3Vf8MTO7UYPQkZ5/YqVhw9HoQ+EPruiESdjXc0B+fHHFD
A8ysO+FAz6bqCqKgLpCGhOOGyR5lf/FOOYWrlwdMnc+ntrbjDiIuOxlSLi30y+Mh
FIpvjDANANlKLtFUNvelqqPuTh9yCA==
=tFpm
-----END PGP SIGNATURE-----

--Sig_/qoON3TObHWLZWXJHJY9btDR--
