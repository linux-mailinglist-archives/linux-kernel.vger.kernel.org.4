Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A4B65C5D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbjACSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjACSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:12:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA0402BC1;
        Tue,  3 Jan 2023 10:12:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAD221516;
        Tue,  3 Jan 2023 10:13:23 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B17B73F663;
        Tue,  3 Jan 2023 10:12:33 -0800 (PST)
Message-ID: <67ae3a53-3db9-c1bc-2b67-08df14bc15cc@arm.com>
Date:   Tue, 3 Jan 2023 18:12:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH] arm64: dts: ls1028a: mark ARM SMMU as DMA coherent
Content-Language: en-GB
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
References: <20221208151514.3840720-1-vladimir.oltean@nxp.com>
 <2a188b8a-ab16-d5d4-ed5f-f8eec236e4ca@arm.com>
 <20221214165356.6tbzmfyoifqt4cwk@skbuf>
 <3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com>
 <20221219121618.z3dcyob542cnmdnk@skbuf>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221219121618.z3dcyob542cnmdnk@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 12:16 pm, Vladimir Oltean wrote:
> Hi Robin,
> 
> On Wed, Dec 14, 2022 at 08:33:10PM +0000, Robin Murphy wrote:
>>> Does looking at the CTTW bit make any sense for MMU-500?
>>
>> In general, yes. The result above does imply that NXP have inadvertently set
>> cfg_cttw wrong. For the avoidance of doubt, here's another MMU-500 showing
>> SMMU_IDR0.CTTW set:
>>
>> [    3.014972] arm-smmu arm-smmu.0.auto: probing hardware configuration...
>> [    3.014974] arm-smmu arm-smmu.0.auto: SMMUv2 with:
>> [    3.014976] arm-smmu arm-smmu.0.auto:        stage 2 translation
>> [    3.014977] arm-smmu arm-smmu.0.auto:        coherent table walk
>> [    3.014979] arm-smmu arm-smmu.0.auto:        stream matching with 128 register groups
>> [    3.014981] arm-smmu arm-smmu.0.auto:        128 context banks (128 stage-2 only)
>> [    3.014984] arm-smmu arm-smmu.0.auto:        Supported page sizes: 0x60211000
>> [    3.014986] arm-smmu arm-smmu.0.auto:        Stage-2: 48-bit IPA -> 48-bit PA
> 
> Thanks for the explanations and the patch you've sent separately.
> 
> I have a side question, why is the dev_name() of your SMMU set to
> "arm-smmu.0.auto" (determined by PLATFORM_DEVID_AUTO if I'm not mistaken)?

This is an ACPI-based machine, where platform device discovery and 
creation is... different :)

SMMUs are among those managed by drivers/acpi/arm64/iort.c

> I'm asking because I would like to study the mechanism through which
> your SMMU platform device get probed, to make sure that it's not
> possible, during shutdown, for both platform_driver :: shutdown()
> and platform_driver :: remove() methods to get called by the driver core.
> This is generally not disallowed, and even possible if the entity who
> registers these platform devices has its ->shutdown() method pointing
> at ->remove().

Yikes, I'd very much hope that that's not a thing!

Cheers,
Robin.
