Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A6675E74
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjATTzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:55:44 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E0BB96
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSL/g176LmGC0ysLLgEK/MzzzHlv93vIMcK9P2f2K+tTsqcIwHoURL0mLzrFzMGYBciU7FbhQJ2jmvQnm1LmSfFuZmUSDI6oXjdA9HJyN6G4OnGzGvatOORVpqDz+LRYZrg0GPbcyKCsxVFuoOYlYc7jqrCaAG8CoNZB+5aj+5ruyfUrNB82Nm5VKuq3PzAATqeMzBM03lgrrJN3esrSJS0v/uGFil/7hUScuclNxZXGc60hEvcHGKCET77Xv0GAAy+/8fKWm6e1LFqihtJo644cosbDbh+M3Av+3BwpCMDVlZLMZaXEWflqvSu8qvNpffrKk4hgeECp4BK63Mz6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqw0VLpPJ2+HNIt/go5j60c2bL2EU3ULlLAoBIcSQSM=;
 b=TqBJl+bOiFGQegYQ3D/rl3rEsx2gjrQA92Jp9EowScx18uNo6znlgFd3PDO4JUFl8xvX8WX3Z19Ttezd+/6jIXKjTGIYGQSXfvptAs13f+bz7G0KHEzCfI2vOs4x2sANqzMRgPZ+PB9CnhAx07hHoGBrNZQ9yIoi1w40rOln6+MflqDrWd7p75J23ZMEirJYogx71nKgCUBQcn4trthCUpA0Y3P5KsYBJC7i5T4yHfBIa/gphd/sWDzaeEP80KxSnWpdDu7Dpha/YNT6cKerinFSW6ws+mUsika/TTx/wXrWsUNdGTWPoH1t/Whb5q1czYHwC+sKJc28IdLCP58XGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqw0VLpPJ2+HNIt/go5j60c2bL2EU3ULlLAoBIcSQSM=;
 b=f7F2xFc6AENDcCjnAS/4uhFBRHbtL/9jrbnUBHN0zX49DjhVKrzuvaKVEtNMxoBRWNwMhGal2FIiSkqHxOxROaaON03wswQEq1552aBuTSfCX613zdB43oLC4kZ3U2c2ahQMEYUJ0ILmWQj7ucVy4tkW5iXVG23cOjWwWQ5Ydn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 19:55:41 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::5317:fa3f:5cbe:45e9]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::5317:fa3f:5cbe:45e9%3]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 19:55:41 +0000
