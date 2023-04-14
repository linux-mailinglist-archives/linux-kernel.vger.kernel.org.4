Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294F6E1A60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDNChs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNChq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:37:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B1D40E4;
        Thu, 13 Apr 2023 19:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyOzTT2DsPNk7tQqPHZkdkvtRR/IFpUkDuAYd3tPrct6ghDWbXLoQ4X58SZYPZj2f2ZFRW9JX8TahNkOXzmbQlK8jHcGWpPOAh4e9et95I55eqd6ciF2JgKBXyRBoFL/yyII9DndsmEULFrjic8dI1LGzsckJ+FyEbwAJow0T1DcNGPVAcEqsnDhDi2jiljkpwleXUdHc+gk4NsqvKcehR8vCs985aYivu9+m8xkbwRbBc4oBi8nbUAMa3mQuZ/q8VoX5RenWPpkt1j/ig2xyV/vfZ5sac06guCh/FzG4olfaoCUArpK0k7jHrl/rJ3ySGWyIfEIvCPETa8qkNZu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQlvGw5K9RwJyeD3tPx3I991FUcfcV4mgwD40tAtlZY=;
 b=BOIif7DZzGRfC3ih7PS5Ll8mM4Z/8bDl7Wa9cXmNEPSPgXfxZawQyV+DQZq2RSekfp0Wlb3SiC0FAUd/7kdqdCHcQSn3CCraMpVw4ruuBXj+Cj2ZduF9kWRjkw15XrJ5Ss+VKWHCcUjS3JeWVvIrXpPpMKOA5vXKNUTnssXfE38UxOnuwpUJkmRF+jfboqhCZkCXBEeUvTrkSRNqsxMKOir/N1K4fF3BXOp7ahJPpQq13tXriTuxGUpo/QbLR/JtAf9p9yRlhpqNkmKzPX8+fNCJAxDRjtmz6x+TnskR4pN2eERMvyxMiyLB+1A9LFvU9lEU1cMlQTeWOuEU1zpXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQlvGw5K9RwJyeD3tPx3I991FUcfcV4mgwD40tAtlZY=;
 b=HVphdp2MkSVj+OH4QGxU4rIOW5FC53FKhx9LrVHR7KuU59VmPvHyPOYiK38M1wGSch4FrD6Rq7vhkdfiKcFnEZGezhj6JkL88Y3/UbIoPJMY883apLucXUF8DD4eWBzshYhLq95mAsOv8SW2VMjZpoY5JHv6Fi1hCl4ZVGYb9lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 02:37:41 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 02:37:41 +0000
Message-ID: <225bdcc0-9351-63a7-f071-5536d495ada6@amd.com>
Date:   Fri, 14 Apr 2023 08:07:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/2] x86/Documentation: Add documentation about cluster
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org,
        oleksandr@natalenko.name, bagasdotme@gmail.com
