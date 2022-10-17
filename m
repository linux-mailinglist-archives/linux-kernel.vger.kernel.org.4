Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60706010D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJQOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJQOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:11:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A257BEB;
        Mon, 17 Oct 2022 07:11:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k2so25236231ejr.2;
        Mon, 17 Oct 2022 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc4vhu3cj7ob5Y0sdul0MVZXyT2m9YP+8Qo/4ifVpWs=;
        b=gxdD1NB9+4TZqPOstQjfh2IOQoJQ4GXNBKGNF2IeU1ZsIyAN97PghiyFeJH0se2Boy
         fc1kN47+MUZKEAkGx7/cAIV+x1SlO9jiUtZEv4cBn8iaesre/Vh4/v0GHNlp3hiiw5ev
         CmqIjVHlD9zUtck6BtNckzBrXx5uRfRVL7LjxhME5cc1rJcDLK3RjfK20C7eIFYYhqKV
         SM/XyTa2x/kOwI3+dnPQ9KuPHa2URB8dQqXc8I7c/R/Z9iV/IWiC9F/d0xfS8QOol3zC
         EPCBXvOvR+yrN73dadAb10KO0P54yg7CVHnSs5nNQjX4PNWK3od4TuhzPBNljkqedZOd
         a+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc4vhu3cj7ob5Y0sdul0MVZXyT2m9YP+8Qo/4ifVpWs=;
        b=4toSJD4pXK/LM3GxOXv8ktN2uMAKiUpNF3c1LcffwbQxsxVd8iPOPuOr/25Rphi7D9
         7mxwpx3sR09r5lMQYKXjHgMF4uk7kPsokzACTv83qBjsA9okvOyq3z6aKlJ2QS8BbDra
         vvQ005sIDFQ+ZzFHHGu1cil8Mwh6k83GXsRroWzw7uw6xZ1Xtd0rD4KdGzmCCOJ6qITa
         trfVKbuJvKZe8uZMzSSyJ8qMlbW827vCdD6hi5OoHvpvZYmM7LpqNVROjoAH/U622IVS
         Ln7ykDKWPBJY9LCcOrjGgSBA0xHtGWytEiBGAZnZlD8TQ2G7rebzTnQiwc1ZZqgS6DHe
         9jrw==
X-Gm-Message-State: ACrzQf2V8qCkqxQ/MfGDjJkPIONxzcRzAg6wW4g/yct0p4BHAPaMu/LV
        6zPs6DAYV8dLmHOcNVQK794=
X-Google-Smtp-Source: AMsMyM4y6Ve+vTWBpgAifoQzvsVeFbJBwIEnSCHCwtM8mCeMeDXljEtdl7teviAk5kN9Im79G96oxw==
X-Received: by 2002:a17:907:6d9a:b0:78d:f864:de0e with SMTP id sb26-20020a1709076d9a00b0078df864de0emr9112609ejc.26.1666015885968;
        Mon, 17 Oct 2022 07:11:25 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906311700b00771cb506149sm6236307ejx.59.2022.10.17.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:11:24 -0700 (PDT)
Date:   Mon, 17 Oct 2022 16:11:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Prathamesh Shete <pshete@nvidia.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: Re: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC
 stream ID
Message-ID: <Y01iiqtNA9xek46S@orome>
References: <Yz6zfrVq9cP/wrJb@orome>
 <20221006130622.22900-1-pshete@nvidia.com>
 <20221006130622.22900-2-pshete@nvidia.com>
 <CAPDyKFr_Yi2EgrBUzsORnM4mOkf25WR8+7_dfF2h4XzRDPm9-w@mail.gmail.com>
 <DM5PR12MB2406610AB26183BACB19EED6B7239@DM5PR12MB2406.namprd12.prod.outlook.com>
 <CAPDyKFqn2jMVQ5BAOZPFx2OOyMRQvsQ1E7mGAQp82x5+v6aSGQ@mail.gmail.com>
 <DM5PR12MB2406405CE44A7606B5A28203B7259@DM5PR12MB2406.namprd12.prod.outlook.com>
 <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bW1/UntuZ/Dpz/dP"
Content-Disposition: inline
In-Reply-To: <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
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


--bW1/UntuZ/Dpz/dP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2022 at 03:43:18PM +0200, Ulf Hansson wrote:
> On Thu, 13 Oct 2022 at 08:33, Prathamesh Shete <pshete@nvidia.com> wrote:
> >
> > Hi Ulf,
> >
> > >> In that case, perhaps we can add a "depends on IOMMU_API" in the Kco=
nfig
> > >> instead? Or is the tegra driver used on platforms where IOMMU_API co=
uld be
> > >> unset?
> > Yes it can/will work with IOMMU disabled so its not recommended to add =
a "depends on" condition in Kconfig.
>=20
> Alright, in that case it looks to me that there are two other options
> to move forward.
>=20
> 1) Add proper definitions of the struct iommu_fwspec in
> include/linux/iommu.h even when CONFIG_IOMMU_API is unset. In a way it
> seems a bit silly to me, to have the iommu stubs around, unless those
> can be used for cases like this, right!?

I recall that I had proposed a patch for this a long time ago:

	https://lore.kernel.org/all/20191209120005.2254786-3-thierry.reding@gmail.=
com/

Given that Joerg had acked it at the time, I think the only reason why
it never ended up getting merged is because the rest of the series did
not get enough traction. I wonder if I should peel it out of the series
and propose it separately.

I agree it doesn't make any sense to have the stubs to allow compilation
and then break compilation because users of the stubs will end up
wanting to dereference the structure.

Thierry

--bW1/UntuZ/Dpz/dP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNNYocACgkQ3SOs138+
s6Ealw/+N+g3kvb61CMuasUT4REnY/0pdkX6PG+sIPl74h/vEy4RQONsMSIF60At
vT5lx44ULGJq6Hi76D4A2OaZqGwezVI8lhdMPPzajE6LgH+VgnqaXbZzcSu1C0n9
jGRyRvg0xcikfl8leufXlIPY4vew2i6OHaGX9kOOrpfuHyQPEf0qYGPRPtdOPHg6
nxkUuOSxT2wSVxByOystb2Idao31IaN+dHk9Yds/OfLi5a3eXicJTfcV2Ashpktx
91k7ZbPIXrYpB0TxhkqlsQGTC2tqaoR2vXAYB2MfGlz7FTuFXeyV7Xk8zaHvgMRg
jfqqsqwXyzltIk5MY4ErJk8c1XZLRO6q3iepi4xSU0wb59Sjmcb7klZP5scPJC6H
fHha2s6BZoLzw584a7O5RvjDK5GOGcMYDxmEGz5mb+ZKLsHdG24sdV2F46/qJU5c
iRNZhlYV7PNCJmSxMFoOozA63v7YKR4RYQfBJSKHGSinTK+QJ2Cqm3EsRbCrBQgt
u4AigcYY+T+pMd+L9HfYb0nxPYjViqa0FEtvv8fDua89MVVtGlQ+trHec4licmNF
NNj87vkJpFe8uJYIWbsNAI6s1d6G/tGdcW85v11KFsBbJX/+HJawDSJXVj1ZF4m8
fRRI7PcXMrKBlKhCAPfYz5057boPT+Gh64gTH1Lv2HQz7TCYvTE=
=FnaY
-----END PGP SIGNATURE-----

--bW1/UntuZ/Dpz/dP--
