Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA633609C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJXIHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJXIHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:07:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AD45E66C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4GIotqAD+w0pHy4lofZJHey97Y0MeGuLy+OLmtO5QEOJiUSPE1z4WTUWdEOClph7Rp+JTRdp7OxfGtJ/0UBDYCme6dN3M2Qy3YlbBicRs53EpvF+xl75EN1QYWRmzxQYZAgSyAhBrV1zrebtuGOH//rfflt0BHbx5uLGFuzZFqlknLYfH+nkIYybkY5V+tVA8OVSl4UOYGvp39Cjffhw8z5P4IQAhGkeIlmA4/yzuJxASS0jiKKSlWOmwceuQltPaJSBQsviAZsiR6aixTC7PGJbiadS5d2K8Qz833ywGv4FyEln/VrfeFGacj+JrJ25y049wn/aUWIYBfx4FoohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHO8mL0z6+A37AAhJiNEw4EghYmeVF1vaZ82zMgRUrY=;
 b=V71cpLU0BTrJnM5QCUHkUaex0YvLrGvr2eeVahSkzB11Q/GOI5RNoJvbiyZbCOTXNavy+K0Rb6Y/fZhT8mMvKszFoxlbXpUMR8AsyLhViYnXwM86KmpwP0XYr13jTR/k9ef8yN3Xqwa6VRXKmA4Co3O+MV86Y0llRgK1+dZuaP/sakZkD/cfTIeT2ur0LJJaALWA3iCtw6uADDilF9t3JHpPZFqkFZ6H0vFOo0wnOdUj4PLUIRCyHXdKzQxX9aYf4Yhz5g3hJ2HPKj6h18ATqzhhtAs7APb9D8tqIrZtSaZfeNfPfGPSS8sNX47qyz0CXRmNRKRrx9NroYsInhUwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHO8mL0z6+A37AAhJiNEw4EghYmeVF1vaZ82zMgRUrY=;
 b=Lyhfkx7zW0dmAz7ey8HYnGl4SiE0ZhsNtioHgKjtUDOKdFoCb8BQJPACnKEu3+PpACrfK5VeFHudGVlMuetO1iQYEuasRRwoyv43NGpJUyyG+RPY6E9mSDNBd3TSyHa3wSNUL0/zaJiGm+ZkUAUTdAhr+cDr5MMZvzL217/ImqhUEPrkifrAoUyleNtrktV3CiRW8wtE/GTKWFB3pRTnYECRwg4F3drNC9IXw+ULKGG0N//ZOtfTXvLVLj0w3tXLligCqJzr9brteszddEgqFLMmedoRcyk6LOjAZ8RJuy440zIIE7X8ymmxXduNgrnY/BYmJJPAzKZqFdF5nrFJ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 24 Oct
 2022 08:07:26 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.034; Mon, 24 Oct 2022
 08:07:26 +0000
References: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
 <87pmeiq6qc.fsf@nvidia.com>
 <4fcb9065-0d0c-7bd3-d4f9-5830792cce60@linux.alibaba.com>
 <87lep5r7t9.fsf@nvidia.com>
 <f2cc7bb4-f296-766e-16b5-0d70498669eb@linux.alibaba.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        ziy@nvidia.com, shy828301@gmail.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
