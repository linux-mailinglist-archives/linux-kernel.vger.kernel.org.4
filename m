Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D81699BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBPSGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBPSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:06:00 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E034F38662;
        Thu, 16 Feb 2023 10:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtO8n1jvtISkxF4zVaCmrQX36SBUJibOvfin67kQTWyjA5ZduykV3bszNwLuR3S1EmrgBLKnv57oJ4Nv2FtVfD1OTH0+VeyWzXFdzDz/TLdFjjHL9nILskKi9FAfWRvBH5eyk51OCxf/p4rCmDUJJTyCpaU6UxZpY61y89xr7ZcNW6HuAPpA/kQlZmf8y7mXEETi28dIamiPFwdFScSUbwDwu42tZf7+igMpm75WNb2b+wA39qeFHUyAkEQ0ntsP83VJeaUKKh1BvQvevea37l6tIcZikKWpEGJ1QvgVcLw27oAW+Hk0NptWYm2DX27REZMSHcs3kHIVwPf6W1uMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLKeMRdAXSMLbvkvZjqoYrUzaqbB/DtPfsDvC4Q6Ovc=;
 b=J5qTxG0vD5D0mpAZMifHebodndvp76wiTA1xkD3vBU2Kdb6etwztLF+cEgugG2wOgblx0PqS7rMOpZup8uPIGifUaDOnvJSMBgy/jEYnOfdtGQH84pGFQdgowapuqzLqi0BwjELpH4qWZDMh1o50p5c1CjsweoxdGiYGLvotXgRXnjXWgA6pWYTrP0zidXoViJ+Nx5osleYdyH8lIEpE/bFe2a3T7Sge0f2vHtd/wx9QLp+6eRadAvfHGROkr5n8cblhlxGtaOw3goocejhV/Cgp+K7SJ4BcJRVHi2l6De0VsOM9QBcLsWaasv3ZNtj/k4OGRViq9svxvt9jLEPDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLKeMRdAXSMLbvkvZjqoYrUzaqbB/DtPfsDvC4Q6Ovc=;
 b=JqEVFW9jIhTQCMiT4meIQcLkon+iPA1atNa34W0OOmKQrujbcRsDHNBoUcJEpMp1qskJuI9r4JLo65N76t0ThNeWeZXuZkwKul32fUZH1hWT6afBe8FJ4nweoqxQkaaMPwvyN9LPxomI7zSkCGO0fbRPvNE4GkokfQcVN7hAFhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 18:05:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bae9:2c2c:976e:ee97]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bae9:2c2c:976e:ee97%6]) with mapi id 15.20.6086.023; Thu, 16 Feb 2023
 18:05:54 +0000
