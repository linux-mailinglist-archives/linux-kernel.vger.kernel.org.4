Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0536A6382E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKYDuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYDuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:50:02 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB8F26117;
        Thu, 24 Nov 2022 19:50:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqdUcJom4+KfYOmnKIDwGgrcuyn7DtJB2TRxc6r+vlUvwn8HRwBHu85Wgp9aesGQjdTH727KtCpm2UbBTXEnyhKkf8v2gMAXvjxlSR5NJn15JPh9MC0jJCR3adOx/T5Ih5WqVEcCXJ3H4Y5uO7bIlKNrD6hcjenWFLYwOdwz9VwXVhGEUg+P41BLXsG6eW9mOopq0Kab415WC2e7Wgk3jhU5Phd6Fk0WPsa5vAHgq9kdjOicEacXJFfm26grp5o00N6Pz9Sndu8wUr+JRC9zrH75+LkPekApYUEfbHMtERA5XZLYVULFAKNBt1YoZfstG+Bu71ZnLo7i09GVK80QeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YPx7IjiE7TyN4qtH4pj22WKlJRbC1eb8vXXzNgDdJg=;
 b=PwZfruMdY92x21nDCok/8lPfEwO2WXLGyNZlHG+PhR6BdxymT5ijFEAytEorP7li5W2MXTR5Pj0ePhcl6f26T2dqcPHfWJB4oghoSe3Hz6OI7In1Segc0CH+nCNgbnuZU8RYMTiyASHauoxnS7hBDxbAEBBw2cLx+Kg9gRVN+3y5L6Npf2GvRIjXKKoALiqntPMRD4Wz8i6nuFH8rut+01AKkv+mAoanKbZmZC0u9aCocTVOhEjv7zsyQDIsCCz8CDz7xQrM7dBx9ferJIa05r2yuQR1fPd0OcsBFIBIgn1YVFy2AwVYNfrx074AVLQqccyVW7D3GahhC0QMo4DWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YPx7IjiE7TyN4qtH4pj22WKlJRbC1eb8vXXzNgDdJg=;
 b=LFD4tJosfLyLK9ftGlsww8tm/A8IYo/siAgVaoqq4hbvj/YkSZtHMhHP9bIrWxAkSPTQnYz/rRW1uG6NnmOpilAfB1hOnnzf3v95QnfzPDLg7nNh5adnD9jHmBd7oQ9GwJrfnbv9g3IsBbivNKQBRnH97NVsxpTRxF4dvrSkoPbwLUIysaiRXQa2SnW8zLVJTKDIw2VC/AETo7QO3R8B5as2naDg8UZt1BEqmXNlOAeTvrpUkpJnPmsqb1K//WtGHXKKBszu9+qQOvh8fBylQrbEbWnC2TA6aFtDOTd8unyxHMaCNVSMqfHScJKW5lQ2xv3DoWAv3OytLwBqAMe9rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 03:49:58 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e62f:b3d6:965d:36e4]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e62f:b3d6:965d:36e4%8]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 03:49:58 +0000
