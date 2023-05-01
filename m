Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD4C6F2EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 07:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjEAFnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 01:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjEAFnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 01:43:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2113.outbound.protection.outlook.com [40.107.243.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD91BB;
        Sun, 30 Apr 2023 22:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTUgxDnvx5vBIXdxzzB45hXjKmW/8tCVOajezjcRmgNXyOrNsUXhiFQHr2Do1AGTc+Hb9wbnT7A82o03ARXfVzofJ6qJfBOUB/GcbR+QBJHU4tafMhWtaC6/2kxjT9l2rlxa/Z6m6qn5YLdWNwzymI7iRFfY5XBu2VnFetyoMO/zoamlalpW8syUPHaOa8445g93reS2TEqBztnzMqblpSq7fjO3SxfFGspxxGRrNyu5xQ9iN9qc0iEmmljezGhary7K/PhzYe22gG7Ar4MSKfP2BLA5+ZOJQXS3OYNGw8S8MAJa97XL3S4yRTwgxkmr5HY805aJFKHmlE6C9oZnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+mROnDiR1EF4H9bCrJXpKI9TAuBXLc61+DaP0rblTg=;
 b=ZZ4ZF2WLizRBQ5V+RuVvH5JXTa5drisxXuxvTjMCAH+GuhnFiJjmtmdDukjbNi63Yf6UFK5/+JiLSMU9nsVkr9S0/D0wnZdOZwR0IHwCLPIu9iqCNPG6a6BwMth0KKswlKv1woiPKEyX/v7U8Eq7+EYBCjtP3yiqtEC5AGju1nXhW/mg5b/USOUW5//lKpsJZGOoymCsLPC8hh7bNeg/mPjS2C7VZERAHT84w+SzeDL8MPOFeF4EjVKRxzZR39qwcPn9iOrwQrx+QyOBBsCQvBNjsAIUD4u3c19aCsBMkpgLEUxK+mLNEjQx05AVYALDk92tOvBKtSeTvgsb9OGVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+mROnDiR1EF4H9bCrJXpKI9TAuBXLc61+DaP0rblTg=;
 b=SuQWV6UAyY6sp+06wEO2kaShRs81p2tvlmJlnJcgfK/RwtUxt2f/fQQro3iNeBwYD5p2uTJgoMXXYd5sYLI37MRxfN5dqy5zS/gPpPR+C8v0vh1GdNL40e2ntmHQlT07M96LIx5+NWmaDH0n6C2n3zaw3TBpzKKesGNeK1lQRL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BL1PR01MB7841.prod.exchangelabs.com (2603:10b6:208:399::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.29; Mon, 1 May 2023 05:43:40 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 05:43:39 +0000
Date:   Sun, 30 Apr 2023 22:43:28 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: ampere: Add support for Ampere SoC PMUs
In-Reply-To: <7d7cafea-37b2-a050-7247-6c0234cb4f4c@arm.com>
Message-ID: <5d29aa57-7c92-3dce-ecc0-a7b2c8453c80@os.amperecomputing.com>
References: <20230427215325.1067752-1-ilkka@os.amperecomputing.com> <7d7cafea-37b2-a050-7247-6c0234cb4f4c@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BL1PR01MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: ca49c1ac-2678-43d2-684d-08db4a07039d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzDkxgB2bBet3yot8yIuu2g4SgFbw5sPp5ULAmDwlG4oFtXopbZuZS5xuJmAEmhDkHtCOw6ku2Qsfx8QqA64orj+4/TpFmJo1Z0AXDRjW9IbrIzC/tS2PmysB177zAtLSC7ZGL9mcFSoXTEqFZSXIde8D6NaymOEWrJcUnVGJb5QLGjU7x0VZeEYSwq/JU4GVTYi4/+usjBwUs23DJauAR6tjiPtdoDeIrujStN5fEEhvM3TKXAFF44qwtEZZU3vBPPqr+Zu70uZ3A5DoBaNnPszoWLo8+PQHQu+yAIT9hbYqs+go6XFzTbpmyXDtqGq3E/55qkhKZf+At+34Zh9szPT3I9esRVW/78q0aAnqZRAKBxkkRRE0rvtZBDZYbRAKFT1ezFlpL1M94d/7HTI/WY8KqBTf9lZqjqihg2EUHzHIV2Ipv6rJwcczN0NIvLD7n0J1mce111zueP0AXyVXR2Wm8DNHEwIkp46i3ZnaafirYEvk7lr8qH+WRYF2IHEbzfvoljj60h05owskhG9wHBfRtKHdIAkIjD/OHdEcJZ+HIWxSBplJHVzYGaWMAXUKfDXIpXrS+YkJkg7LOzLJONCSAKZ8R+c85BDl+NxiEu2Fuv14XPgy4gsQu56FxNH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39840400004)(376002)(136003)(451199021)(8936002)(8676002)(5660300002)(41300700001)(316002)(86362001)(31696002)(2906002)(38350700002)(38100700002)(31686004)(186003)(83380400001)(2616005)(478600001)(6486002)(52116002)(6666004)(53546011)(26005)(6506007)(6512007)(4326008)(6916009)(54906003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?msfCif6zWh0JT6z0ErIxVZdwPDRPfxnCiTfJYp8xjSRa2B7WfVkxdYa4ceEQ?=
 =?us-ascii?Q?ilak8G4oT0WIBw9j7tH5gqFjF9QvzhAZ27wZ2vswFGzL+eY6SKxGV+WEGkpX?=
 =?us-ascii?Q?h4+nt4bJ472uxiXqAd8jDG7LtIhZT3P0g7in53Fmh7BiFu/+ao2QUg10e1M3?=
 =?us-ascii?Q?Ry5UCDlXKsstGtr0hxFxdZQQIxQyk8GoNbvTnlMWbEw9DNT75zGFouT4bw4P?=
 =?us-ascii?Q?LmXk6HzSeoEGi6BIXCmGCq3KzQefoaFIQLSybl8CddC0cjbZhPLtrViJZ+u8?=
 =?us-ascii?Q?NRjUHmrCq7+JzUoq03IdKZd0EwboYb1KhrOS/Nr/2URv0bSUlx2WezNtPnDj?=
 =?us-ascii?Q?GAbQUOLn25iESBGYGD/Uu1vf3c1kilO1gRN9UciOI9BKXWr8dzEMuWBcR8Pv?=
 =?us-ascii?Q?dc3yQ0PQSNfXmb2Ok4GUjTZbVK9tUu46jG0ZIv4gu8yHraU7GrI4aHKQEAB/?=
 =?us-ascii?Q?BwFMkRDbKWYT1OJlh6JE5pZ6xRMtrv9wD80TE7zJIhwNsn/KPVujutqO3vR6?=
 =?us-ascii?Q?NvbIQ9WKT9pERY50sJ83t+cnUqr/radMoC2bywaRmxXAHwxLcueh/MSHmzeD?=
 =?us-ascii?Q?SRxwL699jRnc3BNzI6njGhWN7X9W4Ep2+ieOjU6gvA/LqrBxArTq1CGFWA1e?=
 =?us-ascii?Q?ayAY1cYZKRm67ZXrOy3gHplmIbmauvAMEhGd3lzxhixN3izouP48pE4Ap6xV?=
 =?us-ascii?Q?XMAROkAphXSkY7QaH8SIxCbabVLh5s4nu4RUPc8isWBIHDpls/H8zDN9SeHY?=
 =?us-ascii?Q?fzDtGzJntAQXvVLj2aUTthIAKGNpmzNn0KOxvYCW4foxHzYu2F+pa/IDWMoU?=
 =?us-ascii?Q?SH0UnL49/p2dE1naExU11VuEQkwAQ/p94N2FKFsJlbkmztNgFN/tpBlvsQZt?=
 =?us-ascii?Q?Ztrgg/NJclM05ib+lLIVQ7Ltlv7z+eWEtGW9vTbLK2cMTww6IyJD9ekZpm1G?=
 =?us-ascii?Q?WscvG+5NcK7rWMhL/PhVLs5zyytZwHr4freD+/rVqxPduCGWRnMwoH/UFts0?=
 =?us-ascii?Q?o6fG06N4qexYLHb1TSxmD0es5StamIo3rgpcbjgUivAuHm9aoUqHGsE/q9Qv?=
 =?us-ascii?Q?GssQi94WJvJBS81IGVmrl17+D/58bmBRsNr1D6a70WiKmm3ce85t+66WAg5h?=
 =?us-ascii?Q?qZXY78Ds7S0jRLZRdvh5GSxmYWZMHVksouYtDk+x/jJNtG8WgRPnHqbZI+NF?=
 =?us-ascii?Q?CBb8g8pdMRJt/nVst2MCllfX2WM7zJS+d8Bro6bUHHj8I10Tiuew/xc3Y4NE?=
 =?us-ascii?Q?4Qf8oKpM/TaW5aBDfWyjZNEoS1vSq+gJ+nMu064rC/XYkwzKWJNRc9Z+bU0z?=
 =?us-ascii?Q?eZldm5xo10hjufoopyJH5vyxPudtxwm6I2umld3duiSJedhdYZ3K5R2t1fk5?=
 =?us-ascii?Q?hbFPWpFOXRMJV4ViC+q98YNaz1uSSZVcoRrUHB7hN9J1JEaFtlzzx1CduEDK?=
 =?us-ascii?Q?IRNDvgK8FSELdZDFfTO8m7vNAr6Y0NAmrFHszokeW6ZANN0TMs6GwgArDfBC?=
 =?us-ascii?Q?uApoSrZTrBT4iF43ApNAXqK+N/hWupFw+cWoY3ViIaU4L5FQjEB07+3U8sBX?=
 =?us-ascii?Q?syK811L1bYDykL01e1HSy8k2vAbdYNvkKJXIwmuAxslEQMXiDe0zwtbB/wu7?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca49c1ac-2678-43d2-684d-08db4a07039d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 05:43:39.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pA7IZiQh5phPzsRR4mjZpQTZEnZJxylItFq19aAjHD+TS2V5N41ipJj9m6BRGGdoSPVCUsH01nW15V+oR4tGlJX8IireMwMMyuhlGrh64m5/5iDiaxi3hLIsYUMRLHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7841
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,

On Fri, 28 Apr 2023, Robin Murphy wrote:
> On 2023-04-27 22:53, Ilkka Koskinen wrote:
>> Add support for Ampere SoC PMUs. This driver supports MCU PMU
>> available in the AmpereOne SoC.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   .../admin-guide/perf/ampere-soc-pmu.rst       |  36 +
>>   Documentation/admin-guide/perf/index.rst      |   1 +
>>   drivers/perf/Kconfig                          |  10 +
>>   drivers/perf/Makefile                         |   1 +
>>   drivers/perf/ampere_soc_pmu.c                 | 724 ++++++++++++++++++
>>   5 files changed, 772 insertions(+)
>>   create mode 100644 Documentation/admin-guide/perf/ampere-soc-pmu.rst
>>   create mode 100644 drivers/perf/ampere_soc_pmu.c
>> 
>> diff --git a/Documentation/admin-guide/perf/ampere-soc-pmu.rst 
>> b/Documentation/admin-guide/perf/ampere-soc-pmu.rst
>> new file mode 100644
>> index 000000000000..5161fbd1c548
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf/ampere-soc-pmu.rst
>> @@ -0,0 +1,36 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +============================================
>> +Ampere SoC Performance Monitoring Unit (PMU)
>> +============================================
>> +
>> +Ampere SoC PMU is a generic PMU IP. At the first phase it's used for 
>> counting
>> +MCU events on AmpereOne.
>> +
>> +MCU PMU events
>> +--------------
>> +
>> +The PMU driver registers a PMU device for every supported PMU instance on 
>> each
>> +SoC. See /sys/devices/AMPC0100:<nn>/.
>> +
>> +The PMU driver supports setting filters for "rank", "bank", and 
>> "threshold". The
>> +filter settings are device specific and shared between all the relevant 
>> events.
>> +The default value for all the filters is zero. The filters can be modified 
>> by
>> +setting them with the last event of the particular device. All the 
>> previous
>> +settings are overwritten.
>
> Yeah, that doesn't really work... what is the "last event" relative to? Order 
> of arguments to arbitrary tools? Order of perf_event_open syscalls? Order in 
> which events are actually scheduled on the PMU? (which users can't even 
> control - think event rotation)
>
> To be practical I think you'll have to handle this the same way as 
> arm_smmuv3_pmu's global filtering, and only allow events with matching filter 
> configs to be scheduled together.

Thanks for pointing out that to me! I thought my implementation had an 
issue with the shared filters but when I tried to look, if any of 
the supported PMUs was using them the same way, I somehow missed 
arm_smmuv3_pmu. I fix the driver.

>
> [...]
>> +#define SOC_PMEVCNTR0_LO	0x000
>> +#define SOC_PMEVCNTR0_HI	0x004
>> +#define SOC_PMCCNTR_LO		0x0F8
>> +#define SOC_PMCCNTR_HI		0x0FC
>> +
>> +#define SOC_PMEVTYPER0		0x400
>> +
>> +#define SOC_PMELCSR		0xA10
>> +
>> +#define SOC_PMCNTENSET		0xC00
>> +#define SOC_PMCNTENCLR		0xC20
>> +#define SOC_PMINTENSET		0xC40
>> +#define SOC_PMINTENCLR		0xC60
>> +#define SOC_PMOVSCLR		0xC80
>> +#define SOC_PMOVSSET		0xCC0
>> +
>> +#define SOC_PMAUXR0		0xD80
>> +#define SOC_PMAUXR1		0xD84
>> +#define SOC_PMAUXR2		0xD88
>> +#define SOC_PMAUXR3		0xD8C
>> +
>> +#define SOC_PMCFGR		0xE00
>> +#define SOC_PMCR		0xE04
>> +#define PMU_PMCR_E		BIT(0)
>> +#define PMU_PMCR_P		BIT(1)
>> +
>> +#define SOC_PMAUTHSTATUS	0xFB8
>> +#define SOC_PMDEVARCH		0xFBC
>> +#define SOC_PMDEVTYPE		0xFCC
>> +#define SOC_PMPIDR4		0xFD0
>> +#define SOC_PMPIDR0		0xFE0
>> +#define SOC_PMPIDR1		0xFE4
>> +#define SOC_PMPIDR2		0xFE8
>> +#define SOC_PMPIDR3		0xFEC
>> +#define SOC_PMCIDR0		0xFF0
>> +#define SOC_PMCIDR1		0xFF4
>> +#define SOC_PMCIDR2		0xFF8
>> +#define SOC_PMCIDR3		0xFFC
>
> This register map quite clearly follows the Arm CoreSight PMU architecture. 
> Nice to see it being used, but would you mind having a go at hooking up your 
> imp-def bits to the existing arm_cspmu driver?

I didn't think about that. I'll take a look at the coresight pmu driver 
and see how I could do it properly.

Thanks, Ilkka