Message-ID: <15a893b3-e6d4-5bfa-85e9-1f5210173073@amd.com>
Date:   Thu, 16 Feb 2023 12:05:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: babu.moger@amd.com
Subject: Re: [RFC v2 PATCH 0/7] x86/resctrl: Miscellaneous resctrl features
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eranian@google.com,
        peternewman@google.com
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:610:54::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acd36ed-7334-42cd-b15e-08db1048724f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /GbDkWRr+Xa0B4DsW63Ta/hwlVJyLH1Ce9wnxxudB8+VKM3t0NTvPcOcUhaEHzprCQcKNTk8pxLJkW9PVuclEG0o3B37dYXGC7/zZsH7OHlcLIrJu8bmwXyxeiTIlgRGeuBXHSCCUJG9Qufk7j16/B+9dXWneYxXAgp2zWaNuxsDS2OrDJXwgBV1sy0ZGgBonZSiz+cXb1yguS36LD+dlTDF59xjGOqCtrm3oGzEoGKgHvePjFzxUM5TYj3RxmI6HCYILSIbxLADt1s+FYb35LWrsI/liYzv+rfCLerhUF3/jrsNclj4I9Zg+RGvxTHgvP74k8FnsXgwQvRznvNb74YDFxNxmi55XdDLnUm55iOMwsIr/RPApIU9ANMrKkAINJ3ecFDhfTBeiKNnhVFms1xRJhOdtGcvbPd5bYtCAJR6WbManiIYsz7/cQJSxllAzZCc4BbE5xmZcUfoftEtzHuY8q14MdIyfUclsjDLtumlsGk0YRgYmuwejalezyNnX/KTkftVIU3vlfeNY/sB5IKXCDiYiwKavnDiOXK2xKrfml+JJgCcWIrCknTj7XCG9OgfL+elMyNqBUJk4K3Vly8oWjK4b6Fqd39VJsu7B2T7Y2J1SqB120GyMH65mJveIBKuvqrHpPa69KVedsb7bhLUuM1Z2G32z+wLQdu2XmHl3xzYw+lPVPgJvraVE72MaaKVBjkmGE/ME7nT7ljmnm2eND80plf30i0NkOcJlj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(5660300002)(8936002)(2906002)(3450700001)(7416002)(66556008)(8676002)(478600001)(41300700001)(4326008)(66946007)(66476007)(316002)(36756003)(2616005)(38100700002)(83380400001)(31696002)(6486002)(6506007)(86362001)(186003)(26005)(6512007)(53546011)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJoY2UzazdLaEVxaytoaldqTzNHVFBUTTl2Q1k1NldXZ2duaVBEM0dnQTd6?=
 =?utf-8?B?MFN6cThCUjM1RFgxelRoYzh5MThuTStnSXRCcEdsektvV3g5ejBrekIxRHpw?=
 =?utf-8?B?QXY3S1hma2RaMjh6VnZSRDN4ckg1VmxlaTJGaS9FTGNXUENobXRyMC9IdUh2?=
 =?utf-8?B?UGhWOGd0anAwWmROM1hwU1RXVmhZcUZiZmRpcWVDSW9JRyt5aGNxQ0N6bEZh?=
 =?utf-8?B?NjJKdlFrSlZZTll5Rms1dDhpb3FiSWcvdWxISS9lcDZ1TStTeWdvbWdUUzdo?=
 =?utf-8?B?NHJWL3ZyMHZWNndJd0xMT1I4MVlrRGpxcHlYQTkxWE16cmw2RVVtWG9GcGNS?=
 =?utf-8?B?SlYyVG10ak1JOTV6dVZ4R2I2bHh5c2YxMnFqZVVDNmpIT0dQb0dsMTFQNGli?=
 =?utf-8?B?TFkrQmNmcUt3VktXM2YzcjJWQWNsMDlLZ0tFbDlnbEdMK3RHbzkwMGhidVND?=
 =?utf-8?B?a0ZuYWU4bTdua01HMHR2dVNRY2tIRHpKSVlWd0tFektjWEhzWFlZcGpJYmoy?=
 =?utf-8?B?VWYxODRzbXloekd5aXRDcytEbzQrbkh1V3JzTFZKU2FZcFV1Q3UyYTlDQ3pm?=
 =?utf-8?B?d3dzOHBjTWxMQ3IyUVFDN0orLzdRRDlCaTZkMlcyY2RDMkdFMzN6VElhYVEz?=
 =?utf-8?B?NVVwMEh3ZVBUQU1wTkVhVjZoRlVpdWR6OVpieVR1RmMwMUhNamV6dmRncktj?=
 =?utf-8?B?ckdXOE45UXBTdzNjZkNSZnRFMnJhUkdQbHJ4YjdrYlNic2hZVjBzQjVxYU9t?=
 =?utf-8?B?b3pkbHJDWW16SnB5UVUrQ0ZQN2FKNjREaXFucW1qdTZ1MlNNUjVwYmlXVXZp?=
 =?utf-8?B?Rno3cWtsR01hSXJhTDYzMWhMS0tsRDhhYk8rVmxCNmNOR3JpVWhNZm4wMTl1?=
 =?utf-8?B?WVptMU9INEZENkQyaUNBNWxveWtua1UvbERYZERjb3RrZ1pocFJkQXFhc0lL?=
 =?utf-8?B?RlUvdnBQWUx5cE5VejZha3NET283WEpaKzZjaTdjVC80d04zS1JFSjJ5eUtL?=
 =?utf-8?B?TzFjRjI2MHBQc3J6QW5wcGhNWUF6MHQyNGc3cVlkbWVGUE1VNlpzUUd5eTVa?=
 =?utf-8?B?NmsrREtLNHdobytQWU1FLzBHZ1poeWZmSjROcS9PQlhvUFZjZ0J0dS9ja2U2?=
 =?utf-8?B?aDdNblJxa1ZQejJkZ3JvUVZoKytwSlZpVnNjc1RTbzE2UGREWkNQamVZNFUw?=
 =?utf-8?B?b2pnSDZjSFBlQjFLVUtyM0VyaGFadHlUVWs5WStzbHZjempWY3RmNXAwcVRR?=
 =?utf-8?B?YSt5a2M3TUczSnJ5MGZJS1JuUjhldUw3ZlFUR1ppU3lCeDBKdkx5RXRSLzZs?=
 =?utf-8?B?aWIzOWZaTHRyd1BHTXc4NEVETFhNbGpMRzB4VXhvQkZnWlNrYkJQS1pRaDlQ?=
 =?utf-8?B?alQ4MitGWWZGTHU3MzRFV1diWGVZVEV2d0FsOUtKVDlqQ0dkZWxUTFVHeXpq?=
 =?utf-8?B?QjdtMGM4ZTdkWk1JYlBCanowWTRTMmwyQnh2eFpxWjN4MHU5Ti82R0sxRURW?=
 =?utf-8?B?ZHRFb0FoTkVJTmVQVlRLY1pZV1RDTCtNN0VKNUc5TDFPMk1oZi9PcTRGUWs3?=
 =?utf-8?B?NlRJdGVMOSswdDNSSlpZR3RLYk51TTJhQ1hGZjExeUxub2gwbTdhcTAwTUxj?=
 =?utf-8?B?SVYvcitodnpoRDVuZGhvdlpEMUwrclVlRy81ZFl4NGVHV0Faa2plSFBFSjNz?=
 =?utf-8?B?WXFxMHBOUnJ4SXJyZnRrcm02V25RSzVtR25hekZ0N1c1YTQvc25QN2JZYTBV?=
 =?utf-8?B?eHVsSGpOZHJVSVNqcjFOTXRBbi85ZDdiVnR5ZFBDeENLSlhJZlZDamlocXpr?=
 =?utf-8?B?U2oxQ29SMkpOZ1QvbGw4K2QvUXJ6akx0ZjJSRHJPRElOT0xwV0tVbitIa1A4?=
 =?utf-8?B?aDdBMDhNdWt0NlRlaEU1cDRsdUpGaHYxT2t6N2hyWFBTeUpKOG4ybkdiTHlD?=
 =?utf-8?B?a2hiM0xyaDJ0T2h5Sm52bzNNTnFnNnFkZjcvOStONzJEd2hmYnJWV0hMcFQz?=
 =?utf-8?B?MWlwdW1ZYWp0dE1JVW5zUmcwV1liQW42UlR6VHZZUHNTTGdwOXFaRGJyenBo?=
 =?utf-8?B?NEtYVWJwMTlCcW9vVlpoRWdwdVNKbVRFU3VVa08rSnEzNkNoamd0cWZ5TFl5?=
 =?utf-8?Q?6svewE/evoIFAGT2v7TJnxyWT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acd36ed-7334-42cd-b15e-08db1048724f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 18:05:54.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VElG3q51nbCKUtzOPvNmG9/YqNylXGjypdvp9kV/HBsXm4tTenB9JlkT9K9h+d90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping. Any comments on this!