Date:   Mon, 24 Oct 2022 19:06:57 +1100
In-reply-to: <f2cc7bb4-f296-766e-16b5-0d70498669eb@linux.alibaba.com>
Message-ID: <87h6ztr6f9.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: d7507185-8445-4736-140b-08dab596c9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZR7eUx3gvUOhrBILLdsKcIml1gu7KZSCHcneCdWj6Fb7VAAcQL9FN6I0nPNgRWKeerkYfRiXP7uTZuy9h6z6OfpsjJznG2pBuyIdCpjLMj6UINKeUQUmNol2TUJluUSXGoxKjSGyHJn4qVB9k1kRC1RMq6vX6TbHBkGSDmkd3r37UDdDd+VCeEeqiEag8sidOb6NEmgrzr1FbzXO3L982wYEmzBJ6yfmp2eQysTNv2NeA+CVtosRMHqvxqAozXnfk35MwoEhsMDk2RzeZmCBWlY9+eT5Ziw5vRc33bOpHnmmmihQq8i7zjJDXF9P1r7iwJdzucBK9r/BJpy2LxvlCAhzAIzMgzdDi5qNfXmyrafGp/pX5Ky0aS5FQlWt0HewODWS0dulYBAEuINyxJ3SaFv6IRyOGeUfyiMIPiwFVZjGDXsfr5OBYwB1hFTVRlKQWtghm2Kkjr6y7EWK+TCaWtw0s8IrspWij/ice3aqyF1dwD3//LJENY/1oF9116RtJdP1297iyiFi1iU+Sd73cQsJUakDm36sEF4zY3E6SqpVJ8+n5NxuEkrfmd5mUgCBOxmmmGWviwfd75mZuD6Lt2GGSiPZNpjf0IiqKDhgVw9r/aUAiH4RkP8jjLMU3SDtXzqQ1YGC1zaqkBIzznZgNnH52xHoaGdBgL8xM2Qpw5UaIBLch1rbTscvvezrv3sn8sgXzZGJg2VxSUUa1ZRamOf/O4uVjdaGRhdSHD2/9NIUalwDCaO2a7gRpyQyVmGOnOxPHjt8Ge3Pw+8Usqjtwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(83380400001)(36756003)(66946007)(66556008)(4326008)(66476007)(41300700001)(8676002)(6512007)(966005)(26005)(38100700002)(6506007)(316002)(6666004)(6486002)(6916009)(86362001)(2616005)(53546011)(478600001)(186003)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ne4KPCexsU1JnkY43nUmaUYkox1cXYsG8VyKCpiPUsbJh+XbnkvaSMJEHU1R?=
 =?us-ascii?Q?IXErwSH1vC38OQnKhR5n55AcbOgDYwpxb1zi5DSExROgOvZKI7T8ThzT1feY?=
 =?us-ascii?Q?rdw1tjaaewBc2OyFTm9Chlalp45VCtHnAtI6a8ydX7HwCc6G6LiWQQgOi6XX?=
 =?us-ascii?Q?kjUM+Lpr9o2+JbDBno+lzaMclrDKOHwStwcVHPUUP6F9S/Neh15PkQjUgS/X?=
 =?us-ascii?Q?bCuxD89H9BAMG4ofI9HZcU0PDsvRm6qJU2JviahvNGr0mkBUTBrkdGYsKFb0?=
 =?us-ascii?Q?rj18tkexvroRtd2Bp1hHyyMbQIg36m2pKYMQpw16KHT3BbHMpz639MB+ItxC?=
 =?us-ascii?Q?lF6dFBLEGkq1iWG2PepCLvA8wACFinpyVkDOz93qDykRWB9aMmXprOBXRVno?=
 =?us-ascii?Q?kbQFqt80dm8mgGzxMIw7j/Wf5ogIbSr+Mskr8WEGqYZHr8/rzEBDn9+YRyIK?=
 =?us-ascii?Q?uXcThMrrzn6G3yAy0KggKJoYsznEiQT9UVYm8ANf3TB+HoM+NBLjUoMoxm+L?=
 =?us-ascii?Q?Sg4ATZjIHfTlHmirkPkS3DqHdrubZvAFdFz5A15Xu6+TjRpEgByY6eI0lS7+?=
 =?us-ascii?Q?5KZu+9DG5y6raFkTFB71DQPmYN7/lz2kSEm4kZP+pILAwMbNO8OHQYe3375Q?=
 =?us-ascii?Q?Ysvb85987LayWKwJ4QEARDZ+QU33qqIHnji1bOHC06rufexnMtdgY1zViXdh?=
 =?us-ascii?Q?lD1hiiJcoZTgnH0+QR8Eqncme16YTtjDSoErZTD8hVkHSN6rqQ7PJmsCmv0F?=
 =?us-ascii?Q?qI6nSDfoHVwRoMPJV6G52990h57A/QBjJ/GLVNtzdyuqkDRYIRxrlf5gjx/D?=
 =?us-ascii?Q?g+j5iIsp1tdkpsADW749y3ZX+ktmz5MN6jTUv+tKtswiBP23cyD39wN5Bo7F?=
 =?us-ascii?Q?3TIep2xH+uI3ynK67qecPA3IlcJ4MT318jj/YkkH/O7Q1S/a0DEayypHgoia?=
 =?us-ascii?Q?0hpb2rxOXyh4A8IMPOUTkTYdTM7Vd2+YmiIG40F1NI5zrxAu8GLNCQPlCf5l?=
 =?us-ascii?Q?ViA0VTGsv3DFBr8xz9rdcLAU11AzIYCfCeRp4Zt/vJYS9e9XUKmW8qHwHgei?=
 =?us-ascii?Q?BXpY83djwj4o7sKUzpfTXAruJCwxOmq8Gj+1HyZvhIuKgUDp9MuM14kxCenn?=
 =?us-ascii?Q?u+OuSQbb9lKLtNe3M99vFMr0iJ39UhbDDeyUh5fxSOF29PrMxGNgFrzMUifq?=
 =?us-ascii?Q?0Aaq+YIH/q4rDYuUHc7rNQZRHAvyxFJxEds5k+ktMhHALL/LRNkJotG5PMQr?=
 =?us-ascii?Q?0EwaHjnZsnmJi91XBuwACJJN8ncgkTv5gQ/UfpxMdaXveL26nRB60fOafkZl?=
 =?us-ascii?Q?kPs2kMi5paIL1jfZoUK5KgzsLm/5744+Tlo6VVNUL4fk+Eoa4YCMCcyaaHqJ?=
 =?us-ascii?Q?3uQy+b/Y49gsf2pwSmrsgub53cxgwWUcMJsLVGaGuEOZP397WOX/9xOgYqom?=
 =?us-ascii?Q?plYIycDiC5X6Cy8PLDe9wCen+2x9NcYgWgg+Hzzzwsxheh6NHRN4aomAIIiZ?=
 =?us-ascii?Q?rpeQ5ihXL7qgdX30mfZD/fkRiunnWjdYKnBELZGk+q6HERHFVRg3D9rvlUko?=
 =?us-ascii?Q?YNAJSlRvJAPaP8kZ+eQ+NEgxE+UsfrE0OpZ/QPAr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7507185-8445-4736-140b-08dab596c9e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 08:07:26.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDZO0PN44chhJ3HdpFBRm60jRi61dnTd1j1/h2DPmpTy3NK6jTKpdxsjioFf6uIF2LvvP1AB4CHariMWDYxOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 10/24/2022 3:24 PM, Alistair Popple wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
