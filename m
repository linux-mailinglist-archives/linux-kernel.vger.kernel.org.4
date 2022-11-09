Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB662221C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKICq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKICqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:46:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FF612AF2;
        Tue,  8 Nov 2022 18:46:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N6TrQ2Z28z4xYV;
        Wed,  9 Nov 2022 13:46:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667962007;
        bh=pA20xVz3b69bYSk53jc1p+5JifPGTd7CJByWk/tyL/c=;
        h=Date:From:To:Cc:Subject:From;
        b=LbIo/6Mscwc6KVypUngwj/Qk3ytOHB6HIWS2NWoLA4tB8++j/QZJT1sfrf9GGM4XF
         q8jTq2yDRR7LhZsiuYZ12jZQMEWWQlDMSC5MHKvIt8fzi+Tw9zZzDH7KND4SE7G+1U
         azC42aX5GzLswdvWtBvp9/ymv5M/5tJF9pKPN74zJTAbKzL6Gi2DUCTJKYssjDCTGs
         wS2QTSiaRARMZN1sfxJoouUoo3JhrSc2REOEw1gwqNfdsSZBzWxiBofPAT0hdbXuhO
         F2AiPHMmKX5zXfv4+BLt+FoTGBxL2OJxmvFFOum58Q0lg2lKVGkrWBsd8Ku4AkDVPA
         VcXdF5TEVGQjQ==
Date:   Wed, 9 Nov 2022 13:46:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20221109134644.1621f1e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ceD9C=eKPHSohzaVTJ_mWnZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ceD9C=eKPHSohzaVTJ_mWnZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/pinctrl/pinctrl-loongson2.c:42:29: error: field 'desc' has incomple=
te type
   42 |         struct pinctrl_desc desc;
      |                             ^~~~
drivers/pinctrl/pinctrl-loongson2.c:63:38: error: array type has incomplete=
 element type 'struct pinctrl_pin_desc'
   63 | static const struct pinctrl_pin_desc loongson2_pctrl_pins[] =3D {
      |                                      ^~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:62:26: error: implicit declaration of f=
unction 'PINCTRL_PIN' [-Werror=3Dimplicit-function-declaration]
   62 | #define LOONGSON2_PIN(x) PINCTRL_PIN(x, "gpio"#x)
      |                          ^~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:64:9: note: in expansion of macro 'LOON=
GSON2_PIN'
   64 |         LOONGSON2_PIN(0),  LOONGSON2_PIN(1),  LOONGSON2_PIN(2),  LO=
ONGSON2_PIN(3),
      |         ^~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c: In function 'loongson2_pin_dbg_show':
drivers/pinctrl/pinctrl-loongson2.c:208:9: error: implicit declaration of f=
unction 'seq_printf'; did you mean 'bstr_printf'? [-Werror=3Dimplicit-funct=
ion-declaration]
  208 |         seq_printf(s, " %s", dev_name(pcdev->dev));
      |         ^~~~~~~~~~
      |         bstr_printf
drivers/pinctrl/pinctrl-loongson2.c: At top level:
drivers/pinctrl/pinctrl-loongson2.c:211:21: error: variable 'loongson2_pctr=
l_ops' has initializer but incomplete type
  211 | static const struct pinctrl_ops loongson2_pctrl_ops =3D {
      |                     ^~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:212:10: error: 'const struct pinctrl_op=
s' has no member named 'get_groups_count'
  212 |         .get_groups_count       =3D loongson2_get_groups_count,
      |          ^~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:212:35: error: excess elements in struc=
t initializer [-Werror]
  212 |         .get_groups_count       =3D loongson2_get_groups_count,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:212:35: note: (near initialization for =
'loongson2_pctrl_ops')
drivers/pinctrl/pinctrl-loongson2.c:213:10: error: 'const struct pinctrl_op=
s' has no member named 'get_group_name'
  213 |         .get_group_name         =3D loongson2_get_group_name,
      |          ^~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:213:35: error: excess elements in struc=
t initializer [-Werror]
  213 |         .get_group_name         =3D loongson2_get_group_name,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:213:35: note: (near initialization for =
'loongson2_pctrl_ops')
drivers/pinctrl/pinctrl-loongson2.c:214:10: error: 'const struct pinctrl_op=
s' has no member named 'get_group_pins'
  214 |         .get_group_pins         =3D loongson2_get_group_pins,
      |          ^~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:214:35: error: excess elements in struc=
t initializer [-Werror]
  214 |         .get_group_pins         =3D loongson2_get_group_pins,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:214:35: note: (near initialization for =
'loongson2_pctrl_ops')
drivers/pinctrl/pinctrl-loongson2.c:215:10: error: 'const struct pinctrl_op=
s' has no member named 'dt_node_to_map'
  215 |         .dt_node_to_map         =3D pinconf_generic_dt_node_to_map_=
all,
      |          ^~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:215:35: error: excess elements in struc=
t initializer [-Werror]
  215 |         .dt_node_to_map         =3D pinconf_generic_dt_node_to_map_=
all,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:215:35: note: (near initialization for =
'loongson2_pctrl_ops')
drivers/pinctrl/pinctrl-loongson2.c:216:10: error: 'const struct pinctrl_op=
s' has no member named 'dt_free_map'
  216 |         .dt_free_map            =3D pinctrl_utils_free_map,
      |          ^~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:216:35: error: excess elements in struc=
t initializer [-Werror]
  216 |         .dt_free_map            =3D pinctrl_utils_free_map,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:216:35: note: (near initialization for =
'loongson2_pctrl_ops')
drivers/pinctrl/pinctrl-loongson2.c:217:10: error: 'const struct pinctrl_op=
s' has no member named 'pin_dbg_show'
  217 |         .pin_dbg_show           =3D loongson2_pin_dbg_show,
      |          ^~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:217:35: error: excess elements in struc=
t initializer [-Werror]
  217 |         .pin_dbg_show           =3D loongson2_pin_dbg_show,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:217:35: note: (near initialization for =
'loongson2_pctrl_ops')
drivers/pinctrl/pinctrl-loongson2.c: In function 'loongson2_pmx_set_mux':
drivers/pinctrl/pinctrl-loongson2.c:223:43: error: implicit declaration of =
function 'pinctrl_dev_get_drvdata'; did you mean 'dev_get_drvdata'? [-Werro=
r=3Dimplicit-function-declaration]
  223 |         struct loongson2_pinctrl *pctrl =3D pinctrl_dev_get_drvdata=
(pcdev);
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~
      |                                           dev_get_drvdata
drivers/pinctrl/pinctrl-loongson2.c:223:43: error: initialization of 'struc=
t loongson2_pinctrl *' from 'int' makes pointer from integer without a cast=
 [-Werror=3Dint-conversion]
In file included from include/linux/container_of.h:5,
                 from include/linux/list.h:5,
                 from include/linux/module.h:12,
                 from drivers/pinctrl/pinctrl-loongson2.c:9:
drivers/pinctrl/pinctrl-loongson2.c: In function 'loongson2_pinctrl_probe':
include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not a=
n integer constant
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); }=
)))
      |                                                   ^
