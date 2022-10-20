Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1994605F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiJTLuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiJTLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:50:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319BA67073
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHYllO6d2KKBJZlTVghLvBGfLUQcTn0Y6Pw41oLLDnxKoZsGqPY5kCffDb8UKMUgznkT6TUgnkIBGrasVZCzVmOp6GSuy/4D35DrxmFYLRBZuGSxNkInvYwH7wKW3+klxl5S9j+fdbKdL/uH56TKD0pnJQZywtZ0m1ESqn9SqLi3/+MAUQsnfltsBdiIQQRy4ecmhoCcb8HZoU4yLfWBrj6MEXSu8iDR0uMFtNhOTQFDmah7ZbVhiBXiEryPUfZ9dXlz+vsw/yZQ8MwVrKyvrHnH43cLTSNGhpHeTmTnLXpzbnpk8A+H7Ew3KA6bc/ifoAqKGJY54deJZyxYisjwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07jHnwxzyxQ6cL/Kko0m/ZJJK4GJO5hqe6rmtSNXVr4=;
 b=SWlq1hhtjCv3+ev+e5xuhp6K51WN4SVbAF1hiBOtzGBa4gKrV+W2Vj85Q1dhPC1z5aDd1AR9mjwgih1uogaevfWiOss3IftXMeWrn+xa1L6y47PE9zUyTr3GYV6Rzek7qrD5k2wqcbecNmBUEydDjImC+Io1CSKJB4Aq/yycJEjyo3gxPkMoOJkB/nBCQRfYqsMClYkwv+vP2Xhar5MhfKdRaO3pHmYRALy8AbEdKJpkrq1mGXsHBVeIuS52UhGrZZ9pJecfy8Pxz935NN3lR+7/5jf+21Tj5X0rtkD/PmZX19F61jzvoFJ+5tmoGkLenXvOzJMAKc2NqNj7R/xuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07jHnwxzyxQ6cL/Kko0m/ZJJK4GJO5hqe6rmtSNXVr4=;
 b=idsnRYzZqE5NMSuprg6VZj8TKOJq8r2WWk1AQfMiHF1eVfHSDmCURs8eS/K25xAmkOVh7qSwzyViKMAxhYrH4+bAk48EPnX52i+1u+BlrhOPrHtayhNNiDAQxUUQEdBwKHEarmPEMw/zgJmu6HRLD4cmWh0Q7NmAeAuWvAWWr49/Aihetd1fLjYBLYnl3aqBPj0dxRqoCFQ5c19H79i67zABdYWuq/iyLCqN4DXE99LVxQ1RBgK/9XQOO8/Z6qAq4NC0cIc/P9qMMHBV1C9EEkASu1f8iSOBBEziDKjvAE4vNfyITBYqC6kVwYsjzv3LdjZtOAHtWeTMuTScOWDaUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Thu, 20 Oct 2022 11:49:55 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 11:49:55 +0000
References: <cc48dc1e4db8c33289f168cf380ab3641f45f8ad.1666251624.git.baolin.wang@linux.alibaba.com>
 <87r0z2nc6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <b2b44837-045a-a5ac-319e-216f6b2491bb@linux.alibaba.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, shy828301@gmail.com,
        jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: gup: Re-pin pages in case of trying several
 times to migrate
