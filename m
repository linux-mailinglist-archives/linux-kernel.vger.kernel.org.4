Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B455B7405AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjF0Ve6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF0Vet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:34:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1342D4B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI4nZpZN6qLE1AstqraK1nA0ePkBdsD0ZtyCjfimkyjuwMVhDBmzmhSIcthvaSjtP8mUD+Vx+gpWaPRmFCpR8stvckvzqmHYgBVNz6PRCh8LxD+GfnptY6QbzIjGjrsdrisU83haZvHu4VL4CtFgLgfVj6sSxkfyFH2dOi1B1GHa3jFSmeLa7VuG7QhoDKsEZJO/szfarDvL9N7kbkU+2C3dO4ODRwD7z17pMy9NorY70Fc/s0qsS7PJRyjj4hzx/qptBttwrO3e6KSPnr8ZcegX1ItKsbADwZxVKcMvIDi74dFN7v+gfNfoZAwHPeGXhZ1vppQ94SSuz4czQ/xYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=816Nac5snZQQ6cx9GmBzXIqna7KudkOs3bUvCKTNwGU=;
 b=ZzNaqCShPMg/qH387Yb8/7ZIQ3/VxOlXfsm6EQ0aGHsLEwf6c5vmrXv+AaZo8FApqCgT+2lmtwVgzDnUp/m1RmfWoEt3yq1KtmQnRpe88ygBNx3OMOQwR0KjbHDWqY213cxM4ZAuCLQ8sRNzQLRRsfYBhEboJkofCIsM+jPwacPeGUaeatQzuS9B+/9Vo+I6X5RK3vzWDaSAo1cgiEDce/55jAdPbKl5MhULLEpEx7xHyS8mKsOi8YgM0/tszAbGEeHB3gPTU0ebOsYwmGnN/sCRzvNbsUO2XuEYGq68oVcPdGka/8qYMlFWirh/rIOxeXPDMENPH4lEwECc1jQUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=816Nac5snZQQ6cx9GmBzXIqna7KudkOs3bUvCKTNwGU=;
 b=B1f/lWJ0eKJvg/mjZo1GLZSG193bpWtPRM6n5IMP6Wbc2aGGDsCeaP48Dltb4z+y5Jw5JQAsJYx0tcgagxxSv8ISBmo5smoexzODLE/Fy/Nyr7oxvWxvL9wsBb1uLm7SkL3DYRvlc/hI6pG3vtB16piFZUE1Lg7VlHPWWHltnRqJrrHMg2p70odwQFUY34002MmEXy6a8EM9lp2/6T5jwld3WooEV1DqNlhmbe7n/xqJEuW5u/H4STvgV5UPQphSNbO+/h+G+4yl5Y3iiafqH4VvnaQBgpmFLPPcEeiZnZxUMHUKLUvertSdDqyz3ZR0R3n4g/8cISj126mA48HsQg==
