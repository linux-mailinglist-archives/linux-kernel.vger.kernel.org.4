Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1DA663C13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjAJJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjAJI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:59:55 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD05370A;
        Tue, 10 Jan 2023 00:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCrx6NtIAgCkHFAnGyzSuNBWDWYyi5o7B41gWt39K5YZcyCcLTeTDgPPMxvRL7Fwy0viBXSM1sOd5u83hDcFWBInBOJoOgds3bVuB848q+v4ahu9XepQBbmi/T5UoSfLlTtejdc4pod1HndWyRCsAvSRyCiO/RRtbOcMO5Nh9DMXQg1WvaEu89IwO7Pf4V09T7O4qPXc5IvXPmbS/4NHRxlCnxF8rEciqWtdik45EVZXoaPJeZ5nUMQmG/FRNuOP2snhk9o42maSFldibll/7rnypx8a6GvuPXDm2fzLKRtpU4IvaOv/HzRyVNOSr+IX/IND+0tGvy+0OS8YThiH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym4DufXJrf8nR7eilfR340I2Qbqidh82LP5qufyzOHo=;
 b=VLNV2c2w+ORxiryQ/yQ2hkea+mPCF2UfSs64JtNpE3C699gw1eEE1JDJ3mt4q2LSxzy4JdS8AJve5IHM0RHdxGjmBg7GNM5uv4Shdet3Z7wx16/vNtnOicGhdffbvIB65SPSP9gfM07jbivzFViyu264jnckGpS3gcQxvkCxBS4Jtl/Vx95I73ANmCZ/0uQmzKXgbPfl116b8qOV8v/973oAZkuHXBLLQocwKCtPWCRHnUzjRPO0TtZHl+hbZOTh1d9h/ogA8vxFy3J3EVpzzILNi35Vp31XVmL616wUxvJ3LSKgBg3tvg9J14b48kX5uUPyx+/vpsRYfDAuKEJE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym4DufXJrf8nR7eilfR340I2Qbqidh82LP5qufyzOHo=;
 b=J9nr26+TyPo/9lXBMqsQaUvB+JGM09tRHRJAZ/Kh+A2m7T/0uK9S+gWoZC20skxXFRhb4Eu6Pie02v+XBhAPKXYO927GQ4x2L36Va6+lEZK8+yXDqGlBBBQVxyehalybCGIcbAEK6+2AO/YQom0AM3ectQIn18hdWmcjcBwjI5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:58:52 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:58:52 +0000
