Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4986B6C0A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCLWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:46:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389A30B2B;
        Sun, 12 Mar 2023 15:46:45 -0700 (PDT)
Received: from mercury (unknown [185.209.196.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 882006602F13;
        Sun, 12 Mar 2023 22:46:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678661204;
        bh=MTii68UXbEJyigv+rC2VJmnMysj4S0AVTawLMJCZCS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsnYAxtv9e6JLpZfb5Dh6vIuxwGi6XBcOoi+cGhRpXjQGEOi4v6Na7aPxWkoeMzjq
         +VMB3XsdTBJWlqX71AXg4hfnWbQVVyh9rftK/Q/x/s7CG72QEfgoAr1TdA7ERK88X0
         eSC1ISYLVd/6gu/EtBrG2/Hlx5iV7OSzUUt1bcsAPl0ZXWiKL69+lMhjYjEMe3rzlH
         jhoAIsr8235La7BGG9diUcAvZq8F6GOzo8x4JrtmfmAZUTK2nJ3Rd11geGW2ylsfAi
         8Azn8zp40SVP/sEk85IWOfnibsk90JaQnwsMuas1EPYA8qZkzPxiiA3vhvRZYWnL/Y
         v2efZhdtX2jOw==
Received: by mercury (Postfix, from userid 1000)
        id 0D2C41060FD4; Sun, 12 Mar 2023 23:46:42 +0100 (CET)
Date:   Sun, 12 Mar 2023 23:46:41 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <202303110050.1EF6YVC5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dx3tdltyysw5wcwj"
Content-Disposition: inline
In-Reply-To: <202303110050.1EF6YVC5-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dx3tdltyysw5wcwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bjorn,

Can you please send a follow up patch for the sparse warnings in
qcom_battmgr [0]? It looks like there are two issues:

1. qcom_battmgr_update_request.battery_id is u32 instead of __le32

2. qcom_battmgr_enable_worker is missing cpu_to_le32() when building
   struct qcom_battmgr_enable_request

[0] https://lore.kernel.org/all/202303110050.1EF6YVC5-lkp@intel.com/

> sparse warnings: (new ones prefixed by >>)
> >> drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] battery_id @@     got restricted __le32 [usertype] @@
>    drivers/power/supply/qcom_battmgr.c:357:31: sparse:     expected unsigned int [usertype] battery_id
>    drivers/power/supply/qcom_battmgr.c:357:31: sparse:     got restricted __le32 [usertype]
>    drivers/power/supply/qcom_battmgr.c:369:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] battery_id @@     got restricted __le32 [usertype] @@
>    drivers/power/supply/qcom_battmgr.c:369:31: sparse:     expected unsigned int [usertype] battery_id
>    drivers/power/supply/qcom_battmgr.c:369:31: sparse:     got restricted __le32 [usertype]
> >> drivers/power/supply/qcom_battmgr.c:1285:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] owner @@     got int @@
>    drivers/power/supply/qcom_battmgr.c:1285:30: sparse:     expected restricted __le32 [usertype] owner
>    drivers/power/supply/qcom_battmgr.c:1285:30: sparse:     got int
> >> drivers/power/supply/qcom_battmgr.c:1286:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] type @@     got int @@
>    drivers/power/supply/qcom_battmgr.c:1286:29: sparse:     expected restricted __le32 [usertype] type
>    drivers/power/supply/qcom_battmgr.c:1286:29: sparse:     got int
> >> drivers/power/supply/qcom_battmgr.c:1287:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] opcode @@     got int @@
>    drivers/power/supply/qcom_battmgr.c:1287:31: sparse:     expected restricted __le32 [usertype] opcode
>    drivers/power/supply/qcom_battmgr.c:1287:31: sparse:     got int

-- Sebastian

--dx3tdltyysw5wcwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQOVksACgkQ2O7X88g7
+por+A//RI7dYm0hzeTkTcP+T3pb09fz6dwlsWcoLmzi00a5gu2EhtN/UQjhAqEN
1slZ9k3PIfBzYFERJBSeIct6r9ysd8WP2e2XrL8ItMN/aGrdh9mYkd7l6vOZkrlb
b/aNyO1aNPVik+qZOzy3fgDLIObbQxfPzHZ9bBQNBycp4qMtLAQ2oS7FcwTlrJ18
pHhIKQ87kpf/u3rzR6V9iQguIoTgCKBKAg2bNUVjOveKKA2cmzRoLoB5R+Fc8Oke
VOlCKUYttwXB+zYTTSoPIxJIOy32kFNiLFt10F3BJbS2SdhmdmWz7zC/VKlJB0Eu
oVq8IvDzjBKWpT/+UB1c8lLBj8HJ52AT0J4VoweM3P+JWPuibhSx24FvsSEjPYzg
j5bRxr0mlHrK35hyTRGAYvOIInX7REaMYsC0Cgup5z1GmA6zQdPptsnSTURCOOxU
o+5H6qe3/++GqWXrd8xuoiXh5bzRVoLCo/fNg32536tdwMpQ2MkxSRZCaSUzCVbc
twP75tMqE1iI0bgybNHbgsjMxueh1WnGEdAYgs+NXIAx1FGc5oAjj8AAeuN0L/ou
vY/q20xEeXhb444Wc6ITadByYGsa9q/SQjglklJ98aRgVaus+oQn2H+RauL2HQSi
zzaQ5D6AB6XM5G7v5Txyh6Wq4wF7YSW+RJKj5ZyKHiNBsMfQX0o=
=bG3l
-----END PGP SIGNATURE-----

--dx3tdltyysw5wcwj--
