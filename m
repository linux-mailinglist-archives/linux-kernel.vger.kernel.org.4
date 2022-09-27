Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152185EC1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiI0LnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiI0LnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:43:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1FE5127550;
        Tue, 27 Sep 2022 04:43:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 508821042;
        Tue, 27 Sep 2022 04:43:07 -0700 (PDT)
Received: from [10.57.32.158] (unknown [10.57.32.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2DCF3F73B;
        Tue, 27 Sep 2022 04:42:57 -0700 (PDT)
Message-ID: <7082762d-2d4d-aa7b-656c-75593b0697f0@arm.com>
Date:   Tue, 27 Sep 2022 12:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v4 2/2] perf: arm_cspmu: Add support for NVIDIA SCF and
 MCF attribute
To:     Besar Wicaksono <bwicaksono@nvidia.com>, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
 <20220814182351.8861-3-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220814182351.8861-3-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2022 19:23, Besar Wicaksono wrote:
> Add support for NVIDIA System Cache Fabric (SCF) and Memory Control
> Fabric (MCF) PMU attributes for CoreSight PMU implementation in
> NVIDIA devices.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>   Documentation/admin-guide/perf/index.rst      |   1 +
>   Documentation/admin-guide/perf/nvidia-pmu.rst | 120 ++++++
>   drivers/perf/arm_cspmu/Makefile               |   3 +-
>   drivers/perf/arm_cspmu/arm_cspmu.c            |   7 +
>   drivers/perf/arm_cspmu/nvidia_cspmu.c         | 367 ++++++++++++++++++
>   drivers/perf/arm_cspmu/nvidia_cspmu.h         |  17 +
>   6 files changed, 514 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/admin-guide/perf/nvidia-pmu.rst
>   create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.c
>   create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
> 
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 69b23f087c05..cf05fed1f67f 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -17,3 +17,4 @@ Performance monitor support
>      xgene-pmu
>      arm_dsu_pmu
>      thunderx2-pmu
> +   nvidia-pmu
> diff --git a/Documentation/admin-guide/perf/nvidia-pmu.rst b/Documentation/admin-guide/perf/nvidia-pmu.rst
> new file mode 100644
> index 000000000000..c41b93965824
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/nvidia-pmu.rst
> @@ -0,0 +1,120 @@
> +=========================================================
> +NVIDIA Tegra SoC Uncore Performance Monitoring Unit (PMU)
> +=========================================================
> +
> +The NVIDIA Tegra SoC includes various system PMUs to measure key performance
> +metrics like memory bandwidth, latency, and utilization:
> +
> +* Scalable Coherency Fabric (SCF)
> +* Memory Controller Fabric (MCF) GPU physical interface
> +* MCF GPU virtual interface
> +* MCF NVLINK interface
> +* MCF PCIE interface
> +
> +PMU Driver
> +----------
> +
> +The PMUs in this document are based on ARM CoreSight PMU Architecture as
> +described in document: ARM IHI 0091. Since this is a standard architecture, the
> +PMUs are managed by a common driver "arm-cs-arch-pmu". This driver describes
> +the available events and configuration of each PMU in sysfs. Please see the
> +sections below to get the sysfs path of each PMU. Like other uncore PMU driver,
> +the driver provides "cpumask" sysfs attribute to show the CPU id used to handle
> +the PMU event. There is also "associated_cpus" sysfs attribute, which contains a
> +list of CPUs associated with the PMU instance.
> +
> +SCF PMU
> +-------
> +
> +The SCF PMU monitors system level cache events, CPU traffic, and
> +strongly-ordered PCIE traffic to local/remote memory.
> +
> +The events and configuration options of this PMU device are described in sysfs,
> +see /sys/bus/event_sources/devices/nvidia_scf_pmu_<socket-id>.
> +
> +Example usage::
> +
> +  perf stat -a -e nvidia_scf_pmu_0/config=0x0/
> +
> +This will count the events in socket 0.
> +
> +MCF GPU Physical PMU
> +--------------------
> +
> +The MCF GPU physical PMU monitors ATS translated traffic from GPU to
> +local/remote memory via Nvlink C2C.
> +
> +The events and configuration options of this PMU device are described in sysfs,
> +see /sys/bus/event_sources/devices/nvidia_mcf_gpu_pmu_<socket-id>.
> +
> +Multiple GPUs can be connected to the SoC. The user can use "gpu" bitmap
> +parameter to select the GPU(s) to monitor, i.e. "gpu=0xF" corresponds to GPU 0
> +to 3. /sys/bus/event_sources/devices/nvidia_mcf_gpu_pmu_<socket-id>/format/gpu
> +shows the valid bits that can be set in the "gpu" parameter.
> +
> +Example usage::
> +
> +  perf stat -a -e nvidia_mcf_gpu_pmu_0/config=0x0,gpu=0x3/
> +
> +This will count the events on GPU 0 and 1 that are connected to SoC in socket 0.
> +
> +MCF GPU Virtual PMU
> +-------------------
> +
> +The MCF GPU virtual PMU monitors SMMU inline translated traffic (as opposed to
> +ATS) from GPU to local/remote memory via Nvlink C2C.
> +
> +The events and configuration options of this PMU device are described in sysfs,
> +see /sys/bus/event_sources/devices/nvidia_mcf_gpuvir_pmu_<socket-id>.
> +
> +Multiple GPUs can be connected to the SoC. The user can use "gpu" bitmap
> +parameter to select the GPU(s) to monitor, i.e. "gpu=0xF" corresponds to GPU 0
> +to 3. /sys/bus/event_sources/devices/nvidia_mcf_gpuvir_pmu_<socket-id>/format/gpu
> +shows the valid bits that can be set in the "gpu" parameter.
> +
> +Example usage::
> +
> +  perf stat -a -e nvidia_mcf_gpuvir_pmu_0/config=0x0,gpu=0x3/
> +
> +This will count the events on GPU 0 and 1 that are connected to SoC in socket 0.
> +
> +MCF NVLINK PMU
> +--------------
> +
> +The MCF NVLINK PMU monitors I/O coherent traffic from external socket to local
> +memory.
> +
> +The events and configuration options of this PMU device are described in sysfs,
> +see /sys/bus/event_sources/devices/nvidia_mcf_nvlink_pmu_<socket-id>.
> +
> +Each SoC socket can be connected to one or more sockets via NVLINK. The user can
> +use "rem_socket" bitmap parameter to select the remote socket(s) to monitor,
> +i.e. "rem_socket=0xE" corresponds to socket 1 to 3.
> +/sys/bus/event_sources/devices/nvidia_mcf_nvlink_pmu_<socket-id>/format/rem_socket
> +shows the valid bits that can be set in the "rem_socket" parameter.
> +
> +Example usage::
> +
> +  perf stat -a -e nvidia_mcf_nvlink_pmu_0/config=0x0,rem_socket=0x6/
> +
> +This will count the events from remote socket 1 and 2 to socket 0.
> +
> +MCF PCIE PMU
> +------------
> +
> +The MCF PCIE PMU monitors traffic from PCIE root ports to local/remote memory.
> +
> +The events and configuration options of this PMU device are described in sysfs,
> +see /sys/bus/event_sources/devices/nvidia_mcf_pcie_pmu_<socket-id>.
> +
> +Each SoC socket can support multiple root ports. The user can use
> +"root_port" bitmap parameter to select the port(s) to monitor, i.e.
> +"root_port=0xF" corresponds to root port 0 to 3.
> +/sys/bus/event_sources/devices/nvidia_mcf_pcie_pmu_<socket-id>/format/root_port
> +shows the valid bits that can be set in the "root_port" parameter.
> +
> +Example usage::
> +
> +  perf stat -a -e nvidia_mcf_pcie_pmu_0/config=0x0,root_port=0x3/
> +
> +This will count the events from root port 0 and 1 of socket 0.
> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
> index cdc3455f74d8..1b586064bd77 100644
> --- a/drivers/perf/arm_cspmu/Makefile
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -3,4 +3,5 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += \
> -	arm_cspmu.o
> +	arm_cspmu.o \
> +	nvidia_cspmu.o
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 410876f86eb0..7a0beb515e53 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -31,6 +31,7 @@
>   #include <acpi/processor.h>
>   
>   #include "arm_cspmu.h"
> +#include "nvidia_cspmu.h"
>   
>   #define PMUNAME "arm_cspmu"
>   #define DRVNAME "arm-cs-arch-pmu"
> @@ -118,6 +119,9 @@ static_assert(
>   			ops->callback = arm_cspmu_ ## callback;	\
>   	} while (0)
>   
> +/* JEDEC-assigned JEP106 identification code */
> +#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
> +
>   static unsigned long arm_cspmu_cpuhp_state;
>   
>   /*
> @@ -369,6 +373,9 @@ struct impl_match {
>   };
>   
>   static const struct impl_match impl_match[] = {
> +	{ .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
> +	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
> +	  .impl_init_ops = nv_cspmu_init_ops },

Super minor nit: Coding style. Could we use :

	{
		.field = value,
		...
	},

>   	{}
>   };
>   
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> new file mode 100644
> index 000000000000..261f20680bc1
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +/* Support for NVIDIA specific attributes. */
> +
> +#include "nvidia_cspmu.h"
> +
> +#define NV_MCF_PCIE_PORT_COUNT       10ULL
> +#define NV_MCF_PCIE_FILTER_ID_MASK   GENMASK_ULL(NV_MCF_PCIE_PORT_COUNT - 1, 0)
> +
> +#define NV_MCF_GPU_PORT_COUNT        2ULL
> +#define NV_MCF_GPU_FILTER_ID_MASK    GENMASK_ULL(NV_MCF_GPU_PORT_COUNT - 1, 0)
> +
> +#define NV_MCF_NVL_PORT_COUNT        4ULL
> +#define NV_MCF_NVL_FILTER_ID_MASK    GENMASK_ULL(NV_MCF_NVL_PORT_COUNT - 1, 0)
> +
> +#define NV_SCF_MCF_PRODID_MASK       GENMASK(31, 0)
> +
> +#define NV_FORMAT_NAME_GENERIC	0
> +
> +#define to_nv_cspmu_ctx(cspmu)	((struct nv_cspmu_ctx *)(cspmu->impl.ctx))
> +
> +#define NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _num, _suff, _config)	\
> +	ARM_CSPMU_EVENT_ATTR(_pref##_num##_suff, _config)
> +
> +#define NV_CSPMU_EVENT_ATTR_4(_pref, _suff, _config)			\
> +	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _0_, _suff, _config),	\
> +	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _1_, _suff, _config + 1),	\
> +	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _2_, _suff, _config + 2),	\
> +	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _3_, _suff, _config + 3)
> +
> +struct nv_cspmu_ctx {
> +	const char *name;
> +	u32 filter_mask;
> +	struct attribute **event_attr;
> +	struct attribute **format_attr;
> +};
> +
> +static struct attribute *scf_pmu_event_attrs[] = {
> +	ARM_CSPMU_EVENT_ATTR(bus_cycles,			0x1d),
> +
> +	ARM_CSPMU_EVENT_ATTR(scf_cache_allocate,		0xF0),
> +	ARM_CSPMU_EVENT_ATTR(scf_cache_refill,			0xF1),
> +	ARM_CSPMU_EVENT_ATTR(scf_cache,				0xF2),
> +	ARM_CSPMU_EVENT_ATTR(scf_cache_wb,			0xF3),
> +
> +	NV_CSPMU_EVENT_ATTR_4(socket, rd_data,			0x101),
> +	NV_CSPMU_EVENT_ATTR_4(socket, dl_rsp,			0x105),
> +	NV_CSPMU_EVENT_ATTR_4(socket, wb_data,			0x109),
> +	NV_CSPMU_EVENT_ATTR_4(socket, ev_rsp,			0x10d),
> +	NV_CSPMU_EVENT_ATTR_4(socket, prb_data,			0x111),
> +
> +	NV_CSPMU_EVENT_ATTR_4(socket, rd_outstanding,		0x115),
> +	NV_CSPMU_EVENT_ATTR_4(socket, dl_outstanding,		0x119),
> +	NV_CSPMU_EVENT_ATTR_4(socket, wb_outstanding,		0x11d),
> +	NV_CSPMU_EVENT_ATTR_4(socket, wr_outstanding,		0x121),
> +	NV_CSPMU_EVENT_ATTR_4(socket, ev_outstanding,		0x125),
> +	NV_CSPMU_EVENT_ATTR_4(socket, prb_outstanding,		0x129),
> +
> +	NV_CSPMU_EVENT_ATTR_4(socket, rd_access,		0x12d),
> +	NV_CSPMU_EVENT_ATTR_4(socket, dl_access,		0x131),
> +	NV_CSPMU_EVENT_ATTR_4(socket, wb_access,		0x135),
> +	NV_CSPMU_EVENT_ATTR_4(socket, wr_access,		0x139),
> +	NV_CSPMU_EVENT_ATTR_4(socket, ev_access,		0x13d),
> +	NV_CSPMU_EVENT_ATTR_4(socket, prb_access,		0x141),
> +
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_data,		0x145),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_access,		0x149),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_access,		0x14d),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_outstanding,		0x151),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_outstanding,		0x155),
> +
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_data,			0x159),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_access,		0x15d),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_access,		0x161),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_outstanding,		0x165),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_outstanding,		0x169),
> +
> +	ARM_CSPMU_EVENT_ATTR(gmem_rd_data,			0x16d),
> +	ARM_CSPMU_EVENT_ATTR(gmem_rd_access,			0x16e),
> +	ARM_CSPMU_EVENT_ATTR(gmem_rd_outstanding,		0x16f),
> +	ARM_CSPMU_EVENT_ATTR(gmem_dl_rsp,			0x170),
> +	ARM_CSPMU_EVENT_ATTR(gmem_dl_access,			0x171),
> +	ARM_CSPMU_EVENT_ATTR(gmem_dl_outstanding,		0x172),
> +	ARM_CSPMU_EVENT_ATTR(gmem_wb_data,			0x173),
> +	ARM_CSPMU_EVENT_ATTR(gmem_wb_access,			0x174),
> +	ARM_CSPMU_EVENT_ATTR(gmem_wb_outstanding,		0x175),
> +	ARM_CSPMU_EVENT_ATTR(gmem_ev_rsp,			0x176),
> +	ARM_CSPMU_EVENT_ATTR(gmem_ev_access,			0x177),
> +	ARM_CSPMU_EVENT_ATTR(gmem_ev_outstanding,		0x178),
> +	ARM_CSPMU_EVENT_ATTR(gmem_wr_data,			0x179),
> +	ARM_CSPMU_EVENT_ATTR(gmem_wr_outstanding,		0x17a),
> +	ARM_CSPMU_EVENT_ATTR(gmem_wr_access,			0x17b),
> +
> +	NV_CSPMU_EVENT_ATTR_4(socket, wr_data,			0x17c),
> +
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_data,		0x180),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_data,		0x184),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_access,		0x188),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_outstanding,		0x18c),
> +
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_data,			0x190),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_data,			0x194),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_access,		0x198),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_outstanding,		0x19c),
> +
> +	ARM_CSPMU_EVENT_ATTR(gmem_wr_total_bytes,		0x1a0),
> +	ARM_CSPMU_EVENT_ATTR(remote_socket_wr_total_bytes,	0x1a1),
> +	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_data,		0x1a2),
> +	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_outstanding,	0x1a3),
> +	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_access,		0x1a4),
> +
> +	ARM_CSPMU_EVENT_ATTR(cmem_rd_data,			0x1a5),
> +	ARM_CSPMU_EVENT_ATTR(cmem_rd_access,			0x1a6),
> +	ARM_CSPMU_EVENT_ATTR(cmem_rd_outstanding,		0x1a7),
> +	ARM_CSPMU_EVENT_ATTR(cmem_dl_rsp,			0x1a8),
> +	ARM_CSPMU_EVENT_ATTR(cmem_dl_access,			0x1a9),
> +	ARM_CSPMU_EVENT_ATTR(cmem_dl_outstanding,		0x1aa),
> +	ARM_CSPMU_EVENT_ATTR(cmem_wb_data,			0x1ab),
> +	ARM_CSPMU_EVENT_ATTR(cmem_wb_access,			0x1ac),
> +	ARM_CSPMU_EVENT_ATTR(cmem_wb_outstanding,		0x1ad),
> +	ARM_CSPMU_EVENT_ATTR(cmem_ev_rsp,			0x1ae),
> +	ARM_CSPMU_EVENT_ATTR(cmem_ev_access,			0x1af),
> +	ARM_CSPMU_EVENT_ATTR(cmem_ev_outstanding,		0x1b0),
> +	ARM_CSPMU_EVENT_ATTR(cmem_wr_data,			0x1b1),
> +	ARM_CSPMU_EVENT_ATTR(cmem_wr_outstanding,		0x1b2),
> +
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_data,		0x1b3),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_access,		0x1b7),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_access,		0x1bb),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_outstanding,		0x1bf),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_outstanding,		0x1c3),
> +
> +	ARM_CSPMU_EVENT_ATTR(ocu_prb_access,			0x1c7),
> +	ARM_CSPMU_EVENT_ATTR(ocu_prb_data,			0x1c8),
> +	ARM_CSPMU_EVENT_ATTR(ocu_prb_outstanding,		0x1c9),
> +
> +	ARM_CSPMU_EVENT_ATTR(cmem_wr_access,			0x1ca),
> +
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_access,		0x1cb),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_data,		0x1cf),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_data,		0x1d3),
> +	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_outstanding,		0x1d7),
> +
> +	ARM_CSPMU_EVENT_ATTR(cmem_wr_total_bytes,		0x1db),
> +
> +	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
> +	NULL,
> +};
> +
> +static struct attribute *mcf_pmu_event_attrs[] = {
> +	ARM_CSPMU_EVENT_ATTR(rd_bytes_loc,			0x0),
> +	ARM_CSPMU_EVENT_ATTR(rd_bytes_rem,			0x1),
> +	ARM_CSPMU_EVENT_ATTR(wr_bytes_loc,			0x2),
> +	ARM_CSPMU_EVENT_ATTR(wr_bytes_rem,			0x3),
> +	ARM_CSPMU_EVENT_ATTR(total_bytes_loc,			0x4),
> +	ARM_CSPMU_EVENT_ATTR(total_bytes_rem,			0x5),
> +	ARM_CSPMU_EVENT_ATTR(rd_req_loc,			0x6),
> +	ARM_CSPMU_EVENT_ATTR(rd_req_rem,			0x7),
> +	ARM_CSPMU_EVENT_ATTR(wr_req_loc,			0x8),
> +	ARM_CSPMU_EVENT_ATTR(wr_req_rem,			0x9),
> +	ARM_CSPMU_EVENT_ATTR(total_req_loc,			0xa),
> +	ARM_CSPMU_EVENT_ATTR(total_req_rem,			0xb),
> +	ARM_CSPMU_EVENT_ATTR(rd_cum_outs_loc,			0xc),
> +	ARM_CSPMU_EVENT_ATTR(rd_cum_outs_rem,			0xd),
> +	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
> +	NULL,
> +};
> +
> +static struct attribute *generic_pmu_event_attrs[] = {
> +	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
> +	NULL,
> +};
> +
> +static struct attribute *scf_pmu_format_attrs[] = {
> +	ARM_CSPMU_FORMAT_EVENT_ATTR,
> +	NULL,
> +};
> +
> +static struct attribute *mcf_pcie_pmu_format_attrs[] = {
> +	ARM_CSPMU_FORMAT_EVENT_ATTR,
> +	ARM_CSPMU_FORMAT_ATTR(root_port, "config1:0-9"),
> +	NULL,
> +};
> +
> +static struct attribute *mcf_gpu_pmu_format_attrs[] = {
> +	ARM_CSPMU_FORMAT_EVENT_ATTR,
> +	ARM_CSPMU_FORMAT_ATTR(gpu, "config1:0-1"),
> +	NULL,
> +};
> +
> +static struct attribute *mcf_nvlink_pmu_format_attrs[] = {
> +	ARM_CSPMU_FORMAT_EVENT_ATTR,
> +	ARM_CSPMU_FORMAT_ATTR(rem_socket, "config1:0-3"),
> +	NULL,
> +};
> +
> +static struct attribute *generic_pmu_format_attrs[] = {
> +	ARM_CSPMU_FORMAT_EVENT_ATTR,
> +	ARM_CSPMU_FORMAT_FILTER_ATTR,
> +	NULL,
> +};
> +
> +static struct attribute **
> +nv_cspmu_get_event_attrs(const struct arm_cspmu *cspmu)
> +{
> +	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
> +
> +	return ctx->event_attr;
> +}
> +
> +static struct attribute **
> +nv_cspmu_get_format_attrs(const struct arm_cspmu *cspmu)
> +{
> +	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
> +
> +	return ctx->format_attr;
> +}
> +
> +static const char *
> +nv_cspmu_get_name(const struct arm_cspmu *cspmu)
> +{
> +	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
> +
> +	return ctx->name;
> +}
> +
> +static u32 nv_cspmu_event_filter(const struct perf_event *event)
> +{
> +	const struct nv_cspmu_ctx *ctx =
> +		to_nv_cspmu_ctx(to_arm_cspmu(event->pmu));
> +
> +	return event->attr.config1 & ctx->filter_mask;
> +}
> +
> +enum nv_cspmu_name_fmt {
> +	NAME_FMT_GENERIC,
> +	NAME_FMT_PROC
> +};
> +
> +struct nv_cspmu_match {
> +	u32 prodid;
> +	u32 prodid_mask;
> +	u64 filter_mask;
> +	const char *name_pattern;
> +	enum nv_cspmu_name_fmt name_fmt;
> +	struct attribute **event_attr;
> +	struct attribute **format_attr;
> +};
> +
> +static const struct nv_cspmu_match nv_cspmu_match[] = {

Similar coding style nit below.


Otherwise,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
