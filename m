Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A3174F30B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGKPJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGKPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:08:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490DAA0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:08:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso93010101fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689088135; x=1691680135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELbRN/LifTQ/7zfClfcRkCTRTEOE/j2wLv/6DGZBUz4=;
        b=bHShCj9WG6pWGVLraRILWTJ5Y6Mng+dA241HQjJRiFC35Gq1C/o5NW6At9jKzg/rbX
         Zqokjm0nSV5C4DYOXykaXAsu32+8OkBgyjAE4UuMzsJqVnpFMREp+43yARPuzrWVvnqP
         4JSK+5PwF1fY/5hcE/B7w1V4JrnX142QDccqWs4eAZ83DYQ5Etg9/pJV+h9iwON/dpSb
         Efw8rDIr7GVWNglfdYQjccwsfKpqH7BhHMrA35G7xEoSGEh7G5fSwXA8dmLiDufUwcfk
         nVvAKnFlI6ihu4nxJpkF4BAHv//PG48mX8nsoijXRUKtIQJT+JCQjVflSVZvglMin8TM
         Og3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088135; x=1691680135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELbRN/LifTQ/7zfClfcRkCTRTEOE/j2wLv/6DGZBUz4=;
        b=ioM9naAuAWpxPtKMlNoFbraHdU9uRkufgqUv5qYoOMS4AlETX/4xViHw5bbEhhviA0
         yQWnuXZdw7DfcnQP3XRF+/2sNJvH6DC0oJ++BcdZFJ3NYEevWzpI7/bKDpAVu7MePiY7
         o8TncjdshNJnpn/11jA9xgfGNSDX5zbYr33U7x8NzuLmY6Vue9hKGmd2ymXqcv8ELAxz
         GYgwBm9izWijntf4oTQYkKK6pWRNumoFdPXa4K9kui92wJs45WxnFqtV+3oBlOjJq/Sm
         IavzxX1SjrFjJfaqccZIpRLY56MEExcRBtSPoCGRbShK/suvT9zo74gdt3NAA0pP1kG/
         emaQ==
X-Gm-Message-State: ABy/qLZMYy020uTFyIN3KTO18ZPKDZ2fGUfWrjhMaNXsSC8ZdFPGbHJI
        D4Z9A2hRYmX7JpEkwewMITLl15OPUuux9V075rbCHA==
X-Google-Smtp-Source: APBJJlFyHgLU0mFIDZnS5y64MOAa8Euz64fKBxKrauS2sfQG8LwcHwrFCtcUV/dbu7fZM9mUz4o8e49Feg8R5ByUPWU=
X-Received: by 2002:a2e:b0c6:0:b0:2b6:fa3f:9230 with SMTP id
 g6-20020a2eb0c6000000b002b6fa3f9230mr11813753ljl.46.1689088135367; Tue, 11
 Jul 2023 08:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-3-eric.lin@sifive.com>
 <20230616-revision-speed-a83dc926b334@wendy> <CAPqJEFo5genyjY7qJBaESzeppbEnTiDe9qzv98ETLhWfMZeG4A@mail.gmail.com>
 <74385f9d-ed8d-8906-13e3-b3091dae7993@codethink.co.uk>
