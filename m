Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98D6489E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLIVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:10:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDA1B3D9C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:10:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwxY3TswXJWvTvU+SpfErwUtAVxzzV2LcANqn4Fn3AlXVCTLUfI5+4YMOwerGwXb5RtAhWi3xImdpV3CfbS3mLQQ/TEmO8JtuFicuXW+Bz19jye1IrmmQACOFBw9CR8eiMZUiMQktf1eGsqy3+RP4xsCy5wdW/qkQe3SRRy4RHPScATtirKBPXIqVJmI5P1tEGSG/Kt5y/7cxxBAUmD1/Y8x8aKKCOvD8gmX5ibhqgxqoVj3XitHWE2cT4DpNoA/fDG6+anCShff+zjGQIu1XlYsQCBQCXpodswizfRnRoCLSu57sGIWB/upR91036Cfl5ha74Z/62RKPpSL/txwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qReRSVj/EU8+s5vB7t+1cEk0+rTE8B+f/91nCL3c0rs=;
 b=lza3ftidXLr7JRiK3MdscbjNQOtw5wPj3YcvS1TzY7ybONGeKeT1Pc7y6scwgYoNTGzkjgcTDWZ30hNr8Ogq1HDLk+ycITZlVKTCO5QGYlPfM2rng/ipExJdE8AieqhUCt6/B6e5Z6XsBBqJBfs8G+6GiZ2OR3b7RZruBa/5uYoo6GWh20OguXHoahziz11MiX4PoGPSTEs5MyaK2TEIEAeFxy2/6SL2vVzYSiHeqfP3NtCpTJ9KFYOFVWuDunajiWZYury01dHR48Z7IWVKW5R0XPYZI1TsNIs82vaR04WXj9x5/MzJnI7AJ/LoFiqbYhMXyJO4lh2/IhRY8vKXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qReRSVj/EU8+s5vB7t+1cEk0+rTE8B+f/91nCL3c0rs=;
 b=ZaPmPbKR+4nytA0Q0Ib4yGGna51tjLuAPIGW9Fo5WIIZ+WdHyABLzmYB3hApYmFS7OqTechTz7wwzOI5r7KmhBDQEk4WrJ/hforgTejJHOGlxY+AOnLaNQ5MEZK7Gnf42uIL5GqV3o7OOh+DQWYPIBlODQj+G1t6is4SsrswNM1IDVrvzkaaJ05DoZPRUe5cLoU8+RsPom6IRX/ytloCA/Q0XZdqwOhhDq0vgg2I39VwdPrdNprTXW+4bXAQECaKst87m6ybZl0YQjoJgidakvwpQyK6lzS0DW10jmMUyQbTHH6ZhKU/9ugpzdHzdECHQxSCtroQFc/swIUM0rSRzQ==
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 21:10:54 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::8) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.6 via Frontend
 Transport; Fri, 9 Dec 2022 21:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 21:10:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 13:10:46 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 13:10:46 -0800
Message-ID: <f4909342-eaca-8c55-ad95-359ab7a5e6db@nvidia.com>
Date:   Fri, 9 Dec 2022 13:10:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
CC:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>, <tsahu@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
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
 <7d72778e-7305-18e9-edf4-ed55a98aa7e2@nvidia.com>
 <00222280-DBDD-49A3-92A5-05112359AE30@linux.dev>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <00222280-DBDD-49A3-92A5-05112359AE30@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: aa91f9c5-f5de-4998-bddc-08dada29db81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T74PkDPFfckUCoa1rN+ECR6NQl7e3E/OWfvvIP2aCCm7Ss/p1QlyeSDH+OK32UDrPrHiJUFNBW3V9DhaP60v0QItYU4FQNQbx2OferUeNPntv4f065qgZzPUgoX45vgcGoPrSPfoNuTK7sFKCBF2xP0NdHFegkv71WtJoVXCCUCKnHWuz9E5czkf22luQW0+MtCOWIJbQFJr/IjjFswyqiuFa5kpy3YhWvUA1R1CllMiz9R2uePDPcbCYbm/2qQ5WQTLF7M3hqbNAZa6pZf8m+x3tiU/zaJdINLPw3RQTU0o769AvOequ8oCTfgnYnmSCbNNdHhCF7ClcWC53YPBEw9y3P/Tfhcxr6ZM8kj/Pd6l/7d0uO5mOxhuaAXAdbTwVPs6I/dmoHNdPeSdi2YphqI7T8oPNRoCvYkfW08xhxEZgbVrvtLUEk3XgEyfc1mIkcZnk8TKV8klpeMIbFJOhsWzbbF4ZA1PdSXfKe8kBasMc402nwDoPOFS47akI+JOWUYZdiANNeKZ+asBD3p34/8F40zpUc/jSNDwMyJe8/ZBbsVcViv2fQOjMXiM8Q7CZVw3Vy3zKKwH2LFehQDzdZjR6Qtmeb8U7m50RmePriDwzdakLeeYq2tPoR5pCB8t2rkLtXz3pXAwfaF3FqcD69WX1YMUutQUxrOvucVGM1gZ6/9/KiD5VuG0MBPPENccUtDIvmIIQ7cwGjWkpLMPG7AY9qpnyDs9o4YbOrTiiTQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(426003)(47076005)(8676002)(8936002)(70206006)(70586007)(82310400005)(4326008)(36756003)(41300700001)(36860700001)(83380400001)(478600001)(186003)(26005)(356005)(7636003)(53546011)(82740400003)(16526019)(336012)(40480700001)(40460700003)(2616005)(316002)(6916009)(54906003)(16576012)(31696002)(86362001)(2906002)(31686004)(5660300002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 21:10:53.6167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa91f9c5-f5de-4998-bddc-08dada29db81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 06:27, Muchun Song wrote:
>  From you advise, I think we can remove VM_BUG_ON and handle non-zero
> order page, something like:

Yes, and thanks for summarizing all the individual feedback into a
proposed solution.

If we go this route, then I'd suggest a little note above the function,
such as:

/*
  * For non-large folios, this will have no effect, other than possibly
  * generating a warning, if the caller attempts to set a non-zero folio order
  * for a non-large folio.
  */

> static inline void folio_set_order(struct folio *folio,
> 		                   unsigned int order)
> {
> 	if (!folio_test_large(folio)) {
> 		WARN_ON(order);

Better make that a WARN_ON_ONCE(), to avoid taking the machine down
with excessive warnings in the log.

> 		return;
> 	}
> 
> 	folio->_folio_order = order;
> #ifdef CONFIG_64BIT
> 	folio->_folio_nr_pages = order ? 1U << order : 0;
> #endif
> }
> 
> In this case,
> 
>    1) we can handle both non-zero and zero (folio_order() works as well
>       for this case) order page.
>    2) it can prevent OOB for non-large folio and warn unexpected users.
>    3) Do not BUG.
>    4) No need to rename folio_set_order.
> 
> What do you think?

If the new behavior is OK with everyone, it seems good to me.

thanks,
-- 
John Hubbard
NVIDIA
