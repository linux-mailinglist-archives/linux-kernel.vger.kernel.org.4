Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0687021BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjEOCfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjEOCfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:35:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1431BB;
        Sun, 14 May 2023 19:35:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKNl349svz4x1N;
        Mon, 15 May 2023 12:35:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684118127;
        bh=2u50IuYuFGQsWZ4R/Mr+7FE6MAZhgBZcHZaJvakXl4Q=;
        h=Date:From:To:Cc:Subject:From;
        b=UTqdV03E2pSxoCshskhNSlE2HtOLIZyCpqhR7+SCHqztkH9ce6RkwKzQ2XzIhdl8G
         ZbvI2ehEIDjWMPoh8OZMA5GxqnOwS3Ojj02VXyHcSMiA+UvnVOSARKWlsVPNJvZ30x
         KGYXAq6bmxgtbB3J5xkiVfP0/5JhQE/QouHabHN0MyHfotJ6jK6jDw+16tRt9lWmrv
         jZG+6dfjpjyDdqfu4KGbF0l5esNMVqRG73eiZfkz2QJtZv4mAQ26+LQ3KgPYSXbEJk
         uOzwDS4JHPALrb88dOA5d0REw4DQWYh0O+U2WZhEswz/3fOFISCnnBSuX9QAVKNWZv
         diJZzYxHFgwYA==
Date:   Mon, 15 May 2023 12:35:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20230515123524.74e7bda3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X4OBLMXhdWLp_/7nqeqQWoZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X4OBLMXhdWLp_/7nqeqQWoZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/dwc3/gadget.c

between commit:

  c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_=
gadget_resume()")

from the usb.current tree and commit:

  813f44d57e19 ("usb: dwc3: gadget: Bail out in pullup if soft reset timeou=
t happens")

from the usb tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/dwc3/gadget.c
index d831f5acf7b5,5965796bc5d5..000000000000
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@@ -2700,21 -2699,6 +2700,26 @@@ static int dwc3_gadget_soft_disconnect(
  	return ret;
  }
 =20
 +static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
 +{
++	int	ret;
++
 +	/*
 +	 * In the Synopsys DWC_usb31 1.90a programming guide section
 +	 * 4.1.9, it specifies that for a reconnect after a
 +	 * device-initiated disconnect requires a core soft reset
 +	 * (DCTL.CSftRst) before enabling the run/stop bit.
 +	 */
 +	dwc3_core_soft_reset(dwc);
++	ret =3D dwc3_core_soft_reset(dwc);
++	if (ret)
++		return ret;
 +
 +	dwc3_event_buffers_setup(dwc);
 +	__dwc3_gadget_start(dwc);
 +	return dwc3_gadget_run_stop(dwc, true);
 +}
 +
  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
  {
  	struct dwc3		*dwc =3D gadget_to_dwc(g);

--Sig_/X4OBLMXhdWLp_/7nqeqQWoZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhmmwACgkQAVBC80lX
0Gw4Jwf+PAfCqjjWkX1KLNnY0k4raSlKkT5c2VdCEZXaE5w+zAf8vhal9XNl4m1v
7tz2RiqWkWiw/4r4Q4k6NkXB85r4Am0wWsI+xEQ6LXHs+ZnI8IO1NsMloVPgo6HP
RZZmKV7blAJrxNa5dGBhXSzKj5USLEnK4ZvbatEjRvZc+E9KXjBJTPuXSjBP4HyX
ic25IZ8jhhtmJdqZ+V2841ll7qc2v3w6AurhPv6CctmEPq6AuSRe1eIx4OL6xc/J
6cHNpxJvHXLL1ad2/l/5DbiGal4Ag7ccBAbw0jgt2WU8KRT2PqJcszg7q4Vx+VPw
TrMz+EHNQRPpunHjDF9dsKgcDwHkwQ==
=RzRF
-----END PGP SIGNATURE-----

--Sig_/X4OBLMXhdWLp_/7nqeqQWoZ--
