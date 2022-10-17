Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1118C6007E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJQHlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJQHlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:41:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E670620F75;
        Mon, 17 Oct 2022 00:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1Dze4QjSIlBCcJOyedFMAX3vCpdn6IIWeGw8k5eJGx+zAGgtHPMef2qlQihEafGVUpJEKMrwRx3QSiv0LqkuTBqm7fKePweRD1OMFU493tQL2qlPv7y78Ii+M8iPonSlaT8bxQ6VNJrtW0mmjrxrXzwZec7hb8oQmMw2xqGU9uusfAxVnVf4Y48iLntVSOS9PQuCnmDQWXSR+UdP6rFWZrpVJ7PvQ84lB7mbPoXzXPouj9umBIrEFvzXWx/4R2343YI0/3Zs8HKbw5bji4temQ05oEgchkDKJMOICiAs4viCfRDs0d/AdXIP5Cv7w8HbYFj7E0LIaOWb74hnzmIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4aXs2Ra5Y3uL00uY9hC2NOIX/fRW9XU99LSwgh1CrA=;
 b=Cm6bSiaMfc5iuNQcVX3r6iGg3MuWDXg9t+3pG+Cg3AsE/c9+IrVa9qE4ETROwJAdrW4TK1Rlvc1iX5+FDIqsn+jxTicW9hl3dNkjYMcD2ALnP9yZMfH+Rt9XlvU2A5eQwibj3hLEmg4PBLjb1aLBzwJ4uIGJYhopqKN3WKOXucyIjbMIdcmYROGW5wWSVJd1M+Q4nfW4zIwTx1LPIP92nDqbAd0y6ws8QB84JRDt3qjN3PqCWVAmHnSA9pedCyRjNcG57n4u6u8ofzabKZaz70VfJzQO+KiQQr5+O+W8j33FmN6D4Xin/qmCkfZtmcoNXIlKJoaP6Q+aQ5DPOxPMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4aXs2Ra5Y3uL00uY9hC2NOIX/fRW9XU99LSwgh1CrA=;
 b=UZejZay3xpuvthEtL2KBkFf5CjO1Taa2T7aukOM9aOsFUYA5srITWGSjObU/VrtJH0ifoxo+Ut6VP61pi81SAzulz8iK6068DjcDIP7ofz5vf23qDlU1IWyj6uD06cy2zEwAC3AJO2J5TvezK/9zwPnItQqSvoXqVuwO2yisRcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 07:41:14 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 07:41:14 +0000
