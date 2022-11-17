Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7362E771
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiKQV5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbiKQV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:57:33 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E279929;
        Thu, 17 Nov 2022 13:56:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gv23so8568087ejb.3;
        Thu, 17 Nov 2022 13:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDO6ZvFTlzP/mSC07WX0PHWZxtm2OkM+w+461rLKdK4=;
        b=XwyvU3K6QvYPxeEt8mlmDGyP13A/0mOWUl2b49auWMpIR1Rdz8s4n2ak7BfMWM7Lvz
         +w0y6JEAurNqxL9NR+XNehJ3actjk7k09WAt97nzwidit0nM+KodUqqjSqkL9cYgVE5o
         wHG44++hDUB9hARpHKJrqdGfIhscgQ9+e5e2h2ctJaoqJUIofZuXoFhvZZ+hjewh/pA8
         7/ScWWztNH7LfQVXJvHMX/8s77XDWSNhTUYAY6OLbSWtEmTVUciaZZyGmKgCWevH5lsv
         ZmKuc22EQahZ9RzxQwEwsjvrRQ8Oez2H0RONmQa6jzSvH77C//H8BnOvEFT2pNF51hLO
         iCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDO6ZvFTlzP/mSC07WX0PHWZxtm2OkM+w+461rLKdK4=;
        b=J3S3jC7c1CYoC8Xb0RDVT9q04W7vt4noDQCkbc/5kYD4Ujz7MfRXiwBtv/k8zJ06CZ
         COIE8NW8nwjy5LntLw5hIqC348fmSqPRYXNey8Pa+SbPDMicf4FenWG+t3lsaI7vy6Co
         ec6ULr8WII08D+vvVedt8QXw4z9BWuuJFjbzFyxa/r1Q5CGvdbYOJUqgT4MydZE165Ur
         +HEhJxI3X9CbLMKpAUQU/DoCtEf56ZaZlkseZbBPA/46dcecwjfIshcqwcSms9YgdWDF
         9wo8ikTsSpZX7a52jPFY0PrpS8/1aKbddDouzJ/7p1Z3SlIiwOoX0s6e2ZOp+3QVAqVv
         RPoA==
X-Gm-Message-State: ANoB5plLl/70IpWmMmlakxaHiOsSjGcBeoLlnwN1SPodlrvd80ef4baw
        diE6XnADQjFUv2t0fJy8ZFxRtEilimM=
X-Google-Smtp-Source: AA0mqf5JEOAJSEkta+wEDUuq3Us56H/u5TD23H7SAzl0eMCj5iOrVl0eyopeO1WmUfkq5iTaFA/rYg==
X-Received: by 2002:a17:907:1df2:b0:7ae:8411:112c with SMTP id og50-20020a1709071df200b007ae8411112cmr3535248ejc.97.1668722208647;
        Thu, 17 Nov 2022 13:56:48 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b14-20020a170906660e00b0073dd8e5a39fsm861542ejp.156.2022.11.17.13.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:56:47 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:56:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, mperttunen@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] arm64: tegra: Fix non-prefetchable aperture of PCIe C3
 controller
Message-ID: <Y3auHfv0VL8AiVd+@orome>
References: <20221025182508.10687-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6OwvVH3W1DANH+Ik"
Content-Disposition: inline
In-Reply-To: <20221025182508.10687-1-vidyas@nvidia.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6OwvVH3W1DANH+Ik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 11:55:08PM +0530, Vidya Sagar wrote:
> Fix the starting address of the non-prefetchable aperture of PCIe C3
> controller.
>=20
> Fixes: ec142c44b026 ("arm64: tegra: Add P2U and PCIe controller nodes to =
Tegra234 DT")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--6OwvVH3W1DANH+Ik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN2rhsACgkQ3SOs138+
s6FbWw//XlQN3vUskTr3058wSW/TFQa3V6T2wS7zqqN6d5JZw9JlcW+zC2Fq2IVl
EE6WLbT5IcV6gKXZQ82C7ge6Mu9Dn3ve6YgvLiuwN88nxoN9w2oIW0YMU/DrcWDi
jYMN9xJcJzQV/rO/0NIAqNsJheVtP8CPxchsTRuWr7f8sOLV4ou3pvs9IGio3O2n
JcI/8JKVwHBlSn9pJgGWcPWxB7uvj3OU1Lyzk6HBFEcDk+Mf4rX4mRSqv+WM9kow
eEGdLhCtevPhs6ymC1XzTLfkIsYsJoC4wHXP6fvFiqF9xvrdRfbvpmSB9b/34EcT
lO/K6MepwxtK+eFn1v2MvQYYaH/5VBAmltkCyr1wiUQeDBofi0LYYu4JEo0xqmZB
5tKUBE+5W4XogoKArMZHgdVfoyhUFva3diS0H1QCC3HLiX0t6RiztadPfP7qb8JJ
Pwy7HQlY03mKC1nyOmaxYVZe71J2knCLnvXC8ByUvQmL6HHjlVbQoQXgJ81bGVp7
oAFqxFYoVwVF5bOeuuXLby/IDirtnlv6HaNk7Tmwpo78fg9fdYk1dHkXNsh8KtK5
z1jpKmDur9n8A1yDRBwHRsGddYQk+guEnwXtwGFsuheH1ZUCnHiX3FcNLd9xH3ui
+W4EzkiaRbHVnmp04CH5fPlFZ8Pnw7cWQATcJuv3fayomQJx1mk=
=u8DA
-----END PGP SIGNATURE-----

--6OwvVH3W1DANH+Ik--
