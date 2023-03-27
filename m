Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D86C9AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC0FMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjC0FM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:12:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B505262;
        Sun, 26 Mar 2023 22:12:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlLXf4yQ0z4x5c;
        Mon, 27 Mar 2023 16:12:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679893938;
        bh=NmVwBuNMuoG+achc19MswavOU5HtJpHUdNA2NB7aQz8=;
        h=Date:From:To:Cc:Subject:From;
        b=uuJ+JrYswWIlpt+GNgeEbWRQC0IuZaRjCRSou3kD+Zsx3UXa37tAG7oEKc5PraMF2
         7EDDuiYr3RDgdTfq/d/++R5MAmA07GE2XTZ9xPZQa/wZM7MsJvzJY79ikLfoT+pFRs
         EGfiUoF/jNpFKYl0YDfEdblW1WdsXHBMKIGB8sQ0xZvNrCvir6KDkemZbz2OgkFZKB
         VwT/8yi14O3I4Z12LCyHESR1ZRlh0P7tZBQtSvc77t0CK58CTULIlvH2djPcjMDH4j
         bliguqJaLmcytZjQsjKbJoCef+sH+W4s1RDRV91ExlInkuKw4ZckNsjFCWP1TBP+tv
         R2Mt8XattaL4Q==
Date:   Mon, 27 Mar 2023 16:12:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mips tree
Message-ID: <20230327161217.7cc4b439@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uPpYLtJqbGBuvCx5WFUe/Yj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uPpYLtJqbGBuvCx5WFUe/Yj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mips tree, today's linux-next build (mips
cavium_octeon_defconfig) failed like this:

arch/mips/cavium-octeon/octeon-irq.c:2893:35: error: assignment to =E2=80=
=98u64=E2=80=99 {aka =E2=80=98long long unsigned int=E2=80=99} from =E2=80=
=98void *=E2=80=99 makes integer from pointer without a cast [-Werror=3Dint=
-conversion]

(reported here: https://linux.kernelci.org/build/id/6420fc4409ffd05fb69c951=
a/logs/)

Caused by commit

  ed6a0b6e9fd7 ("MIPS: octeon: Use of_address_to_resource()")

--=20
Cheers,
Stephen Rothwell

--Sig_/uPpYLtJqbGBuvCx5WFUe/Yj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQhJbEACgkQAVBC80lX
0Gy5QQf/UYmwkLBKKOEK2XjWHjJFg499M5mG+t30MPjFB141UZsc/6ifm/NzbdPb
hGGn+EB1Vhz7Na0e/720GwefDanIZpfapHxeAPQPwrcyI/JYz0b8AsYVmBh30xlD
9UQARNRXHXpqCVmJGCftslK0cvARG/JQXpsftAlBnzr5TDFEymq/1jwBvqY9L2E6
yTIeytGB0W7DrLh4x+rK+gwceSI/omVn6NJpPgMozGGfeeV/506CCiJ0Syga3XXE
J7BcwrV/hd+bo91/95XdUTc4fdBv+z38SlXtRiwTtAYQYexXT0FI9FEZG9s5KMG7
3YdZusQPJITEBJ/mB+MCyCMKSm0rRg==
=RdTd
-----END PGP SIGNATURE-----

--Sig_/uPpYLtJqbGBuvCx5WFUe/Yj--
