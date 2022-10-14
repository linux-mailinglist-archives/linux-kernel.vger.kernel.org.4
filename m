Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6A5FEFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJNOK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJNOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:10:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89694E986A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsdRpb4MzUclQwVTji3yGB4t0Zk816EW2bGJKuxasZub8QfDHAOoEXiwy4eLLhA7uS4yrqQ2PhbeMDWZjy4INg2IHXCUUylUL956ayS1C/f9NXcCw9Og/vtrRJ72O73+yLrkFuaa04k3dmYm0LlQycDh67ORDtYEiERhjHidazsfZZItKQMTtLK58cnrDGwsUKbb7/wp8tRhJ+T6nHLCp0oiDqsA8QvkBLYwvGQYRJNjBffEYQ9ashGT7Mqx5zub9QOB7oU5Z7+imKJ/zGY4mhfndZlfgoBz4Cgnzh2/YDcLY9cbVcn9MdJR/kzgyDirAyB1fPEkUZv6ZcsIONdbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jld0d160CNmvtJjN4Tw//9Jr3kvH/ZYmaKQs406lXLk=;
 b=K4n9kiIo94vKFTuOb1fAFaPwQ3WVpw7aUUK23f992wSmaT6PFJIetOfoS15FyEU+wrAFCgzp1gwwCjn7w015UkMY0MP9NxkB8q8Xm8gTHXyE/3sK0AvcKXB+In4VIVsGd4PPrS+rgET60XzmRNBQgUh2B12ZgxNQFLakXPDmqPvcqDn+KRoer8V0MfcyRGWN82VhVkty+gnCkIVwGUe8C7N+c+kdhdLd7VGxGBV+ZXQdJm6iJ64DhiaPZWGGS6QT5kHs6H7ybfSKZnhev12G7Qj5oSrIJYrGzyat7kJRJAnYXfBl+DvJhbudo4I4fKY/yI+q+2+v50J6TVa+5mR2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jld0d160CNmvtJjN4Tw//9Jr3kvH/ZYmaKQs406lXLk=;
 b=jB2R6Vm+sGveLMBweetG+mkxdrt1UvS4vtmVmISDnwbwyN+o1KssUGBXvVMU0FxA6uRbVbvwzJNcXSkB8fdoBMZlLqA+cmei3EQYwq4qcpeW6Um+Nr0aG++Lte0tJDtRtcSAMD2C0aXD2AzkenXxyMo4Q6zz/63aWqebLcUTwwSnPGMk5YjxqbXfCJY/JYwzTGRDb3yNiM0SnPcEMcH2MJkFdJ3vpv5EbJULZYsqCNlOQ2GXAMMUyH2MdSUzrMmOBLLajfg1jFa4VNCTCtPz8Y3cWDSbpFhBBynR0f2pbOqlMNrjbLEcs69rezRJjSBbypH5TDkyBYMx3V4Dk8PE3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by PAXPR08MB6751.eurprd08.prod.outlook.com (2603:10a6:102:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 14:10:12 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 14:10:12 +0000
Message-ID: <7472d836-51af-d3b6-e4c3-8d9e7ea53c82@virtuozzo.com>
Date:   Fri, 14 Oct 2022 17:10:10 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
To:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
 <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
 <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
 <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
 <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
 <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
 <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
 <72e535ce-80eb-a02f-970c-6a9c80da0a24@redhat.com>
 <5b1e0a13-8018-630d-d512-c3033db2f2e3@virtuozzo.com>
 <7e6f2d09-e5cf-7f8d-965d-a39bfb0ea286@redhat.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <7e6f2d09-e5cf-7f8d-965d-a39bfb0ea286@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:803:50::36) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|PAXPR08MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: c62cabf9-580a-4597-a55f-08daadedcf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkGW3jOh8pIrXTIfKyV9R9+jn2VLJW59+VOhzeelKuQg8LvjgxZFikq4DFdZmf0NyL/1BoSQVGPQxjCj15m4x786LK29MCet5VyLWFdqhhp+LPID/7UYKZgar8NcC4zCjJs2arb48jHn4W8sDNj44o4f4R1zY5lWpduEY1mtSk/eKj6ar3IEIe6KW4oW9eJUXjPAUHln5vvA5xyiBbmceWeG/dersR/774H02hRV5NilIcsulvwiHOSPTIcPb4eiSi2d2GrT7DLdYQx7EK2IntS2LsE2xvADNa4OtBb9rBtgssWbNa7rh4ddMj5IpItEV9i7UkQz4HOIWiK6lAP86f2p7tW7JFRZQRA+AMfeK6GNU/y9sDOPdgkdhSDyQmEQadfvOpZy1ZJS1y7ZIH7XrEgSi9BUIRCfFlZRobqhVBJuKEwCS2Q+8jY0sqJg8t2H4a3qNgh6EmfO7auue1Lm4kuMtKJppunFpUGVw2a/kGGZ4giwInZZvIZDuZUWYw3lk/Bt2qm7Ar2FVtDC7QQ1uHlM65XcL7tr5mMgYzq/m4olXMzDoZ7feS1Vo/eVcAIWGW4/lqsSzti4pSMd5vTeQK7/Ijp7eOugv7WG2SoFEQFCcE77/MXwMJCX916/Lt3CkMTVjtef/45T6BXVuSC+WjtWMfiv3PMk7kZBX+dY5yl9kSbenxw8hFm4a4xx+TMm7iXZk2CK6cluPbpVAI1aQHgAnXZROfKbvhmsTbb/6RoFv1r2KxYyBz2Qx+ap+CdETifCqGNcipfuYfTMqI7IvEDHh8VGM1ZH/M1SCQn/0pg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39850400004)(396003)(366004)(451199015)(8936002)(31686004)(2906002)(86362001)(41300700001)(110136005)(26005)(31696002)(54906003)(5660300002)(186003)(478600001)(6486002)(2616005)(53546011)(36756003)(44832011)(8676002)(66556008)(4326008)(83380400001)(66476007)(66946007)(6512007)(316002)(6506007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUo1OXBXb3ptdEV1QnFHZnFsNmh3bUppengwM25va3JSK25GaVBMTXIxYXNF?=
 =?utf-8?B?UEpRMGF0bDJlcG5HZXQzaENGeXFyMGJaTDAxenFOcmd6cEx2d0ZXbTl4ekUz?=
 =?utf-8?B?Qm5NVHZYeEVkOUQ3Z1FzVWNWUXRUVG91bmNLSlFaL3RsNVpZdWxaUjYwdzFI?=
 =?utf-8?B?c2FKekR5Uy8xY1BRM2N5Smx5VTZJMFVOcUx6SStSVjJtdHBteS93TnpTcmJX?=
 =?utf-8?B?Vjg2dFBjcVdHdUI2czZsd25WRHVsSi8zajJ4WDBkb0pRWndmbEVBN3JJNjhM?=
 =?utf-8?B?QTFkbXBmLzNtTjEvaitIMnZ6TC8rak1ROE9VZ3YyUWpwdXc0VWJpWENVWlJh?=
 =?utf-8?B?NDJVSVBIaEZpOHkrMGlpNjJMSlVHZEFUTmN6MFRNbkhtL09KaGRldlV3NDMr?=
 =?utf-8?B?aWVrUWNxYWRyWkR5OWRuQllYQ3VMbWJ6U3ZPMldlRnFkc0pCaWNoTUZxdW1Q?=
 =?utf-8?B?bWoyT2VFTnIxd1FRSUQ5YlYxSWp6NWtXSjM0dVBTQ0h2c2NVSjVTSjBXU2Y2?=
 =?utf-8?B?ZUlwR0M5UTd2OXhYU0Q4eVZBakp6ZW53UXRFOTExR0NjazFVSkRuWUsvbE92?=
 =?utf-8?B?aDVENGY5SVZIUFB4enRpVVVpeHNnM0RsclNBWXNZdUFCWjBxT21XanExQlZI?=
 =?utf-8?B?MkIwWTVCNDJjcmh6SFpmZGdLSjE2anlMTG4yd243TG8yVFdPUEZqbmpld20r?=
 =?utf-8?B?S29tMUhvYW9OcWZEYm1HOXFNNnlTd1ljQWJ2T1JzUmRhWnNmMFJ1YVRhaXlx?=
 =?utf-8?B?aWZZeUVWSXZjUGhCMjFqS041NlRiUy9KaHZrUGZqWjRZWGlUWlBDNnVOc2lE?=
 =?utf-8?B?R0JNUGRDZFV2N082bEFoVUxuOUlqLzBxY2loQVdQV3cyb1BDRVFDTURYaTVB?=
 =?utf-8?B?T3ZCM25pd3dkRFl1MTE5cUVaWTZROEZZNFYxY1ptdWtvVDNTNDBKa0hGS2hz?=
 =?utf-8?B?czJmdk90ZWl2YmR6OWoyYjBjbUx0QzA0cW9QQXFLVU5zNmdtL0tCQm1USXdJ?=
 =?utf-8?B?WlRWQlBlVTNqUHVUc1liZEMxUERCRkdiaDFZcHVoa3lzLzRiMkJ0ei9PNmhm?=
 =?utf-8?B?ZGhtWlQ0RmE4eVpvS3Fod0FpRTdNd1ZRZmc0OWZCTUpteDUrL3dqbmdHU25o?=
 =?utf-8?B?b1Yxclo5dzF2SnM1SDZucUZPUVB4ZW12WlZWK3FDdWZ6cjJjK0NObXkrMXVl?=
 =?utf-8?B?K0Mwb0J3ZVJHOXNYMVg1bHNSbFlLbnlpbGJlcVRSbVhPRXh5dUNWa0RkQVJ3?=
 =?utf-8?B?MGpJc1hyOUVKM2pDTDlXakRLV3NCOXlrUVNacHRqSDdGODk4WURva3FnbW0y?=
 =?utf-8?B?Wk9QM0V3WUE2OW5hckFjbWFzaVd5dms5ZWtTYnlNUDF4MjdHUXlFbGgyQVlq?=
 =?utf-8?B?STRIUC9FWjdNL0JRWGtVbzdVOC9ORzhEb20wd2J0NzNnTEpQV25hUldxTkJo?=
 =?utf-8?B?cHZDUUZkQTVKbjRaT3VlQmUzdVpyRzZKZmZkclNKTEhSdDdZaCtkVXdDT2Fh?=
 =?utf-8?B?SUN1OEREb2xCVGdFbFd4cWJUcHFtOGFnRUZaM09oeldacEtWbmRlUlc5Mkk3?=
 =?utf-8?B?cmdZSitwNmlpek05eFUzcW5VMFg4THJzTllSVVI3Mm4zMGM3RFM4Y1VHNkRE?=
 =?utf-8?B?NzFGS0hvcTErdm93ZWN5U2gwUENVQlRIYWpOejhuU3M5aWZVZ1lyOVdyTGcr?=
 =?utf-8?B?Z24waXV2VXA1aU40NVU3a21EVTVacnhwblJkU240cEFuRzFIWGFRbVF5RTdy?=
 =?utf-8?B?UW1KR2JHd3l4aWdralQ2dDhFK1IvZ3UxelJGcVNDeTQ4QTRhVlEzaWgwWmZF?=
 =?utf-8?B?dDVIMVV2VmZJZFFGc1ZyY2lJV2IwZUU3U0xNY1NidS85aWkxZkNXeHZndWNp?=
 =?utf-8?B?SVRSZ294ai9xK2ZPOFNmYUl1eitPV1J4eEQ1QTAySVpGbS8wb2d4U1dCNzRv?=
 =?utf-8?B?eWxmWHlxWmFFeHc2aDRabjQ3eEYrNGZjQjRhcThwL2JWd3lRdmJEYUpFSEFU?=
 =?utf-8?B?TlllRHlZQzNFYmh5dEMvUDhPZEVuRmpKd2dxVEV0YkNEM0pTY1krMC9NTHg1?=
 =?utf-8?B?UldvTk9ZWkRySFBmMkhpTUpJV3FMd0QwZkM2aThTVUxTeVVEQUpMTGZOV3li?=
 =?utf-8?B?MU00R1ZzeUJWYWI4b0tUeEhiYjFvYTdMazRxNkpsTERTUGY4M3RPcm5FbUd0?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62cabf9-580a-4597-a55f-08daadedcf64
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 14:10:12.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Wc8uO86wHKVyYwXsQIIqrNXpibt1I6Ghtx5OdaAMtB+65QJ69u1TygsoUMssU/FCwb3PQ0nH3d/EtskjaN4DrMqEQ7jmMe7y9GfsDLftCjWH6y5+GtzmtKUw6/1Csk8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6751
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 14.10.22 16:40, David Hildenbrand wrote:
>>>>
>>>> Other problem is that there are drivers that do not use
>>>> adjust_managed_page_count().
>>>
>>> Which ones? Do we care?
>>
>> VMWare and Virtio balloon drivers. I recently proposed to unify them and
>> the objection was that it would break existing users - which is valid so
>> we must care i guess.
> 
> I'm confused, I think we care about actual adjustment of the total pages 
> available here, that we want to notify the system about. These 
> approaches (vmware, virtio-balloon with deflate-on-oom) don't adjust 
> totalpages, because the assumption is that we can get back the inflated 
> memory any time we really need it automatically.

We want to notify about the actual adjustment of available pages no 
matter where they are accounted free or total. Users don't care where 
the ram came from or has gone. They need the total change, so they can 
decided if they need to recalculate.

The example i wrote earlier:
Kernel boots with 4GB.
Balloon takes back 2GB.
epoll_events allocated 4% of the total memory at boot.
For simpler math after total ram is reduced to 2GB, that 4% become 
really 8% of the total ram.
We want to tell epoll that there is 2GB change in total ram, so it can 
update to really use 4%.

Reverse direction is true too - you hot plug 4GB and the 4% become just 
2% so you are not using newly available ram optimally.

And it is not only about epoll.

When not recalculated/updated this allocations/limits/etc the balance of 
memory usage between userspace and kernel gets a bit off, and i think 
not a bit but a way off.

About the assumption drivers can get back the ram at anytime - if they 
use the oom_notifier - they can update the totalpages without problem. 
oom_killer doesn't check totalram_pages() but tries to free memory with 
the notifier and only if it fails totalram_pages() is consulted.

-- 
Regards,
Alexander Atanasov