Date:   Thu, 20 Oct 2022 22:43:39 +1100
In-reply-to: <b2b44837-045a-a5ac-319e-216f6b2491bb@linux.alibaba.com>
Message-ID: <87o7u6soip.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0041.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::10) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: b764d911-0c9b-4708-24da-08dab29134a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AG7gqnKb1/iSB88k+1qIoD5wmTQEKYbURU0f2okRWVHeUvY3cGRs01pbETQgFDan/ZzO+bsqAPBsWVZuCfcT1RDN99dMohghnS8dJ1aUndtLVQF3kDMxsAPghhRhibyka6KvfPrJEfZWK7fpwNY8LivkXSgpcjTZ+GbhBBl62f0LOWtfrXE0zdYkZdMvbQT8OGNyCC5/5Gm0x2H+a7xOHJJVgudC1jbKyTZQDu91xSvTLYXF+4rK5tx1cHzI4ujEH/N6ScF+ePpAoK0I/gzJiFnGy6gH6IcEJLIIGKZIpWRvnHHa9oZXKvUL1Zfh0tk6TU//+ddyGWM/uQdeQylWv4qH5lx5fnl06ux4dKHqPASJRK41h1okd9n43JeVR1EDu6ElNXUvtOoCVhxMv0FRCVJ1sfAadnwezt0k+/nIQCN4trtY7m5KtF2jSQoxaJi9tTincWZ64+bC+AehbygMRTqnx90BVLjtNGGfkn8pfqcwj6chVnWLmq6d5LTre4QD+VRvkL9G0bhvJVfmSK+EiS4SBnnF/lyvnfALSntvxhXVwjcmif0VY8nhT15tw03+rynlVYfFJIRwfVyFIklnuZcEV4396AYcTUkLiXKuKiu9OD30OYoRbcgJWYHIYWHS1bhti/vtDhSU5K8/Ok8hcXibjy1hCeGYvTOkaqo0yWtvj3miY1Im12mKEa3pEQeiSqd75vMUsEXlhPs86XpDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(478600001)(53546011)(8936002)(66476007)(316002)(41300700001)(8676002)(66556008)(66946007)(2616005)(4326008)(36756003)(2906002)(6512007)(38100700002)(6666004)(86362001)(26005)(186003)(5660300002)(6916009)(6506007)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ahc5JbJmMQtO+/P4tgqhTH8vPoJkMHrcuPUVqPvFpHcgQejzaUg3uonRuTEs?=
 =?us-ascii?Q?yvMzCoohBIKk/OTbjdoampJShv4EDSIDr5Fky3ihT7cVjntbPFeTe/vKeEaf?=
 =?us-ascii?Q?uomTCKaZQvHpH5EyMl6UWWLjykRWXmJ/zyNg3VYvfr0E7VkhmNo6mzrFY6Y8?=
 =?us-ascii?Q?Mmptei1Rf/HEt5O16WFQ50BSUXYN4EDKnHuLXwpqLHHQjrDVjzZeA/WN5y2H?=
 =?us-ascii?Q?SwzhEFCWYaeWZspdreo+y2wVRw8obj3clO6gOZgGS3kYlpJKe+QGs6A+3ee+?=
 =?us-ascii?Q?G4OIUffdY0KV1GdR/SiE/vd+WTAaAlvLpKlVIDWPnNSSc951riQFDkJpmdCb?=
 =?us-ascii?Q?EVoMqNL4m00wKT3KFywikm3ffUsO4jpTC0z1lKbDMhlyXO2qdyxiIAuTO7T+?=
 =?us-ascii?Q?PTCgNeuLS5XyOF8nf6bE4nJ7TJhrEyhjQk743oVIIOAk+hO97aRHKK9JMSl0?=
 =?us-ascii?Q?CFxQwwiVGyqSlQAPtpD0QlSx+vIVxZAguXrsBu5rh/VhBAzfsOwcUzh87xpz?=
 =?us-ascii?Q?mCeqozIqSgVohia35xD6YF+SMEcVz5IPw1f4bKtebrujBzUCU79niEwN5bfI?=
 =?us-ascii?Q?s2xSuh+lv48Srq5G9koXWjFjPoUaSrPJ7VDwNh+jKdbysRm13UcrmtkrwqXG?=
 =?us-ascii?Q?ELXIgdlaCAOw2oRNn7EyES7L9RfZY/dj0XLpsuXA5HV4GctY07Z8WNIC3Bz4?=
 =?us-ascii?Q?451gkz7NZAisVtXTiWZATs38oGd0ITHmGd6vvsryzhtARSvxhupTJYK1FYuH?=
 =?us-ascii?Q?gmrYD6r3+uKVgAmX6TX6oI9JHnGdwuZS2WpMZUsYdh+OQvEnniwJJfa3r52u?=
 =?us-ascii?Q?HViV7RysFHOFWQ8qRDRYMYFVo+uD8fOu7U07vACja2gkxccSa3eAeGdHTsXS?=
 =?us-ascii?Q?JrftfRq7egVRcdNaKA+UJiPX20s2/t1cJBhvMzDyyQvv4LonsmIJD9uC3n/M?=
 =?us-ascii?Q?Xy3Qxp0LIx3ij9v8/Zq4J0Y4jrk82DrX2lhv2Xd9RBbR022uTJ0y1ujuzBO1?=
 =?us-ascii?Q?qCI/S21CJn0wm6ZKKQwFs7Xa8E/PQUbyEl5YDDXmfwzhCCxpCq9NMii42GDO?=
 =?us-ascii?Q?jTQSkJWoMva66czh/a1w5DOTRdyBeY7RyMwmoKlYI7XNnxp/TtIZHWe+k9Qk?=
 =?us-ascii?Q?hDlHz7V3+/0rr0kJfWxe4vrzitCWNVrkavggLAOHTkARLIvp6c2WAITQtWPw?=
 =?us-ascii?Q?JOCN6X2VpUjaGHLPtKldZt5UKqK19K0Rs0O175HbJLKXx8EEZpI9SIcBpo0q?=
 =?us-ascii?Q?321h+zHMOMkeWteDjyGSHz2PujBVeAmuM4xytSrl633SZkG+O8HzL+oQJMjG?=
 =?us-ascii?Q?jAa5ysWMcmve3uGiYrRwwcgOxzIMnTrO98li1dWeMcGv1ShN2nS5ud3Wa5/8?=
 =?us-ascii?Q?OaWrrviSMKMsid1ZKwLGhUkAyx787rxwPDnjMWR3ICOwLhKe/ONNW/a5iYdd?=
 =?us-ascii?Q?nz6/RiDHNO8j2lDR4C5s8w2857jnu+oABRtMbkLYYCa5XOOBH3nCEayhgteA?=
 =?us-ascii?Q?5ZYUrIturEjquZJDtiecCizzKD3CQ/l7z08dk+XT7n47tqLt4g+wRVjvIyg/?=
 =?us-ascii?Q?r2LXXgNJYMZi/wGJK5Z9R2WgBPREu1ai3amBZoj8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b764d911-0c9b-4708-24da-08dab29134a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 11:49:55.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz88Gh7F9jXH/2CZm2FYicgC+hTv0BdB+sZwbHt8zS6lIWJ0sFRwDQLsYY9JfmwOrdITYDvZJ1yFQGHvpGeMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 10/20/2022 4:15 PM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
