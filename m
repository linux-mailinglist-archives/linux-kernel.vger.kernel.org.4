Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3502B67357B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjASK0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjASK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:26:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777E2521DE;
        Thu, 19 Jan 2023 02:26:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id rl14so1083462ejb.2;
        Thu, 19 Jan 2023 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clRCjHfA7rKJ2oTt1B+97caDociqEL0Rl6BA3x8VTP0=;
        b=hS975poE2XDyTtRXqaSp3RNPHLKWlnWoBUnMSaE+kUZiL3hg4no7WvjdggldCJ3H8Z
         7GY4set0sB24oy2yCIPP+ywNqXfoejuJFzZAJ0lZny/yYuiHzwUXJ19RhwvgsLxd/CbI
         le0vQvjW0byRPCLW/9vLZj7/K0/beC3jzIPdPOafEt0B6QraEuBIU+8aDJ7iW9Q9MR2g
         wvCzm8406/+hILoyADBZgUh9YwIKrL/iEHilNOt0exSb3lr6Gdgz9seiPDOOfjVJwidz
         NgyGLIkGkshORF0yWKDOyd2jk9UtmoTomzt1iKL4zT96WmikSjKGkpwXQUjCy7QTqCC3
         xVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clRCjHfA7rKJ2oTt1B+97caDociqEL0Rl6BA3x8VTP0=;
        b=699DYf3fRRATauzi2Ge5KyzX/9DTzqYAdfLpTGBngmvJtHWWECbWNPmvtdfIy2iAss
         ZEpxMLqQ1gFRVG+Q3MLp2YQrXjoILrbD8Nz5crpUacY/HX1l+LZfN6D9lkYerFHXASyO
         VARLzaiZrb5MMzqxrS/e9bLbtA8rzyubnEikTOSU/+gk6GpQg0TKIBvLPjVTRW0dq4C5
         fGc+dKHSV9AiecNfWHBIJiZXNt3LG/vQIKrzSHzfmNeFcytr6vDIBIJqJcfNED6K6OsG
         f1qz4gLAx8Np97bzzCH1U5X2YM8TGx0pBNWvy/UW/SYovL5A7IukqQ9lT3E796fYDdja
         RKxg==
X-Gm-Message-State: AFqh2kqTZM4vXui/+l++C610IhFkgJkRj8kswCPZ/w3xMN5OdYxESlJC
        r5L4Tx6p7skEIKhrdaucKkLir/kmV8o=
X-Google-Smtp-Source: AMrXdXtqcH/8Sf/CngK7xv/mWLSKmba4Glnzkg/+gCZisxT3aEJJ6tNONigLWslMq7fmyrz1h41VNg==
X-Received: by 2002:a17:906:5906:b0:870:2f70:c624 with SMTP id h6-20020a170906590600b008702f70c624mr10657240ejq.3.1674123982603;
        Thu, 19 Jan 2023 02:26:22 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b1-20020a1709063ca100b007af0f0d2249sm16057107ejh.52.2023.01.19.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:26:21 -0800 (PST)
Date:   Thu, 19 Jan 2023 11:26:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com, Rajkumar Kasirajan <rkasirajan@nvidia.com>
Subject: Re: [Patch v1 08/10] cpufreq: tegra194: add OPP support and set
 bandwidth
Message-ID: <Y8kay0/AmjqhU2jO@orome>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-9-sumitg@nvidia.com>
 <4e3e4485-ba22-eb47-fb95-e8d626160bc6@gmail.com>
 <8e6d7dd3-1bdc-ee4b-0c1e-1ae9cd8e4f29@nvidia.com>
 <8bd5cf36-e1fb-305c-08c5-3bbc80204866@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wXgEOUGcow8GwYyA"
Content-Disposition: inline
In-Reply-To: <8bd5cf36-e1fb-305c-08c5-3bbc80204866@collabora.com>
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