>>> On 10/24/2022 10:36 AM, Alistair Popple wrote:
>>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>>
>>>>> When THP migration, if THPs are split and all subpages are migrated successfully
>>>>> , the migrate_pages() will still return the number of THP that were not migrated.
>>>>> That will confuse the callers of migrate_pages(), for example, which will make
>>>>> the longterm pinning failed though all pages are migrated successfully.
>>>>>
>>>>> Thus we should return 0 to indicate all pages are migrated in this case.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>> Changes from v1:
>>>>> - Fix the return value of migrate_pages() instead of fixing the
>>>>>     callers' validation.
>>>>> ---
>>>>>    mm/migrate.c | 7 +++++++
>>>>>    1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>> index 8e5eb6e..1da0dbc 100644
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -1582,6 +1582,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>>    	 */
>>>>>    	list_splice(&ret_pages, from);
>>>>>
>>>>> +	/*
>>>>> +	 * Return 0 in case all subpages of fail-to-migrate THPs are
>>>>> +	 * migrated successfully.
>>>>> +	 */
>>>>> +	if (nr_thp_split && list_empty(from))
>>>>> +		rc = 0;
>>>> Why do you need to check nr_thp_split? Wouldn't list_empty(from) == True
>>>
>>> Only in the case of THP split, we can meet this abnormal case. So if no THP
>>> split, just return the original 'rc' instead of validating the list, since the
>>> 'nr_thp_split' validation is cheaper than the list_empty() validation IMHO.
>> Is it really that much cheaper? We're already retrying migrations
>> multiple times, etc. so surely the difference here would be marginal at
>> best, and IMHO the code would be much clearer if we always set rc = 0
>> when list_empty(from) = True.
>
> Yeah, the difference is marginal and I have no strong preference. OK, will drop
> the 'nr_thp_split' in next version. Thanks.

Thanks. With that change feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

>>>> imply success? And if it doesn't imply success wouldn't it be possible
>>>> to end up with nr_thp_split && list_empty(from) whilst still having
>>>> pages that failed to migrate?
>>>> The list management and return code logic from unmap_and_move() has
>>>> gotten pretty difficult to follow and could do with some rework IMHO.
>>>
>>> Yes, Huang Ying has sent a RFC patchset[1] doing some code refactor, which seems
>>> a good start.
>> Thanks for pointing that out, I looked at it a while back but missed the
>> clean ups. I was kind of waiting for the non-RFC version before taking
>> another closer look.
>>
>>> [1] https://lore.kernel.org/all/20220921060616.73086-1-ying.huang@intel.com/