Received: from BN9PR03CA0793.namprd03.prod.outlook.com (2603:10b6:408:13f::18)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 21:34:32 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::16) by BN9PR03CA0793.outlook.office365.com
 (2603:10b6:408:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 21:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 21:34:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 14:34:20 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 27 Jun
 2023 14:34:19 -0700
Message-ID: <59ed032f-cfde-7eda-f755-9d05c15d2828@nvidia.com>
Date:   Tue, 27 Jun 2023 14:34:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/5] mm/memory_hotplug: make
 offline_and_remove_memory() timeout instead of failing on fatal signals
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <virtualization@lists.linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-4-david@redhat.com> <ZJrYv0JIcrNyf2py@dhcp22.suse.cz>
 <74cbbdd3-5a05-25b1-3f81-2fd47e089ac3@redhat.com>
 <ZJrvhACxmaQmmwYP@dhcp22.suse.cz>
 <0929f4b9-bdad-bcb4-4192-44e88378016b@redhat.com>
 <ZJr8zM/Van7UaUif@dhcp22.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZJr8zM/Van7UaUif@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1beb53a7-adbf-4643-4ff0-08db77564bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niO5Rmus2WB+yaMa307SMXDETX02zUWmVolWRKdVA2aZPgSRrSaCt2FUfFlvQZ9Illfp8FK/b3yE83uQGe88vBAdb2mnFKJuQO98Fv+Df7TvScGtLqEnuMQkgzv19WRwhdq3aMex+q9UinOQkj14S4k+K3nCjPQX9qqo54pmsTgkCgupcPu261jW8lmeFlLzk41L9b3u8mDpCj7mN+/RRcWjXcmsT7TOob2ci1ZcwO1j8Rgm2rqAPOVVkm4+P25W+Lu2LVVk11DUG+gE+0am8h/oIeVJe6JJLX6Nbk2UAeywXbShVWJQlJg16W90it8rnYIK/0GH4TPSiXRdZAOn+LGJ0EKDbqEq3HDCX7pnzvDS5kICZOY8qWHzAfXiXnjrU8woOqitDmTtgfZWFd9+YIsDEgEbG+fVoJhaprOxtWoOzUqqE9eZWwX/YWX2Auhr2f9oP3ZjH0WTmu4dO+UighZXdrJ/zTTFV6qc5z72CDgrxpmfHu7dxW1NaFZA+gNeNY7HYJEvHQXk5O6Kv1n5Nj8xwG9SQoiic3KUjX54OQHiIpEs/Z0aoynXZoYfzfKOn33Xkzn63CDt9IGXgqXqHGJHWgA29/zhxwwY4XiTs8qrlDJ8n0g7nqOK0gUjHU91FNIbU42KzLReyfY6pF2YCvcwrlwmFmrgpI+AvElGRrQmGiArC9nL3TV9vKxQU5Z1W8x/nCHpKkv8PeAvtfnX9UEVrh3J7X7TdubghusD31zeWfW+shU5A5J9Q7qCArVq+oLnyMP/FQa6e6CEtSqOww==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(31686004)(82310400005)(53546011)(36860700001)(36756003)(70206006)(40460700003)(7416002)(5660300002)(356005)(41300700001)(8936002)(8676002)(86362001)(82740400003)(316002)(70586007)(40480700001)(31696002)(7636003)(4326008)(47076005)(2906002)(26005)(186003)(478600001)(16526019)(2616005)(16576012)(426003)(110136005)(83380400001)(336012)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:34:32.2944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1beb53a7-adbf-4643-4ff0-08db77564bc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 08:14, Michal Hocko wrote:
> On Tue 27-06-23 16:57:53, David Hildenbrand wrote:
...
>>>> IIUC (John can correct me if I am wrong):
>>>>
>>>> 1) The process holds the device node open
>>>> 2) The process gets killed or quits
>>>> 3) As the process gets torn down, it closes the device node
>>>> 4) Closing the device node results in the driver removing the device and
>>>>      calling offline_and_remove_memory()
>>>>
>>>> So it's not a "tear down process" that triggers that offlining_removal
>>>> somehow explicitly, it's just a side-product of it letting go of the device
>>>> node as the process gets torn down.
>>>
>>> Isn't that just fragile? The operation might fail for other reasons. Why
>>> cannot there be a hold on the resource to control the tear down
>>> explicitly?
>>
>> I'll let John comment on that. But from what I understood, in most setups
>> where ZONE_MOVABLE gets used for hotplugged memory
>> offline_and_remove_memory() succeeds and allows for reusing the device later
>> without a reboot.
>>
>> For the cases where it doesn't work, a reboot is required.
  
That is exactly correct. That's what we ran into.

And there are workarounds (for example: kthreads don't have any signals
pending...), but I did want to follow through here and make -mm aware of the
problem. And see if there is a better way.

...
>>> It seems that offline_and_remove_memory is using a wrong operation then.
>>> If it wants an opportunistic offlining with some sort of policy. Timeout
>>> might be just one policy to use but failure mode or a retry count might
>>> be a better fit for some users. So rather than (ab)using offline_pages,
>>> would be make more sense to extract basic offlining steps and allow
>>> drivers like virtio-mem to reuse them and define their own policy?

...like this, perhaps. Sounds promising!


thanks,
-- 
John Hubbard
NVIDIA

