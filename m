Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398073957C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjFVCWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVCWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:22:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7F1A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0xipKsm+8srFXmDEXpUHWK+3HnggQ2rAOzVo2zckgkXBOfQCnAbTgTD7CvL3T2eRFNJM1RI/QazR029dGOB+xhGFZsRy248fK64wmO6eC9qdykHQ3wAWI3SaOBpwGm7QTWqwPnhIlhVkapqcYRMlywVELzTmF2KFPJ6JZql7c1olp6NSnI8wdME69/ZADnTjnWevkQ5oTUEiCKdoPzUAdm/cgOAajo1EIhOrxQrZ7m5CZycRaQ9QF6XAZmcAAU2HXbw46qZrml4G3aXd5FywRWxpLTgayLuDmZ9uWsEIznvvW/Hgd4fpbk1iAsvq0bxa5E/odFGNqLHviBvqXMjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmDtMUTFEoFu9QiDNYQlE4auySvq7e52sW5ZQqtOdJk=;
 b=VnUBEn+xbRb5lPSpJO3GF7lLt1O6k74GI6eSDDRf79KWucyKyY0d1L8ap6IiJhBhp7B0WhTqBPvA/2VSp5XhWRRfmURG7Bsy/eTLbqZm6GKg1RDMzLmkA+A+NT8jRruQ6cpAURHreJlinhB6bub2fsN3R3m4ctLWqO7zxNLakFzOd0g3RJ4683HMGkPmOqlH8lPp1mrUYLTT7weZizTTyrHbRjnyqUZn/2hBcYKO8ZXxRj1pm+us3XB7jaPkBmeClvHqFxJJvHr66w06iw78keYjIdmUtUks+b9KOhOEthKvRdsKJf17W31LUG8RD49yuzz4sB2TuthavwN6xUfT7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmDtMUTFEoFu9QiDNYQlE4auySvq7e52sW5ZQqtOdJk=;
 b=SKGXb4LMsrC7DsoOd2QxSf5qkl8z6SHfLSC9P4TeHO86J5fsl9mDCIdZpHsR/KRABIowqmF6zsLUGMTGiiSZdOy/8LSFiSmrr1oJQnxy859+09aFsYzwPQ8M445qvXg3XoaLsY8E4MQkcjYxXQbvIcRSGoF44TA4Z13BqAobw47sJZkWszog63YOk07Xmb7pOpn0N1Ly3+s9/ujnx4xY4Yb+FppxunYXDYbW22Ihn4JmYAuZmjqUvSqalGUkgrHHjhRjFuaKAvbPeS5clXnuZ16HQm9fiBbef4YPeOQ7IIR04EMhO5BWLhAswcuJcqt9m4KyZC379dSoLv0Fvebalg==
