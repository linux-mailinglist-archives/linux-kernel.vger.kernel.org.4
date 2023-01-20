Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CEF67604F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjATWnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjATWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:42:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F313DC5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEz4ij1ztBEuPeFejMgbge1FBQALSS3hzytN3N7J2Dgx7oxqIbvpS9u+bwO6NBfYD0g2zoJJUReMf6FnXyRPWTENGKCgNiBqQ5etKkpdvDixZG1jP2maRWABGFaCyfJ0kE5uonHfxOwIH3tKdtx66tR4G/AGLmXqvkDWgaRgc7G5zgCj5mifzIB9lDW8E7/CY+Mba4vUZQyizWbwUI4Rx6ZcgGMEWFDXg4Poqmb7c72b0QdnQREXdaMbrq3xgCu64BaGbAX0yU+SwUqamIFTDK0x4JlronY4Wleus5yZVCA/pbhKhR5DnGQxhe0LXV5aB1vY2LwiFQxtbP/v7EKlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWaLlCMwjpVul+I4LV8h21MhjlC50OD8dzKhCzsUag8=;
 b=FmBlT37WCPQaHa//Jsbkn0iHs2DCTdxpGDiJwJMkUcPhG3W9/6yWn87LMs4PUuSLT2mVQoRKT10YqYPXN3LDVQTgKQz+rn8o/f7+bkochoVt0ZSXze0PRzP5Wjb6ZE01+mPZtnIqtqvKTPudq0UzZHPQt+IXU0xzscDFzAtjY2B1JpYbQ81SdjKZX7wzmDuxxnP6xVxpNZi8BkcI4eIk63DNIoH/2/a8ag174W5Om8kuPbE0RIQXjoS9Us9sduKXcwEPQ0hr6Tv60UBx0TiyHU7glFjrtmYMlfl0sRWvqwcKBUZKVKKQaGJZgV+ewa9pYClwSRjtvYTpq5ySEpTENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWaLlCMwjpVul+I4LV8h21MhjlC50OD8dzKhCzsUag8=;
 b=quv1arWwOL74qI+/oUp4/YVs/TWBlpqXRYUmIDX4axvKBt76820GggHo5sFmILbUsynsR+WXgFA6hcRE3PMJ5+SJgiU6clHyR7lbBFzsugjG1u70qXzGYTJmfgtfJFKRmj0XRqxG0nIcbILv8ykdgMnrdWVs3DRybUFA9kGtBc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 22:42:29 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 22:42:29 +0000