References: <20230413172918.1500-1-kprateek.nayak@amd.com>
 <20230413172918.1500-3-kprateek.nayak@amd.com>
 <1ea129d9-19cc-5f33-fc10-3e832679c5a2@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1ea129d9-19cc-5f33-fc10-3e832679c5a2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfdafcd-5d9a-4de4-3aa5-08db3c9137ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UeCxPuZctN2klyr4MW/Pw0qSGmLAbZ0/ExrIBOnXNzXybptY6iS7OK9pvDdUpMMmJO7hWobW1aKXpFAI7zrs95GRNo1DTzNtx9POn6Zy129OAtrbW1WZH12A0Y0eUUrWP66mhc6ffPE6e6K0UtOGUjarN4rX91mh90ZYX8h80sZJT+30j8PrP7hW8Ys20ml4JDWu9rFZsXSG25+mxi8ae8R2Py8pPsjkhsQp+sxSud/3O9cr6JxPIOx44GNfaSL5FQ9MqpVevmjJ7NfKQHLX/ysTtDTRM6n57ATEa+v4gunTF6RdkapvZRSLOBIV1uWcCas9H6vGTSEYWatGKAu15N4ORHh40AN21MM0n0qZItbBBkAEnMxiK8mLhNgCu0XzU96s8jSV2bWq/qM3SFrPOoMLxJge8T5T3w/j4WcvBLz/3QGHOAiYwG6K+3vbps0LpTZPJFpDWj79JwzfYIlDqwfCbM86d9iKYUEazPjtHnju6YOQ2zYsN20Oo6fXHMIfo1GqpXxMzAjlRiGf/B6wIn33/Yo2qauyd6JOowM54TJPpt1jDqKteOD3KCKsXpk8ouya9Slb50zyMqTbMA3Dt4aRIGS9Tc5YHdCvoJ0qG9xc9LZJ3LeAzx/TYnK+eQKxI62e/jjiBR3o+voiOFTYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(36756003)(478600001)(6486002)(4326008)(66556008)(66476007)(8676002)(66946007)(41300700001)(316002)(83380400001)(2616005)(6666004)(186003)(6512007)(6506007)(53546011)(26005)(86362001)(31696002)(5660300002)(7416002)(38100700002)(8936002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RpVW5CVFEyY1Y2YlZQQ0VRY0dsYlFvZy90WlkzYUNMcTM2ZHFIMGxTNTd6?=
 =?utf-8?B?SnJIdmxJRzF0WmJYRjBhZFc1U2d3OU9YOXFFT0RLRFJra1pYWk5kUy9saisw?=
 =?utf-8?B?eTB6Yjk3MXV0d1V1UEx5TFZvVHJEVXVqampxTHJPVGUrK1liUTcvaW1ZbzJR?=
 =?utf-8?B?SWtLbjg2U1g1eGkyNWJuRWxpTlZyak1JazBHWTF6aFlNK2piOUdqaHRDeGRT?=
 =?utf-8?B?NHJzYk5HVDZ0eDRhb3RQSHZFRHFHVkdZR0FGcG5UUjdQSUFqNEZJZmVUL0JR?=
 =?utf-8?B?OXhqVnJYYmwyeWJocm9mR2ZabjRmQzN0VUQycW9Mb0Njdmt6d2JZdnpqdjlo?=
 =?utf-8?B?dEZTOWxvSEoyQUo1K1pwREtyRUxZT1dybVNmNzdNOG5nWkh3L1A3alVaQ3hB?=
 =?utf-8?B?K0hvSVljVEluVjcxZHlFcGlPT0dQVFRZeFZhV3RWb0xGSWIrVHNFL081RkVO?=
 =?utf-8?B?MjBzYjU1RE1FODVzV2N5TDVybjhPb2xkdUhZbmVSMm12ck40aTFoQzBXa3dQ?=
 =?utf-8?B?Wmp6andCaGt6VFBYOVFrNGhtSXJxb0lJVk5oaTZnYjRsbVlTRE1NUExPRkpG?=
 =?utf-8?B?Tnk2MmN5MzBxMit1dUVMOTE0MmJkQlIweWJKRTFrdFhmTHBSeXpQbGladnJ1?=
 =?utf-8?B?K0RHb2lXSE0xNWRXRjdYSS9uZUc2a3p2ZlJpcDlGVUovZFFlOTlIVWFUNzJQ?=
 =?utf-8?B?YlZ5emFQK3dhL3VESjFWM3VtTkhJZWZ6K2NpcDFocHVDa1pBWmFwWUFCMmRs?=
 =?utf-8?B?SHhHd2VVdllWNDdFYXhlb0RTb0dIVnpYSGc4RFNpakpHYzN3dVVvRUhrZ1Jz?=
 =?utf-8?B?KzN6MXRldVQ2NE5jQnJ0ZnY0WnQ2Z2o0eGt3SC9aa1lxZ1lsMXVKTW8wcC80?=
 =?utf-8?B?aFRocHlXeEhUSTB6dG9jUGFWZTh0WklMM3A5RjNScEVkS3hKTjNZU1MxVGRo?=
 =?utf-8?B?RFRuQ2NDNEZYM0t4TC9Celc3cEE5clRSTTcxWG1JNElNUW5FdGVVcHhHcytF?=
 =?utf-8?B?dnZjeWxtRDAzWEszMmtHNHlUelBBQS9UYitVckRQVmlTQ2Q5QWNOcGo0TjJC?=
 =?utf-8?B?OWxpNlJEQ1loYUYvT0ZsU2NBYTFzQWd6NEVvNit3R0h0c2lzZHkrNmFaaFJR?=
 =?utf-8?B?YWQ3MjcrNWZ6TytJamtYeG5UVmpwdTB2RmkybmlwY0JnYU9WdVI0QmVlelB2?=
 =?utf-8?B?a1V1UEExRC9uVzJURkV6S2d6YmZPRnZFN3lITHZLdFBnMldTMkJSdUIxeGJ4?=
 =?utf-8?B?UGtkYmJidU96VWZpUHZERWRmcytlSkFzZWM1MGNGZlpXTEZxZDZZV2xWbkJm?=
 =?utf-8?B?K1RzNUl3VGdZQnBNc0p1bERETVpDZXhBUndZQjRjaWhLR2ZkOVBXcE5LUXFy?=
 =?utf-8?B?TmVqTk9HakdLRU9DTEd5dmtnaUl3UERBWWUxR3ZDRjJaMk5KcllCQmlidU9L?=
 =?utf-8?B?R1NRQ1BCaWlhdWdxODgwUGUxakVKQThjMXpaRlBRd3dUb0xScHhGc1NSOHZH?=
 =?utf-8?B?VGJYRE92cE13TVFNcFFtVzNsL2ZFQTRmdmltbXFFMDdtd3FTbHRDVXFYelc0?=
 =?utf-8?B?a3oxbmZFdGdTR0drYVpIdGpPMDBBSG1Lc3l0QVQ4Yno3MjhPMFR2T2Y0dHk1?=
 =?utf-8?B?S05NWmRKNXZtUVVYY3pxVjR2R2NtbkN1azNHU2xRRXpaMk1sdmhxc1p0OEEw?=
 =?utf-8?B?dmM2VlYwbDYrQWpid1Z5TGlnSVMzNzhFV1hmOGlUK2o2ek1HWGdmemF5Z0dO?=
 =?utf-8?B?MlpkQWgwczJ6dlNZS2dERGFKbVJCY3Rzd0IzSS9CL093L1R5M3NCdnU3RVFH?=
 =?utf-8?B?Y1dQVzZJb0tJcko4Yy9aNEVyZytPMW8xSVFjNm52TmZJWjYrZTlLRDFaY0xU?=
 =?utf-8?B?RUdmTjd4aU9aL3o3SUFreDhrbytsYzh4TnU4VnJ3emVGT09HN3h4RzVsVUk1?=
 =?utf-8?B?d0Zta1FDUFlMMVFFa29XekhFaWRBNmFsZWFpYU9USHF2TDArSlZ4TmZ2UTZw?=
 =?utf-8?B?aE5mODJmbG54TUxjRlRzaXpSMEJ2ZnpRS0xLdXVPWVBiVWdES3Q3N203bXcz?=
 =?utf-8?B?bmZZS0w2Um0vbVlNb0pRZE1zNDNXdjN5MjVTZzZBRHZWZFVicWJQMU9oQmtX?=
 =?utf-8?Q?9umBbf5BFx2rPxl8F2WlKx41f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfdafcd-5d9a-4de4-3aa5-08db3c9137ef
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 02:37:41.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqYkXwfQ4Mo4uvtiTo5M6XGXdyU7TcoEfmZ0vzF9gF+telrzwAxQv/Ur+R4uW6TZXs7GfZVV2FSAGk4g7TPBxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

Thank you for taking a look at the series.

On 4/13/2023 11:27 PM, Dave Hansen wrote:
> On 4/13/23 10:29, K Prateek Nayak wrote:
>> +  - cluster_id:
>> +
>> +    A per-CPU variable containing:
>> +
>> +      - On Intel, the common upper bits of APIC ID of the list of CPUs sharing
>> +        the L2 Cache with lower bits set to 0.
>> +
>> +      - On AMD and Hygon, with Topology Extension, the common upper bits of the
>> +        Extended APIC ID of the list of CPUs sharing the L2 Cache, left shifted
>> +        to remove trailing 0s.
> 
> I think this is too much detail for Documentation.  We have the code if
> anyone cares _this_ much.

Yes, I agree. I'll reword this as you suggested.

> 
> Also, I'm perplexed by the "left shifted" comment.  I don't see a lot of
> left shifting in the patch.  Am I just missing it?

In Patch1, cacheinfo_topoext_init_l2c_id() sets l2c_id as follows for AMD
and Hygon processors:

  bits = get_count_order(num_sharing_cache);
  per_cpu(cpu_l2c_id, cpu) = c->apicid >> bits;

For Intel, in init_intel_cacheinfo(), l2c_id is set as follows:

  index_msb = get_count_order(num_threads_sharing);
  l2_id = c->apicid & ~((1 << index_msb) - 1);
  ...
  per_cpu(cpu_l2c_id, cpu) = l2_id;

In the former, only the upper bits that are same for all the threads in a
cluster are retained, shifting out the lower bits, whereas in the latter
the lower bits are set to 0s keeping the upper bits, common to all the
threads on the cluster, as is. Let me know if I'm missing something.

> 
> Further, this makes it sound like all Intel CPUs have the cluster_id
> populated.  I'm also not sure that folks reading this will have any
> worldly idea what "Topology Extension" is.

I agree, it becomes too technical.

> 
> Why don't we just say that some CPUs don't have this info?  That way we
> don't need to spell out AMD vs. Intel or expect our users to go figuring
> out of their CPU has "Topology Extension" or leaf 3 or wherever this
> info is on Intel.
> 
> How about:
> 
> A per-CPU variable containing:
> 
>    - Some upper bits extracted from the APIC ID.  CPUs which have the
>      same value in these bits share an L2 and have the same cluster_id.
> 
>      CPUs for which L2 cache information is unavailable will show 65535
>      as the cluster_id.

I'll reword the description based on your suggestion in the next version.

--
Thanks and Regards,
Prateek
