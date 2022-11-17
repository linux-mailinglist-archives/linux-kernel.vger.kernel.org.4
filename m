Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14862DD34
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiKQNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbiKQNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:50:45 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B01A821
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=1SUGJrSudNeiM56y5XJ36XguegUY
        X2Jqm0Nw1sNvWu8=; b=Rl9vJabtlm1xcK3gM7JQjLkSLWrKkV6GihBMsruBz7Ak
        d+HQcAMnVQAABvfRtkDJ4qgElGOzmpVJEH5PCrJAXbLKpsfZXZd9KMl4Hl/TkHnc
        oMYCfC1MqPPT2Gz6AbHdggThBOgGBs/kDrFJdJI6Y2nJ5rC8Mzu+y7Sou1yptlQ=
Received: (qmail 1293491 invoked from network); 17 Nov 2022 14:50:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Nov 2022 14:50:38 +0100
X-UD-Smtp-Session: l3s3148p1@cCXJ36rtzpVehh99
Date:   Thu, 17 Nov 2022 14:50:38 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Teppei Kamijou <teppei.kamijou.yb@renesas.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>,
        Chris Ball <cjb@laptop.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] mmc: sh_mmcif: Add check for NULL for host->chan_yx and
 host->chan_rx in sh_mmcif_end_cmd
Message-ID: <Y3Y8LvvaOQ/n7pg9@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Anastasia Belova <abelova@astralinux.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Teppei Kamijou <teppei.kamijou.yb@renesas.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>,
        Chris Ball <cjb@laptop.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lvc-project@linuxtesting.org
References: <20221117123007.13071-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqyIQIYOFD+6jl/f"
Content-Disposition: inline
In-Reply-To: <20221117123007.13071-1-abelova@astralinux.ru>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nqyIQIYOFD+6jl/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 03:30:07PM +0300, Anastasia Belova wrote:
> Without these checks NULL-pointer may be dereferenced in
> sh_mmcif_end_cmd parameters inside if (data->flags & MMC_DATA_READ).
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Is there a code path actually triggering it? I wonder because it seems
to me the check for valid channels is already done a little above when
DMA is started. And I'd assume once DMA has been started we can take for
granted that we have a valid channel when unmapping. But maybe I am
missing some error codepath?


--nqyIQIYOFD+6jl/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmN2PCkACgkQFA3kzBSg
Kbbs9hAAl+dK8Jq2FdvPUYK2U8h4bOOr+XZ+tAEGMibNs4Rm4onGruLDOb8oa1GR
vA9Qy2SvV8P5ev1aQYgn5pzNWc8UHAdg4iNOt4d3eZQvhcw+jTNW0JTMyUnwb2A2
Kfm8u+6hjYF3pwsvv2hDO/XiJQxleG8rhCVPqZtQcMPYuxrjh4BhEL4rtmBT1auC
5zCiLT0FHCic2XzMRrGwuaX5p/AgsZ79RwnHzwUl9N8muED31BeVDw6iGCjNYNxw
dUteqPU+YlRjytRJSbkOfsYjRM+Eq3P9GoUAcLtjsgVayvwmx5YgsUdh83mqsGXe
+I37UOAywYPAL8ejithAMX1du9oR8RXzUAJb0tvYcjmIDE7TC2llt2mVU3bi7ZQA
1b1e539VscSHXD117lPEGa78b0OIs6+fxetyG4aqsU2/up9jadv4KRP5qW2zW8cu
yVlU3ydsKD72JPiHqLWX0wOjEDyko0pojW7gTrJa8pSophMnaEgTqNVcvDb2DGDY
zNFwX0CceXeuKRK0TqdUodQpDtZrMcBRHwEbJUQwYEt3c1rmT8tatIqZvKLxicLm
QHYCvIq0TObSxnE9vhy86xbiPB2ngVXssw5eRcBZhHeB8CTef2Npbh9wuqtnVOzS
HP34Y9qoocP9V+RauqUb8Ex63V+dQInStJ8atpmVZRoxTqXNxEA=
=IGZL
-----END PGP SIGNATURE-----

--nqyIQIYOFD+6jl/f--
