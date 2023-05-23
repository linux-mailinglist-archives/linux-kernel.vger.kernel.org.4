Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19B70E55D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbjEWT3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbjEWT3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:29:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29806126;
        Tue, 23 May 2023 12:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqvLf7hHkdUOqd9NeRlrX5eo0Bk0ykapi7liiXBFz7MdilLDQRqFNECEG6KhZgtvcGeMbuaWhvAuutcdkGx9leLDfYWRnkAd63TSkmkMWuvkRP6lCztKuOQFjZKSjXjDsnrrP4JM9LMnCSauUcU4+qHRweH/neOeeJAiuUnzN0KLO/twwn/yaujA4kqhkRAetP/60pYAav4wzBUv29LZFnnp+grR9HRJNSr9BTchHXD4GkRBVttBUeVL2X7p+21SUa+decgG+J9HCMpOBJjP2tiyJ48Z05HEDOoNAABoPk+MLSyOIfMm6YniywXUJnA/cR84N7kKBiHavQHA4u+Bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX/9XDoo0YbDXURDbVwMHkKb4pAE0c5n5ThHdtyEICk=;
 b=J0N0K+LrlQOrmZHaFKwoMJLqS2Q5aX36adakSaHDXizEip66rdUVOrLG7GS4p1JQILp47mUQr2LNytyy2WBKy7ubxsSHh6/qKQfUpURRZRDqC8quwwhgTvBhY+j6I8p35nyEadAaehuGEiG93vQeI8luTTVKqtjfdiJSwYYo+A8/XexKYEnPZTRtDvMmV1xYx0JasoLVeRVqVO2fUTMzYEqOyONYbAddj8ZjSPR6w5QNZyb997ishEP/phnJGsO00gpzWXJn3xz6lHRV7xeZKF3gcpUzviib3NNhPimp1DLmyfH1Proz4+Tg6QAu05wUq+1aKW03k0W+K39abc9OUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX/9XDoo0YbDXURDbVwMHkKb4pAE0c5n5ThHdtyEICk=;
 b=iB8kAq+wdGfmM3NfFZwbGHOfeo1+LvssWHs5heotT1nz+J7iAg9AAjIs3skCxs8okqdPEKsROHpBURlco6tHK7lQbBEwiGbr+YlIq+gBFuoyeE9RT4hDodMRSlirOBdgeY/cRuOxLGU1k4VnLnYr2UKxZw+8GqGaLlc6FWCHgvU=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 19:29:12 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c2) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 19:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 19:29:11 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 23 May 2023 14:29:05 -0500
From:   Brad Larson <blarson@amd.com>
To:     <michal.simek@amd.com>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>,
        <hal.feng@starfivetech.com>, <hasegawa-hitomi@fujitsu.com>,
        <j.neuschaefer@gmx.net>, <joel@jms.id.au>, <kernel@esmil.dk>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee.jones@linaro.org>, <lee@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v14 6/8] arm64: dts: Add AMD Pensando Elba SoC support
