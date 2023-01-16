Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F75B66C8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjAPQnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjAPQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:42:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806738B62;
        Mon, 16 Jan 2023 08:30:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ss4so62047143ejb.11;
        Mon, 16 Jan 2023 08:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVo92w+mMU35HgccNk8F5uG9725xv7bq4W+283/I+5A=;
        b=F1V4NeV1D7nGM8Ao68MkS8QO+9OEKX18y9BLG9eBcTm68JqtuVTes13gtGycIoLRAw
         srN9x+oQ+5buVkRa2BwZdBVn3kyWx/Md4mJiCqwYdWg7qpuutIKeUlKkwRtm9zk0iQJy
         +5VIGwNlh1+Yqesp2qqIWTy/rFP2ZnWflhy7kxO1BQE5yjv50Jo9YjkQCCUgBrsJWhho
         mHjXgiXIWPXB8OGy0UhqN7YE3R2LO0sQh7NEsFnakRuvHcJZPmpvVGDmUBIinGg07pyf
         HYlSl6MJBi5ctVB4BQUOjdKWHAkIUWQa1z+LWtDPFSz2w3Tc+PmkmgQHYFEDLtR7sAbY
         tZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVo92w+mMU35HgccNk8F5uG9725xv7bq4W+283/I+5A=;
        b=hnwJy7qSKCqduy3csjO0yJZ0GgCCCGGgjKmRIO/TjxPhgZ9Ru74z8BLx+gSaHk7VmU
         wONqFu7781Yx9SD9rbP+EhWJ6NjWk1clujRDEwUIg4C2TbqZ/KCCbrhcd26scxivSVHA
         CEXaKyH8FCgGK7YEB/GRSUGoC0XUSOEtJY7fI2JqKfjCUGLBAQfqk8eOMOtl9tbGKNw+
         odlf9qjvXYR+Nx573h/Onw+tP1cMMJ+5bPqX0sQyoOWZtV3DWcwu2Snng/qtn1OKYPIG
         UvIbQKBLZcNsXQVXWHT5DNKATSDdYYT5P3uPjIZv5Ser2z6UEXOMpTXdIyIX50rMUPd8
         3aHQ==
X-Gm-Message-State: AFqh2kopwUnbP/bic8JNCOmd6B0rJClrh6h1m2yYlCmHC8uO0pd2ff9k
        bhAKpaC/B7Ec3Y5KkYA9Lsg=
X-Google-Smtp-Source: AMrXdXvuq2AkcmdJDlN5B8LWYcHY5dyWpQtmhK1kg5hNM+AsoxOfhH9r3YeEkJiVk7A1UbLdpoJDBA==
X-Received: by 2002:a17:906:39ca:b0:871:e336:cd2a with SMTP id i10-20020a17090639ca00b00871e336cd2amr1478292eje.47.1673886628390;
        Mon, 16 Jan 2023 08:30:28 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b0084c6581c16fsm12005496ejc.64.2023.01.16.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:30:27 -0800 (PST)
Date:   Mon, 16 Jan 2023 17:30:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        treding@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v1 09/10] memory: tegra: get number of enabled mc channels
Message-ID: <Y8V7oIzVPffETqtO@orome>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-10-sumitg@nvidia.com>
 <db223161-a424-c4cf-09a8-ff2241fda71a@linaro.org>
 <86f94266-d88e-af82-0352-876bc369f6a2@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g8Q09nNnddE8uScx"
Content-Disposition: inline
In-Reply-To: <86f94266-d88e-af82-0352-876bc369f6a2@nvidia.com>
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


--g8Q09nNnddE8uScx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2023 at 08:34:18PM +0530, Sumit Gupta wrote:
>=20
>=20
> On 22/12/22 17:07, Krzysztof Kozlowski wrote:
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > On 20/12/2022 17:02, Sumit Gupta wrote:
> > > Get number of MC channels which are actually enabled
> > > in current boot configuration.
> >=20
> > Why? You don't do anything with it. Commit msg should give the reason of
> > changes.
> >=20
> >=20
> > Best regards,
> > Krzysztof
> >=20
>=20
> CPU OPP tables have per channel bandwidth info. The "mc->num_channels" is
> used in [1] (Patch v1 10/10) to make the per MC channel bandwidth request=
ed
> by the CPU cluster as a multiple of number of the enabled mc channels.
>=20
> Will update the commit description with this info.
>=20
> [1] https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com=
/T/#m3ac150a86977e89b97c5d19c60384f29d7a01d21

Both patch 9 and 10 are reasonably small, so it would be okay to merge
the two patches and avoid any need for an extra explanation.

Thierry

--g8Q09nNnddE8uScx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPFe6AACgkQ3SOs138+
s6E/2BAAiVcPFgJQq47pbkFQvbySJLa/pcKt6BI8lTuPJwZsRJ13RxfCp2Y+KkE0
xSYrAmtvD+IDy2s67qTGm6UZjT9KqGmV9zMaZ6ooTylKYtOW4N/Ln4///T9jwRGM
oTG6NN2DEPVKkV96gTtLzYAAM0cNx7lx7pNEHV7uXDUr2ieKHUhEkEeliDK73xBN
6so7/FzLBCf/O7mitcLOud1qC1pHSXwULHMxDFZyU3VinsqIJBBc4Ua5IB0dkc8U
Cy8E04CrxU7H49ylIl4cpO/bq0PuazW6PlIemqoheJyWKyr0foyRpjvJI6nsy1CT
9Mb+ocRAB+Cu2IILTFl4IaW09982TBJOyIYJ5qRi0DvMhFAb64dUWT/rdMPvQ4q9
P6RLArDLfcksDnYnhFwhFESdEPOa+YccCYwfFyeYcN2/XzE9AMGW9iNYKPw4fnpM
fDmU33Q/0ze7q4BDcEDfLFwiRmoHpXZv2QYIi/U2fhN6cuux9QEMWEX4Lksxvqst
uH/9FFgHHlViYPkb/iW1qZjuOsG4Z5A6xNVCMxbKYt89W7800FlI0tWZGQ/LYT2R
JdorAB6uZnW0MkXm5N70rnCJn75+2xJmrRLnnIfmAivLrRE6uo8WwXOTVYgTZVAN
8WONvNE9WgSPFSw2nJ8Rr+UE/pektA2R8QfNrVgyF5w9txkkCDA=
=jOs7
-----END PGP SIGNATURE-----

--g8Q09nNnddE8uScx--
