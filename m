Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90C66478F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLHWkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLHWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:40:00 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA53120BA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:39:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXpMOwh00q4MxfLHn7IrLd6XgC0AWNFP32n7G5tyB5Kmfz8zX0iF9Ehzp+sEeQXJzYlXpdhW63vuHC7NZUePMfcdcO/EixMtwHZdiT2fj19yAszFIXPAJxN6U0YoopuUTM5LtQsVQGiab8vi9qcu/nG3XCHO9dC67i4zdmyxbqtuFniHCBfmf3lLGdVv+BawBeWlrMcJrSELyAyU7pjgR/aMx+WvH2zCJAHtAWQySwf+d39rJ1ITGtV0vmP6+JnxPAluGtNNYWXth1DgSmIG7u1HQ3IzG0BFIL0tCbsRZFUNO6GCdluj1pioLW6ZwP+O1fTMxLKCUf6XJ+NpabbnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke1PJG+umFm7mj9jNpunO3Hi6/cJnjq4H8NYXukDnOg=;
 b=RdFfiNAgltftQZ0gVsx5NUD4xPzySVQyBqBhlulamZEQlcCv12WIYV0EnNKFJgNahHU2mCvIZosRHSqfDm6ViugSu5Kh819E06wGRK/MGY323pQQ7N27ZHNwvW4d82ufSfny1jyfAbqnJCtGUKoE8C8eZnoBh91maDjlyg/fzQ7krPqBFxk8KbxcahudLsZL8PWQc4Q5wwfU0vcfaBaDqHF871rTTVebwIWlq2uW1w6AidswG/t+WkNI9HNgOu/ZQ1gQpwqMzoHItQla3CJBJujgFLRreA/1Wn4NB0oJHvmf/dyPS+rMjj52ZSG4eag6hfnRm86Xk2EU0sXgFc8YUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke1PJG+umFm7mj9jNpunO3Hi6/cJnjq4H8NYXukDnOg=;
 b=eq+fPxQbTQ69EihlrJWHNKdp9nSs9aPx8e60qAtXaGL8OtaDHXeuIE5SGe/xVakf7MZ86z5UrSLzyD20XaegXJR+SYEjjTIi86G4mdBCpgYo/WsQQKAEqL/lZQEumDnpqHvK5e0ySksnC+BS75DQTUDcPu2W233hu9xL41mkak/arXwpu1DNEbHE12anRqbYbcTia7YJSVIBnFMDELuY/NbqgWXqXNgVlUQ4qyp6CDHgjHPQDl5f1R2nK42vHygKU/D+UvpelguJNhF8S35RffbEBzk7m/XHWiSb8E3ETQW0ukM6JU2MJqJt63ZqP5FH6EOLan0OODsUISZ3+jBVsA==