Date:   Tue, 23 May 2023 12:28:58 -0700
Message-ID: <20230523192858.31924-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e4227418-151d-7222-b439-4ce53bf0fb81@amd.com>
References: <e4227418-151d-7222-b439-4ce53bf0fb81@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fc750c-6000-4906-b8b2-08db5bc3fcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RVM3gv+CWiMhkH11GcPCtKl/M2Gt0CUt+M27fFpRBAgYD5xb4a2iwPhWZywfdxXl1c/sUrJDcrbtrp4CkrP0mtDE1EBr+Prfnq13Ac3IMKu4Zi+jaRsbf/Gl9qLAV5RXzl6y4Wg/wae9YyiPOQrf2LgLHb5eeeADTmXiO/KTcy2E8p8euThFQXKqpWz2Ub5zxeVRzMKzy+D7BWKEsx5vroDIT3BWFeMl7iCsEW7mZmeCio1LvGLTtqkcnQhS9Nv6ZGZzZkGN5EScw/WNKMqRJ5zIx4QlXP+jaaXe0YGS/pRgzD8LLUusEEWNBeTpn5Jmp2bAckC/xa7QElZfSsHFDixOizZmB2oQ49YZdzrISZ8cDVsxBWNlJtriR88Eq7H9S/RNfOLMmJ9DRqQ4ImkNyZCzbAy/2CAx/4IdhfDqF8CddXTa5actnSRTVlLGpJLIlHyBUQYVc4BR63zY0q6jijEOfW9xEZR8HbYR9qWchbpaC2GvyAFrvkrhFXfJXfLHbHPiWsgY7uFPLs+8F/XHRMl4e5bqLknYZXzm1UIlVbPd1d8+3p4WwB9qN2Vx0tVH7A4oZ/UYgkz0bW/F1LrIq3Hs4XGnbQfwury4p9k4Gpz+HHgTzwjRUcnxdJ4R9KkKhN6R8n4NFRHUvWe0T1WPdlqOBz1tw458eDTGXUkFJ6U8pOUZjP2QjTzoaTzrIBZsQ3sTNjDmvheufA4J+2Pbre7aLO64uQgzoKPpnjOAJihmiopG94lAIbMpPruLqa2JcCQfoszc9lTV/mOdLVG0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(53546011)(356005)(81166007)(1076003)(186003)(26005)(40460700003)(7406005)(82740400003)(7416002)(2616005)(47076005)(36756003)(36860700001)(83380400001)(336012)(426003)(16526019)(2906002)(40480700001)(54906003)(37006003)(316002)(41300700001)(6666004)(82310400005)(478600001)(6636002)(4326008)(70586007)(70206006)(8676002)(8936002)(6862004)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 19:29:11.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fc750c-6000-4906-b8b2-08db5bc3fcbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thanks for reviewing the patch.

On 5/16/23 09:54, Michal Simek wrote:
> On 5/15/23 20:16, Brad Larson wrote:
>> Add AMD Pensando common and Elba SoC specific device nodes
>> 
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>> 
>> v14 changes:
>> - Fix dtbs_check l2-cache* property issue by adding required
>>    cache-level and cache-unified properties
>> - Observed the issue after updating dtschema from 2023.1 to 2023.4
>>    and yamllint from 1.26.3 to 1.30.0
>> 
>> v11 changes:
>> - Delete reset-names
>> - Fix spi0 compatible to be specific 'amd,pensando-elba-ctrl'
>> 
>> v9 changes:
>> - Single node for spi0 system-controller and squash
>>    the reset-controller child into parent
>> 
>> ---
>>   arch/arm64/boot/dts/amd/Makefile              |   1 +
>>   arch/arm64/boot/dts/amd/elba-16core.dtsi      | 197 ++++++++++++++++++
>>   arch/arm64/boot/dts/amd/elba-asic-common.dtsi |  80 +++++++
>>   arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +++
>>   arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 ++++++++++
>>   arch/arm64/boot/dts/amd/elba.dtsi             | 191 +++++++++++++++++
>>   6 files changed, 603 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
>>   create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
>>   create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
>>   create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
>>   create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
>> 
>> diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
>> index 68103a8b0ef5..8502cc2afbc5 100644
>> --- a/arch/arm64/boot/dts/amd/Makefile
>> +++ b/arch/arm64/boot/dts/amd/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_PENSANDO) += elba-asic.dtb
>>   dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
>> diff --git a/arch/arm64/boot/dts/amd/elba-16core.dtsi b/arch/arm64/boot/dts/amd/elba-16core.dtsi
>> new file mode 100644
>> index 000000000000..f9f9f5fd5f69
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amd/elba-16core.dtsi
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +/*
>> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
>
> 2023 and the same below.

I'll update the copyright in the next submit

>> + */
>> +
>> +/ {
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 { cpu = <&cpu0>; };
>> +				core1 { cpu = <&cpu1>; };
>> +				core2 { cpu = <&cpu2>; };
>> +				core3 { cpu = <&cpu3>; };
>> +			};
>> +
>> +			cluster1 {
>> +				core0 { cpu = <&cpu4>; };
>> +				core1 { cpu = <&cpu5>; };
>> +				core2 { cpu = <&cpu6>; };
>> +				core3 { cpu = <&cpu7>; };
>> +			};
>> +
>> +			cluster2 {
>> +				core0 { cpu = <&cpu8>; };
>> +				core1 { cpu = <&cpu9>; };
>> +				core2 { cpu = <&cpu10>; };
>> +				core3 { cpu = <&cpu11>; };
>> +			};
>> +
>> +			cluster3 {
>> +				core0 { cpu = <&cpu12>; };
>> +				core1 { cpu = <&cpu13>; };
>> +				core2 { cpu = <&cpu14>; };
>> +				core3 { cpu = <&cpu15>; };
>> +			};
>> +		};
>> +
>> +		/* CLUSTER 0 */
>> +		cpu0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a72";
>> +			reg = <0 0x0>;
>
> Do you really need 2/0 split here. The first cell is 0 anyway.

