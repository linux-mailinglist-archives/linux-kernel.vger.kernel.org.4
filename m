Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5CE6D3B05
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 01:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDBX7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 19:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjDBX7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 19:59:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6F5241;
        Sun,  2 Apr 2023 16:59:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqWGj2Lq4z4x1d;
        Mon,  3 Apr 2023 09:59:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680479982;
        bh=BCqdPfGxR3iXmxIIQroDKtqaoRU4eM/i8SKEIAgbIBU=;
        h=Date:From:To:Cc:Subject:From;
        b=TKsonUC+kXomeRwiuUMwGOvrmimWhlOaKoHEqmPYqsYmVhTYq+WEWe0n4B91iO5Ch
         I9K3TRl2Eo3vke2uK61cVJUI4AUQWCz+5HuGhuOEq+krM8rszuS1VPh85lczLOlkks
         I14AjGACBgNC6dx7Z6QHlCPAowZYwy43kzt7bJI+BfKX8CpisrtBytdtm8VPW2INZR
         EDI6tvQYO7EFpkC2fhdZreSWdrDML0tXE+o7OXnDDoEKdcmCSt2j6ATjQ6I8QT5Orq
         121nczKqFRlR8PZnXbDpb8THQulSUIx1OgPkHOUw/IkmyQVHLjo+KKSk7HTbKIu1wE
         OkFgBhhw4IOEQ==
Date:   Mon, 3 Apr 2023 09:59:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the clk tree
Message-ID: <20230403095939.423806fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EUcM.HxKayhTipK6IvJl7zZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EUcM.HxKayhTipK6IvJl7zZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clk tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from include/linux/device/driver.h:21,
                 from include/linux/device.h:32,
                 from include/linux/platform_device.h:13,
                 from drivers/clk/mediatek/clk-mt8188-wpe.c:9:
drivers/clk/mediatek/clk-mt8188-wpe.c:91:31: error: 'clk_mt8188_vpp1_id_tab=
le' undeclared here (not in a function)
   91 | MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~
include/linux/module.h:243:15: note: in definition of macro 'MODULE_DEVICE_=
TABLE'
  243 | extern typeof(name) __mod_##type##__##name##_device_table          =
     \
      |               ^~~~
include/linux/module.h:243:21: error: '__mod_platform__clk_mt8188_vpp1_id_t=
able_device_table' aliased to undefined symbol 'clk_mt8188_vpp1_id_table'
  243 | extern typeof(name) __mod_##type##__##name##_device_table          =
     \
      |                     ^~~~~~
drivers/clk/mediatek/clk-mt8188-wpe.c:91:1: note: in expansion of macro 'MO=
DULE_DEVICE_TABLE'
   91 | MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
      | ^~~~~~~~~~~~~~~~~~~

Caused by commit

  f42b9e9a43e3 ("clk: mediatek: Add MT8188 wpesys clock support")

I have used the clk tree from next-20230331 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/EUcM.HxKayhTipK6IvJl7zZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqFuwACgkQAVBC80lX
0GxZlQgApgR6zgP+URPXuMmB4/LBfktsX0xBYjRjRZvgJhS1n0mumL7mbbYp6nTb
JWbVbMn6pzMgfxWWKS7qbCQ2QPkr/slrAhKkOQ721SgYJ9pkGZcWad6cyB2DtOh1
JoLslFCPQMm3e5rlXizLN6gVm80gKcVDDxrjioVAfPLuDAxGyCbCREVXJ9+yVMnK
IU52SaOVqbDM3lUvyI3dWu0aFFzYcSqfWF773+A2IHpS0I0LHMguU8UbcuVLuB4y
kyPoebmu/D7PBLTR8bBQF9vMLcsTHW+fEsdLaVEPJlKePuUboTaGXoPDEjJosa0F
/A1oSdPBJ1K0W5tKCbSV4grl33Wdsg==
=sU6l
-----END PGP SIGNATURE-----

--Sig_/EUcM.HxKayhTipK6IvJl7zZ--