Received: from DM6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:5:1b3::45)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 22:39:58 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::fb) by DM6PR17CA0032.outlook.office365.com
 (2603:10b6:5:1b3::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 8 Dec 2022 22:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 22:39:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 14:39:47 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 14:39:46 -0800
Message-ID: <7d72778e-7305-18e9-edf4-ed55a98aa7e2@nvidia.com>
Date:   Thu, 8 Dec 2022 14:39:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <tsahu@linux.ibm.com>, <david@redhat.com>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
 <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
 <36ddac45-ecd0-e2d2-e974-8c85ca503053@oracle.com>
 <20cc2088-b66e-28d1-a529-414e82146336@nvidia.com>
 <434a111c-7f1a-0018-6bd2-561cb382deea@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <434a111c-7f1a-0018-6bd2-561cb382deea@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|DM6PR12MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 5519375c-fda6-4ee9-c95d-08dad96d22c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noss11olN3YTe3NOE5EvuoGn96b+EPpUFPVLxc5wA56mttsBqdZlFxc1YIL6VXAivOxBvoyP+3yrzjss492sxRZsHgoTGyU2XJOGpY+rRzJMlyXeXdLOmsDTqs7K+xibqU0C50EzgZG+nKrpuO6WZv+BK9Wcr4qMeBKLT/SKdg0lBWvv+dmX+eU+QoqfXFU0Jm2WYTfX2fKmrLJOZcz1bbuzYVArqa+mfcFKU6TqDo2PiIYxtHdGcX3pv4jOTuJ1pBnXCA2/DUGeMoYQ7DswCau65/ou0wpj9LouNm6R+4gvmbbO++YX1d0iuPKgQq6+OgmdRFKLPGNNNS1UMv4g7PKVLqwfVg66Ta51DVgHHPD1K5XiMkzZeHFXn+bYsTXHFOf3xyaf1Y4HZ4gP/YAqecg6PlNhOHLAzrY5TcBU3GRktnjSKzgm9nYRdx7XF7h69YavshlMLIFx2aKHZJIGW8J8H0Wq3WBOFsByTFxTteXoqA9/XwT+FOgE3l1qPoE8YQ0ww0FBhqlBclwky8Y/FdoWMu2vFRQqkVHFnjYy2Rgt7DGquXISU0331Pvr8AOEDcOWXge9Ba38nFstYxoK4bOmJDeLyj1Wlk3Ikn6F1Q7D+1pYl7OPeIaWB/hDOJXXuinqJd1G4ZcrQegFdgjXFiXm9ZvCVrEvch7bpbhA6D5i/vaEk2SZvP6m+alsNcgsqZdzYh43d5V4swRMcrzrh6gMNvoX9zkQexdU9CNVzOvCXTvg+tgLmQL8tAXi8PKcvNmoyl/dUMWU5APsFo0ayj439JsetMZD+G/Ijgu7GhgYK6RczaneZP9iPrmovaMB
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(186003)(16576012)(316002)(478600001)(26005)(53546011)(110136005)(54906003)(4326008)(70586007)(70206006)(8676002)(2616005)(31686004)(966005)(336012)(5660300002)(47076005)(83380400001)(8936002)(426003)(2906002)(41300700001)(16526019)(36756003)(36860700001)(40460700003)(82740400003)(7636003)(356005)(82310400005)(31696002)(86362001)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 22:39:58.3030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5519375c-fda6-4ee9-c95d-08dad96d22c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 14:33, Sidhartha Kumar wrote:
> On 12/8/22 2:14 PM, John Hubbard wrote:
>> On 12/8/22 14:12, Sidhartha Kumar wrote:
>>> On 12/8/22 2:01 PM, John Hubbard wrote:
>>>> On 12/8/22 13:58, Sidhartha Kumar wrote:
>>>>> Thanks John, Mike, Matthew, and Muchun for the feedback.
>>>>>
>>>>> To summarize this discussion and outline the next version of this patch, the changes I'll make include:
>>>>>
>>>>> 1) change the name of folio_set_compound_order() to folio_set_order()
>>>>> 2) change the placement of this function from mm.h to mm/internal.h
>>>>> 3) folio_set_order() will set both _folio_order and _folio_nr_pages and handle the zero order case correctly.
>>>>> 4) remove the comment about hugetlb's specific use for zero orders
>>>>> 5) improve the style of folio_set_order() by removing ifdefs from inside the function to doing
>>>>>
>>>>> #ifdef CONFIG_64BIT
>>>>>   static inline void folio_set_order(struct folio *folio,
>>>>>                   unsigned int order)
>>>>>   {
>>>>>       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>>
>>>> Sounds good, except for this part: why is a function named
>>>> folio_set_order() BUG-ing on a non-large folio? The naming
>>>> is still wrong, perhaps?
>>>>
>>>
>>> This is because the _folio_nr_pages and _folio_order fields are part of the first tail page in the folio. folio_test_large returns if the folio is larger than one page which would be required for setting the fields.
>>
>> OK, but then as I said, the name is wrong. One can either:
>>
>> a) handle the non-large case, or
>>
>> b) rename the function to indicate that it only works on large folios.
>>
> 
> Discussed here[1], the BUG_ON line seemed more appropriate over
> 
> if (!folio_test_large(folio))
>      return;
> 
> as the misuse would not be silent. I think I would be against renaming the function as I don't see any large folio specific function names for other accessors of tail page fields. Would both the BUG_ON and return on non-large folio be included then?

Actually, if you want the "misuse to not be silent", today's guidelines
would point more toward WARN and return, instead of BUG, btw.

I don't think that a survey of existing names is really the final word on what
to name this. Names should be accurate, even if other names are less so. How
about something like:

     large_folio_set_order()

?

> 
> 
> [1]: https://lore.kernel.org/linux-mm/20221129225039.82257-1-sidhartha.kumar@oracle.com/T/#m98cf80bb21ae533b7385f2e363c602e2c9e2802d
>>
>> thanks,
> 
> 

thanks,
-- 
John Hubbard
NVIDIA