Date:   Mon, 17 Oct 2022 15:40:49 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 0/9] Implement AMD Pstate EPP Driver
Message-ID: <Y00HAWmU7nOoKXBI@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d7acb3-f24c-445e-ecaa-08dab012f82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9KhaW1xgDz4tXH7vPbnbtnCdF1BCdO9y8gCaukRXrdn8eK6nh/5scEDjx9oZbeg2wF30I1LDV3WO/xxb6XoD4Rjn5midFG64MvhkHrYd3p9teXrIdS1TGUxOxfj8mnQlyzn5vYDNpypvwZvuZJA1aXAZlp+HbNqZQ0exYK6gpP+gNjeQocsCfwpwh0nmwm3kBQ6olzWo6X3HFL1Ty5aiUuVk/XXNb7T/GZELHZ7v2144kFzJcyK7Or8qZJKLFthtTCiVC+o5mWt/NpARsUFpM49A17xoKD2lZveRQUnwDn460nf240BEfnjXpwaxjBZZrMGxg//eP249HfZGQBfW62sX2T9NBlYY6pKz4BeFtKN5MkjcFUm8rmPeAvEIoeMjmf5ZVfGbVX8kYkNPv/faAWI3UGH7jnLxk2OTG2a0Szq5RjJTjft5pvr90MZbMIi99S64+1hxdK1ZEmTFINZ8cOjQV2im7y0fXpMlr1c7vFp8+But/NbSdmVdXnHVbvMBZZdfaQ9D7BawOqQf2MVnMRG7LddNEeFBo7zETc+iuSNjik4rOSwXvKRNsh0X77SL5Wlr5xI7+dhh41eA0Qxa2yC/VzsC2CRARVY/onesy863Y3VKwXYIvqALl0OeY6xyK6UtY5qxi1UKnctb7UUzOabZX12MSiwfHNTPx2/Opu6P/mUnabAF+fSoP/OOCrwPCJ/H4Zyjpi7Yea+5VC/H6jNsy97kITu+3p4I/dof/em9goWqUE+MuzpifKOXARX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(36756003)(38100700002)(8936002)(6862004)(5660300002)(83380400001)(86362001)(26005)(6512007)(54906003)(37006003)(6636002)(6666004)(186003)(2616005)(478600001)(966005)(45080400002)(6486002)(316002)(4326008)(66946007)(66556008)(66476007)(41300700001)(8676002)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?QmdGLzRGNjFEMjJwSmt5UmJ5SzNaY2JMN2l2bVpOUDIyYU1pU2JWUFliOGpP?=
 =?gb2312?B?cVRrMGpidmhIRjN5R0VaV21XQzVib0pnVHF6QXFEcXJsOXZlNkIrSUIrK1Bt?=
 =?gb2312?B?ZXJvdEl3TmREUjhHRWhaU1lic0h2WkFIM2xpODJEcFQ2aCtndTNWbkM0K3ZH?=
 =?gb2312?B?Vm1kVDdORHNHVDRhdllicWhlV0lqVmtOQXV4OWtFeldqZktucTMyNDNKek1C?=
 =?gb2312?B?RXovWHEyRE5JZ0dkQTM4RUhWOWZKWmtlREFjTzR3dzlzdDBxc3ZwTU12UDF1?=
 =?gb2312?B?ay90dXZBVkUwK2NFZ3NBUldpTVpxWnZLcVI3VG1FRGNzMFM3eGVCZDYxY2ZT?=
 =?gb2312?B?YU0xRmFXU2NwQUw2YThPbW90ZGo3RHFBUU9Id2dtRUY4UHh3Zk40MnRqQkZl?=
 =?gb2312?B?bnB2RTZkRFdBWUhJZlBFYm1WMjRYSWlJQVpSYm5jKzlURldWeEJRNE1URVBx?=
 =?gb2312?B?TE02eHcxR1M2NnVWL1lXa2IvR1grcmxxV2ZzY2dPNTZIMjdtNFQzcS9lNm50?=
 =?gb2312?B?bjBLQmxJemdkV3pKVDVDS0pPUDRmU1JiQjB3WHJKR3gzdXNFQnNkMGNyM3RO?=
 =?gb2312?B?eUhiUGlYQTF4Lzl6bVhsaklSd3kvYU5wRkJZVTMxbnZOSzRIcm5pN093TGpT?=
 =?gb2312?B?V3kxZjRKYVJHak9vejAveEhWNGhKU05WdllIMGduV1AzTmxjTGdtbkpNQUhB?=
 =?gb2312?B?U29oaTVRMHFCaS9lL3JJdmdlNkU4dDNDZXM2S25uQ2VQWWI4MHcyM2trUCtI?=
 =?gb2312?B?WW9tQlVsM1I4RTYrajdERHhLZzU1ME9Ca2l6YkdFM3ROckEyd3h5MWppZDVl?=
 =?gb2312?B?blF0K2RIQVRQakJobndKanhvdDlJV0VJUlBBUTh3Q1c5MVlQODc3QUF5UURq?=
 =?gb2312?B?YzU2M0R4T1Z5MXl1VlhwSTdWYlAxNUJIWjNnenRhamxlNmNwdmVWVEJaVE1J?=
 =?gb2312?B?SlZTVE9zY3Y3dTY0OWFvd0cwM09aMkNJVCtkZWFCeVg3RjFyclUvWXllWEVH?=
 =?gb2312?B?TGNqZENKWDdMUmpmbWFvaGNOaXlZWnNrTks2L1FvM1JEbXcrMU1GYkRzTGlM?=
 =?gb2312?B?a2NSWS9sZmlURFQ1ZHZLUGxTUnEvK1hBMjJKMDBPcGcyYkk4ZVdEY3A0MVJP?=
 =?gb2312?B?SkloWHE3ZnpKdzJydzdzOWtlK0l1bDMzWHBDQUg2c256eU0vWmJQMTVXSkU1?=
 =?gb2312?B?S3lOaTY4eENvdzRJTmRHTWR2T256NWxmdlUvK0plUnVKQmgxSnE2c2t5NUha?=
 =?gb2312?B?WE5TMEZiM21EdVNXNnladHovdlhNa2JweWJQWlh1Z0lRS1RLN29Ya25xSThi?=
 =?gb2312?B?VHdrMjM5KzZweFppcXRvaEo1NVdxc21IbXpLdnNFRHJmT2xDNTZpNyt2NEFx?=
 =?gb2312?B?UC9oaytmVit6Sm5KejZqWEFtVExsYlFseThQWHJhQytmanl0amFHaXZDdGVp?=
 =?gb2312?B?Q244MkRHWkxEaGUvZkpUSS8rdlZVdG5TNUFrZW5aRnkxR1UxeGgzbTk1Y29G?=
 =?gb2312?B?RWJuMW9aUWxqZHdFV3R3TkFacTBlNE9CRFpJaUtiRUQzS3AxR3FyZVVNbnpp?=
 =?gb2312?B?MUdTZmpUaHlPKzhhRXJnSUc2K3Q0MFkwei9xYnZhR295N3Q0eWF4S1BLNDMw?=
 =?gb2312?B?aE15WHJ4SHJUNEtoZ05WS0kvL2xiY21lc05McmIwZGxhMHlkSnNhQTJoblMy?=
 =?gb2312?B?SzVxZ0JzcFNmU2o2SFNPU0N0S1M3M2MxcUVVem1pdEF1M1F6TlQ3Q0pNQmc4?=
 =?gb2312?B?UG5iR1RjY2lTOVJuWDJEeFdGbk4yRXVDcldjZStnS3ZwbUxmN1RJMmNlVkxF?=
 =?gb2312?B?NVp3KzR3VE5nUVVUM2RTamFpVzI0YkdwUkExempJZlg4TkpXL3p6aHR3Mzgv?=
 =?gb2312?B?M0E4LzhTdW1CZ241SGpWdlY0ZzFYMUdBWkFYVmI5NGlBR2Fxa2xaMVdCUWVO?=
 =?gb2312?B?Znhrcm1XTTl4NVVnM1VCNVVkQUVTZzlGM0VRMmUvV2g5WHhnYU1sUlNqSm8x?=
 =?gb2312?B?SDM2V2swZ3JwdUpTS3F3VDVHTmhnYVlQWU1NenZDRWEyNzhlRmFZaHJ0QXpK?=
 =?gb2312?B?ZndxekxCeERnL1VMVmJvNU1iN2VEUnNZRWVWWWFjYTFpU0JxbStCeEJBNGFv?=
 =?gb2312?Q?OjB3sSX7M09l18bLbeGOoK63A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d7acb3-f24c-445e-ecaa-08dab012f82b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:41:14.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wpYxu0kzEti5dJF/oD4ZkrwiwjKlVkBnJ5NM2x5PEhhnl4oSMDvGFWQnZ/SiT0aSTcJLcBOFgqzxellq0ZjaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:22:39AM +0800, Yuan, Perry wrote:
