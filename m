Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7246D3EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjDCIQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:16:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75EFAF1C;
        Mon,  3 Apr 2023 01:15:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqkHG6TFHz4xFj;
        Mon,  3 Apr 2023 18:15:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680509755;
        bh=Q2R8Dot9lOgfCR3BJoYVs7FXCpjz1nOl+0DsGoZait4=;
        h=Date:From:To:Cc:Subject:From;
        b=c+XVBGDMaK8MrO6IGSvgSsDSR+kSZ5kr6DTpwUdvWsy+MNndoCDRiqEc/jD5SC7N0
         uhS2IhtVYNpUCDrS1fnBaIFH5jWwuPxWjZFuXhstqoKkQxqaON3fwoTRoMAMGgQk2p
         pfK2WoLjXz7NBifywH35cvukBJxz1Unk6iopm15RuZNkqtPYWmsIXat+oF4KDKCHC1
         JDusUJyP4QmdCYfWxIq8uuVTJhkNbSGhFbp2b06ijQbZsyAMnnOuuWDBfCYjRHJxzs
         v52dt06xzNk5rfQ3WlT6eyxHR/Vn4ywh7kadAqYtfndhjA7zAmkYEaALYu1c3jJxsX
         WGjQJ/gMNL05g==
Date:   Mon, 3 Apr 2023 18:15:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mediatek tree
Message-ID: <20230403181552.607a8b64@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/95aa3W4Sir8AnNa+cGlkH8d";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/95aa3W4Sir8AnNa+cGlkH8d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mediatek tree, today's linux-next build (arm64
defconfig) failed like this:

aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_mm=
sys_update_bits':
drivers/soc/mediatek/mtk-mmsys.c:147: undefined reference to `cmdq_pkt_writ=
e_mask'
aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_mm=
sys_probe':
drivers/soc/mediatek/mtk-mmsys.c:386: undefined reference to `cmdq_dev_get_=
client_reg'
aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mutex.o: in function `mtk_mu=
tex_enable_by_cmdq':
drivers/soc/mediatek/mtk-mutex.c:883: undefined reference to `cmdq_pkt_writ=
e'
aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mutex.o: in function `mtk_mu=
tex_probe':
drivers/soc/mediatek/mtk-mutex.c:1023: undefined reference to `cmdq_dev_get=
_client_reg'

Caused by commit

  b34884b4c878 ("soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_=
CMDQ)")

I have used the mediatek tree from next-20230331 for today.

There were also the following warnings:

arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:104.21-109.4: Warnin=
g (unit_address_format): /soc/i2c@11010000/accelerometer@0x10: unit name sh=
ould not have leading "0x"
arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:111.20-114.4: Warnin=
g (unit_address_format): /soc/i2c@11010000/magnetometer@0x12: unit name sho=
uld not have leading "0x"
arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:104.21-109.4: Warnin=
g (i2c_bus_reg): /soc/i2c@11010000/accelerometer@0x10: I2C bus unit address=
 format error, expected "10"
arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:111.20-114.4: Warnin=
g (i2c_bus_reg): /soc/i2c@11010000/magnetometer@0x12: I2C bus unit address =
format error, expected "12"

--=20
Cheers,
Stephen Rothwell

--Sig_/95aa3W4Sir8AnNa+cGlkH8d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqizgACgkQAVBC80lX
0GxoTAf9GFGRRE0fwnjtKsbJGJp/i9zy31ytzJkMewVHdASpZWs4QRijKiSVPIKQ
+e5+OV8KsKLHDo+JBmiUyTCFTKqPDz7yGQjJ3LwgX+LTs9GXxhjk39G6whvkdUZj
cMU19DsToRUzVDzW0D8Po8DVSwbZY5+8khKVr/ZfcUNYQomC3oLlKiPN81PZpZRf
Eob/alYCrdND/FWpONNOHd+754kIt8ZFRooc4poIQHvmpwPsde03VBG+c4aI1Ycb
p5WMqeK87Ap5f2vz2xCP+Ow4SIHu97+RiqD8iESOlPYU7Rfz9IOn3w5UJvQ0pdyN
VWwDDf1r6diSx/4ryGG8evoAn382IQ==
=JJ+I
-----END PGP SIGNATURE-----

--Sig_/95aa3W4Sir8AnNa+cGlkH8d--