Message-ID: <4d696236-14da-dca6-0ea2-0db0b0b040da@nvidia.com>
Date:   Fri, 25 Nov 2022 09:19:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [Patch V2] memory: tegra: Remove clients SID override programming
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        dmitry.osipenko@collabora.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20221122053103.17895-1-amhetre@nvidia.com>
 <cf5422a7-351a-6780-ff7f-e20bc81f94c7@linaro.org>
 <df879efe-cbae-603a-1d1c-1ac63ac9c12a@nvidia.com>
 <2a27c32d-b013-e914-62ae-393af3987716@linaro.org>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <2a27c32d-b013-e914-62ae-393af3987716@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::11) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6c5b5a-01f5-42f0-babc-08dace981ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbbkyiPRbZI2BC9YhOy/sEO3RT/GR5WV1UOcIg2iI+4iz8yN4GS8WuPgO9xqEHe7xkxurTqvmbCUm2FM3giQ9J+4QlJBzcNIwqRm+MYHc3PXfyrBEwTjqajImul8swiBYgLvk6cUw1H1lgKgeTk2gH/9NjoA7m5ZmX7UqLs0/l6y2IEI0qWAd2Q9TnoP74EkrJqZpFYPfVr6BNWH0uwbdBNpmsTf9M8HqV6k6WDCrI08gjwebp/OZFR6vaOj29ye0detBjILp1GOff8pWnEHhzXPSiYpF8oGWhpGiy/nhjE2KzopJjQ0ow9AWq/QGJv04Dl/jfr+2Cdl6gNGUCE7JqZrEuCr8Mr08L2gqrji64RezrfHLcPOkVs1Gotv/Zu3BwrT7xTHILsy5VgchHRJVkY6/78pcODL6oPzVF64a5bHdUbWOEId5DiUCLGryvZcqt+7DJ6KxcEuhouFvz9y67xSgTLfgkQ5gTeGCZMTQ8HLblCkEb7hzvyHv7ZRCQ9L+gKDSzBAWP0hER1eLnBoF8bOAKQGilkbroYZCFLVNfSxRWRNVzQRpi6/KnGeKzooM3SXAAQkevUhG2YpzeTbMDqTf2vrPQOy7BE7oAwuE38rXHLjLkNo1qb3qv2sVjEKwhMpUpGEstectNI0JpXoKtstBhJPaqZfPjKH+CH55utNlR4fhTIFGlndi7hOaVWBIs/M1287eqt+qjXuSdWt37lWFRqA2M/ZVfrUfHeA5Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(41300700001)(5660300002)(31686004)(66556008)(66476007)(8936002)(66946007)(8676002)(2906002)(36756003)(6486002)(83380400001)(316002)(478600001)(31696002)(6512007)(26005)(86362001)(53546011)(2616005)(186003)(38100700002)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWNwbkdZRi9NNkcvOU9GQ2M4SHBTNU0rdFFkS01HSUliUGhiQkJyWXVhRndk?=
 =?utf-8?B?WXVDTTRnYkVPRUx2cTlNcXlra29FUjVHME5XRWxacVB0dzRIeE9CWWVMWEhD?=
 =?utf-8?B?dVVKekZPRXkvOWVLWnppNnR2OXRYOWEveDN6Q2VZRXpMTis1VjNXdnRIZm43?=
 =?utf-8?B?K29DVytaK1ROLzViWFFUS1NoTVh5MlpxR1hZT2MzWnN6NndRK3IzMEc5L3Rt?=
 =?utf-8?B?ZWNCL2RUYW1UWTgzR0NNNkZnYUNmNVlMWHIyZ2lVLzJFQ2RTaGNVbFlCbXI3?=
 =?utf-8?B?SmpPR1hJWktLeU8yZUUzSklqcTNpMDVMNTZuOEJjWGl6bi9zckowQ1dqQnlt?=
 =?utf-8?B?cFhGai8wWEl1a3pUNlZRV2xTRlM3VnI2bnJ5Y2xIdlZmMEdMRUJKSWIwbWFh?=
 =?utf-8?B?Q3k5bGV5VE9vUW00bXB6Rk9RdW94RHIwWlNnbjZiMERNQWJGaDhRNm9mc053?=
 =?utf-8?B?Rk5DVllIQkZ1V0hFU3BkN3dodndJN1ZNdmpvR25GbUYrUUxibEJ1ZEJyQSsv?=
 =?utf-8?B?S1RxRmxDVWx5c013MG1qSlN5SEtXa0Eza21yRXBVVGhZN0I5ZkhZOEVOZG1k?=
 =?utf-8?B?c0htSmxnSUYvQ2k3cFVxeTlIWlc5c1FHWWViSnhTc2xnVDRmdFp3bU1ELytP?=
 =?utf-8?B?eEpPMWU4SFBtSmRIU2cwVXprU2t0MmFQM3NrYnRuMlIxeEp6L2gyTlpsTlRF?=
 =?utf-8?B?MjFGN1gxYjMrWFF4N2FXT3krYXozYmFhK0MrWWxVQnNRU0RYN1ZZNWpNUHQ4?=
 =?utf-8?B?QnVGbTd2Wm5BSnNnbUdUdys4dStGa1lFYlhSZ3VWS25KeHh2cFB6NWdHUW96?=
 =?utf-8?B?Q0kwMGlPZG0zRVFEcU9LUkZCUmluOHNzUWhBK0dLdE1QbG0vOEhDSnZiNStC?=
 =?utf-8?B?ankvc2tBZlM3aG45Rk1SRXkzNGFsdno4Vk1LUEVOaFIvMmNFa0U5WVpGbmtF?=
 =?utf-8?B?U01mSE9hMTNPSFVBTTZiY3V3M0hNV21WRk9MWHBtbkxRaHh2NTcrZXlKNGEw?=
 =?utf-8?B?Yzh4NjZsZ3MwczY3UEJhb0Q1K3p0MVpXUzAzY2llSUxNZEs4K3JyRy9GNXhD?=
 =?utf-8?B?aE9wcXkvZ3I1OHZCbXluZk54Mmg0Zm5RNzNYQ0VqcVEwbFNkY05abFlVTEMz?=
 =?utf-8?B?SjFyOGlTOXd1OUhkb2ZrV3pyYUg0K29aMEsxZ3BaVXBBbU1pUUFKVStzUzk2?=
 =?utf-8?B?c3lXTldCM2lHeHFZYlFnK2VyejNPUWVnNDRYMEVYb1l6NWU2OUVjbTlhclEr?=
 =?utf-8?B?UGNkdEZJdTA0Q2FTenZNZFc5YTFIc1VrVmp2S3RlWEVMTmtSU2M1ZlczVFdI?=
 =?utf-8?B?K3RzSGlKdDJiS1VuSm1JWk50RC84SDl3Y2ZKTElZd2tkMDdwbi8yZkliVDJI?=
 =?utf-8?B?bUZKMENlV01MU1FqeUJuVkY0VTFZRmNjZ29VaVdURzZrT0VJUU5sOE01M1do?=
 =?utf-8?B?ZjVCb2RVUmcrYkZQblA2TGpxVVFIaWpYbXdNN25peE1teHFLdXJlMTR0TmpD?=
 =?utf-8?B?QnZHMjJTbXArTWVtSUZTVFBzT2picTljR2VqbXdnVXBYY1QzUWcvYWdvVDQ0?=
 =?utf-8?B?WDl2ZHJsYlRoZ1VpNDQ1OWpLejlscEdOOHNsUUpZS0RCNitXSEZyczdnVmMw?=
 =?utf-8?B?ajU4NWZJLzZYakc2YWVoTGl6UTQ3eGErb3FEZFRaRjFxN0pqbDIxYUNzeUs0?=
 =?utf-8?B?Z3UxSXJMbFN4ZnZPcE1tTVkrSDFZWjNFZ2xydWVXV3FZbjRFYmNEZzIxeDlH?=
 =?utf-8?B?SXNlOU1MQTVZUEhIM2I1dVR1SHdXZlFKZTFLZkhTWXB5VFVBbS95SUdhMFJQ?=
 =?utf-8?B?b2JlVVpCc3JHcS8wenNVMlYxbGwzMk9uSWE5RWEybnRXNExkR2pqMnNhSTlo?=
 =?utf-8?B?K1dVRzQ3d3lYajJJbzFGWnQveHhEL2RFcnNlZThZQWg1RDFGL2pJU3dtV0Zp?=
 =?utf-8?B?SzFPc1ZMMGxURjZWTWgvQ0d2UkI3Qldld05yUGszbU1wODEwN3oyRTJCbnJr?=
 =?utf-8?B?N1BmRDJGem5kMzRJb0M3NGhnZVdYVUE4RzJ4NWI1dzRJalNXRmpvNjFZRHg5?=
 =?utf-8?B?Y0lJZkZ1dStkTTFuZzdrdkpxbnd6UnE3VCtHK1ZZRm1Yc085Z0FSSnJKbUpX?=
 =?utf-8?Q?Q28HA1d2nBTX8PK7QYDSEAyzs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6c5b5a-01f5-42f0-babc-08dace981ee5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 03:49:57.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+yVSWDaaFv0NaTZIUfP59N6YV2H56cUh8REWueeqN+/5tH36G6TVpjVEnsvoSR2FMfsm+45oN7MHg64lEJVsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/24/2022 5:04 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 24/11/2022 11:20, Ashish Mhetre wrote:
