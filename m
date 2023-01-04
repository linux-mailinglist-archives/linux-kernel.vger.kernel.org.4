Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036CF65DA4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbjADQnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjADQlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:41:51 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0981A071;
        Wed,  4 Jan 2023 08:41:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so21283390wmk.4;
        Wed, 04 Jan 2023 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbzxU5euIcxEABo/okhvZ+7+gLeYJigIQ++SaV23kN8=;
        b=Vv3SD/+KX93KfiwpGZ2JyRm5eOsHlgBrfkK9R/wKbwSmkonHYwdmMF6VYTVWObb1uf
         TuhS4DJiP0NhWIJtzUJOAVk7/kYSOCWdHu+voz4fToJ0VSqW8eJ4/2eT6Bw637KrxzpS
         imtDxuJ49Y1W9xidm/600C85oB92+BRHuK/JMHkYQm3hR/O4EoTyqH1C0SkPROQh875u
         xqU1fzC+m25JIue+IpN9DY5vggwiQbL0Prs3ZyQWroeVML4ll9KFgsctTkktxIA6SUiZ
         h0HGbUtCk3tibWlkRc5yjvxeVsnSUkTmCPWOMI7Nsb0bVcdJjsO8yqobT9286G5XS4ZY
         N03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbzxU5euIcxEABo/okhvZ+7+gLeYJigIQ++SaV23kN8=;
        b=x7L3PPmqG6aHbUjx+3yt4FN/Woa+Hx4OOxZj7ZrP/I1LBTcBPI4puPlxktYNesKHkV
         O/umVw7qfHRdgTzx7cuP9rGO5rsKMs0Zk9K73soFCbcZskQDpv443kRnjBNeCtUBMILy
         qRFuCNuqzlVlUelHXZ4rHttao1EIVju8vBhkpEx7NsEAp3oZCHUWl23uKGXTuaCktOMF
         28JlmYzeFMZJBQR5HBP/4GvHfLjeyMbF4TMqKx3rr9dIX4cX4RVkCSZMsB3Kl0hmKE/W
         1qcHe32KoMOL3kWSbrzZuXVSavu774HFWmrYbcg8SgsszarotVDrbnuoCfEwYfYDXZ8G
         XWgQ==
X-Gm-Message-State: AFqh2ko7xRMC1tekrLiVI2D51ydGrb2uI+lTD1bbAPEDdqKecOh/KSXQ
        oYRlMRVJJctHOjKcr1JBXUo=
X-Google-Smtp-Source: AMrXdXvBPs18VPwQsd5vdpo+q/HiSisve1cs2s1GpS8cGdAmMYHcGVo5cmfq3uskXw1KNnf2ultFnQ==
X-Received: by 2002:a1c:7c0f:0:b0:3d5:816e:2fb2 with SMTP id x15-20020a1c7c0f000000b003d5816e2fb2mr36816947wmc.14.1672850508975;
        Wed, 04 Jan 2023 08:41:48 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b003d973d4fb28sm40202364wms.4.2023.01.04.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:41:48 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:41:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [rft, PATCH v4 0/3] gpiolib: eventual of_node retirement
Message-ID: <Y7WsSh6RCNGIgml4@orome>
References: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6P9QVOoCHcJjesZE"
Content-Disposition: inline
In-Reply-To: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6P9QVOoCHcJjesZE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 11:20:42AM +0200, Andy Shevchenko wrote:
> Now that all GPIO library users are converted to use fwnode,
> Drop redundant field from struct gpio_chip and accompanying
> code.
>=20
> Bart, I prefer this series to go as soon as possible if you
> have no objection. Or even as v6.2 material.
>=20
> Thierry, can you please test it once again, so we will be sure
> there is no breakage for OF platforms?

Seems to be working fine on at least Jetson TX1, so:

Tested-by: Thierry Reding <treding@nvidia.com>

--6P9QVOoCHcJjesZE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmO1rEoACgkQ3SOs138+
s6FeRRAAkybdKFdnyI1ieZLySlXbFjVHf1PXM0FLsrllv4w6gRH4oZGhBk0AboDT
0t24iTezsN1sRPSwzPGeqIELjtwi2c8w3/nY3ijVirRvQCFiuMjGUkh55323ayK/
ZLb7Y6+kUniwzfmvBDw3hGdUeGWuN6x9fX+5VldL3BZ+GpZ6EZwAQaSwa0SQuY85
QuLLP87qSn2yv8q3yxtQa6bJ0a4Mmp7m99hFdae5qET71/ryJsWrcs5MdwcHtuSX
W3MhecG9TiAYTaWBF8W5LEeBGJdyTzyCnoBDVNAq9vJy7X1sc8pMlY4VLTXPq4hG
qj6wDGvc1/ScCBSBZ2X0UGsg/0/VN5COXj6p2KNrj/Gs4GjJJZQe/jj+K74KUX+O
qIncihz1YI/70Yj9ZY49HcNKlL88/6W1jcUM6FSAmINEnw6loQK4HVVRu7dvVLbh
CTyfBGXTX/BX9DkqQ0k7OQNa24MOw+4FWC/YIbLXKintL1ZEMoNhLNR4tLZcfE3p
BNnnRyHjvyVSGuS2cwtlsYi3EIv44VBBENt9esQs/hvXJSo4JIBcqWM+VCJtEzuU
w6DmNesWX8l9Md2gWc95V3M42whx71mDxEAxYT9jG/ebS84GTufwQCtBIOgAL7Eu
aMvHzizlzyU38+UkfI+R6h6mOl8Oclejl2hQTDwOIpaMPSDDvDc=
=v/wN
-----END PGP SIGNATURE-----

--6P9QVOoCHcJjesZE--