include/linux/compiler.h:232:33: note: in expansion of macro 'BUILD_BUG_ON_=
ZERO'
  232 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), =
&(a)[0]))
      |                                 ^~~~~~~~~~~~~~~~~
include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
   55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be=
_array(arr))
      |                                                           ^~~~~~~~~=
~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:294:35: note: in expansion of macro 'AR=
RAY_SIZE'
  294 |         pctrl->desc.npins       =3D ARRAY_SIZE(loongson2_pctrl_pins=
);
      |                                   ^~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:296:24: error: implicit declaration of =
function 'devm_pinctrl_register'; did you mean 'device_register'? [-Werror=
=3Dimplicit-function-declaration]
  296 |         pctrl->pcdev =3D devm_pinctrl_register(pctrl->dev, &pctrl->=
desc, pctrl);
      |                        ^~~~~~~~~~~~~~~~~~~~~
      |                        device_register
drivers/pinctrl/pinctrl-loongson2.c: At top level:
drivers/pinctrl/pinctrl-loongson2.c:211:33: error: storage size of 'loongso=
n2_pctrl_ops' isn't known
  211 | static const struct pinctrl_ops loongson2_pctrl_ops =3D {
      |                                 ^~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-loongson2.c:63:38: error: 'loongson2_pctrl_pins' de=
fined but not used [-Werror=3Dunused-variable]
   63 | static const struct pinctrl_pin_desc loongson2_pctrl_pins[] =3D {
      |                                      ^~~~~~~~~~~~~~~~~~~~

Caused by commit

  6c2a0a800390 ("pinctrl: pinctrl-loongson2: add pinctrl driver support")

I have used the pinctrl tree from next-20221108 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ceD9C=eKPHSohzaVTJ_mWnZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNrFJQACgkQAVBC80lX
0GzOOgf+NxCmUJffEDciiXB/8Wt4NAHET/l33iW9hGcguUHi7nLv2IK5ONzJ8n96
rWMVV8FdEBiTPlyWd9w2S6SfzCFl34amye0xNBJJfkOWsGZkSnaVNEWXh+aE7C+M
1EKllV4KnFSU5q9WIz+H1T2JvIhLKEkCNiO6m2Lfx99WUajZfY3DKv+WpntqdT22
Eee80ZQm4rhmHPpD9mnV8lydTI0vFvv4tF/lFu8cC+FOaXejvwvV/73IL/nwSiec
sXpz6xInpej/sfFRfStjZCN0AoGAaRllrCgK+cdxIXCy8FkQi5kbN3qPiNHsBwS6
3MT+/YMOXHpyE5t5dZBQjTkY0g5SaQ==
=/6As
-----END PGP SIGNATURE-----

--Sig_/ceD9C=eKPHSohzaVTJ_mWnZ--
