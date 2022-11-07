Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE4761FDB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiKGSkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKGSju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:39:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62E3E1ADA4;
        Mon,  7 Nov 2022 10:39:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32AD71FB;
        Mon,  7 Nov 2022 10:39:08 -0800 (PST)
Received: from [10.57.67.115] (unknown [10.57.67.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BC543F534;
        Mon,  7 Nov 2022 10:38:59 -0800 (PST)
Message-ID: <69a3cd4b-c4b0-b998-b4c1-70a928690972@arm.com>
Date:   Mon, 7 Nov 2022 18:38:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v14 0/9] Coresight: Add support for TPDM and TPDA
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 09:19, Mao Jinlong wrote:
> This series adds support for the trace performance monitoring and
> diagnostics hardware (TPDM and TPDA). It is composed of two major
> elements.
> a) Changes for original coresight framework to support for TPDM and TPDA.
> b) Add driver code for TPDM and TPDA.
> 
> Introduction of changes for original coresight framework
> Support TPDM as new coresight source.
> Since only STM and ETM are supported as coresight source originally.
> TPDM is a newly added coresight source. We need to change
> the original way of saving coresight path to support more types source
> for coresight driver.
> The following patch is to add support more coresight sources.
>      coresight: core: Use IDR for non-cpu bound sources' paths.
> 
---8>---

> Introduction of TPDM and TPDA
> TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
> short serves as data collection component for various dataset types
> specified in the QPMDA(Qualcomm performance monitoring and diagnostics
> architecture) spec. The primary use case of the TPDM is to collect data
> from different data sources and send it to a TPDA for packetization,
> timestamping and funneling.
>       Coresight: Add coresight TPDM source driver
>       dt-bindings: arm: Adds CoreSight TPDM hardware definitions
>       coresight-tpdm: Add DSB dataset support
>       coresight-tpdm: Add integration test support
>       docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
> 
> TPDA - The trace performance monitoring and diagnostics aggregator or
> TPDA in short serves as an arbitration and packetization engine for the
> performance monitoring and diagnostics network as specified in the QPMDA
> (Qualcomm performance monitoring and diagnostics architecture)
> specification. The primary use case of the TPDA is to provide
> packetization, funneling and timestamping of Monitor data as specified
> in the QPMDA specification.
> The following patch is to add driver for TPDA.
>       Coresight: Add TPDA link driver
>       dt-bindings: arm: Adds CoreSight TPDA hardware definitions
> 
> The last patch of this series is a device tree modification, which add
> the TPDM and TPDA configuration to device tree for validating.
>      ARM: dts: msm: Add coresight components for SM8250
>      ARM: dts: msm: Add tpdm mm/prng for sm8250
> 
> Once this series patches are applied properly, the tpdm and tpda nodes
> should be observed at the coresight path /sys/bus/coresight/devices
> e.g.
> /sys/bus/coresight/devices # ls -l | grep tpd
> tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
> tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0
> 
> We can use the commands are similar to the below to validate TPDMs.
> Enable coresight sink first.
> 
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> The test data will be collected in the coresight sink which is enabled.
> If rwp register of the sink is keeping updating when do
> integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
> generated from TPDM to sink.
> 
> There must be a tpda between tpdm and the sink. When there are some
> other trace event hw components in the same HW block with tpdm, tpdm
> and these hw components will connect to the coresight funnel. When
> there is only tpdm trace hw in the HW block, tpdm will connect to
> tpda directly.
>    
>      +---------------+                +-------------+
>      |  tpdm@6c08000 |                |tpdm@684C000 |
>      +-------|-------+                +------|------+
>              |                               |
>      +-------|-------+                       |
>      | funnel@6c0b000|                       |
>      +-------|-------+                       |
>              |                               |
>      +-------|-------+                       |
>      |funnel@6c2d000 |                       |
>      +-------|-------+                       |
>              |                               |
>              |    +---------------+          |
>              +----- tpda@6004000  -----------+
>                   +-------|-------+
>                           |
>                   +-------|-------+
>                   |funnel@6005000 |
>                   +---------------+
> 

--8<--

Please could you add the above to a Documentation file (Of course
skip the description of patches).


> This patch series depends on patch series:
> "[v5,00/14] coresight: Add new API to allocate trace source ID values"
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20221101163103.17921-1-mike.leach@linaro.org/

So, is there a strict binding between a TPDM and a TPDA ?
i.e., Multiple TPDMs could never end up reaching the sam
TPDA ? I see that the TPDMs could be connected to funnels
and thus other TPDMs could be connected to the same funnels
and thus reach the same TPDA.

Also, the trace-id is bound to TPDA and not TPDM. So, if
we have multiple TPDMs, trace decoding is going to be
impossible.

Thanks
Suzuki

> 
> Mao Jinlong (9):
>    coresight: core: Use IDR for non-cpu bound sources' paths.
>    Coresight: Add coresight TPDM source driver
>    dt-bindings: arm: Adds CoreSight TPDM hardware
>    coresight-tpdm: Add DSB dataset support
>    coresight-tpdm: Add integration test support
>    Coresight: Add TPDA link driver
>    dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>    arm64: dts: qcom: sm8250: Add coresight components
>    arm64: dts: qcom: sm8250: Add tpdm mm/prng
> 
>   .../testing/sysfs-bus-coresight-devices-tpdm  |  13 +
>   .../bindings/arm/qcom,coresight-tpda.yaml     | 111 +++
>   .../bindings/arm/qcom,coresight-tpdm.yaml     |  93 +++
>   MAINTAINERS                                   |   1 +
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          | 671 ++++++++++++++++++
>   drivers/hwtracing/coresight/Kconfig           |  23 +
>   drivers/hwtracing/coresight/Makefile          |   2 +
>   drivers/hwtracing/coresight/coresight-core.c  |  42 +-
>   drivers/hwtracing/coresight/coresight-tpda.c  | 208 ++++++
>   drivers/hwtracing/coresight/coresight-tpda.h  |  35 +
>   drivers/hwtracing/coresight/coresight-tpdm.c  | 259 +++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h  |  62 ++
>   include/linux/coresight.h                     |   1 +
>   13 files changed, 1509 insertions(+), 12 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
> 

