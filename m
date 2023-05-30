Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E88717067
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjE3WEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjE3WE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:04:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109EBE;
        Tue, 30 May 2023 15:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nusnB+UHU38R9z1fr4y/ICVKIFr/6X9Ncdigbf+jR5TLLJcrtRFITBkg+9SMUTJ1BbMIhj7i564t+mAOlocotSKmHf+0oaP7FftiIrT3VdFu2Ql6M+IPoZT8B8w/6qFr06mgYoIStZUqdFzVJAL5wRPjmNCRoL0u/8OUzWNwX2C9oE3VpJo00eBSD3JPNxDuFXLzfBzwJB1fK5mL+ugoXyuzyPrBxRHoRYK/KRpTtChQDKNcNM8ubsuig+mrhS0KvnN/akvQ7gAijIytt1K68dKGg6Jp2pkJnYlcs3spQvL61y2KG81clUbA8+TDSZWWx2fNd54+K6t2uYx4ALKFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCC/g6c6odjb1J23E9tyj2tfR65P6J7bCE5VfHHgJPM=;
 b=aP+0Jvs9EFSjNbkkbxH4ENEah9oViQpEUt7sYyPXEmeWx/k/0SPdAYaoYjTavOfQr4mb9+/3OoLZmci9/nUsy8HZloOQcAS4UeoiH22lNaKdHJpLcaRdu5xdEZd1tNY6QgUSch4s3fjPC6UqkfR49AqBL9WOfYhD3Jtvrj/fFPYywaqquEy2SYSePmQNxY4LoSPzGCuoDAr+zq2/Pec5TfuSf8YSERbmPVTARVczyO6423Lg18Wtsvu+A5SXDMR52MWIWlwWebFZYKUoEugxjbsRsk0Pic/fzEJGkoIAqCJS0CGbXKWh74OM4CYMFh8OoJxeErdh24dWSmDYHHXtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCC/g6c6odjb1J23E9tyj2tfR65P6J7bCE5VfHHgJPM=;
 b=TY9QpTbZa1NLdCVcfflZDADUcSvNmjt4oNKluYyytHsNq/KITPCd496BSDpWuYLRE0LWIq1AJZjnHjUe24Ygcv8kYH0Mv5ax/x2I2lLw7mRkYlOxfr+dZJhS2TGarmYVTjGTiwzYPqc3xRXCUpn1Jad69qm/KUSbYQFcw8rCOEc=
Received: from BN9PR03CA0728.namprd03.prod.outlook.com (2603:10b6:408:110::13)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 22:04:22 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::28) by BN9PR03CA0728.outlook.office365.com
 (2603:10b6:408:110::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 22:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 22:04:22 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 17:04:17 -0500
From:   Brad Larson <blarson@amd.com>
To:     <geert@linux-m68k.org>
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
        <linux-spi@vger.kernel.org>, <michal.simek@amd.com>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <skhan@linuxfoundation.org>, <suravee.suthikulpanit@amd.com>,
        <thomas.lendacky@amd.com>, <tonyhuang.sunplus@gmail.com>,
        <ulf.hansson@linaro.org>, <vaishnav.a@ti.com>,
        <walker.chen@starfivetech.com>, <will@kernel.org>,
        <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v14 6/8] arm64: dts: Add AMD Pensando Elba SoC support
Date:   Tue, 30 May 2023 15:03:47 -0700
Message-ID: <20230530220347.14049-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMuHMdX_Sdb3RFrLthcwThK__GKhJvJuXWu5+2RsQpGgFRkrXQ@mail.gmail.com>
References: <CAMuHMdX_Sdb3RFrLthcwThK__GKhJvJuXWu5+2RsQpGgFRkrXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6e20a6-e6b4-478d-0596-08db6159d2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: osA6rXPcaNgUpRnuXwFfrs5mzASPSvKGIbtd2Jmg4IkzF8gMyOusDG2RNTFW/8bfk+NntqSFqUVliTocuEpf2NMBMGGOZRyPCnCo9UvHvl9QRfPPPXzNHPHLdID284M0tcP9h1gNap8//igx62FSEmCs+kKJL+B0Lp16tZMkZ7hhhkHOw36AnCzfNrU4DldEmHuiY2gTieB6jRxsd2hbrHUNoxt0TRnYpmSJXZpM18nDpmhJE5OSx9cpJuGNxmcicagPg90XHyq35P3TvfDN+uGOp0BsdpWsiqvKZ8Z7tMJMEN129SzuwzULZHmEgfOQ7sHE9Ut2C2t0dohlwC2eOJPFVUbcvIO8HnNCWnnGsFMr/33gbUPCUfNSwLs0piI3BU+/P+ZQdTdxhEcI+fnaK2fdRdflQevZuiJuAmrG8hqxE999CP85O06N9dgBN/8h7QH389wXvU3RPaGe01P22bNlJBO0a8dmk/BmYyNJSyaIhoed/crUurPSWAyeceqqf1caaCmvOal3vbcqKYrOBdb3sHshHFw4t2Mfbj6P557TKcYK7xWys3Hofiea0eJ2soVXV4d9xZRXt1B0VMvLFm0VobdzWR1WL1htkWc9HJnwRX30Ux+s2ZMG5Dh6u3zNSe3blZKX03tjQPhYd0jGl63DAv+fmPL3fdHFuc/2At4ukU11uEztUPgcCrj950hz/kQKuvcGkmNHJPxcCYBQbGuq5FdDO4c4vRPAq6kjyBPOKEBz2E0Pz6WQnFO/UcxPuYZgN8mmxGup9JJ/nHS77Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(426003)(478600001)(336012)(83380400001)(40460700003)(36860700001)(40480700001)(47076005)(5660300002)(186003)(16526019)(6916009)(4326008)(8676002)(82310400005)(2906002)(8936002)(41300700001)(356005)(81166007)(82740400003)(316002)(6666004)(1076003)(26005)(2616005)(70586007)(70206006)(7406005)(7416002)(54906003)(53546011)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:04:22.1124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6e20a6-e6b4-478d-0596-08db6159d2ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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