In-Reply-To: <74385f9d-ed8d-8906-13e3-b3091dae7993@codethink.co.uk>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Tue, 11 Jul 2023 23:08:44 +0800
Message-ID: <CAPqJEFpSkN9fJgNut6bdZUzpTvNp_mikWdCSrE=TNnajf5BRRw@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     will@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Tue, Jul 11, 2023 at 4:41=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> On 20/06/2023 04:14, Eric Lin wrote:
> > On Fri, Jun 16, 2023 at 6:13=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> >>
> >> On Fri, Jun 16, 2023 at 02:32:09PM +0800, Eric Lin wrote:
> >>> From: Greentime Hu <greentime.hu@sifive.com>
> >>>
> >>> This adds SiFive private L2 cache PMU driver. User
> >>> can use perf tool to profile by event name and event id.
> >>>
> >>> Example:
> >>> $ perf stat -C 0 -e /sifive_pl2_pmu/inner_acquire_block_btot/
> >>>                  -e /sifive_pl2_pmu/inner_acquire_block_ntob/
> >>>                  -e /sifive_pl2_pmu/inner_acquire_block_ntot/ ls
> >>>
> >>>   Performance counter stats for 'CPU(s) 0':
> >>>
> >>>                 300      sifive_pl2_pmu/inner_acquire_block_btot/
> >>>               17801      sifive_pl2_pmu/inner_acquire_block_ntob/
> >>>                5253      sifive_pl2_pmu/inner_acquire_block_ntot/
> >>>
> >>>         0.088917326 seconds time elapsed
> >>>
> >>> $ perf stat -C 0 -e /sifive_pl2_pmu/event=3D0x10001/
> >>>                  -e /sifive_pl2_pmu/event=3D0x4001/
> >>>                  -e /sifive_pl2_pmu/event=3D0x8001/ ls
> >>>
> >>>   Performance counter stats for 'CPU(s) 0':
> >>>
> >>>                 251      sifive_pl2_pmu/event=3D0x10001/
> >>>                2620      sifive_pl2_pmu/event=3D0x4001/
> >>>                 644      sifive_pl2_pmu/event=3D0x8001/
> >>>
> >>>         0.092827110 seconds time elapsed
> >>>
> >>> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> >>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> >>> Reviewed-by: Zong Li <zong.li@sifive.com>
> >>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> >>> ---
> >>>   drivers/soc/sifive/Kconfig            |   9 +
> >>>   drivers/soc/sifive/Makefile           |   1 +
> >>>   drivers/soc/sifive/sifive_pl2.h       |  20 +
> >>>   drivers/soc/sifive/sifive_pl2_cache.c |  16 +
> >>>   drivers/soc/sifive/sifive_pl2_pmu.c   | 669 +++++++++++++++++++++++=
+++
> >>
> >> Perf drivers should be in drivers/perf, no?
> >>
> >
> > Hi Conor,
> >
> > Yes, I see most of the drivers are in the drivers/perf.
> >
> > But I grep perf_pmu_register(), it seems not all the pmu drivers are
> > in drivers/perf as below:
> >
> > arch/arm/mach-imx/mmdc.c:517:   ret =3D
> > perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
> > arch/arm/mm/cache-l2x0-pmu.c:552:       ret =3D
> > perf_pmu_register(l2x0_pmu, l2x0_name, -1);
> > ...
> > drivers/dma/idxd/perfmon.c:627: rc =3D perf_pmu_register(&idxd_pmu->pmu=
,
> > idxd_pmu->name, -1);
> > drivers/fpga/dfl-fme-perf.c:904:static int
> > fme_perf_pmu_register(struct platform_device *pdev,
> > drivers/fpga/dfl-fme-perf.c:929:        ret =3D perf_pmu_register(pmu, =
name, -1);
> > ...
> > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:549:    ret =3D
> > perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
> > drivers/gpu/drm/i915/i915_pmu.c:1190:   ret =3D
> > perf_pmu_register(&pmu->base, pmu->name, -1);
> > drivers/hwtracing/coresight/coresight-etm-perf.c:907:   ret =3D
> > perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
> > drivers/hwtracing/ptt/hisi_ptt.c:895:   ret =3D
> > perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
> > drivers/iommu/intel/perfmon.c:570:      return
> > perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
> > drivers/nvdimm/nd_perf.c:309:   rc =3D perf_pmu_register(&nd_pmu->pmu,
> > nd_pmu->pmu.name, -1);
> > ...
> >
> > I just wondering what kind of pmu drivers should be in drivers/perf
> > and what kind of pmu drivers should not be in drivers/perf.
> > Thanks.
> >
>
> Given the registers for the l2 cache controls and l2 pmu don't overlap
> do we need the pmu and general cache drivers together?
>

From Will's suggestion, I'll put the pl2 pmu driver to drivers/perf in
v2. Thanks.

Best Regards,
Eric Lin.

> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
>
