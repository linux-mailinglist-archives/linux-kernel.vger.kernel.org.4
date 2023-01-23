Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD0677405
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 03:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjAWCSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 21:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjAWCSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 21:18:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE26144BC;
        Sun, 22 Jan 2023 18:18:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0Yg01ZKlz4xyd;
        Mon, 23 Jan 2023 13:18:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674440300;
        bh=CxYqtpt/pJCUXQBlKHHgtAfFQj3OCZMzJNeA2PIf5PM=;
        h=Date:From:To:Cc:Subject:From;
        b=Xv1MW7AQcgKMD7z5ch53QWxfNdtA5Y62hystEzhCc2CvQaCBGwK4DbjfYSGWchG07
         eSGF2KgQAvw+64fJCoQJl7J79O3clqV889g+CHyfn1CvlJNLwCGFIbxrT9HzGtP6UQ
         pgxIcgniwhmSeBKrllYeHHuvOhKVqM3RZ3HUt1q4SFaQJpJXvUeGN+outoZdxRxG4i
         5vySAOM1t7+PmDm+BcdzGevtX0+F4WMOrKJdnyTeaUvM8rMfBXxkOFyrudgQ4fZrbb
         5QdlA3cK3Eyx2UXn8bog3GtiTtDaJ8qdTTCe7FETbjxD05VZz04C50RNbf8QoV3z37
         Zd8KQwCj1WrgQ==
Date:   Mon, 23 Jan 2023 13:18:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tty tree
Message-ID: <20230123131818.2785f4e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p1p/vaXsSc+vE6pY.3o34IZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p1p/vaXsSc+vE6pY.3o34IZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/tty/serial/qcom_geni_serial.c: In function 'setup_fifos':
drivers/tty/serial/qcom_geni_serial.c:1058:17: error: 'struct qcom_geni_ser=
ial_port' has no member named 'rx_fifo'
 1058 |         if (port->rx_fifo && (old_rx_fifo_depth !=3D port->rx_fifo_=
depth) && port->rx_fifo_depth) {
      |                 ^~
drivers/tty/serial/qcom_geni_serial.c:1059:21: error: 'struct qcom_geni_ser=
ial_port' has no member named 'rx_fifo'
 1059 |                 port->rx_fifo =3D devm_krealloc(uport->dev, port->r=
x_fifo,
      |                     ^~
drivers/tty/serial/qcom_geni_serial.c:1059:63: error: 'struct qcom_geni_ser=
ial_port' has no member named 'rx_fifo'
 1059 |                 port->rx_fifo =3D devm_krealloc(uport->dev, port->r=
x_fifo,
      |                                                               ^~
drivers/tty/serial/qcom_geni_serial.c:1062:26: error: 'struct qcom_geni_ser=
ial_port' has no member named 'rx_fifo'
 1062 |                 if (!port->rx_fifo)
      |                          ^~

Caused by commit

  2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engi=
ne DMA")

interacting with commit

  b8caf69a6946 ("tty: serial: qcom-geni-serial: fix slab-out-of-bounds on R=
X FIFO buffer")

from Linus' tree.

I have applied the following merge fix patch for today (I am not sure
if it is actually correct, but it builds).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 23 Jan 2023 13:09:27 +1100
Subject: [PATCH] tty: fix up for "tty: serial: qcom-geni-serial: add support
 for serial engine DMA"

interacting with "tty: serial: qcom-geni-serial: fix slab-out-of-bounds
on RX FIFO buffer".

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/tty/serial/qcom_geni_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qco=
m_geni_serial.c
index d98e0a8aae7c..61350007bf1c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1055,11 +1055,11 @@ static int setup_fifos(struct qcom_geni_serial_port=
 *port)
 	uport->fifosize =3D
 		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
=20
-	if (port->rx_fifo && (old_rx_fifo_depth !=3D port->rx_fifo_depth) && port=
->rx_fifo_depth) {
-		port->rx_fifo =3D devm_krealloc(uport->dev, port->rx_fifo,
+	if (port->rx_buf && (old_rx_fifo_depth !=3D port->rx_fifo_depth) && port-=
>rx_fifo_depth) {
+		port->rx_buf =3D devm_krealloc(uport->dev, port->rx_buf,
 					      port->rx_fifo_depth * sizeof(u32),
 					      GFP_KERNEL);
-		if (!port->rx_fifo)
+		if (!port->rx_buf)
 			return -ENOMEM;
 	}
=20
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/p1p/vaXsSc+vE6pY.3o34IZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPN7moACgkQAVBC80lX
0GzjoAgAmKZPYPlF96N2ADXZdnl7cWI6f5gv4uSX1xl/VP61TLS7+8uJglreqYou
e3PPlK6Va2lIwWhr0Tn5IcvlV/QIWwNGdjyDm7lz0ZHp5W3HrrjLZYpNOOgae+kl
GG6pLPd7aWLLq53kyNZQpoOR+NvNN0dH9AFNJ2fQUxFVyBi30J0uMuYmBPTS5EZF
B9IBEv7MkkZu8PTkyTdhIF+sOW+aY+0tYny4Suo9jNoejbix2dTqiN+uhf7kjC4d
m/jQSb/5puy0ClPGK6Q2flWI1ohuEY5h83uGNBO3IUuVSfuz7edo/SEWBN1SI8X0
glOvfNWSIbk8RB9u/A71MRH4MY1b6w==
=770s
-----END PGP SIGNATURE-----

--Sig_/p1p/vaXsSc+vE6pY.3o34IZ--