>> On 11/22/2022 4:44 PM, Krzysztof Kozlowski wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 22/11/2022 06:31, Ashish Mhetre wrote:
>>>> On newer Tegra releases, early boot SID override programming and SID
>>>> override programming during resume is handled by bootloader.
>>>> Also, SID override is programmed on-demand during probe_finalize() call
>>>> of IOMMU which is done in tegra186_mc_client_sid_override() in this same
>>>> file. This function does it more correctly by checking if write is
>>>> permitted on SID override register. It also checks if SID override
>>>> register is already written with correct value and skips re-writing it
>>>> in that case.
>>>> Hence, removing the SID override programming of all clients.
>>>>
>>>> Fixes: 393d66fd2cac ("memory: tegra: Implement SID override programming")
>>> I could not get from commit msg what is the bug being fixed. You just
>>> said "more correctly", but usually things are either correct or not.
>>> What are visible effects of the bug?
>>>
>>> Otherwise it sounds more like optimization or a bit better approach, but
>>> not a bugfix.
>>>
>>> Best regards,
>>> Krzysztof
>> Thanks for the review. In the function tegra186_mc_program_sid() which is
>> getting removed, SID override register of all clients is written without
>> checking if secure firmware has allowed write on it or not. If write is
>> disabled by secure firmware then it can lead to errors coming from secure
>> firmware and hang in kernel boot. So, that's a possible bug.
> Please add it to commit msg, because it justifies Fixes tag and probably
> backport.

Sure, I will send V3 with updated commit message. Thank you.

>> Also, it's an optimization over current approach because it saves time by
>> removing re-writing of these SID override registers as in new Tegra releases
>> SID override of all clients is programmed by bootloader. So, MC driver don't
>> need to program them again.
> Best regards,
> Krzysztof
>
