Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26A663D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjAJJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjAJJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:57:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3336C3D1D4;
        Tue, 10 Jan 2023 01:57:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E795E4B3;
        Tue, 10 Jan 2023 01:58:01 -0800 (PST)
Received: from [10.57.89.71] (unknown [10.57.89.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC893F587;
        Tue, 10 Jan 2023 01:57:16 -0800 (PST)
Message-ID: <6ead4016-a8a2-4572-8f75-682726d04479@arm.com>
Date:   Tue, 10 Jan 2023 09:57:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v16 0/8] Coresight: Add support for TPDM and TPDA
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
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

On 06/01/2023 09:21, Mao Jinlong wrote:
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
> This patch series depends on patch series:
> "[v6,00/14] coresight: Add new API to allocate trace source ID values"
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20221123195010.6859-1-mike.leach@linaro.org/
> 
> TPDM_TPDA commit tree:
> https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-tpda-v16
> 

Please could you add a documentation for TPDA and TPDM under
Documentation/tracing/coresight/ ?

It need not be part of this series if you don't have to resend it.


Kind regards
Suzuki