Message-ID: <da56ae0c-8f72-b39f-95b8-8870ec9fb336@amd.com>
Date:   Fri, 20 Jan 2023 13:55:38 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, thomas.lendacky@amd.com,
        vasant.hegde@amd.com, jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca> <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
 <Y8mBczFH/Hw6xot0@ziepe.ca> <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>
 <Y8q9ocj2IZB2r6Np@ziepe.ca> <1ba09b11-8a07-24dd-a99f-eeacb2f5c96c@amd.com>
 <Y8rUYTjVhksAu+i9@ziepe.ca>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Y8rUYTjVhksAu+i9@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6265bb23-7a98-437c-dcb0-08dafb204ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXyweqaBl0eiTJw6O3bRII5wVTHo/+PhYWSi82ypy/Spj1Bw5RT0eGLLz3kGIPJZfp8VVLvozbnd9kNqsaf3mm96rU3PuHYBzZGe3UnIiqfnqdcLxkjuCtFi0OpntiJBdlGt1qhaYz0/1BAo+qyEjb6ItIZ4XbHFhQyYG0HwJFFOvtjwLL7BU4NTFI8/op8cCP9OKXJ5EC4agoM/WLVHpsKlvIbKORhIdzSQ4Y5oIjWYx6FmvdxWax9SUiOi1DcS1sTw3HyDVuCp/JPcq968vB2Zt7UuSbA7K7UbYp/fq3JGHD0cFW+7hwgl30YULfc43Y6h5r90n4R1R8Kx/7CsJZWmpRbJRsKUaYxSEygxf8QKcjI3bbzm6q0m5RmVcugyhiqRd2rI/ZjlZv82482LWfOC7vTCYjZorwr/vQhUqfGK1zP9nurqJRJ47NNTLZb50GxBEb8fI9RDNZhdahd32Zu9MqyvxI1X/FMB3n65fGeGzl2SNygVm9OsfHj4GTw8p3FulOsKdgbwyvFrPc5P0Ds2h0uZ4JDnAcfzb9ergMfg8xotY0ymEzmGFtH3duJKjbXGyelu7U39gf2Bf+uOkrnfJGmb0rFDmTgxOT+Ya69CDgt0q/fbSbaATDleTA2gEwDpI4Ea5EDBKKkbBxk02EfLYrJnrPupJqJs2o9dLec+pK4ToszkP8mM0NrUfb57zfDEyCPvItBOJ3q1D4d+J8gTlo2NJB4dz0KncQe7vIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(31686004)(38100700002)(2906002)(31696002)(36756003)(8676002)(316002)(2616005)(86362001)(66556008)(66946007)(6916009)(6506007)(5660300002)(83380400001)(478600001)(8936002)(66476007)(26005)(4326008)(41300700001)(53546011)(6666004)(186003)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNvY1VXZytOdC9qd292bDFWTHhaT05aT3NLUElxWXpjams1eTBWWW8xZkVU?=
 =?utf-8?B?bDNZY1VvZUp6bWJKeEhzMldDLzBaaThXcUtUcERBb0ZFVXBBdFY1b3lPRVQz?=
 =?utf-8?B?RFZHL1l3Qlk2ek91K3hWNXpIQ0taK053VWlvVWdoZW1ZNi9kK1ZYdlJlRU5E?=
 =?utf-8?B?OXMva3ZTb3pUQXRaYi9KSjZXUUpzajFiYXRDUThSaE9ValFWbHhXSE1CcEdT?=
 =?utf-8?B?aU90NUlsNGFJdEJyeXcxZEZrbEo2UElTVEd5K0JnQUErR0gvQ3ppZWdsdE1j?=
 =?utf-8?B?Z0xFdS9YNHkrUXZBVEdtZWFCYjZoL1NkdnRpYW90ZE1LanpWdFpDNmtkSC9r?=
 =?utf-8?B?cXluckl5VlpWdlNyazhzSitGckZ4RlhJNFBMY0RRVVgvTjQ3Z1lON3M1QkVo?=
 =?utf-8?B?QUVOVjhRU2FyV0VjZGFzaVN2NTFHaDdCR1U2UUpITVpXMUo2MjRLZ1NRNUww?=
 =?utf-8?B?SjVqWG9yTEVXWjhrdkNYQjRBWjJLL3ZmdXFuVkxQREVpNUQxM2tUTlJJT241?=
 =?utf-8?B?Mmthbm5tSXNVTVBoaHBWbWxWZmZIcmgrb0RMTk1USG01UkkvS1ZodFBmdFRm?=
 =?utf-8?B?OTF2TDNIeU9aYytGeEpTZENRUnpOSmFPUTFkVzhyMGRVcEIwL25DTVAvcTg5?=
 =?utf-8?B?UEVGK2s5VmdRUjJqUzh2c2VnYzduN2tCTENaa3JvNkFSSHNpYk9LYlo0VnlI?=
 =?utf-8?B?RnlsSHlWV1lYa3Nqbm4wZFRodFVaMVljdTJZTThBZEtVTEErLzR2elJTMmVh?=
 =?utf-8?B?V2h1ZTh3M2JqOEpWUk92bS9pT3phdGhzM0ZuVGpRTDRRY2loQU0yeVBjcjBv?=
 =?utf-8?B?ZTcvemMrbHVmWTU3NHhOMGQ4ZjBnTlUvQXNWUHVmNU9UTzd6LytFRXhZUldq?=
 =?utf-8?B?d2hLTXBEaDZwMWtWZkV5S1pRTTB1NWdrWVBIYU50UDdwTDVXVEkvSE9wM1dh?=
 =?utf-8?B?MTNOVlVjbVErUFJvWlFoQ0cwb3VWZGVNVFRuOFI4MmNOb1ZXT0owYVBWSjM2?=
 =?utf-8?B?elg4V3FwQ21haWVaUVdRTHRVOGtTbCs1bXdPVEhON1pET3NtUlNOZndjUm1J?=
 =?utf-8?B?S2phZStMeU1SSGRPanRJOGdPdTQ5WWN6NFdySi92MSs5bVNqVmhOanBERzZo?=
 =?utf-8?B?QkFLT1pYeUYxVmhMZ1hYdmdTSFd1c3B4Z2JFZWZ3eTRBM1E3SDdDQ0dPZGtM?=
 =?utf-8?B?MDRPNEtxS1YrT3JmYTlTUVpNRUw0Qy9Ub1hxdnUrVUM0VVprc3dsZkpQeVZX?=
 =?utf-8?B?ZWxkZFlVTERhcnIraExENVdLWDVWckFpU1I1SWJMbERLdmlKR1RjUmpOeHdq?=
 =?utf-8?B?aThUMTdVNHNDNjQzQ0E2c29NT0VISUhoUWdsZGZkQmpVR2tKRGFQa254Nkli?=
 =?utf-8?B?YmhoZldZelFBb2UrUGszaWRtWk5abTRsYWpRUVZxZXcxRDVWSXFncGo2TWdQ?=
 =?utf-8?B?aGRndWV3Y2xPbVM5NzJJa2FQL0NkSVlqZUd2WTBXeTJLS1BJQldSaG5kT3Er?=
 =?utf-8?B?dXJlTHRQSTFTUWlVWXpkRmdDR2x3bWF0T1dhWGMvNCt6dkE2dU9EQjRwaHZO?=
 =?utf-8?B?T0l4QjNoaGMvRzRYV0hFQmg3dEYwMWZVY05mMG1XWjZqc1JCeXNNczY1TDVw?=
 =?utf-8?B?ZkloVjN3RVQyaDA1cXZUWXoyVEhkendNMWRLc1E4OHFCcThZY245cjZVUTEx?=
 =?utf-8?B?YklkWDFDVllaaG9FaVFmTzB3M0xSK21Qa1BrYUplS0M1YUZzN3hjRHBXazBl?=
 =?utf-8?B?VnZleWwwZXAyZjlpLzNlalJTMWdaRWwxK3pWQkUxRGVtcE8xQWNyY21HV0JS?=
 =?utf-8?B?RFB4MjRsTmJHT3BOdHA4Sk5SM3JMSm5vcWRIcEpVRWptWWhPSzZhRlUwVjZm?=
 =?utf-8?B?OFZxeFpXRVNHNlloMUlVNFBJOTY4MWlWMG4zWGJ6YnlqUU5CUEtpZHN6QWM5?=
 =?utf-8?B?UzFCQUh3UE1nQi91NHdITXFJMExqL2ovTnZkRDBlWGV4SXYxZkV2NTJvZWFq?=
 =?utf-8?B?NFBUSHlsSEpMNnFaNm12cjlXR3AxM2VwTnFPSE1rY1lRNllhbnZHK1NRRVl3?=
 =?utf-8?B?RVUrVVFMTTZYaWRSMXdjc1U0TkRIR0daTjBwT2NmRVZwT3ErRTIrN2JRN2Fp?=
 =?utf-8?Q?iqiEgmoMqJj7rkRGpAjKd+Hx5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6265bb23-7a98-437c-dcb0-08dafb204ef4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 19:55:41.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39+CWl5xtNYvvVajrVFpUyVOWIxOeigYEocmQDZ3ANsJx5aJs4B231p0JC1wcCou9ADqrjfyeSBfBW/EFRXYQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/2023 11:50 AM, Jason Gunthorpe wrote:
> On Fri, Jan 20, 2023 at 11:01:21AM -0600, Kalra, Ashish wrote:
> 
>> We basically get the RMP #PF from the IOMMU because there is a page size
>> mismatch between the RMP table and the IOMMU page table. The RMP table's
>> large page entry has been smashed to 4K PTEs to handle page state change to
>> shared on 4K mappings, so this change has to be synced up with the IOMMU
>> page table, otherwise there is now a page size mismatch between RMP table
>> and IOMMU page table which causes the RMP #PF.
> 
> I understand that, you haven't answered my question:
> 
> Why is the IOMMU being programmed with pages it cannot access in the
> first place?
>

I believe the IOMMU page tables are setup as part of device pass-through 
to be able to do DMA to all of the guest memory, but i am not an IOMMU 
expert, so i will let Suravee elaborate on this.

Thanks,
Ashish

> Don't do that is the obvious solution there, and preserves huge page
> IO performance.
> 
> Jason
> 