Message-ID: <06bf52bd-43eb-74f9-dfb1-470e2e42fe51@amd.com>
Date:   Tue, 10 Jan 2023 14:28:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 0/4] perf tool: Fix non-".text" symbol resolution for kernel
 modules
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, james.clark@arm.com,
        german.gomez@arm.com, leo.yan@linaro.org,
        alexey.v.bayduraev@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230110055859.685-1-ravi.bangoria@amd.com>
 <86f43058-a51a-42c7-4d75-564f0e8eef04@intel.com>
 <760acfd9-26a0-e028-bc29-004be0b2620c@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <760acfd9-26a0-e028-bc29-004be0b2620c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: ed95c8f9-f1a4-42bf-6863-08daf2e8e51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEfJHnK0UQ2TYNhBLm0vs/tBIIsPxA7xzqH6JjFPwG5iE5SmHXftV68MAe4+jKWNLTDdDCpdPm5WKtM6BNBmaxRn3op+z+V1Qq17x5/Tb4xDYhqFPf83w5HzoBcYlEMdX/+2awY/t1EsdzKdgggNYLdPB2BO9C8k7wH3IAYqhOrnlQRvBAxggIc3UL140P56+tF0QbFbFvBsHAxd2McYF500WqjfHNzl9YxddNLPSxtdJ3bhnYVoX552f2JnPG0j36TfZLLRrK8/NlDpcRk0fsb4Qx3pmNoofLEFzN/Wi4cPbpMFeoPsO7/UWJec53ucUu8pDgG2NCMTMJHWafHXQhyDqkgwWHU2sTxWQ/6ya8wkbuXpSuxqf7Ua68sDHaZP+ntMS/VpaxQdYqqYOlZMk5kdxg//pHcZWQvH0fIxx/sNv71TqZfut2OXA+ABwoCrqVnEo+JOW/IGgtYBPIWSFA0Th7vOQaMRlrFOnRgufjvTmbbsRJCOP3WaZaa9mB6cbZzllYNUJOHHJppOKSyC3Eyx5VwFpoKr3e0Is1+aav+8VjVUFtydKvdz7X64bAV/xRD5ALbRGW7nk9IkcA2/2Nw6mAZn09c/1Ru39kNVFt5A+ocjfPFku0dUcieBEPynSfEOr0s47Xn62iCu8yL00ktnxATZBdFMunyLbW+UJcAq6qmxuG1tLcBWM2DbiKjmCiMpLIxUA6dLHjUHjuD61CLrpYdfsxT+FkncJLojOA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(53546011)(31686004)(2906002)(6506007)(6486002)(26005)(6512007)(186003)(478600001)(6666004)(316002)(2616005)(8676002)(66556008)(36756003)(66946007)(66476007)(4326008)(41300700001)(5660300002)(38100700002)(44832011)(7416002)(31696002)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFMSVB5L3ZNWUtvNnBzbWJIbDFzZ0NkejdQVUZ4RzBVejRpTHE1bUxHYUtF?=
 =?utf-8?B?V0VGaERQRXpjck1CTkN6OHhBUUFZaFZPOFhIM1BzeExMMG0zM0NNM09Mdjhs?=
 =?utf-8?B?cHA0N1BPWWpKNDVMbHVsQklnQTB2cVh2eE5rb1diZGpWUWJMQWhMbWdPSmFQ?=
 =?utf-8?B?M09vblY5WVZ2TGl1RUpwa1BQR0RYN1UrN0hKdmdRZ2ZIRzNaZXZlNHZkaFp4?=
 =?utf-8?B?cnZTNFE0eW11NWVqNlI1Y1pwdVN1bnR6dWVIZko1UmFiaVVvWHVUWklpTHNT?=
 =?utf-8?B?ZXJ4d2JsK3llZ0dQb1pTNVRDRG5tSko2UlNSVlZndThKQVFWblVua3BvLzBJ?=
 =?utf-8?B?RUJ0dWNYRlFzY2RGZUpmOE9mRG15WkN5NjJxSWFGL3lqb3Ztd0htKzlVUHl3?=
 =?utf-8?B?emNCek5qem4ybnRDaHdkeDVLVXE4eSt2WWJEMUp5NEF6c3BJODBhc2tZZ2tY?=
 =?utf-8?B?bHRSSERQVWtKMlNIVnk0ZVFqWHRSa2NtemhOMFc1dDlxWDc4dTRSY2Z4YUdm?=
 =?utf-8?B?bFJhTFdsMlN5Z0IreDdRMDUwd0VFaFZLSFVFUjk5OWFheEJXemEwYVVJeDBp?=
 =?utf-8?B?UkRZYVZoMkZrWldjSU4wemIvbDRZQnNUNGxsM3NwVlVBRnNPVHN4UUlKeDdX?=
 =?utf-8?B?SFFlQlV2Z2ZtQiswNFpOdzRWMU1rc2p1dUNZcm40bEhJcjhnWkV0NitXM3FT?=
 =?utf-8?B?TVRrY3RuRTU1RHR0QkJublZybHFsaURub1hrQnRTTlV0YXFyeEtLL0pKNVFG?=
 =?utf-8?B?eW9JWEhBWXQwU3l0SDB5OUVrNHJNLzZqVnNUaDE3bjdmZWk1RGZFSmp1cEhL?=
 =?utf-8?B?TDF1UUVNYVYwcWV2Q1Iva1RRK3N0c2FRQyt6MUxUNFVURlNVbGtGL1dUTWlu?=
 =?utf-8?B?S1BMMmQvVVJ5SlRweHJIL21ablYzV1loNDB3dzVCSyt1QzJxQTlvZGVCZXI4?=
 =?utf-8?B?T1NsM3RkcXVuamZ1YTE3cTdmN3J1VjlvR1R6ZWpMaU94aHJMNSt3c3QyVG5q?=
 =?utf-8?B?T1JRTGxaSXg1VnVhdEpJSmg0WXZsRWE4SFhGc1BIdmVMQ1l4dEttNVBjMHhs?=
 =?utf-8?B?eWZzRzVrd2xvMkhVTTlGblYvQ0J1Uy80T21DQk5jUW1JWk5nL3ZrbkFub1Jo?=
 =?utf-8?B?dFJFVThDZDJwUEQza3VUNzh2L3NhUysvUG9SUFIxTHZQbmR0dDN5Ukc1VWhQ?=
 =?utf-8?B?Q1FTRzdlYlNzRmkwczZnUFBmYWVtMVFXd3F1ZXliclY2VDg5OTVKdnJwbDdL?=
 =?utf-8?B?THZQS2JOc3QrdTVaZ0NnRndIU2FRbFNzMEYxWnRnSUk3ZUFjSXpXaklsamgr?=
 =?utf-8?B?cXFhV1AxRUhFTlJtSE5CTk5rR3NDSFovd1Z1bnk2TjVpdzdoWm5Ddk80L1Mv?=
 =?utf-8?B?RXRUbnlXUlhJMkFta3JlMEVXay9scVFVUHVEVVRHWjlBODVxZlN2QjR1UTl2?=
 =?utf-8?B?ckJKYWxKZkc4MmlaRGdjMVhrSGVqRHNDOC95dUphbFZIVWtjemdKa3Q5NmZz?=
 =?utf-8?B?UVMzT0dGVDYvSkp0Q3lENTJEclhhTVZvOU5Nd296RjlsTGtGSlQ2STVmYldY?=
 =?utf-8?B?ZnB6TGFoYVJMWGJ3QyszVTZzNTJoVmpNSURWc1B2b1NUL1Q3ZFdWTlJHNGM2?=
 =?utf-8?B?bXI5Y1phbU8rZUdhNTRxV2JEc2RKZWhlYUhXRnBHSnJMbEhrVEJvT2NnZWV3?=
 =?utf-8?B?emFxTjdiN1U3T3A0ckdaTnZrbVN5U3JWSkZ4Rm90Nnd1d0t6V2ZIcno0L3Np?=
 =?utf-8?B?UVorVWdERFRwM01RLzBSSm1UYnV6SzlzejRLWmJFQm1WUjZUc2t3R3lvOWVR?=
 =?utf-8?B?dWlFRFd3aVpGUGIyRDVCRFRrYUVGOW0rdXk5WnlrakF1ODNXVmlXN01pdDdD?=
 =?utf-8?B?NzBOZkwzMEhwZ3JZTHBjYXFNVGREaUJSN3o3angvam1pSVF0VjgwTnNYNXJM?=
 =?utf-8?B?dkRNdXJ2cUxNSDIwblY1d2Mrd2pWb2RGSDFUNDEzbHkzeUh4eXNuYjB6OEtw?=
 =?utf-8?B?ckN1TE1waEdPTjVoNVF5ZmxZUTM5aWFKOHdTWDNHUGdjbmhBMEVDYWtYMzhv?=
 =?utf-8?B?UFpWME01QXpPZStyYnlOLzByNUFxbGsxSytaWFhWRTJKV1RrcTBuUkhLZGYv?=
 =?utf-8?Q?6YC9S2NZsZMyXTn8Yu9r9Jqd4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed95c8f9-f1a4-42bf-6863-08daf2e8e51c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 08:58:51.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xAUpndyInGbD3YHO7CxXl34Oo+ztRMP1VvRxFcgJxUdr8Xl21TOvLusqv0r052PIGX1lBV510wFbb0057pZsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-Jan-23 2:13 PM, Ravi Bangoria wrote:
> Hi Adrian,
> 
> On 10-Jan-23 12:05 PM, Adrian Hunter wrote:
>> On 10/01/23 07:58, Ravi Bangoria wrote:
>>> Kernel module elf contains executable code in non-".text" sections as
>>> well, for ex: ".noinstr.text". Plus, kernel module's memory layout
>>> differs from it's binary layout because .ko elf does not contain
>>> program header table.
>>
>> Have you looked at using perf record --kcore option.
> 
> Nice! We can also use --kallsyms with perf report and it resolves symbols
> fine.
> 
> But what about normal perf record/report? Why I'm enforcing on normal perf-
> record/report is because, generally user don't specify these options, esp if
> he has root privileges, he expects symbol-resolution should just work fine.
> But when he sees inconsistency in symbol-resolution of the same kernel module,
> he will be clueless of what's missing. This patchset is trying to solve it,
> although I too feel adding section specific maps to perf.data is overkill as
> --kcore or --kallsyms can also resolve those symbols.

FWIW, what this patchset does is not new. Perf already creates (pseudo) maps
for module elf sections while parsing symbol table: dso__process_kernel_symbol().
But perf does it incorrectly so this patchset is trying to fix it.

Thanks,
Ravi