> Hi all,
> 
> This patchset implements one new AMD CPU frequency driver
> "amd-pstate-epp¡± instance for better performance and power control.
> CPPC has a parameter called energy preference performance (EPP).
> The EPP is used in the CCLK DPM controller to drive the frequency that a core
> is going to operate during short periods of activity.
> EPP values will be utilized for different OS profiles (balanced, performance, power savings).
> 
> AMD Energy Performance Preference (EPP) provides a hint to the hardware
> if software wants to bias toward performance (0x0) or energy efficiency (0xff)
> The lowlevel power firmware will calculate the runtime frequency according to the EPP preference 
> value. So the EPP hint will impact the CPU cores frequency responsiveness.
> 
> We use the RAPL interface with "perf" tool to get the energy data of the package power.
> Performance Per Watt (PPW) Calculation:
> 
> The PPW calculation is referred by below paper:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Fperformance-per-what-paper.pdf&amp;data=04%7C01%7CPerry.Yuan%40amd.com%7Cac66e8ce98044e9b062708d9ab47c8d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637729147708574423%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=TPOvCE%2Frbb0ptBreWNxHqOi9YnVhcHGKG88vviDLb00%3D&amp;reserved=0
> 
> Below formula is referred from below spec to measure the PPW:
> 
> (F / t) / P = F * t / (t * E) = F / E,
> 
> "F" is the number of frames per second.
> "P" is power measured in watts.
> "E" is energy measured in joules.
> 
> Gitsouce Benchmark Data on ROME Server CPU
> +------------------------------+------------------------------+------------+------------------+
> | Kernel Module                | PPW (1 / s * J)              |Energy(J) | PPW Improvement (%)|
> +==============================+==============================+============+==================+
> | acpi-cpufreq:schedutil       | 5.85658E-05                  | 17074.8    | base             |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:ondemand        | 5.03079E-05                  | 19877.6    | -14.10%          |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:performance     | 5.88132E-05                  | 17003      | 0.42%            |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:ondemand          | 4.60295E-05                  | 21725.2    | -21.41%          |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:schedutil         | 4.70026E-05                  | 21275.4    | -19.7%           |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:performance       | 5.80094E-05                  | 17238.6    | -0.95%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:performance              | 5.8292E-05                   | 17155      | -0.47%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP: balance performance:    | 6.71709E-05                  | 14887.4    | 14.69%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:power                    | 6.66951E-05                  | 4993.6     | 13.88%           |
> +------------------------------+------------------------------+------------+------------------+
> 
> Tbench Benchmark Data on ROME Server CPU
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | Kernel Module                               | PPW MB / (s * J)  |Throughput(MB/s)| Energy (J)|PPW Improvement(%)|
> +=============================================+===================+==============+=============+==================+
> | acpi_cpufreq: schedutil                     | 46.39             | 17191        | 37057.3     | base             |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: ondemand                      | 51.51             | 19269.5      | 37406.5     | 11.04 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: performance                   | 45.96             | 17063.7      | 37123.7     | -0.74 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: performance(0)               | 54.46             | 20263.1      | 37205       | 17.87 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance performance          | 55.03             | 20481.9      | 37221.5     | 19.14 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance_power                | 54.43             | 20245.9      | 37194.2     | 17.77 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: power(255)                   | 54.26             | 20181.7      | 37197.4     | 17.40 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: schedutil                       | 48.22             | 17844.9      | 37006.6     | 3.80 %           |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: ondemand                        | 61.30             | 22988        | 37503.4     | 33.72 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: performance                     | 54.52             | 20252.6      | 37147.8     | 17.81 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> 

