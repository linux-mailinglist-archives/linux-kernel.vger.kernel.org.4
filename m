Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364F5B9AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIOMep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiIOMem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:34:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393441BE94;
        Thu, 15 Sep 2022 05:34:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 9-20020a1c0209000000b003b494ffc00bso512321wmc.0;
        Thu, 15 Sep 2022 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rfculMke3zk45DcIX3PPH21HXBrjMaL/S8KLHRg8ugM=;
        b=YrZJor5mvnPIukgz8cSamggmjZsUqONu3wuIJKar66MB98OwRPW7marl7wCKWm5wud
         mpKomQ37vBIYwegP6yARerHptVrt4UnC3UNy3esbb6doUt8EIdxRrKS49yBk7DYY02hi
         afXM3rRsxc5BBvQ7P7GI2YDVA0zE6c38v2fzRXRg8qoY6n1quHWoC/5cURbwUW/BWvP3
         QBLY6mi/t0U5XmIiJ6wPcB9Sr1MmDUE17ElTmqw3TFFwct9hMzf7s2jIYIu6JRzOyZFd
         +n1th/L4tqdN7fD5ybgM7cik8O15vlJwzg36RD+KNC+0c6gFjnwQM3cm9l1IgUIC44op
         t5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rfculMke3zk45DcIX3PPH21HXBrjMaL/S8KLHRg8ugM=;
        b=ARknv2ssmh/XBtnGadUdA6XcOXZPvl15+FLzAwz7Hehr0YW3nBP4SMLv4j+T113lYW
         DrsiHoIDslTaUct3gcIiJ6KdnfrGG8p5GIVZaEDHGaITLZitsrGkMig6GCxQGD4sSZ+a
         6Zkr9P/e5kYr9jvvjOxxwj5VEVUap55t9r2IAyndcmcPDjv+O8pwk5ifMR0teJdSCviO
         QIGbj+JrP2BSM23IKfouBRBdMYGSkey6aAw8gf8HivsqsyI4sVvyPUm3wU1wokvrHu25
         b09YvVvmhktXVG0SncA1HyhOgU3L/Z3eVzxRCl4dcyxWpvdWTaCgEgL8aXDNFCAxiOrr
         cj7g==
X-Gm-Message-State: ACgBeo0PivG+J1KlePopG7YnQGg7qeH6DxFHlSCy+QnoE+qoIfq+FG5D
        QLPjzNEuFhRdJ3130RBwCDQ=
X-Google-Smtp-Source: AA6agR5dJkvlup2rpQkt+oWVxvD8ZgsmkloLfLtallqtpWyFCASSlhjY1pdqhDoQKo7l7D4/65b7yg==
X-Received: by 2002:a05:600c:27d1:b0:3b4:5e9c:23ed with SMTP id l17-20020a05600c27d100b003b45e9c23edmr3380383wmb.180.1663245279759;
        Thu, 15 Sep 2022 05:34:39 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003a601a1c2f7sm2720142wms.19.2022.09.15.05.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:34:38 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:34:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        treding@nvidia.com, jonathanh@nvidia.com, spujar@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: Add iommus for AGX Orin hda node
Message-ID: <YyMb3f3r9qZbFy6+@orome>
References: <20220830052736.21348-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BROt6oKdMv4Rnb6W"
Content-Disposition: inline
In-Reply-To: <20220830052736.21348-1-mkumard@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BROt6oKdMv4Rnb6W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2022 at 10:57:36AM +0530, Mohan Kumar wrote:
> Add iommus entry for hda node for AGX Orin platform.
>=20
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--BROt6oKdMv4Rnb6W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjG9wACgkQ3SOs138+
s6Go3g/+KMe2XIpHNIxP2MZonHnO3rrh9c3y6Netl4+m2XSYvvSS/aURkEGPn7MG
gHleQa4mb2s2DROvtbrUZ66idQsz7NYwjYM1c3q9+COuVu612uQ8ChcxC5lQP7Y5
WRA4iWa5YdOMaz9dr+5X+2fo0FcyDIqU5oMKRPQOaxZJah5ymT+eBLXXjJCgVacN
T0Y/RUfvG5WuTMIo9KhNNA5PJiJh4VTjaXoKT0I7W7noINujrbJBXDtDpxcbLd2a
Okwhn/Xrq5IL4fzAl7YThHNex/8xmejptn1HSfNH3gZI5+8WuskZE8GmXclihbeD
3weJ3rYPtUbn23aJYJ95KqBM7qS9M4s5EOkNsHmbvsWesR6V6Ob0kzzalbOtX4sq
KsW8R3iJYQznkahyecZ8lxyH7Toyw41CYQXNyehoX0DUNc8jCLrnANvlMAFHnrp0
qZdjNRqV0o5zzokPeytSj3c1d1xuwAfXsFJPkmuPypMxJp1bJTRPmXSnJ6m4GAQD
xpz+P/ewZh4IFf5K+mHhw+LOkAzpweje3vICMi8ZL+hZtiRSDgBOqD1GHSDn7I6U
w5DiuzYkyszhHkcwDbdrJPFy10ZUHMmD07TW3d3QpZJmEnEvRShSIWdBdgN/keLN
MXHTnOMsO0FkyUsr7hqYbhDwgAZQKfctDERhRLR+80DMulT5xKE=
=nCvA
-----END PGP SIGNATURE-----

--BROt6oKdMv4Rnb6W--
