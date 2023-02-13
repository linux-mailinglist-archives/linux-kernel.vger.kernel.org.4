Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F641693CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBMCzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMCzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:55:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCC0CDE4;
        Sun, 12 Feb 2023 18:55:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFTV265gFz4wgv;
        Mon, 13 Feb 2023 13:55:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676256923;
        bh=hRgej+cb0PonsHuSv7DShfsVANS44C9EXcXfNgC2cJo=;
        h=Date:From:To:Cc:Subject:From;
        b=nLfODpBRSvUeAAn8A62UihapWCXEZpT9MEIivfks9NtceqYLzkTeNP8DeLzToNJ3v
         J+pHAW2gcpC3q6cEd5YqQ8QuodgUiuv6Wrt7/DzRk+oWmVpVLRaHXAjo5SAvJikM0k
         CzZhsIuodtKXWJYeLz7Oxed1/xzBdXaW+3j2GISdyQ2Fu4f0TT8NtZjpJ7hLOb+nEF
         QCf/++8nl0zeW7d0kgaRoczYeX10fdpxz7DHgEcwJpSUJlsxyS/rluiGxKnj/89nIc
         o6nHkS34IvM/rdxcGh6KodSy3x5ZWqs+Kp3Eb0kW8ogL6fwq+FcrS7myY2TnhnbSZE
         ZjyHin9nAryfQ==
Date:   Mon, 13 Feb 2023 13:55:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the phy-next tree
Message-ID: <20230213135521.6ebc410b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JjMfFhe.B7wC+oUKFGTBNkK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JjMfFhe.B7wC+oUKFGTBNkK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the phy-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/phy/qualcomm/phy-qcom-snps-eusb2.c: In function 'qcom_snps_eusb2_hs=
phy_write_mask':
drivers/phy/qualcomm/phy-qcom-snps-eusb2.c:147:15: error: implicit declarat=
ion of function 'readl_relaxed' [-Werror=3Dimplicit-function-declaration]
  147 |         reg =3D readl_relaxed(base + offset);
      |               ^~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-snps-eusb2.c:150:9: error: implicit declarati=
on of function 'writel_relaxed' [-Werror=3Dimplicit-function-declaration]
  150 |         writel_relaxed(reg, base + offset);
      |         ^~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-snps-eusb2.c: In function 'qcom_eusb2_default=
_parameters':
drivers/phy/qualcomm/phy-qcom-snps-eusb2.c:161:42: error: implicit declarat=
ion of function 'FIELD_PREP' [-Werror=3Dimplicit-function-declaration]
  161 |                                          FIELD_PREP(PHY_CFG_TX_PREE=
MP_TUNE_MASK, 0));
      |                                          ^~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  80090810f5d3 ("phy: qcom: Add QCOM SNPS eUSB2 driver")

I have used the phy-next tree from next-20230210 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/JjMfFhe.B7wC+oUKFGTBNkK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPpppkACgkQAVBC80lX
0Gy7VwgAmbxw26Talb9YO6PlxuOyGmPc3g457297iHMfQwovNmGy1DeWS0UsscrO
keAAA2qUncrLjpCG8vtjo3xRMI7jEk7ivVQDjP2Iy9mrg0k8dWRttD2oqsdjro+l
Va6YYQpdFtJ1kkXtRnapozIFyuG2E58YiEEU/DVgUj+Zg7AzLaEkjrdnyi5LSMP2
ttaq4g3xSgk2rLfcP9YOwCQiVdtFZR4Z5tWv541MnfEXrWggio0qg83ZeX/xKvZe
R6IHNQQChWIkEwWIsbjn1pegcGsk99ObJ9RYKH1bmHCeCtJWgEcULKfa6XkBRbdI
GOIxlUVsYyJVhqmTwaRalDpyMCIpzQ==
=CHpB
-----END PGP SIGNATURE-----

--Sig_/JjMfFhe.B7wC+oUKFGTBNkK--
