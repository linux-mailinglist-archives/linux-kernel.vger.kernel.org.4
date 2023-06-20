Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9B736804
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjFTJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFTJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:41:42 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475DFD1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=tfMpnnW+3guYPzLCJJ8Mv1jIbr4E
        bescqvJbvy3K258=; b=vTzTY9y2y1t3QEQl87oUYGiJc/omQ4j0dEIYhUMQUDo0
        r7izDzZBGAC5P/9pbRh/sgyreONoKIuonUgfwWtBTZItLaLfY/bULHYz0X9QXQad
        6DgidPwBltDuEBxX9tnP62I901rgByGlBxoGlw73/u/B/Nc/cyi1TxvRI3Y5Gys=
Received: (qmail 582700 invoked from network); 20 Jun 2023 11:41:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 11:41:39 +0200
X-UD-Smtp-Session: l3s3148p1@mvY8dYz+WpdehhtC
Date:   Tue, 20 Jun 2023 11:41:39 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] gnss: ubx: add support for the reset gpio
Message-ID: <ZJF0U/mIniEksVwZ@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-5-wsa+renesas@sang-engineering.com>
 <ZJFSjrf41PHe400c@hovoldconsulting.com>
 <ZJFsGWepuvkSjL9a@shikoro>
 <ZJFtdWK5I13YUUcu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TA9zqrB6i6FlXnUD"
Content-Disposition: inline
In-Reply-To: <ZJFtdWK5I13YUUcu@hovoldconsulting.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TA9zqrB6i6FlXnUD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> But can you elaborate on the "disappearing" bit? How exactly does it
> "disappear" when the gnss0 device is *not* opened?

When you send an I2C message with the address of the device, it usually
ACKs it to say "Hi, I am here". When the ublox device is in reset state,
it does not ACK its address. So, tools like "i2cdetect" will not report
the device as "someone is listening there".

Here is the i2cdetect output with the GNSS device open:

# i2cdetect -y -r 15
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --=20
10: 10 -- -- -- -- -- -- -- -- -- -- -- -- 1d -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
40: -- -- 42 -- -- -- -- -- -- -- -- -- -- -- -- UU=20
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- -- -- 6b -- -- -- --=20
70: -- UU -- -- UU UU -- --                        =20

And with the device closed. Note address 0x42 disappearing:

# i2cdetect -y -r 15
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --=20
10: 10 -- -- -- -- -- -- -- -- -- -- -- -- 1d -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU=20
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- -- -- 6b -- -- -- --=20
70: -- UU -- -- UU UU -- --                        =20


--TA9zqrB6i6FlXnUD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSRdE8ACgkQFA3kzBSg
KbarfA/+On0rLpkEJ+z3vMEgM7eJICiUy+MeY3d/u7A2Ryur9LhIFz8UmqJYxovG
kTk7Au9WjjnkGKmpNi3lLT0TQEp7HipluRrlKo/uwnedeI2KMrb00qEh1rQUDPn9
Lhj1Q0OhvmrmKEBvypihc47r2ePPPzTNk2HCqhtW3uIBg369zkwKoqudDTPBHw8q
SxJbb92mtUAssqh8rjiqzEQvEwr2y8xYDO30VHJefzWIuazUM4TCwN8OqtSHp+0y
VyVvmG1pSjjDZuAFT13VpmI6/6hABlivVWQT70U4ShnUIL1hBo8ePBF/ehwKa7RH
P+VayQ3eFzGx60IyDPTNJ+hDxwWRXVsNotO472cs3fmg/Nobvs/dN85us4oA61AR
cHZ8CkjQOdwP6w/jsOxg/uZjyoNqANckC1jq848eoCk9nNNgO8G74nG/RYBIH9uA
phpMlgTv5UcHvD6MyN1Vh431SpapYUVdleiMasd/cjP4yq8rKJbrAWI4JKcYpa4y
Qpd+im6XPS0TNZhQQehYFJJJ5aZyCSeVD2cG+SQxKGWCYD1Ce0ZOwSYU3cLNhZIM
Vf5J2zXps5PwGlCjr129Ut+vOfkmDdANiFWxnxALqZjDY0sAhGAritm2XvgXiV3s
BZIMhNQSz0NdW/2FS6YQQnP1cQrGWBGlVu/gev9JLw7wrGtCNSw=
=8voC
-----END PGP SIGNATURE-----

--TA9zqrB6i6FlXnUD--
