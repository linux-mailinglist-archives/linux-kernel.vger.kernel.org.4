Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3DF64784F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLHVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLHVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:54:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1104F82FB1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:54:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewahpb1KX3A/otNrMXqilQ9jVYvxV8xIcIMmDFYMIs+gqYkvGSjDI56HawDZq5SixoDev9O6Rjm8LQ1x0qjUuNcT1Bxa/u9fEmU96zeDSvyoRE/y7YPmrAHJ4zvqUmg5T4Sgo34zWodNXy5/eAGRSaRN79JVy68MLUO9D5p+8NWq9lS64ndaSMFdB+qRewJt3Po/WJshmfDAMSPi4jSiVDERTX01t52T/II2wrNlhZCayvyZk9dbPhnmBPYHauVOJwMQ+e20fc4glxEONc3jj0fHnflaYVpl13OIThz3/QD1vfThawDTgHjibOeigFN/7Rnizgm7hTF6YgoHxMmEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6S9JaNoTKqOviTULGQZV9H5QTk8kTXhkDersZvB4o4=;
 b=fChgq6uL2Al5pND/Q8pqqiwQKEFGiAQR9NK2x8ygWO4FfQmRrYUlA2ttU/a70uleFLQnBMlnCQJboRBrDezR8TgFqxs9Chb+a4uQsJHrloK3UqNrDEvSkiK6TIgyBnb9Ph4n7NxOLx4SW/c3hA6XM8grOfFutvrWaAojBtMQegGic68u9fThMaFmPa59pjEfVJ6a2IaXvdGAMT26j/fZeqInvaMXPmL9emsxIWABEsrTQy7D6ukN67D7xQMG9LNYXTbff77fgKar5kMMV12v/nAuNQuJPLfR36vKh9ITLhWUqiseU83aXQ88UGfID+Sy5XTMKzG80HTosONzHPc+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6S9JaNoTKqOviTULGQZV9H5QTk8kTXhkDersZvB4o4=;
 b=PgN1MX0XREDVLoUC2vSHXXj3cXojDuDjORBLF/2UvyMWcu7xAnyOADfcUBHDn4pX/SpB3t5T1aGQyoq9EGo3oVqHg0w+pN67xrfcM0TBzmxp7F8ZuQAH7EggmybgXng0emH3Os8fbZJAyIzOahJBSfV58aI7LvFjEXDnGEl5pakIfgkeOBBPY2mmonmrvsKND4QD7yALMbpxAG9Qvzp7BH/HZRwLcco5pxSM+hlL5tl0FTdgPej4iikOjxEwwv474cDcmLmEbJC3Cdjx1dET5UcUFEnAk4RiopOiKMAnVhjFPMDSvKg0yLktxNdZUmcTyOU0zZGJ8Hs0J7ENg1VyLw==
Received: from BY5PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:180::45)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 21:54:49 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::cf) by BY5PR13CA0032.outlook.office365.com
 (2603:10b6:a03:180::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.5 via Frontend
 Transport; Thu, 8 Dec 2022 21:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Thu, 8 Dec 2022 21:54:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 13:54:28 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 13:54:27 -0800
Message-ID: <61751d01-2ba4-efc0-9cb8-eeeb3d70908d@nvidia.com>
Date:   Thu, 8 Dec 2022 13:54:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk()
 is safe to walk
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203158.651092-1-peterx@redhat.com>
 <6a970de6-e3da-f57d-14fd-55f65ddcb27d@nvidia.com> <Y5JRhU+9QqoUuSdR@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y5JRhU+9QqoUuSdR@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|CH0PR12MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3f4c6a-b149-457b-d109-08dad966d3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkmJJNAy7URdGWOw4k1RF+H4x2oppkiVo6FpQlH15Ls5vZkGIslsdsx6YjQnybGMNDDK406myjz4V19vU+gNVCKeNoQTUQVaguuE7jTQUiDKUqSD5+w5PQdEkUza7D5pgLvepY0fgSscqYPJWfgbhrm1uJfOE+5LDAHSVRFx7RvmJvRzD4SVnT4B6P0AXhvGlC+femkMMszry9npBGQDr1GufBkK5R2e4xGcxi3YMwds53vesGsaYS2jpNfGDb0DDRBB2S7Yp8QI0Rc9wS8mN+ycgEcYTQtW+Xd0n9bnogn6zasJGDbeHHkvn5liGSNC+6ltKrxQJkwgZTSc5cnvaFH1reBc6BBSUNadSkHPU9/VSxu9e3kAUKqOpSv1W8qfdiZpELiAm7MM5EEqtrxIdCdR5ulBwkx20TAlRkky4qXwFIp1VTpzZinmq6Ubb40hyqplJV/ZXtxJ+UGC/9mNvFhiFWItdKsbRQsJ+8Bkp7E8KVNom6OgtKxFzOqloqL99+skfekKkA1YWyZV3kZKT3pu1QnZ19jBnFX8auDep/fkjnk54HvGZ/b26KBEfpqzXztNGZVl9Df8PmiOGiUq6qmVJl94dR2FXnB4k+IIYBd5sDjyzPVZOx6TqUDqyEoxmDP0pxksNyLSOJs5oSfL1Vnp8F1iuKm/80CIvN3mUWD5yyonZKAYyiEruW9NjApopUO1uv7EfPTCygV4BtUWJlBWvFcLX01l2MF+B0+2bkM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(31686004)(86362001)(336012)(16526019)(83380400001)(2616005)(40480700001)(40460700003)(36756003)(31696002)(2906002)(5660300002)(8936002)(7636003)(41300700001)(316002)(7416002)(16576012)(70586007)(4326008)(70206006)(356005)(8676002)(54906003)(6916009)(47076005)(426003)(82310400005)(82740400003)(53546011)(478600001)(26005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 21:54:48.6124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3f4c6a-b149-457b-d109-08dad966d3ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 13:05, Peter Xu wrote:
>>> +		/*
>>> +		 * NOTE: we don't need explicit lock here to walk the
>>> +		 * hugetlb pgtable because either (1) potential callers of
>>> +		 * hugetlb pvmw currently holds i_mmap_rwsem, or (2) the
>>> +		 * caller will not walk a hugetlb vma (e.g. ksm or uprobe).
>>> +		 * When one day this rule breaks, one will get a warning
>>> +		 * in hugetlb_walk(), and then we'll figure out what to do.
>>> +		 */
>>
>> Confused. Is this documentation actually intended to refer to hugetlb_walk()
>> itself, or just this call site? If the former, then let's move it over
>> to be right before hugetlb_walk().
> 
> It is for this specific code path not hugetlb_walk().
> 
> The "holds i_mmap_rwsem" here is a true statement (not requirement) because
> PVMW rmap walkers always have that.  That satisfies with hugetlb_walk()
> requirements already even without holding the vma lock.
> 

It's really hard to understand. Do you have a few extra words to explain it?
I can help with actual comment wording perhaps, but I am still a bit in
the dark as to the actual meaning. :)

thanks,
-- 
John Hubbard
NVIDIA
