Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10B6AC50D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCFPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjCFPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:31:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031236086
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALIS5LVXQhiWxsYtapnOVr2IDGVQitUl4DK0CDWfnwnbaOCfV1sXaOynE1iqCfnGzmVuCMu/7gzbwPFgmX6Jq2n8qH3DezqwJr31pC3hvRvHUwA1xRtVwGFO4beftAN92yRVblHP//xHqVmErnCug3Pt4xagH3ekWL+4GYdLObwpiv/jhawnzrh5b4c277PDC617lIIzHWvwqRubPfO0eMdj9QFeCFfHyS3xNjKixk9P74RzquoIkaQjHQxwEATAsROMixSB+8tLnjJRjR/fW39Dk4/WJ0vYdnU2jUFKsK2PwyNR3+8dJCYlioAoZ5d6DqPBLjMA/Vs8iLJpDZJTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFLIAAi94sGcpIhUzluEJEgP0hJKTMpXcfKQp2IzVQQ=;
 b=E9vChVgYZ67UOhPsloH2vRY3lfx7iQAuqaQwhgtWuJpC8PAqBT5S+fuHsBh99677EOQVvhk9ZRMq7KAnKj+GtbWgEc2Il5XWmKePtjPIWNH6uD722tusGEuq3MX1gjkRCROnEXcFqKWolG6HkI83xCZpI+h3KrKZCgRsYd3DotpnoNc8JaCws6kzk7nkhE9V/ZzNtuKfS9afmvB6tEyOwCwanJUQBGlXfbNut6kdlfd8JxhIsAsq/NOVLdcqZLqyFV6x+3COPEOVUf8AY8VnU3EC8uPAModDveEd1/YaDqbVrD/rF62OXRUxiIDo4hvubd/qlswLPVCbNUycs0JtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFLIAAi94sGcpIhUzluEJEgP0hJKTMpXcfKQp2IzVQQ=;
 b=S5iZacous+h7gVgHeQXHdlGSIfy1uqoWPrh/CVpuEqfvrCsqKqOxZ3p8Y7s6uy6JIc/oQ2HItWosOzSKvJjkWCNZBdSze8xa7alDHrq3MoxHRZa5yf6Hnx5pDGz1gRIgZmpf95zmIqNZmK5GeSw79ebTjfGmehWJOxa1XhxLF5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 15:31:01 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::fe66:3fca:2cb4:1e7c]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::fe66:3fca:2cb4:1e7c%9]) with mapi id 15.20.6156.023; Mon, 6 Mar 2023
 15:31:00 +0000
Message-ID: <55a344fa-4325-e82d-eeaa-1a77611ff513@amd.com>
Date:   Mon, 6 Mar 2023 21:00:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        peterz@infradead.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, tglx@linutronix.de,
        yue.li@memverge.com, Ravikumar.Bangoria@amd.com
