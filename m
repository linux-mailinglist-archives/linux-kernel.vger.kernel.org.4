Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087606DCE20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDJXbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDJXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:31:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33909270E;
        Mon, 10 Apr 2023 16:31:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwQGV2Kmfz4xGq;
        Tue, 11 Apr 2023 09:31:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681169490;
        bh=RbVWEK+110cXCUfBhP97yyMLZqmw6pdjtluBHUH3vM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yt+rjD7rgTWj00+HuR1wchs9+Pc5iw1aozLfQrVlf/SOW7z2PG2sgqUSZ3tdltTYe
         PY09SLRFlJU74yixqX6yZUBCVZfZN2XpgQ4We06dTviRM/IOtsdE8agpwaU3dKJJjo
         pXRNHga+bq+wTb/QjywEmZOYtA+8PphJLNZ2pd327BUOKCjElCNrT+4TxOGw7pfgcJ
         CiOPfsniFZfMOMTza9/EYUF4RzyLHyIwS4r9tX+XteRzk6xMx19digzbygQ4j+UuYv
         JDY/sy//3oo4HPrI970vOrTD8xXPbp4yU+JujEQrC6bNo+QlxnuEjx0Ve1o8pIZSig
         cQtjVPIbpmrFA==
Date:   Tue, 11 Apr 2023 09:25:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mediatek tree
Message-ID: <20230411092522.6380fa88@canb.auug.org.au>
In-Reply-To: <20230403181552.607a8b64@canb.auug.org.au>
References: <20230403181552.607a8b64@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gIh2U5XJYbniFn0tQjO8cBg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gIh2U5XJYbniFn0tQjO8cBg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 3 Apr 2023 18:15:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the mediatek tree, today's linux-next build (arm64
> defconfig) failed like this:
>=20
> aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_=
mmsys_update_bits':
> drivers/soc/mediatek/mtk-mmsys.c:147: undefined reference to `cmdq_pkt_wr=
ite_mask'
> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_=
mmsys_probe':
> drivers/soc/mediatek/mtk-mmsys.c:386: undefined reference to `cmdq_dev_ge=
t_client_reg'
> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mutex.o: in function `mtk_=
mutex_enable_by_cmdq':
> drivers/soc/mediatek/mtk-mutex.c:883: undefined reference to `cmdq_pkt_wr=
ite'
> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mutex.o: in function `mtk_=
mutex_probe':
> drivers/soc/mediatek/mtk-mutex.c:1023: undefined reference to `cmdq_dev_g=
et_client_reg'
>=20
> Caused by commit
>=20
>   b34884b4c878 ("soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MT=
K_CMDQ)")
>=20
> I have used the mediatek tree from next-20230331 for today.
>=20
> There were also the following warnings:
>=20
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:104.21-109.4: Warn=
ing (unit_address_format): /soc/i2c@11010000/accelerometer@0x10: unit name =
should not have leading "0x"
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:111.20-114.4: Warn=
ing (unit_address_format): /soc/i2c@11010000/magnetometer@0x12: unit name s=
hould not have leading "0x"
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:104.21-109.4: Warn=
ing (i2c_bus_reg): /soc/i2c@11010000/accelerometer@0x10: I2C bus unit addre=
ss format error, expected "10"
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:111.20-114.4: Warn=
ing (i2c_bus_reg): /soc/i2c@11010000/magnetometer@0x12: I2C bus unit addres=
s format error, expected "12"

Ping?

--=20
Cheers,
Stephen Rothwell

--Sig_/gIh2U5XJYbniFn0tQjO8cBg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ0muIACgkQAVBC80lX
0Gzm0wf/YA+bOr/iNHbMRfFBpSeetmwzmY4i6HofVVuPe/he5FxChlxDSUYEkylv
9pfIOW4NnOFyxS9LzNmRq0Iy/6gmuLBrQRdHyipKgPCromZA6Xkdw8YC1caRQzsU
rhqIgj/md97jUAowcYADoEM45ax6z1QVd9x8mD0qv0s0O7g5CSrSoK4G3Ude2K0D
mo0HblPFdu8n9CWNxXEYkafxeAuQVuxg+9ju4GKR/XK93NtK2lZkerBtmuz0S5Wq
yMNNKzBHi4RzLs4lH6YaGLUjcMBdhGGYx5+OLtsZp2yd9ncbGyU1i1jjFHziboCk
4rFu9umaQjouJDj2bCbEIoOr74I7Rg==
=5q6k
-----END PGP SIGNATURE-----

--Sig_/gIh2U5XJYbniFn0tQjO8cBg--