Message-ID: <1e1e98ea-5215-be21-b732-58c67e9c8fd6@amd.com>
Date:   Fri, 20 Jan 2023 16:42:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Content-Language: en-US
To:     "Kalra, Ashish" <ashish.kalra@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
        jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca> <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
 <Y8mBczFH/Hw6xot0@ziepe.ca> <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>
 <Y8q9ocj2IZB2r6Np@ziepe.ca> <1ba09b11-8a07-24dd-a99f-eeacb2f5c96c@amd.com>
 <Y8rUYTjVhksAu+i9@ziepe.ca> <da56ae0c-8f72-b39f-95b8-8870ec9fb336@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <da56ae0c-8f72-b39f-95b8-8870ec9fb336@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:806:6e::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2adce7-52b7-4100-bf38-08dafb379c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Q9oDxb/0hujChcylx+c3cvCRtz/kidoLWiwqsREkjKMfPC47ynNDtAB+U4NtLy9ocHbMk7EHhrHNouRO7EjoxieZxvl8IBvcXGERHO8RxYbgZ/RIMsRBBxyJXqPpFFMh+V4AJXmTRBoEXCbkNbhdboJQy2SRSvOmJtljtl2P1AiymUc6149p8CXyyyWdPNbJNnPjXxJAMGgHKxSO4jNg4BjTUUoY7DIzasg48Y1Hs3M3aO96u6tGT3sUrxWxWKabTiD8y8wr/K0VLWtCXlPNbZL/2qgaeuWuQf/DoN6QATmZLEcVfLrURWw0igubQsRRY5xCxAs1lB+Z6tisA2LE739DtCEaxUb+SiryQ1rZuz8v8srrH1Fg0AU3FuNo+BiBK1+9sFQZkAutaiWTtUOb9UTSLs7fw7mk9GInF8wbfPCk0i/b8a3J1jp5KNsRBKIYMUuwptRQiyCICDJtySJ6nzCPzjSYXEzBlmAxPEL1Bmnj7nvQQYJ3fzLYgmGGgDM8DGYMWU92DM3m3eZBM9nnl+dz2DSuRFs9foAV2IEZPstUfX4BB15m7s1XjoR/kC9P5cn+BkiLz/uMFW52qKkGStselH5YP5+XqZM/M66c4nVRZMmEINHSNSZ2bxitfd6VWpQVdyMaXbTXY+KcgPD7gw8xNlv3KgV9oEfG9X8hGmLSsnzTZAdntVKik2NW9jVKiVcD1ctHuz/URqMhcxAP1jiT/GpNzf7CDzlmLwMYRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(8676002)(110136005)(8936002)(31686004)(66556008)(5660300002)(66476007)(4326008)(2906002)(316002)(66946007)(41300700001)(6512007)(6486002)(186003)(38100700002)(26005)(6666004)(53546011)(36756003)(6506007)(478600001)(86362001)(31696002)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVJSjhwMmVYWkIrU3J1Ri85SWRXbEtWVVZxYlNtZm9GS1VJYm5KVkxlNDNH?=
 =?utf-8?B?STRrUExveGVBTXJubVhuMG5oMTBwdHNXM1JCNVJXcVkvRVhxRGczMVRKSWVL?=
 =?utf-8?B?dzgzQU9wdzdBVUl6YksrSEU0Y281N21ISHBNaDBWUmdpNXFhai92YVZrZjFP?=
 =?utf-8?B?MFdFdDFYLzdXNXJEUnkwNHhTaXRjcmlXbERhLzU4NU5rRlB1c3RsZXI1VGdU?=
 =?utf-8?B?d2hycDBWWEtmUkN2a3JLT09ITy9rTHJmREVoNWRmeHBRNTZmdGxrS204QXEy?=
 =?utf-8?B?UVA0QU5YZ3d0ZVlpRHhWQTlYVGtBYzM5L2sydnRvUSs3VFUvNDVHdXRTcXVj?=
 =?utf-8?B?NnRReDU3S0hLVjhRR3lFcU5BRm01Nm5wSzVnclRrZURNM1pLaGkzeXlZTGk4?=
 =?utf-8?B?YmUvZnpEeFE4LzhOM0NVeUFTKzdFUGFHQmlBSkZLVTRzQUs2V3BBU3Vuc1o4?=
 =?utf-8?B?RGZkTXlLb1V6emhyY3RXWHZRL2gzNFhCYlRNRVpPUk1Qcm91WDEvU3o1YlRt?=
 =?utf-8?B?cksvY25FUSswcTJkSGNVRGdWSnU2M2xvUDhSWlY0UWFtTUlJb0k4Qm03TnBu?=
 =?utf-8?B?eWdkUzdtM0xYZm5YYlM2SU1PR3hLM1dHTEZUT3RTM3ByZjNFenM5Smo5YXh4?=
 =?utf-8?B?LzNEdWtlRUlDMC91d1MxamJvQzJQZ1ZFenVSK3FjOXhaMko5Wmd2cWk1UjFl?=
 =?utf-8?B?MjNNRVpSVmlEYUZYcFdhcUtGVHo1QzZJVEVoZlVsU01NNWg4Y3NqUWxmdldW?=
 =?utf-8?B?c0RENnJIUVFCWkpHc3pncVRCWjdZYjVBZmlOb1dLMHlqK0ViejN1VmFqakZn?=
 =?utf-8?B?SEcyeXZMejU5ZS90NHJlbUllUHZmMWVRMkxtaE9JUDJxUjE1UTdRUGF2UWNU?=
 =?utf-8?B?Mnc0SWhmRzdLWUJWTU9yVGNpSXJzSzNsTkg5Nno5VmNXMDl3NUpZd2pFM3FH?=
 =?utf-8?B?Z0NDTnpwM2NsK0czaE8xS2xwTk5sN1ZzcHdEUjRRYmZVc3dPZDFrbTl3YmJS?=
 =?utf-8?B?ZEFZeDNraCtML0VwOC9DbHFZb3hFTGhjMXVJTU1WdzMwcEZRMlA0YXF4VWZx?=
 =?utf-8?B?QXFJNFV6S3RiMDh3UWlxaUFGVzV5TGhYMkEveC92SWptNEFCYzBRMW1CWGYv?=
 =?utf-8?B?eHB3eExGWFhkQ3lpbFBTcEF5aXZuL1AvMDd3OFJMYllwVW9LUDJEZ2NKNDcw?=
 =?utf-8?B?ZldiY29mbGxydDBtdWE3K0V0dWFncmZWKytRd3VrV1NEcWl5Q1J6QW52U0tR?=
 =?utf-8?B?U2JMUzBHdmZaVjU2dkVPVzFlMHJ1STlSdWl0TVY0SCs2QjcvVVJheDRyRXVl?=
 =?utf-8?B?NkI5S2c5KzZKM3JwRjBXZVV3UVVNY0FqV1ExQVQzeGZRZUFWK0JmVWVnZVNQ?=
 =?utf-8?B?RWhMMG1KUDluNzJsWW02dVA2K094MzBmODJqVDJlbHV2Z3hMQkxZbmdYeHFM?=
 =?utf-8?B?WGNQcG1FblBvbWViM1VTSEd1dXdYeHdqaDFEdTZQbkViYjhRT2QrNVNHQmtF?=
 =?utf-8?B?Qjl2aUt5RGswY1VXTEJ5dDFWVTVpSlp5S0IrSEpYNjREcGhGMXozOWNyeVBM?=
 =?utf-8?B?cWhxQ2V2ZFZnTW5UbVZEOEdXb1ZKM3pVRUYvblpwZ0hoaUloOFR1Wml5Mmhv?=
 =?utf-8?B?YnJBbmM3WjBhZisrS1hDTWJybE05YXdxU1lPaHNEcitZeGNwSldsV2V5VDVa?=
 =?utf-8?B?L2NBdFdCKy9TMThZcmh5eU1BVXJWcThaNk9rMFc1dXBkbWExajZvOUN5MWlK?=
 =?utf-8?B?TW5hOXY2cGRHZlFRMVJnT2FIT291ZzJGMW5ZQ2ZlV3RoNWFlenYrcEgwNzc3?=
 =?utf-8?B?cEczdTZHN3hXR2o3dnZGREU0YUltalp1cS96RCsvVHBHMzAyTjJzYyswRWNJ?=
 =?utf-8?B?R01ydGtvODNRVnJkRFlWSWozYUlpMHBzemRtNkNGNnBzYVd6elNYc3pTUzV1?=
 =?utf-8?B?NzIrbU1XK3BRbWpISU1OMGk1Z3J5dHBwWkdncFFQbU5IU2dacVBhU2J2eDJp?=
 =?utf-8?B?S2paaEFEd041YXVqcnVRNEE0VTFGbkt4dTBCTFc5eU5Mblh0TlZKK0I5WWpO?=
 =?utf-8?B?WFRxSmdHRGpHZVZlZDZwa2tSWWtaNVIzalRJRnhRNTFXVmJuUTkwY2NNQlp2?=
 =?utf-8?Q?bV/viwCOCvcHvA6pvfGbDaYkb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2adce7-52b7-4100-bf38-08dafb379c28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:42:29.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4jIfXj77h5V4OJU8QX6QBuuh0K8ZVLTjGwXRp8Lh7TuBRVHpSzwLt5CH1g6FVTB31AlnrcG9QFZ0TAf8DHcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 13:55, Kalra, Ashish wrote:
> On 1/20/2023 11:50 AM, Jason Gunthorpe wrote:
>> On Fri, Jan 20, 2023 at 11:01:21AM -0600, Kalra, Ashish wrote:
>>
>>> We basically get the RMP #PF from the IOMMU because there is a page size
>>> mismatch between the RMP table and the IOMMU page table. The RMP table's
>>> large page entry has been smashed to 4K PTEs to handle page state 
>>> change to
>>> shared on 4K mappings, so this change has to be synced up with the IOMMU
>>> page table, otherwise there is now a page size mismatch between RMP table
>>> and IOMMU page table which causes the RMP #PF.
>>
>> I understand that, you haven't answered my question:
>>
>> Why is the IOMMU being programmed with pages it cannot access in the
>> first place?
>>
> 
> I believe the IOMMU page tables are setup as part of device pass-through 
> to be able to do DMA to all of the guest memory, but i am not an IOMMU 
> expert, so i will let Suravee elaborate on this.

Right. And what I believe Jason is saying is, that for SNP, since we know 
we can only DMA into shared pages, there is no need to setup the initial 
IOMMU page tables for all of guest memory. Instead, wait and set up IOMMU 
mappings when we do a page state change to shared and remove any mappings 
when we do a page state change to private.

Thanks,
Tom

> 
> Thanks,
> Ashish
> 
>> Don't do that is the obvious solution there, and preserves huge page
>> IO performance.
>>
>> Jason
>>