Thanks

Babu

On 2/2/23 15:46, Babu Moger wrote:
> These series adds support few minor features.
> 1. Support assigning multiple tasks to control/mon groups in one command.
> 2. Add debug mount option for resctrl interface.
> 3. Add RMID and CLOSID in resctrl interface when mounted with debug option.
> 4. While doing these above changes, found that rftype flags needed some cleanup.
>    They were named inconsistently. Re-arranged them much more cleanly now.
>    Hope it can help future additions.
>
> Code is built on top of tip branch x86/cache.
>
> ---
> v2: Changes since v1
>   a. Removed the changes to add the task's threads automatically. It required
>      book keeping to handle the failures and gets complicated. Removed that change
>      for now.
>   b. Added -o debug option to mount in debug mode(comment from Fenghua)
>   c. Added debug files rmid and closid. Stephane wanted to rename them more
>      generic to accommodate ARM. It kind of loses meaning if is renamed differently.
>      Kept it same for now. Will change if he feels strong about it. 
>
> Babu Moger (7):
>       x86/resctrl: Add multiple tasks to the resctrl group at once
>       x86/resctrl: Remove few unnecessary rftype flags
>       x86/resctrl: Rename rftype flags for consistency
>       x86/resctrl: Re-arrange RFTYPE flags based on hierarchy
>       x86/resctrl: Introduce -o debug mount option
>       x86/resctrl: Display the RMID and COSID for resctrl groups
>       x86/resctrl: Add debug files when mounted with debug option
>
>
>  Documentation/x86/resctrl.rst          |  28 ++++-
>  arch/x86/kernel/cpu/resctrl/core.c     |   8 +-
>  arch/x86/kernel/cpu/resctrl/internal.h |  68 +++++++++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 154 +++++++++++++++++++++----
>  4 files changed, 215 insertions(+), 43 deletions(-)
>
> --
>
-- 
Thanks
Babu Moger

