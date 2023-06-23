Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8DF73BC44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjFWQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:03:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD36210A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:03:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b45c289615so13845271fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687536198; x=1690128198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UUUtE/gOtOOjIJp13FnV3LETjhgWLdpmIzdJhfUTGs=;
        b=bgpuJMih2D6iVGs9Xa5gO+96mNDc14lvDPz0FcXhPj6i+71o9Y8XOK1/4zunB6U0ES
         pVIkfpaQlP/oavJ7LNyDxzlF81wUlZXStHvDxEQOsBHvoN792/suVDOQGNUu1K0CC2ej
         H4QhvVNvWhHzPd+DcvvBM0l/QezfgErqLTCHl2XL9WJmQUOllhryfx9fEDC5nNCBwNnP
         aeCN46z/bUoQnVEoWCQ3ZZWGVzhVAaKLLe/PUB5CRcGramM9GW7nl6j8Gddi7Xuajgir
         StLAN6Q1FZQIm/Tp/vC9rNlzbPpsQ/ukLlIN2tihbfr0PkjksUDK4wHDf4UicPwRsZmx
         JcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536198; x=1690128198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UUUtE/gOtOOjIJp13FnV3LETjhgWLdpmIzdJhfUTGs=;
        b=R6d9yw+B/lBG5Q+yZi7LBAgYUsjCDAVIN4Gh2/jezT4q7C9zalhItetMEU1EiHREek
         TMP4J+0TrpHbAOP9aGIrPJPdqfbvpXqA9AkC6Pmf80i8xFva/PNdkRR3EhUEB9eXfP9O
         uLvHBx7sLzT1ILaPAUD2OC5k4Ed2PxE4WWJfPqmcyk0yYI5Alm33jihDaUbb7OA0kMIk
         AUKUfQ4U5RHdExemrVMvUnSoUSj/AWBArZowsefHvtYJuBSRABXCryG3Bic+CZyq5iOp
         cV+qck8ImrssT0n0JzrLz2uOAqa+kIn3bl2ufETdAntzjpcPyJyt59JlTzhAgDS4CQ6K
         H8fQ==
X-Gm-Message-State: AC+VfDwxkfr3hLpZZqPgDRX4fy4rXHhDyf5dLHAN+l/tT75T2wcFilg0
        EDt6hFGTH+aWQ7kQRUxDos6feWGs7oqQZq3BhB3mlA==
X-Google-Smtp-Source: ACHHUZ5gs63B4OgKe4Z9bhc9XG9nQHRewAACqLwt9yH/6emVAQY9Sd7+t/U547Rfa15qOqIHkxiE83q7UsHMNWYeVOk=
X-Received: by 2002:a2e:96d0:0:b0:2b4:7965:419f with SMTP id
 d16-20020a2e96d0000000b002b47965419fmr10755146ljj.40.1687536197874; Fri, 23
 Jun 2023 09:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-3-eric.lin@sifive.com>
 <20230616-revision-speed-a83dc926b334@wendy> <CAPqJEFo5genyjY7qJBaESzeppbEnTiDe9qzv98ETLhWfMZeG4A@mail.gmail.com>
 <20230621-stupor-violin-930ccc7d7593@spud> <20230623132402.GA17369@willie-the-truck>
In-Reply-To: <20230623132402.GA17369@willie-the-truck>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Sat, 24 Jun 2023 00:03:05 +0800
Message-ID: <CAPqJEFp0r5tZJZ48nLakRd92zNf1D93hbTeGUsTyVuF+JAsJEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
To:     Will Deacon <will@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, jgross@suse.com, chao.gao@intel.com,
        maobibo@loongson.cn, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dslin1010@gmail.com, Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>,
        mark.rutland@arm.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Jun 23, 2023 at 9:24=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> Hi folks,
>
> On Wed, Jun 21, 2023 at 04:17:24PM +0100, Conor Dooley wrote:
> > On Tue, Jun 20, 2023 at 11:14:32AM +0800, Eric Lin wrote:
> > > On Fri, Jun 16, 2023 at 6:13=E2=80=AFPM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > > On Fri, Jun 16, 2023 at 02:32:09PM +0800, Eric Lin wrote:
> > > > >  drivers/soc/sifive/Kconfig            |   9 +
> > > > >  drivers/soc/sifive/Makefile           |   1 +
> > > > >  drivers/soc/sifive/sifive_pl2.h       |  20 +
> > > > >  drivers/soc/sifive/sifive_pl2_cache.c |  16 +
> > > > >  drivers/soc/sifive/sifive_pl2_pmu.c   | 669 ++++++++++++++++++++=
++++++
> > > >
> > > > Perf drivers should be in drivers/perf, no?
> > > >
> > >
> > > But I grep perf_pmu_register(), it seems not all the pmu drivers are
> > > in drivers/perf as below:
> > >
> > > arch/arm/mach-imx/mmdc.c:517:   ret =3D
> > > perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
> > > arch/arm/mm/cache-l2x0-pmu.c:552:       ret =3D
> > > perf_pmu_register(l2x0_pmu, l2x0_name, -1);
> > > ...
> > > drivers/dma/idxd/perfmon.c:627: rc =3D perf_pmu_register(&idxd_pmu->p=
mu,
> > > idxd_pmu->name, -1);
> > > drivers/fpga/dfl-fme-perf.c:904:static int
> > > fme_perf_pmu_register(struct platform_device *pdev,
> > > drivers/fpga/dfl-fme-perf.c:929:        ret =3D perf_pmu_register(pmu=
, name, -1);
> > > ...
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:549:    ret =3D
> > > perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
> > > drivers/gpu/drm/i915/i915_pmu.c:1190:   ret =3D
> > > perf_pmu_register(&pmu->base, pmu->name, -1);
> > > drivers/hwtracing/coresight/coresight-etm-perf.c:907:   ret =3D
> > > perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
> > > drivers/hwtracing/ptt/hisi_ptt.c:895:   ret =3D
> > > perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
> > > drivers/iommu/intel/perfmon.c:570:      return
> > > perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
> > > drivers/nvdimm/nd_perf.c:309:   rc =3D perf_pmu_register(&nd_pmu->pmu=
,
> > > nd_pmu->pmu.name, -1);
> > > ...
> > >
> > > I just wondering what kind of pmu drivers should be in drivers/perf
> > > and what kind of pmu drivers should not be in drivers/perf.
> > > Thanks.
> >
> > To be quite honest, I have no idea.
> > I'm just a wee bit wary of taking anything that appears to have another
> > home via drivers/soc. I'd rather break drivers out, using the aux bus o=
r
> > similar if need be, so that people who are knowledgeable in an area are
> > CCed on patches.
> > Hopefully Arnd or the Perf people can offer some guidance here. If it
> > does go into drivers/soc, it'll need a review from someone knowledgeabl=
e
> > of perf anyway.
>
> I'm not territorial about the perf drivers at all, but L2CC PMUs like thi=
s
> one probably fit pretty well in drivers/perf. The usual reason for puttin=
g
> drivers elsewhere is if the PMU is tightly coupled with some other IP whi=
ch
> is handled by another subsystem (e.g. GPU).
>
Thanks for the explanation. OK, I'll put the pl2 cache PMU driver in
drivers/perf.

Best Regards,
Eric Lin.

> Will