Hi Geert,

On Wed, May 24, 2023 at 13:52 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, May 23, 2023 at 9:30â¯PM Brad Larson <blarson@amd.com> wrote:
>> On 5/16/23 09:54, Michal Simek wrote:
>> > On 5/15/23 20:16, Brad Larson wrote:
>> >> --- /dev/null
>> >> +++ b/arch/arm64/boot/dts/amd/elba-16core.dtsi
>> >> @@ -0,0 +1,197 @@
>> >> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> >> +/*
>> >> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
>> >
>> > 2023 and the same below.
>>
>> I'll update the copyright in the next submit
>
> Did you make any substantial changes in 2023?

Yes, additional properties were added to l2-cache*

>> >> + */
>> >> +
>> >> +/ {
>> >> +    cpus {
>> >> +            #address-cells = <2>;
>> >> +            #size-cells = <0>;
>> >> +
>> >> +            cpu-map {
>> >> +                    cluster0 {
>> >> +                            core0 { cpu = <&cpu0>; };
>> >> +                            core1 { cpu = <&cpu1>; };
>> >> +                            core2 { cpu = <&cpu2>; };
>> >> +                            core3 { cpu = <&cpu3>; };
>> >> +                    };
>> >> +
>> >> +                    cluster1 {
>> >> +                            core0 { cpu = <&cpu4>; };
>> >> +                            core1 { cpu = <&cpu5>; };
>> >> +                            core2 { cpu = <&cpu6>; };
>> >> +                            core3 { cpu = <&cpu7>; };
>> >> +                    };
>> >> +
>> >> +                    cluster2 {
>> >> +                            core0 { cpu = <&cpu8>; };
>> >> +                            core1 { cpu = <&cpu9>; };
>> >> +                            core2 { cpu = <&cpu10>; };
>> >> +                            core3 { cpu = <&cpu11>; };
>> >> +                    };
>> >> +
>> >> +                    cluster3 {
>> >> +                            core0 { cpu = <&cpu12>; };
>> >> +                            core1 { cpu = <&cpu13>; };
>> >> +                            core2 { cpu = <&cpu14>; };
>> >> +                            core3 { cpu = <&cpu15>; };
>> >> +                    };
>> >> +            };
>> >> +
>> >> +            /* CLUSTER 0 */
>> >> +            cpu0: cpu@0 {
>> >> +                    device_type = "cpu";
>> >> +                    compatible = "arm,cortex-a72";
>> >> +                    reg = <0 0x0>;
>> >
>> > Do you really need 2/0 split here. The first cell is 0 anyway.
>>
>> Yes following 64-bit system definition
>
> You mean for the 64-bit main address space?
> The CPU address space under /cpus is unrelated.

Yes, the reg prop for this node is CPU/threads per dt spec.  Checked the history and
the Elba dt was derived from socionext for these nodes and this is how those device
trees are configured along with over a dozen other devices.  I changed to 
address-cells = <1> and dropped the leading zero from all cpu* reg<> and booting
the system I'm observing no change.  Looking in drivers/of I'm not seeing where
cpu*/reg is read and used, any recommendation?

>> >> +++ b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
>> >> @@ -0,0 +1,106 @@
>> >> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> >> +/*
>> >> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
>> >> + */
>> >> +
>> >> +&flash0 {
>> 0xf0000>> +     partitions {
>> >> +            compatible = "fixed-partitions";
>> >> +            #address-cells = <1>;
>> >> +            #size-cells = <1>;
>> >> +            partition@0 {
>> >> +                    label = "flash";
>> >> +                    reg = <0x10000 0xfff0000>;
>> >
>> > This doesn't fit with partition@0 above.
>> > Also size is weird.
>>
>> This is intended to not expose sector 0.
>
> The unit address should still match the first reg entry
> => partition@10000.

Changed to this:

                partition@0 {
                        label = "rsvd";
                        reg = <0x0 0x10000>;
                        read-only;
                };

                partition@10000 {
                        label = "flash";
                        reg = <0x10000 0xfff0000>;
                };

Regards,
Brad
