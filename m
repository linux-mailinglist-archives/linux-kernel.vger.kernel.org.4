Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E4573B8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjFWNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjFWNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E27C213A;
        Fri, 23 Jun 2023 06:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F11BD61A51;
        Fri, 23 Jun 2023 13:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBD4C433C0;
        Fri, 23 Jun 2023 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687526656;
        bh=ya+979j6nW2ZkC3+qp94+q7c0uMnkw7U/dMO6m4wlqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1w28N72tr9K7DwVRXA1TYbu6gg+O3KhwX7tls3Oj3WVC535mHlV3dsi/ncKQcZH+
         679ghZFTBqkiuUDpmf+DRI75z5FGlKQn+KBF6G0kHjQov2XnfU0AYTytOTHPtKjgxO
         PFyK6qWdcig9q3FOpD2Z+jvGZkW6qJVojS1LO2XUNICnBPApsNmSkhWaxisg7mCW4Z
         jdHb5rPLzZaaapN2SXxLJIqn2wbqSYGSe3DsuGFSyjWhIxhOaGJ0ms4C1BsSbEWU5O
         P6pmHwuQeNM+lX1OINbFR4aGTZbH13HzJu3HXLQ6Bnnway10Qa22PkJD/hDJxMd5Xd
         iW7DBAT/y1ESA==
Date:   Fri, 23 Jun 2023 14:24:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Eric Lin <eric.lin@sifive.com>,
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
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
Message-ID: <20230623132402.GA17369@willie-the-truck>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-3-eric.lin@sifive.com>
 <20230616-revision-speed-a83dc926b334@wendy>
 <CAPqJEFo5genyjY7qJBaESzeppbEnTiDe9qzv98ETLhWfMZeG4A@mail.gmail.com>
 <20230621-stupor-violin-930ccc7d7593@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621-stupor-violin-930ccc7d7593@spud>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Wed, Jun 21, 2023 at 04:17:24PM +0100, Conor Dooley wrote:
> On Tue, Jun 20, 2023 at 11:14:32AM +0800, Eric Lin wrote:
> > On Fri, Jun 16, 2023 at 6:13 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> > > On Fri, Jun 16, 2023 at 02:32:09PM +0800, Eric Lin wrote:
> > > >  drivers/soc/sifive/Kconfig            |   9 +
> > > >  drivers/soc/sifive/Makefile           |   1 +
> > > >  drivers/soc/sifive/sifive_pl2.h       |  20 +
> > > >  drivers/soc/sifive/sifive_pl2_cache.c |  16 +
> > > >  drivers/soc/sifive/sifive_pl2_pmu.c   | 669 ++++++++++++++++++++++++++
> > >
> > > Perf drivers should be in drivers/perf, no?
> > >
> > 
> > But I grep perf_pmu_register(), it seems not all the pmu drivers are
> > in drivers/perf as below:
> > 
> > arch/arm/mach-imx/mmdc.c:517:   ret =
> > perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
> > arch/arm/mm/cache-l2x0-pmu.c:552:       ret =
> > perf_pmu_register(l2x0_pmu, l2x0_name, -1);
> > ...
> > drivers/dma/idxd/perfmon.c:627: rc = perf_pmu_register(&idxd_pmu->pmu,
> > idxd_pmu->name, -1);
> > drivers/fpga/dfl-fme-perf.c:904:static int
> > fme_perf_pmu_register(struct platform_device *pdev,
> > drivers/fpga/dfl-fme-perf.c:929:        ret = perf_pmu_register(pmu, name, -1);
> > ...
> > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:549:    ret =
> > perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
> > drivers/gpu/drm/i915/i915_pmu.c:1190:   ret =
> > perf_pmu_register(&pmu->base, pmu->name, -1);
> > drivers/hwtracing/coresight/coresight-etm-perf.c:907:   ret =
> > perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
> > drivers/hwtracing/ptt/hisi_ptt.c:895:   ret =
> > perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
> > drivers/iommu/intel/perfmon.c:570:      return
> > perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
> > drivers/nvdimm/nd_perf.c:309:   rc = perf_pmu_register(&nd_pmu->pmu,
> > nd_pmu->pmu.name, -1);
> > ...
> > 
> > I just wondering what kind of pmu drivers should be in drivers/perf
> > and what kind of pmu drivers should not be in drivers/perf.
> > Thanks.
> 
> To be quite honest, I have no idea.
> I'm just a wee bit wary of taking anything that appears to have another
> home via drivers/soc. I'd rather break drivers out, using the aux bus or
> similar if need be, so that people who are knowledgeable in an area are
> CCed on patches.
> Hopefully Arnd or the Perf people can offer some guidance here. If it
> does go into drivers/soc, it'll need a review from someone knowledgeable
> of perf anyway.

I'm not territorial about the perf drivers at all, but L2CC PMUs like this
one probably fit pretty well in drivers/perf. The usual reason for putting
drivers elsewhere is if the PMU is tightly coupled with some other IP which
is handled by another subsystem (e.g. GPU).

Will