Yes following 64-bit system definition

...

>> diff --git a/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
>> new file mode 100644
>> index 000000000000..734893fef2c3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +/*
>> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
>> + */
>> +
>> +&flash0 {
0xf0000>> +	partitions {
>> +		compatible = "fixed-partitions";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		partition@0 {
>> +			label = "flash";
>> +			reg = <0x10000 0xfff0000>;
>
> This doesn't fit with partition@0 above.
> Also size is weird.

This is intended to not expose sector 0.

>> +		};
>> +
>> +		partition@f0000 {
>> +			label = "golduenv";
>> +			reg = <0xf0000 0x10000>;
>> +		};
>> +
>> +		partition@100000 {
>> +			label = "boot0";
>> +			reg = <0x100000 0x80000>;
>> +		};
>> +
>> +		partition@180000 {
>> +			label = "golduboot";
>> +			reg = <0x180000 0x200000>;
>> +		};
>> +
>> +		partition@380000 {
>> +			label = "brdcfg0";
>> +			reg = <0x380000 0x10000>;
>> +		};
>> +
>> +		partition@390000 {
>> +			label = "brdcfg1";
>> +			reg = <0x390000 0x10000>;
>> +		};
>> +
>> +		partition@400000 {
>> +			label = "goldfw";
>> +			reg = <0x400000 0x3c00000>;
>
> This size looks weird.

It's the allocated size for this firmware component.

>> +		};
>> +
>> +		partition@4010000 {
>> +			label = "fwmap";
>> +			reg = <0x4010000 0x20000>;
>> +		};
>> +
>> +		partition@4030000 {
>> +			label = "fwsel";
>> +			reg = <0x4030000 0x20000>;
>> +		};
>> +
>> +		partition@4090000 {
>> +			label = "bootlog";
>> +			reg = <0x4090000 0x20000>;
>> +		};
>> +
>> +		partition@40b0000 {
>> +			label = "panicbuf";
>> +			reg = <0x40b0000 0x20000>;
>> +		};
>> +
>> +		partition@40d0000 {
>> +			label = "uservars";
>> +			reg = <0x40d0000 0x20000>;
>> +		};
>> +
>> +		partition@4200000 {
>> +			label = "uboota";
>> +			reg = <0x4200000 0x400000>;
>> +		};
>> +
>> +		partition@4600000 {
>> +			label = "ubootb";
>> +			reg = <0x4600000 0x400000>;
>> +		};
>> +
>> +		partition@4a00000 {
>> +			label = "mainfwa";
>> +			reg = <0x4a00000 0x1000000>;
>> +		};
>> +
>> +		partition@5a00000 {
>> +			label = "mainfwb";
>> +			reg = <0x5a00000 0x1000000>;
>> +		};
>> +
>> +		partition@6a00000 {
>> +			label = "diaguboot";
>> +			reg = <0x6a00000 0x400000>;
>> +		};
>> +
>
> here is gap

This is intentional for unallocated space.  I'll put in a 'spare' partition.

>> +		partition@8000000 {
>> +			label = "diagfw";
>> +			reg = <0x8000000 0x7fe0000>;
>> +		};
>> +
>> +		partition@ffe0000 {
>> +			label = "ubootenv";
>> +			reg = <0xffe0000 0x10000>;
>> +		};
>
> And this is missing space description.

space description?

Regards,
Brad
