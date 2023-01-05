Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71B65E639
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjAEHsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjAEHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:48:33 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6993B927
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 23:48:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0jYhwH30SLeiYRiWQArNd60059vy7Iz3x+xmPow+jjbviRuDO/Ge8nS+LLcweqHeQboDWmoi3+Yla+eoNFswaQqtuVm8xq4uda+aw3JgPaUvHGj1cbxDvfv5CZwVEwB7Gc+fVmO+WJ4ZxE9kaKiDwklLIS9kRfmK9K7Atf8l6bqolwzB6AXFh/ELqjQZNoF/n+tR9wL9Z+2fLSjrqUFCs/GS9aROtnr3C4LJdCc/DNLhmCxtnLauNNEFYzhmjGnj9na4nEwPys3qLjvpO5euKPQmznis/FvjdqrWa560bl6mfztice9UPcCmR/JoXyoMNC1te5+jwpP63NIuvtPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxY5gqTG+ta2pzy1U3z27o6R18eiCgfSifLVyAmPQQE=;
 b=Mz2Zxj2+TW0TwWGqNYd5kdKdTacA1Aq7kqwN9QlPZ48q4agFQ8QlvlahrS4ZsCt444ybnlvsCPtScRS1SqXUapzu6/AcyHdSZeUMKYnrQUVBTDYYGTXNXm9wQacuRaW8fkBGyWxOysimhIN78A+hLS4RG5kuF4giWv9kW1hAZquX8Xd5onz8vJ5tz1q/jKJDeD6Ar69JwlK7S/vBumhMLLfC0DDQK5iUMPbLXQu0ycEhHRD2ZZBGRYURBSKB+hY4rFo2/uZTjCX2JE3e2QOAAlq7CPWn5u8BSE9NiGxAifWkpiilIfu7HqJEfY+M5geC23ELNQTX39avbqeTbqv8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxY5gqTG+ta2pzy1U3z27o6R18eiCgfSifLVyAmPQQE=;
 b=KT0XMT7Ra/sVzbvkmeqnOaHio6WjGzZYm3i8leeRefEuZ/liVCRIRiuu9JKuw1oX2nSNHU+QJnXH2fsl9o+yXsKPc4ySlbZHoWF90tkv7B+OSs/PaDU5wehpZoqvyjOsf4ixmFjKE3lr2fZDriDbY9iGLAsBsJxcwO9Fi7MTrmAuRfImxCpcLuHklwbd7RSa1FI3Z4BPucDp1Xe0AOswZbWfvxjti+mOXunyZMOloK3kwg//QIa4L0LF8Qh1wqIC6EwWv90hIy7yDK3CbHU1CJ2by6sLDCFKuCeN0QDlByHHdEBkwJrLEDd0JppCjwCLaSZiyY1I/DqadsusFxQnFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 07:48:29 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 07:48:29 +0000
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-3-ying.huang@intel.com> <87pmbttxmj.fsf@nvidia.com>
 <87pmbtedfp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <877cy1scg5.fsf@nvidia.com>
 <87k021bfpj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 2/8] migrate_pages: separate hugetlb folios migration
