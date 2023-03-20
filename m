Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3446C06E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCTAs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTAsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:48:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CBA1A651;
        Sun, 19 Mar 2023 17:48:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pfx1D6mPgz4whr;
        Mon, 20 Mar 2023 11:48:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679273297;
        bh=QcLIfaZPezFlMCQYfvgh1M5erf9QtnCKDR4foIcR2po=;
        h=Date:From:To:Cc:Subject:From;
        b=qeFCgw00UedFknB0zCGwXtTt7IoW/tqT4/e6YsTzkCawbLHo+j1OEHjMdX4dIfpOX
         UcsQxol3mNPbqopgTqdlzSajwvah/NfrQ1G2VRm/OD1b84j/2CZaCQsOTDVb0IJdQz
         XaQym/BM+z27evrFdU106svP6d1K490NNtaXEbO11G+gaQO40Tvp5ez+5Y1sJbr2hK
         ETI2mqeWic3lcahMbvD8M/6khw53BPzVS8Wl424aaZ55WDMiKaBvNMVSKvSfTGQRKZ
         y5iomJ0DwHmHihzeY9Yq9xwjHCJC28d2IaHEf4q0O2XekMnWc0rCCMdlRpqK9q91zJ
         E1euUvYzQOM1g==
Date:   Mon, 20 Mar 2023 11:48:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the leds-lj tree
Message-ID: <20230320114816.2abe5751@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/isvlHpMjxe2I3lD7Cg4I/iS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/isvlHpMjxe2I3lD7Cg4I/iS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the leds-lj tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/leds/rgb/leds-mt6370-rgb.c: In function 'mt6370_check_vendor_info':
drivers/leds/rgb/leds-mt6370-rgb.c:889:15: error: implicit declaration of f=
unction 'FIELD_GET' [-Werror=3Dimplicit-function-declaration]
  889 |         vid =3D FIELD_GET(MT6370_VENDOR_ID_MASK, devinfo);
      |               ^~~~~~~~~

Caused by commit

  55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type L=
ED Indicator support")

I have used the leds-lj tree from next-20230317 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/isvlHpMjxe2I3lD7Cg4I/iS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQXrVAACgkQAVBC80lX
0Gx3Vwf+MArjrV4EynLd3zfNyIyMIsvFZc4c+/6Ct7ovau0FdQg+CdEPHI+VCouY
v7tHRJs6z5pk0zNuOPfXq4PjMoKvtmD+oo+vB7KbPenaZFwxDDxsQNfAurjJ2Z7T
tTDMDCejGAgzJBKaiobKdMNzuH2wm44TvQk56UMJjduv3hp7v2qXMtEgEOBFXur3
XXIgfctbFhYsfJLKHdIvht6rvk8y6lqxHP16Roc4S97t2x8ujq27Y3ZYFensAqXJ
3LF4PU71Thk23YEBeYIAfL+DVxlpe6kVWrZw+DPL9HvBLO+0JARN6ZI5VkrriTTx
idU6xisv8RCLrrhVGQppvWK4nM3inw==
=m4bJ
-----END PGP SIGNATURE-----

--Sig_/isvlHpMjxe2I3lD7Cg4I/iS--
