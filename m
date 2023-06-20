Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049C73621A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjFTDPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjFTDOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:14:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB361B0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:14:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so5488754e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687230885; x=1689822885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqyo5lF4AwdBTzGc1HNFwSE64aWc0p6L5cBBmEt7Tpc=;
        b=i/EUqGMyUXa9aG6pPFn0r02UAFn+MavJrb9ApbyAaak83jn+3pyNYz6C6vhJkpZjGl
         STArlSqWxB6SCQPvMmZM2ej3jZJt9X8DVNtSnmSdfRBpDYqJal4rpP6m+nEQYDdm3JaT
         N/yZzr52RjN1EeaHz38psuMSshz1wuHsGW6jCczk7dxhcod3789zhFvqHKGMiMigZ9tJ
         //XtKOTbeDzYg2SB7kmgfB7rKx+vG7HJFyCEB8852iMc9bZKj6MK6hN7Z9AjzIlzhjS2
         KgpZkQKOopwysEcRKJRNSDMtqZd1dDW2vaEIcF6IURyh5ja3LbVF87Rbg5GwaT9HR9Bn
         8kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687230885; x=1689822885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqyo5lF4AwdBTzGc1HNFwSE64aWc0p6L5cBBmEt7Tpc=;
        b=eZL6e9gbK+UTAnyEQ+OAslBciBrWNed/Qdbn6KiIXTO9I+9wva1eRo0/+4oHT4OL+P
         ctDexyjAlzXlNAsAzieF9gYw4qBuePFjJW9HOF03eJ3+EIt0AtWmMEl0Fjw3w8RYe159
         AveBt2rsnKDlc3kyyq/Z02GFIRvRVZRX49/YEwcK7mOxkMW1UxAaoPiSnwkUnBxEQEej
         Xi8dVCAqLgHoHqDWmlfTxchRKHQTY6dwwQTyjjYkitENKSF+qtielyns0NiUGa+01Br9
         PvwOZPXICAxHTnd+nXJJ1/VSaMGL3Q4DdwoAUEWqfGiquyHDKhuXxZzpcIVJqV5nynzK
         bI+w==
X-Gm-Message-State: AC+VfDyEcZk45elfam4vjQG38ie6X+Xzn7W556p93iDddUgOYqO06Kim
        sgWZrUAvSyUOyKiHXKqat4tgFmVrDbsHRUIKZWClIA==
X-Google-Smtp-Source: ACHHUZ6vqEjLRW4QLCzyiLQ48x1Nfy69MYGkWlDCTNK0yoj1tcpO2ZxAZS7wqqWmeiELbNh5hu82AcEGOEWj4D1qOzs=
X-Received: by 2002:a05:6512:554:b0:4f8:66db:8235 with SMTP id
 h20-20020a056512055400b004f866db8235mr3417503lfl.39.1687230884819; Mon, 19
 Jun 2023 20:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-3-eric.lin@sifive.com>
 <20230616-revision-speed-a83dc926b334@wendy>
In-Reply-To: <20230616-revision-speed-a83dc926b334@wendy>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Tue, 20 Jun 2023 11:14:32 +0800
Message-ID: <CAPqJEFo5genyjY7qJBaESzeppbEnTiDe9qzv98ETLhWfMZeG4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, jgross@suse.com, chao.gao@intel.com,
        maobibo@loongson.cn, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dslin1010@gmail.com, Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
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

On Fri, Jun 16, 2023 at 6:13=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, Jun 16, 2023 at 02:32:09PM +0800, Eric Lin wrote:
> > From: Greentime Hu <greentime.hu@sifive.com>
> >
> > This adds SiFive private L2 cache PMU driver. User
> > can use perf tool to profile by event name and event id.
> >
> > Example:
> > $ perf stat -C 0 -e /sifive_pl2_pmu/inner_acquire_block_btot/
> >                 -e /sifive_pl2_pmu/inner_acquire_block_ntob/
> >                 -e /sifive_pl2_pmu/inner_acquire_block_ntot/ ls
> >
> >  Performance counter stats for 'CPU(s) 0':
> >
> >                300      sifive_pl2_pmu/inner_acquire_block_btot/
> >              17801      sifive_pl2_pmu/inner_acquire_block_ntob/
> >               5253      sifive_pl2_pmu/inner_acquire_block_ntot/
> >
> >        0.088917326 seconds time elapsed
> >
> > $ perf stat -C 0 -e /sifive_pl2_pmu/event=3D0x10001/
> >                 -e /sifive_pl2_pmu/event=3D0x4001/
> >                 -e /sifive_pl2_pmu/event=3D0x8001/ ls
> >
> >  Performance counter stats for 'CPU(s) 0':
> >
> >                251      sifive_pl2_pmu/event=3D0x10001/
> >               2620      sifive_pl2_pmu/event=3D0x4001/
> >                644      sifive_pl2_pmu/event=3D0x8001/
> >
> >        0.092827110 seconds time elapsed
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Nick Hu <nick.hu@sifive.com>
> > ---
> >  drivers/soc/sifive/Kconfig            |   9 +
> >  drivers/soc/sifive/Makefile           |   1 +
> >  drivers/soc/sifive/sifive_pl2.h       |  20 +
> >  drivers/soc/sifive/sifive_pl2_cache.c |  16 +
> >  drivers/soc/sifive/sifive_pl2_pmu.c   | 669 ++++++++++++++++++++++++++
>
> Perf drivers should be in drivers/perf, no?
>

Hi Conor,

Yes, I see most of the drivers are in the drivers/perf.

But I grep perf_pmu_register(), it seems not all the pmu drivers are
in drivers/perf as below:

arch/arm/mach-imx/mmdc.c:517:   ret =3D
perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
arch/arm/mm/cache-l2x0-pmu.c:552:       ret =3D
perf_pmu_register(l2x0_pmu, l2x0_name, -1);
...
drivers/dma/idxd/perfmon.c:627: rc =3D perf_pmu_register(&idxd_pmu->pmu,
idxd_pmu->name, -1);
drivers/fpga/dfl-fme-perf.c:904:static int
fme_perf_pmu_register(struct platform_device *pdev,
drivers/fpga/dfl-fme-perf.c:929:        ret =3D perf_pmu_register(pmu, name=
, -1);
...
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:549:    ret =3D
perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
drivers/gpu/drm/i915/i915_pmu.c:1190:   ret =3D
perf_pmu_register(&pmu->base, pmu->name, -1);
drivers/hwtracing/coresight/coresight-etm-perf.c:907:   ret =3D
perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
drivers/hwtracing/ptt/hisi_ptt.c:895:   ret =3D
perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
drivers/iommu/intel/perfmon.c:570:      return
perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
drivers/nvdimm/nd_perf.c:309:   rc =3D perf_pmu_register(&nd_pmu->pmu,
nd_pmu->pmu.name, -1);
...

I just wondering what kind of pmu drivers should be in drivers/perf
and what kind of pmu drivers should not be in drivers/perf.
Thanks.


Best regards,
Eric Lin

> Cheers,
> Conor.