References: <20230208073533.715-1-bharata@amd.com>
 <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com>
 <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1547d291-1512-faae-aba5-0f84c3502be4@amd.com>
 <c3e79d2e-97da-726e-bcaa-0258e3ddfafe@amd.com>
 <87zg9c7rrf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8fea74ec-8feb-1709-14f2-cecb63fdc9ed@amd.com>
 <87v8jnbl22.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <b19e0c22-c80b-7223-6ed7-472502948fa0@amd.com>
 <87jzzz8tgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <41b47cd7-1ba9-3205-165e-02e8384e7064@amd.com>
 <87356m8jo1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87356m8jo1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::8) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d087e7f-e49f-4347-fa5d-08db1e57c9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATUM0CIxLtkhlv8AG0lXFTKF3GV7olhxcXg2PsfBdh/z90PjHo/HQ/FNlsDFJKTVO5hzndVlLh94S2RKha6vBWxQwYq9XMOzf9WdByBOkwVTIlvAqCRoi7HG8Er2dGBMJp5bBNaAZjUuSWsn8qutwdQooDrjmQawIp1AUJM8Q5hjSqQWgpl0oNB/CBmzgBc7ZKQF3OEiE21ZbuzPGeHTiLOaZ2Bb1y8l+r4ngNpbpQxTw1n+tZ+k/C76QCCf2OgfqSeFZ8X5hRBuMtMPXT+YRzznRCbvpLVTG2jnphdy0avRJ1VxWh7VkF+vJqdTGmlouv4cUVC7PvsJgtESt5iKs2soL353Xuvz8aglnIbqNc6pccvNRa5ODNGuIhnRYxDfvTSlCepaOUzgumVm1Zdm4VG2Ayb3heyN9N6rDQRIAXogAs+GZ/+NdPwizJdthZRNNmqQzxyc/P2ZWhYrITTv6pOBmYEUvUcDv7b7UNaVDQxPoQWelNBbqe4z5L3MxwDJzWKRRDZlDxi/GyBTJ4Ot8CSHs7Zbixo1uxARr1yfR1xQejS6vTeIFPbbUdnw1drCAPMYPTKL43+5v/MJTcH0aYpxZIqkTAVjTJwnmBVot4c3lQjc7KSO22XagAKhV3p65g/vDR8uwuz8lB8il5GWPDfoJypr29rc+xmr8uIl8RryvpFHUdoL1y9zK2iI0kHiSHqIxDSxPGAbxwuiduVVpb9flaQIc54l++YcyxwcjeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199018)(31686004)(2906002)(4744005)(7416002)(38100700002)(86362001)(31696002)(6486002)(6506007)(53546011)(186003)(478600001)(36756003)(6512007)(66556008)(66946007)(4326008)(6916009)(8676002)(66476007)(83380400001)(6666004)(2616005)(26005)(8936002)(5660300002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJ1dytHT2dPOTNWQytVdkRra0hUNVI5eStwc2FzcGRHUGhzemhwWVBYdGda?=
 =?utf-8?B?SDR3OVRRYnpWTFBvRVRkMitWV2d0YTM3ZEZ5N2RaQzJYTUczYm5FNUhGeTFG?=
 =?utf-8?B?STRqZ1hJczZMSkFsMDk4U1JJd05Zemc2ckxYU3lOMzJ0bzVmby91bVZOK1pR?=
 =?utf-8?B?SnRjV2F0dlhVMnhTZXEvaFdYQndWMEVTeUNkSzZ1aHc1eHg4QXRLWEdjMnp6?=
 =?utf-8?B?UDVzUjYwOFhMRmdRcm1ZdS84S29ob0dEcFRiZUpLUVdHU3E0OTJVTWdOeTVE?=
 =?utf-8?B?VWRSMTFNY1kwRDArOS9zREtveUVJTUczcmc1N3JkZ0lMM09kNERmYU05MTlu?=
 =?utf-8?B?aUhDZTY3YVc0blRqR2tpZ1pOVVdvNlBlblkyZzRBNXJweXp1L2dHZVdxRjly?=
 =?utf-8?B?eFE0SGdVbDdhamJwQUUzcUhBT3dXWHJ6UGthRjBtQjdJMmM4R0E5NVpKZkJL?=
 =?utf-8?B?WGVsbjFnNm9DSWRJK3k3dStFUlpFWERLYkQzcVJXK2VpNHcxbEtndU5aQ0ZW?=
 =?utf-8?B?cHFjdnVTZlRnNTJidGF2TG94UnR6TENJazM4dGxQSDk2SkRFQ01zeFI2TEdO?=
 =?utf-8?B?UkZjOWlzUWc5bGd2OVgvbWt5Ri8reTRMQ1JzMGRCVUZGTkZsTWpBbEg1VTg4?=
 =?utf-8?B?ekZHb2d6ZVcrTzhyaFhESXZuMkR4dFFTVzl5djY2eUcyczB2dnRYemg5RllW?=
 =?utf-8?B?UUcxZVI1QS9HY1FWVC90Uy9KUUdQc0ZKMi9sbXpGK2dlT0pRb0c5bmRNeS83?=
 =?utf-8?B?Y2lRZ1pRSHVxUUVWVmM5V2kzMzJmcXdDVVZYYkJGYksxTFNjNzE5b3cxV2Z2?=
 =?utf-8?B?dm1ZSlJ3YzZoQ1NxV0RUNGRjNkYzdVZvRXBvS0IvSkhoVGhDUDFNc3hEcG01?=
 =?utf-8?B?dmRCZUNxelUrWjQyMGZqZ0Y1eFVwNTFlOEV4VUhzRXRIcks1cndXU0x3Rko1?=
 =?utf-8?B?cUN3N1BFV2JoUG1ZWmgvSGU5SElCRnpNbnI2aGQySndka2UzT2dpN3V1VU9r?=
 =?utf-8?B?cUlpNDRzRlJwVEtObjc3TE5BS01kM2pXTFRYQUdwSzVQM2sydmdwMDdWWUFy?=
 =?utf-8?B?L055L1Q4ampMNTBzdDZGenNmRlgwakhQellzTWp4TFU2SnRPdEMybXN5eWNX?=
 =?utf-8?B?cnFoSEdjWitlVXZlWXl5M3Fmc0xvc2MvN254OFYrSnNacWtlTyt4T3plb1hT?=
 =?utf-8?B?UVZsaEVHRHNUMkl2b29hN0xhNHJteUdJZjh0ZXZZMzdWNEtVUTF5VERmTUp3?=
 =?utf-8?B?eFVNUS9Pekwyd3ZSV0dOeTNMRWV5NVJRczFiM21ja1dRZkJyS1NVYitXSnRU?=
 =?utf-8?B?emlGK2g1ZEdiVjcrdU1WWjRqWksxcGtVaXRIWW1WQjlxMHZoNC9VWThINHN4?=
 =?utf-8?B?YVUxbGtnY0tBdVNscDAzNmR2M2tMakMxVnhFRFZVL1BvcFN0ODBqQWw0MFg3?=
 =?utf-8?B?cUgvdnNXWDR2ZktrcFZmT056bUNqbmQ5anEyWlJoTkdCQkRucm1Yc25HbUR0?=
 =?utf-8?B?cnJqcXpkU1hZTG1jUEVMWit0NTlIbUtyeFY1Zkp5N3d5N3hJYUk3OHI0NTBN?=
 =?utf-8?B?c244NHFSN3hnajBXUWFkVE1oV1FJOUd2bkdrYlpFY0huMUlaYVhQaVJ6dCtr?=
 =?utf-8?B?d3NQTU1yQUJHYW4zSkphZEZXb0g2cExIckgyTk56bFhVbkI3QW9KMy93QVpx?=
 =?utf-8?B?UWE2dCt3U2NuTzU0azBoSXl5dTdNUUsxN0N6NW1RTmluamQra3FyZ3lpc2sw?=
 =?utf-8?B?alhJMU1tOHFPUW81K1BRYVh4d2pZZWp5d1lId3J5SmZvV2ljNmJHNndCbzNP?=
 =?utf-8?B?WlVpR213OTRvUm1QVyt0dDZROWVSR2NDaUVkVWFVR0x0cFdHdHZXN1I3aHhp?=
 =?utf-8?B?djZxcGdjSFpVcU8vTlNEUURnelJCWVovYWE2S2MxVDl2WTZMNXpMVWI3RS9T?=
 =?utf-8?B?dWMzS0ZzM3V0dS9rT3JGMmY0OGhnTEhEVFNLMjVBTFczNmpnRXhzdnlVakl2?=
 =?utf-8?B?MWQrT05wU0hPTFZ1WjJOSWRZUm52VlFZQXJjN3FqZ05XZjVoOFFDRGlicGpL?=
 =?utf-8?B?Z2x5SXgycWgxN1BldlNOd1RoNTl2SlZ2cURTazdpUFJUeXpLbWRsOXFXMDJQ?=
 =?utf-8?Q?ke8t94ce88jHeNmXtyLlbaNoL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d087e7f-e49f-4347-fa5d-08db1e57c9e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 15:31:00.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciN8eT+IFUunEwlL+3F4butHGVT0kIXDF49axanTjvjtzmTbf9/FUzLn8d8CJQJ1RCCbfXHnglqeBrTq9k7SWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Mar-23 11:23 AM, Huang, Ying wrote:
> 
> What is the memory accessing pattern of the workload?  Uniform random or
> something like Gauss distribution?

Multiple iterations of uniform access from beginning to end of the
memory region.

> 
> Anyway, it may take some time for the original method to scan enough
> memory space to trigger enough hint page fault.  We can check
> numa_pte_updates to check whether enough virtual space has been scanned.

I see that numa_hint_faults is way higher (sometimes close to 5 times)
than numa_pte_updates. This doesn't make sense. Very rarely I do see
saner numbers and when that happens the benchmark score is also much better.

Looks like an issue with the default kernel itself. I will debug this
further and get back.

Regards,
Bharata.