Date:   Thu, 05 Jan 2023 18:39:59 +1100
In-reply-to: <87k021bfpj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87y1qhqv5k.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0010.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 14434115-ddb8-4624-3e2b-08daeef13c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8BrgVi5bkOghxXbStW8/evybT0kTW0Cc30sQZ+KEUQlLV6MP/umV62jI2KYFcjP4fnXKT1lyqkzK4pTfXknsVjuASoZlXxCqQJiiTom//MZp6N25wQc4EVkBLrJS0eZQo9L7OaEoSasF0xv+m4SPxG3thHhlnwnhwevk4t6zsu1inSXaUHs0tG7ptKoVtuxUhUg8oYYpBnqf298r5Rkm+CW4ggkjz6YEOYfl88Grxdj7Ny8/58J5kW25Z7HiudX4xM1EfCCGANzflVyTZQLPB3/qhdld1dG8DKOYZzPBprGXt8WAMvVfu2CulT/K0NwcPc/FCyUUYZjXIkt7OqeWy7tBTYz9gxT54MKJL4Ce4eXAWq2XX3t2pZuOQq3QkscgWCF+2/OUN4ZniUjx7A0OfX3/fJTcXhquNKGiISh3FbBpYu2oXVRsQ5HZ+EDNLATWcjaZ8QgJtsC5Km7oRE92kq/p6QWCzdar5qw2jbDPuEA0fLDOv8hnG9kO2BycsFJtrRYRt8d3YkGmuE8mW57/KsKvsGTc7OFgEkJduyodaGsevF66HmTipCLyFa160age+I0WBGf2YM7+zdZKFrrr7kh+apWL8nS7q/+Jb6F3hnhEbXNLna8+t/8jDTEDGS0qtRa+N/jeVJHc10ibb5l7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(2616005)(6512007)(26005)(186003)(6506007)(6666004)(86362001)(36756003)(38100700002)(41300700001)(4326008)(8676002)(7416002)(5660300002)(2906002)(8936002)(6486002)(316002)(66556008)(478600001)(66946007)(54906003)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5DETm04At8LHjTRFkEeP0dFZA6CgK1UJucYAYTPaQ+y7SeREUzJKgkkMqKz?=
 =?us-ascii?Q?6dI5fpKdARG5kOnNJ+buJOfEAAP8b7N9T1PQQhhqZSnrZ8ng93PrjatqISqW?=
 =?us-ascii?Q?fiLHJBJwpN3qggl//E2KZlRkK3tOndEqjvDJ179Ym2HZt/ZslvRkkcoUzqHO?=
 =?us-ascii?Q?xIA1L2D9JRlCbKgAZFeAuqqokdp2WWPs/1qcyyqTYjnbdEAjfeWocODneH+Y?=
 =?us-ascii?Q?a7cf5db4ccZ9UZUVD3DOFDsi0rcg0Olm4URh1Z9KWXYT68/tc022Zpy4R0o2?=
 =?us-ascii?Q?Cp77rVtvnPnBb91UZztWbeyxPwxIFuLW5np6RJUaaCTJIwKPP0qM5QOCGbDD?=
 =?us-ascii?Q?26mvgjOD9y2ITM1YEZHvgkFHJnZ31XJeMgK3I1dkHwr92mAV3lw4fF6/5pV0?=
 =?us-ascii?Q?cSHovrdtfZz13Pn99yG5uMXD71AHmQZgB4xUJN3xNLwP33jZBpPL9Jqb+aGW?=
 =?us-ascii?Q?tXyZxfnLyBjg+ka0K8AeJ89A07OOlGOsD++H6dLekIvUAenb53Ar1PKqrFBT?=
 =?us-ascii?Q?RVi51n0ZbVB8hcUnSrFVGr1osVR2rOrhzU4hTepCLEnMUH6zg63w0FpBtESQ?=
 =?us-ascii?Q?RYEAvhQiGjM1Zp0kR4BGRkD7XP5mq5Nlskordk+kYO4ttas4twJDhhIwa2If?=
 =?us-ascii?Q?Vk3yei1ISIZPlvcpSL9DW42BCyQcrl8yeg6ELZkgkysTPFKBzkrsLFJkP2VY?=
 =?us-ascii?Q?tdvQyTaC3mDUh94ufXMMBOIjHZTyx8kIcH1Xyu8ZGMtuiWKLq6wO0JcNKf6U?=
 =?us-ascii?Q?1JHQpEshmOjz8rXeyhZTy5Dh04WwTLEGhvkS7RJsHqQ4Is+K051GFQLt2ymP?=
 =?us-ascii?Q?KfTHQKgjTnmkSEszoRK+2t7EkCdEWV1qDlSeA37rGgyw19E+AfS6Pkweu8CN?=
 =?us-ascii?Q?2Ccus+JrnBfAckrckEIaZKh1sNvKr12k8Xp4EnDCafuLEQzP1dwwCrYHdjH8?=
 =?us-ascii?Q?cyZE/qi6Jo+tmQSK5UZtU43nF/Sf3OhKLvTWCdFkr/ED9GXl8juJHm5JdojI?=
 =?us-ascii?Q?fFHMo5PQPzzYTgdUdgWE4CrBucbYligRyOg267rzH266xJBpCKtwkA7nIDSz?=
 =?us-ascii?Q?7xKoOeyeCyoIot1hF9kelt8rNxM24EUyj1RDvFY9f146HFWqSap4NVae3RnZ?=
 =?us-ascii?Q?JNNE7P/RRQIlX/3EeEy5Tl8EoKj3fAyBUc4jHLZPRJmrTZH/OGJTyKTcA20j?=
 =?us-ascii?Q?7D+aaBx9zrQsuICcPIbO0jhVl8EtrH39X750d5UOmR8FD6NRGbVuZWsWxBC3?=
 =?us-ascii?Q?B0XI0Qub3T8Y2w2Rs5mY6TSmEq33a094QyVcakU5JfLhKJT3MuYdW65Mnq9Q?=
 =?us-ascii?Q?fs3Ol+L24X8rU273uO4FJFHA2vdut1RLhMr1Nztm8WbuTo4b0EQWMTVvn59t?=
 =?us-ascii?Q?jZYvVozibIiDNBcWEPHlyvKiJZjQyp/OQEbNLVoJQKs+JlnQKHx7ZIb2gS5i?=
 =?us-ascii?Q?JF1kRO/yrm6wt0+VQOtkVDuOHZ2d6T9v02cmMVQQlLYrPCcppCasL9NM6U/D?=
 =?us-ascii?Q?H8SOQHY4GNYnZI+uguoz0WYWPYUP1VSA041YON0BjULE0eNNAWSyBpd9Kh6O?=
 =?us-ascii?Q?zctKjdgWilscPilLGY3Yp0Y0WW27aENocJMppuT8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14434115-ddb8-4624-3e2b-08daeef13c3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 07:48:29.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoSN4kxrXnHQw7SkIZn7AsVrycOfYHP62X7d4cbdQA97diOVMR8F6wt3hhSyOu6gsm+dg0lZAzqMrdZZDxk0SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> [snip]
