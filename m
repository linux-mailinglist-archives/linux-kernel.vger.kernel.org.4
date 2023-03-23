Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C56C61E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCWIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjCWIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:35:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F292113CE;
        Thu, 23 Mar 2023 01:35:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so83134346edb.11;
        Thu, 23 Mar 2023 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679560493;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQbo0O83zck/Y+jqz7qZGSpnwSHCg2FVnAgesf/w1fg=;
        b=GBJiQZ6alCqSHGovwtubKU6zF5oGe9RIqKvHZpAzDIgZ7K/Jf2STITpu2nP5deisZG
         cOTlncpYMOcnZIPQrGEAsxQVAl20u3D1wfyietjcXCwYr6oRpA5wcJEDcHRT0678Ql6b
         Or3V1dyMtO2wQQ/szM1g4JxgIaG0e5bDquSdDK9MtBwCnT9hSGlLepduclauD9ub+vEC
         UQq+mWUPHLLeAna7GtDpQK1aUt02QCqFLW+F4+u3s+1GKj5RazhZX9S+moWZ/nPrWE6d
         pmLF3c6+kigo4/uHm5LIijL8ZiI38NkSsXBbAkXfNdqw4EK/FF+q5mxh90MEsrLWWHrU
         38sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560493;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQbo0O83zck/Y+jqz7qZGSpnwSHCg2FVnAgesf/w1fg=;
        b=E6LgTuE+C9btxmQlVE50MN372LXI4G4qMiGVBqPGvAPgJRn5NraJzYQuaTWi84GRiH
         WFZ5Y9c7obOd1aVYvAF4L1CC/AKqTDVquwouJ4aK7P14xZtbudsXU7uJlrU9thQ3RD/R
         aP0ZlpYAqY9lrxH1SLBR5A1sYCjCrvaVWGXStkR7VtChO/UDfipNiAYvUJ4gYhuY5kAu
         +Ji6fRGGR5ab2Ssj+MbsLD7olCCmK2kNiuAB/JP98ksNxAm2v+abZu3IwUBAwZ6ZiPk/
         jzE2FwoFrRk1ezK0qZAqCb2znHf0iKwwOs/LPnmtdnbhm7yBHXnnC/kSpXg4iqwUs2Lt
         PloA==
X-Gm-Message-State: AO0yUKUnLJHD6pi7gYgx5B9KxpeF+Z6rpUghkBYqW6q/blpHhIvUxwW5
        1kj9i0lkBVARVEb1MVVJdjc=
X-Google-Smtp-Source: AK7set/cgtpGLtTZn6MqE8lSd/l0TxeLPnqNIe0c3ohOQaa5BainwjgWMcAohgWj/KpGJ0rymYA+gw==
X-Received: by 2002:a17:906:646:b0:8a5:8620:575 with SMTP id t6-20020a170906064600b008a586200575mr9637254ejb.3.1679560493067;
        Thu, 23 Mar 2023 01:34:53 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id so8-20020a170907390800b0093d0867a65csm405500ejc.175.2023.03.23.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 01:34:52 -0700 (PDT)
Date:   Thu, 23 Mar 2023 09:34:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: tegra: drop serial clock-names and
 reset-names
Message-ID: <ZBwPK05yP1FV6CSs@orome>
References: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
 <cd9d9983-3dd5-70dd-8155-1b7d856bf35f@linaro.org>
 <affc7a51-c29f-968e-c15d-ccd13b0c530e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xsls5xfW08UfSqzQ"
Content-Disposition: inline
In-Reply-To: <affc7a51-c29f-968e-c15d-ccd13b0c530e@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xsls5xfW08UfSqzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 08:22:45PM +0100, Krzysztof Kozlowski wrote:
> On 12/03/2023 17:59, Krzysztof Kozlowski wrote:
> > On 23/01/2023 16:15, Krzysztof Kozlowski wrote:
> >> The serial node does not use clock-names and reset-names:
> >>
> >>   tegra234-sim-vdk.dtb: serial@3100000: Unevaluated properties are not=
 allowed ('clock-names', 'reset-names' were unexpected)
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > Thierry, any comments? Can you pick it up?
>=20
> Hm, so I guess it is for me?

Sorry, been away for a couple of weeks. I'll pick this up.

Thanks,
Thierry

--xsls5xfW08UfSqzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQcDysACgkQ3SOs138+
s6H8kA/9ElUXOD33HPGOnfOsDn7JyVQq6CSmNqq4j0IS9vVwYSZcrGkngLlAVco5
BMAlg3k+309bVmQyrF/F4sm2d6juBjW+d+xzUrmytsqzCEEaZ2me429Fwb1tQcX9
W63io2snkcuoxJiANEv4sUNRG9uH9NwwB5YVvm0vGC2T2gI8X0lTmPlyWWLvz14L
OFWVJUJ3bUKiH9X8hgHZFihyaAiGq6JH8wLRtvjs2twrtai/AFPEkru9/SMwDw1A
WnnMgyTaxMR3SkZEMFu15oz9B3xNEcO7CgK2K2t3EanFBB52JVqw82vPqBaCfKgm
nlymiY5h1TCLhaf1kt9VRqChm8sEfk0XasWf46YZqezUExu0xUkuZIGAF1bnzHr7
p/x67fNuWRTShebIuFFweRqssB2CWFUMWptGtJMlasi8/B7nKRV8IrXhjrYHk5Md
31o/vOQNpdjy3bQdrYL52yYnA1t0sdILKh/3IaHXTcuaDumphFSU9SiJaizo8RO8
O+K1LKb/8rHGZIvmUWCna0ZoQUf77r43EvWNCZoMoW3A1gUreFbpYmKqrf2LPnQY
wK8FY2c5+shSmf85l/lZt+j0CK22jxr1hR6/Vz2lBufYcCwfVQQqmEukgJAwB0KE
/SzMu+2D0jP4JMhgmFNvvRww7m4J6FK614tsthPsfdNJ1ETAG3A=
=QW3h
-----END PGP SIGNATURE-----

--xsls5xfW08UfSqzQ--