Please add the test cycle number in the average test result.

Since Jasmine has submitted the TBench and Gitsource benchmark test suite
into amd-pstate-ut test module, I suggest to align the test script and make
sure everybody can use that script to get the similar accurate performance
per watt data even on the EPP mode.

https://lore.kernel.org/lkml/20220914061105.1982477-1-li.meng@amd.com/

Thanks,
Ray

> changes from v1:
>  * rebased to v6.0
>  * drive feedbacks from Mario for the suspend/resume patch
>  * drive feedbacks from Nathan for the EPP support on msr type
>  * fix some typos and code style indent problems
>  * update commit comments for patch 4/7
>  * change the `epp_enabled` module param name to `epp`
>  * set the default epp mode to be false
>  * add testing for the x86_energy_perf_policy utility patchset(will
>    send that utility patchset with another thread)
> 
> Perry Yuan (9):
>   ACPI: CPPC: Add AMD pstate energy performance preference cppc control
>   cpufreq: amd_pstate: add module parameter to load amd pstate EPP
>     driver
>   cpufreq: cpufreq: export cpufreq cpu release and acquire
>   x86/msr: Add the MSR definition for AMD CPPC boost state
>   Documentation: amd-pstate: add EPP profiles introduction
>   cpufreq: amd_pstate: add AMD pstate EPP support for shared memory type
>     processor
>   cpufreq: amd_pstate: add AMD Pstate EPP support for the MSR based
>     processors
>   cpufreq: amd_pstate: implement amd pstate cpu online and offline
>     callback
>   cpufreq: amd-pstate: implement suspend and resume callbacks
> 
>  Documentation/admin-guide/pm/amd-pstate.rst |  19 +
>  arch/x86/include/asm/msr-index.h            |   7 +
>  drivers/acpi/cppc_acpi.c                    | 128 ++-
>  drivers/cpufreq/amd-pstate.c                | 949 +++++++++++++++++++-
>  drivers/cpufreq/cpufreq.c                   |   2 +
>  include/acpi/cppc_acpi.h                    |  17 +
>  6 files changed, 1115 insertions(+), 7 deletions(-)
> 
> -- 
> 2.34.1
> 