>>> The migrate_pages() will return the number of {normal page, THP, hugetlb}
>>> that were not migrated, or an error code. That means it can still return
>>> the number of failure count, though the pages have been migrated
>>> successfully with several times re-try.
>> If my understanding were correct, if pages are migrated successfully
>> after several times re-tries, the return value will be 0.  There's one
>> possibility for migrate_pages() to return non-zero but all pages are
>> migrated.  That is, when THP is split and all subpages are migrated
>> successfully.
>
> Yeah, that's the case I tested. Thanks for pointing out. I'll re-write my
> incorrect commit message next time.

This is confusing to me. So users of move_page() will see an
unsuccessful migration even when all subpages were migrated? Seems like
we should fix the return code of migrate_pages() for this case where all
subpages were successfully migrated.

>>
>>> So we should not use the return value of migrate_pages() to determin
>>> if there are pages are failed to migrate. Instead we can validate the
>>> 'movable_page_list' to see if there are pages remained in the list,
>>> which are failed to migrate. That can mitigate the failure of longterm
>>> pinning.
>> Another choice is to use a special return value for split THP + success
>> migration.  But I'm fine to use list_empty(return_pages).
>
> OK. Using list_empty(return_pages) looks more simple.
>
>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   mm/gup.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 5182aba..bd8cfcd 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -1914,9 +1914,10 @@ static int migrate_longterm_unpinnable_pages(
>>>   			.gfp_mask = GFP_USER | __GFP_NOWARN,
>>>   		};
>>>   -		if (migrate_pages(movable_page_list, alloc_migration_target,
>>> -				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
>>> -				  MR_LONGTERM_PIN, NULL)) {
>>> +		ret = migrate_pages(movable_page_list, alloc_migration_target,
>>> +				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
>>> +				    MR_LONGTERM_PIN, NULL);
>>> +		if (ret < 0 || !list_empty(movable_page_list)) {
>> It seems that !list_empty() is sufficient here.
>
> OK. Drop the 'ret < 0'
>
>>>   			ret = -ENOMEM;
>> Why change the error code?  I don't think it's a good idea to do that.
>
> The GUP need a -errno for failure or partial success when migration, and we can
> not return the number of pages failed to migrate. So returning -ENOMEM seems
> suitable for both cases?

Seem reasonable to me. migrate_pages() might return -EAGAIN which would
cause everything to be re-pinned and tried again which is not what you
want here. See the comment at the start of
check_and_migrate_movable_pages().