>
>>
>>>>> @@ -1462,30 +1549,28 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>>  		nr_retry_pages = 0;
>>>>>  
>>>>>  		list_for_each_entry_safe(folio, folio2, from, lru) {
>>>>> +			if (folio_test_hugetlb(folio)) {
>>>>
>>>> How do we hit this case? Shouldn't migrate_hugetlbs() have already moved
>>>> any hugetlb folios off the from list?
>>>
>>> Retried hugetlb folios will be kept in from list.
>>
>> Couldn't migrate_hugetlbs() remove the failing retried pages from the
>> list on the final pass? That seems cleaner to me.
>
> To do that, we need to go through the folio list again to remove all
> hugetlb pages.  It could be time-consuming in some cases.  So I think
> that it's better to keep this.

Why? Couldn't we test pass == 9 and remove it from the list if it fails
the final retry in migrate_hugetlbs()? In any case if it's on the list
due to failed retries we have already passed over it 10 times, so the
extra loop hardly seems like a problem.

 - Alistair

> Best Regards,
> Huang, Ying
>
>>>>> +				list_move_tail(&folio->lru, &ret_folios);
>>>>> +				continue;
>>>>> +			}
>>>>> +
>>>>>  			/*
>>>>>  			 * Large folio statistics is based on the source large
>>>>>  			 * folio. Capture required information that might get
>>>>>  			 * lost during migration.
>>>>>  			 */
>>>>> -			is_large = folio_test_large(folio) && !folio_test_hugetlb(folio);
>>>>> +			is_large = folio_test_large(folio);
>>>>>  			is_thp = is_large && folio_test_pmd_mappable(folio);
>>>>>  			nr_pages = folio_nr_pages(folio);
>>>>> +
>>>>>  			cond_resched();
>>>>>  
>>>>> -			if (folio_test_hugetlb(folio))
>>>>> -				rc = unmap_and_move_huge_page(get_new_page,
>>>>> -						put_new_page, private,
>>>>> -						&folio->page, pass > 2, mode,
>>>>> -						reason,
>>>>> -						&ret_folios);
>>>>> -			else
>>>>> -				rc = unmap_and_move(get_new_page, put_new_page,
>>>>> -						private, folio, pass > 2, mode,
>>>>> -						reason, &ret_folios);
>>>>> +			rc = unmap_and_move(get_new_page, put_new_page,
>>>>> +					    private, folio, pass > 2, mode,
>>>>> +					    reason, &ret_folios);
>>>>>  			/*
>>>>>  			 * The rules are:
>>>>> -			 *	Success: non hugetlb folio will be freed, hugetlb
>>>>> -			 *		 folio will be put back
>>>>> +			 *	Success: folio will be freed
>>>>>  			 *	-EAGAIN: stay on the from list
>>>>>  			 *	-ENOMEM: stay on the from list
>>>>>  			 *	-ENOSYS: stay on the from list
>>>>> @@ -1512,7 +1597,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>>  						stats.nr_thp_split += is_thp;
>>>>>  						break;
>>>>>  					}
>>>>> -				/* Hugetlb migration is unsupported */
>>>>>  				} else if (!no_split_folio_counting) {
>>>>>  					nr_failed++;
>>>>>  				}