--wXgEOUGcow8GwYyA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2023 at 03:16:48PM +0300, Dmitry Osipenko wrote:
> On 1/13/23 16:50, Sumit Gupta wrote:
> >=20
> >=20
> > On 22/12/22 21:16, Dmitry Osipenko wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> 20.12.2022 19:02, Sumit Gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> Add support to use OPP table from DT in Tegra194 cpufreq driver.
> >>> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
> >>> Cross check the OPP's present in DT against the LUT from BPMP-FW
> >>> and enable only those DT OPP's which are present in LUT also.
> >>>
> >>> The OPP table in DT has CPU Frequency to bandwidth mapping where
> >>> the bandwidth value is per MC channel. DRAM bandwidth depends on the
> >>> number of MC channels which can vary as per the boot configuration.
> >>> This per channel bandwidth from OPP table will be later converted by
> >>> MC driver to final bandwidth value by multiplying with number of
> >>> channels before sending the request to BPMP-FW.
> >>>
> >>> If OPP table is not present in DT, then use the LUT from BPMP-FW dire=
cty
> >>> as the frequency table and not do the DRAM frequency scaling which is
> >>> same as the current behavior.
> >>>
> >>> Now, as the CPU Frequency table is being controlling through OPP table
> >>> in DT. Keeping fewer entries in the table will create less frequency
> >>> steps and scale fast to high frequencies if required.
> >>
> >> It's not exactly clear what you're doing here. Are you going to scale
> >> memory BW based on CPU freq? If yes, then this is wrong because CPU fr=
eq
> >> is independent from the memory subsystem.
> >>
> >> All Tegra30+ SoCs have ACTMON hardware unit that monitors CPU memory
> >> activity and CPU memory BW should be scaled based on CPU memory events
> >> counter. We have ACTMON devfreq driver for older SoCs. I have no clue
> >> how ACTMON can be accessed on T186+, perhaps there should be a BPMP FW
> >> API for that.
> >>
> >=20
> > Yes, scaling the memory BW based on CPU freq.
> > Referred below patch set for previous generation of Tegra Soc's which
> > you mentioned and tried to trace the history.
> >=20
> > https://patchwork.ozlabs.org/project/linux-tegra/patch/1418719298-25314=
-3-git-send-email-tomeu.vizoso@collabora.com/
> >=20
> > In new Tegra Soc's, actmon counter control and usage has been moved to
> > BPMP-FW where only 'MCALL' counter is used and 'MCCPU is not being used.
> > Using the actmon counter was a reactive way to scale the frequency which
> > is less effective due to averaging over a time period.
> > We are now using the proactive way where clients tell their bandwidth
> > needs to help achieve better performance.
>=20
> You don't know what bandwidth CPU needs, you trying to guess it.
>=20
> It should be a bad decision to use cpufreq for memory bandwidth scaling.
> You'll be wasting memory power 90% of time because cpufreq doesn't have
> relation to the DRAM, your heuristics will be wrong and won't do
> anything good compared to using ACTMON. The L2 CPU cache + memory
> prefetching hides memory from CPU. And cpufreq should be less reactive
> than ACTMON in general.
>=20
> Scaling memory freq based on cpufreq is what downstream NV kernel did
> 10+ years ago for the oldest Tegra generations. Today upstream has all
> the necessary infrastructure for doing memory bandwidth scaling properly
> and we even using h/w memory counters on T20. It's strange that you want
> to bring the downstream archaity to the modern upstream for the latest
> Tegra generations.
>=20
> If you can skip the BPMP-FW and use ACTMON directly from kernel, then
> that's what I suggest to do.

After talking to a few people, it turns out that BPMP is already using
ACTMON internally to do the actual scaling of the EMC frequency (or the
CPUs contribution to that). So BPMP will use ACTMON counters to monitor
the effective memory load of the CPU and adjust the EMC frequency. The
bandwidth request that we generate from the cpufreq driver is more of a
guideline for the maximum bandwidth we might consume.

Thierry

--wXgEOUGcow8GwYyA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPJGssACgkQ3SOs138+
s6FLcQ//SDuIXbEmFWNwO/6zyR0Uu1oyte3hbT72Pg/1mj0FdHlo44tkuI2iGsJo
XslkLfJSE8FQ4kygY2mqyKBsZP0Eqlmh2hwWfofm4n1+EX6NE1u1zOOw8YbVrG+2
PYiFHf2JxQUTvEg1GgaU58OXm6aLT9jKS6zFl6R7OLnsSUKtJzzJUIgwdGfnH6qV
yvyo7mG30Nk+7s7Yn7LA85CaD18/agj+DHvFQ8UD7Ysn3+SvyVbcq2u4+JdOlSeN
oYGIJ8S3OMSXSt3M35p4Q+5+9xEPzPN5sZ9Xov9A5xS0jdVHoFzTGj4FhMRKAJq9
VQYmR97bYQlIAwZYiI1Lh6n/YMNtfBtqfKA7qvVSTK7Z7QnbVD4JuIBq3AbatPuK
DWykzPs/8xOf0fbLS7e9KwdahWaYdjbsfDvKV81JbA8xRaEO47+x7lBsa5RT/mHg
ala4a4Ia0TLEjQ6eHmg16qxrP9HRvGqezInLHO/2/RgJOaxps1kcljyotMkZspnb
fHK7VFMvtDI0vLlDya2NJu1XWQnPlP1j3virK8zBTlRbQmwXbp4OfXumP8hHa9et
CeccsM+oIXovEm4Zkc23V5aRDnKG9o6iQ6YIbj0Kl/VMo+boffDb+sltcgJDAcZT
OSx6CdbmLW2OoZhC6x926chQZXo1APxTdYdUegNrUQsJRjyHnY4=
=tF8B
-----END PGP SIGNATURE-----

--wXgEOUGcow8GwYyA--