Received: from SN7PR04CA0120.namprd04.prod.outlook.com (2603:10b6:806:122::35)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 02:22:33 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::d) by SN7PR04CA0120.outlook.office365.com
 (2603:10b6:806:122::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 02:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 02:22:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 19:22:25 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 19:22:25 -0700
Message-ID: <6a5cd655-f3e6-49ef-e359-401ba84fca25@nvidia.com>
Date:   Wed, 21 Jun 2023 19:22:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/memory_hotplug.c: don't fail hot unplug quite so
 eagerly
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
 <ed83df65-f785-7077-ddd0-4e53d6fa6056@redhat.com>
 <80e01fa9-28c0-37e8-57f8-5bb4ce9a9db7@nvidia.com>
 <83689f25-ca50-7ece-45f0-a936e704df7d@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <83689f25-ca50-7ece-45f0-a936e704df7d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d57c62a-ca5f-4be5-52e6-08db72c789c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExljtDXSNTPLna2nTFFAknetzsj6TAwu6IEgh1KU+kNtRyNysBa/iFJdARsMf4HmU3J7Ab/94OQYwDl0dcM+EGar+ze1NtmW89MDDPJBfY/RFv2CxuOouMIoP7K6gOO+Yse2YzRxC/UsM05izR5/uscm8beH1ddzrTIrs8P4tg9oETfdEKpKHOfZNZO8n058mftTKnBlG0VoNmCOLHzMqc3Z0yVl9i/vuwnNQitttC5rVvKMnCZwK+EGY1iHAIBtpmNP0aso4e0SPt1WkrQXLvrDhRS4shGza5WaopXIhsk3RXI87ykdnAkfz0HxIXupFwl+r2N47hxKqccA8IFBnuvZdkGwwXko1hylGRGXg+PJ5yKsYp1cBgIn8KGsGxQK5TRv1pV09E//gFDkuZV31t51HFQ+Az9sWqIndEy5lWVFxiJEvbpm2MKlFCXLveAwzgW9H3SJJvuxPFNbe96hB7dvm3KU4LwoQVuLQEnClyIbYdahqsfBNK9A5skM47gXt6lnMrED2ReVl+BoxO3AQjkXiHWv800kcPEwyZuR5khV+rLu8fzByuN+6T3HQBI9t7mYRGONh5oXi8jlXMpex+I3jgEeP6ELytJc9zwaFydj87Ri5ACV2gj4QjDdHS4txSK7Y7YIO2R6YeoZBfmjbulkS5+k4vecwQOT1bT5IgHYPYfPR+fZSRP6Dt/Ft7fbA2vQ5z9TFijZK2moybowFYpp9kowSQfAXVCut9wf3e9CWsITH8+8hCjcIdXICZAiI9dkJtBWa9N/lPvA4YMEoA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(356005)(53546011)(7636003)(82740400003)(336012)(186003)(2616005)(16526019)(26005)(36860700001)(47076005)(40480700001)(8936002)(8676002)(41300700001)(5660300002)(2906002)(36756003)(478600001)(70206006)(70586007)(83380400001)(40460700003)(110136005)(54906003)(316002)(426003)(31696002)(86362001)(16576012)(4326008)(31686004)(82310400005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 02:22:33.6923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d57c62a-ca5f-4be5-52e6-08db72c789c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 01:11, David Hildenbrand wrote:
>> ...what about discerning between "user initiated offline_pages" and
>> "offline pages as part of a driver shutdown/unload"?
> 
> Makes sense to me.
> 
> There are two ways for triggering it directly from user space:
> 
> 1) drivers/base/core.c:online_store()
> 2) drivers/base/memory.c:state_store()
> 
> We cannot easily hook into 2) to indicate "we're offlining directly
> from user space". SO we might have to do it the other way around.
> 
> 
> Something along the following lines should do the trick (expect whitespace damage):
> 
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 53ee7654f009..acd4b739505a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -152,6 +152,13 @@ void put_online_mems(void)
> 
>   bool movable_node_enabled = false;
> 
> +/*
> + * Protected by the device hotplug lock. Indicates whether device offlining
> + * is triggered from try_offline_memory_block() such that we don't fail memory
> + * offlining if a signal is pending.
> + */
> +static bool mhp_in_try_offline_memory_block;
> +
>   #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
>   int mhp_default_online_type = MMOP_OFFLINE;
>   #else
> @@ -1860,7 +1867,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>          do {
>                  pfn = start_pfn;
>                  do {
> -                       if (signal_pending(current)) {
> +                       if (!mhp_in_try_offline_memory_block &&
> +                           signal_pending(current)) {
>                                  ret = -EINTR;
>                                  reason = "signal backoff";
>                                  goto failed_removal_isolated;
> @@ -2177,7 +2185,9 @@ static int try_offline_memory_block(struct memory_block *mem, void *arg)
>          if (page && zone_idx(page_zone(page)) == ZONE_MOVABLE)
>                  online_type = MMOP_ONLINE_MOVABLE;
> 
> +       mhp_in_try_offline_memory_block = true;
>          rc = device_offline(&mem->dev);
> +       mhp_in_try_offline_memory_block = false;
>          /*
>           * Default is MMOP_OFFLINE - change it only if offlining succeeded,
>           * so try_reonline_memory_block() can do the right thing.
> 
> 
> 
> There is still arch/powerpc/platforms/pseries/hotplug-memory.c that calls
> device_offline() and would fail on signals (not sure if relevant, like for virtio-mem it
> shouldn't be that relevant).
> 
> I guess dlpar_remove_lmb() can now simply call offline_and_remove_memory().
> [I might craft a patch later]
> 

This direction looks good to me, I'd love to see a patch if you
put something together.


thanks,
-- 
John Hubbard
NVIDIA

