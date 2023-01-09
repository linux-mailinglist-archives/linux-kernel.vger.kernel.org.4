Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7601F6630E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbjAIUCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjAIUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:02:08 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3C6C00
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luB2wgl2VPk1+uJ1Dp1N/QirJALcy6WrkOTiix/5aFM2l49ZPnTYe2TpdxxfqEEnVRSMWScNHhE6YQhPP3a7WZuZp11BVpRg+Ky54L9raorVLLqJgIBh0xnm7R2cMFFVsSGlVhN43qBsKJ+cifhOHqikEAAV0+VbQmzY32lhPgJfU90eYoFw2UvD0E7XUNNu8TWhSVWDw7lK7K55s7sLIeNTmGUhltleQFWHpxFOlWuzyr1ESW9qjxeOI2HEOQfmjTgXc2/xRFhM7hAqzVRljvSON4szh3bn0IjazQNTb2PrWVgCEycH2tuYqZayAL6imEhEW5vjnE/1mB4Dbmvp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eua6IuiQN9ebrh7DxAte4XVPL1CdeGvpKwPACydzqkk=;
 b=WDzo3nGa7rv7ZN6+R3o7gLbaDi88YPiqwooG9S8sGj+eMsKPhPxMp5m2zrTBur1h5q+BcgdUyAkalA2KWCLvSCtM4HbWOooGjunKfCDsx6g0ixZLNubxxKlLAg4FCbd3CeN3mKcKtpJLoGio73rR03Jazyt8cGUt5qDQ0Qb7QcVX3aZkYgYLzCs3jgdPvxoDrBO6Se1k2vhpFi+TYYXlze5I3d6byhlPYfvG3hiDmrEADtykOUSOEMOkPDfZ4HlzsM0CwInH23FYzCRMSOLBqUn/I1xqlX57PeW4vSOPn/kciLS8f/XSEITAo/t2A6cQjAuug2UiTFqK2vS7hPNRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eua6IuiQN9ebrh7DxAte4XVPL1CdeGvpKwPACydzqkk=;
 b=GKPjc7oiFNF0g4CiTKsk+V4EnH68ad6JR0IeQvFBwVGqZhXbT+WbvxqIR73loLwDnLSiZVIGiwefVWbcoU8EecXQM70rl8ELWnqUKDyBgVTUlwPC6cEfy0Yna7BC2Gnh1/+bpNP/LTuhDk/EZQZhhL1cLbipftLdUJpzuZb7R0E+//vaEh9uxXFL++6zcGTCI6eJ1fjnIZSZUXJPMzkRUWUX2HR++elMkE+xuysmvvtUozP9p4SmlQewfO/wv7cSXsASzEFTS2F+ZFjl8aCytx1T481xfEwr3uNHE2NuTzQWI3p0qeQf7DL9kldov2tPVrncPkmOCSHJ6oaBFoPVGw==
Received: from MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 20:02:04 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::14) by MW4PR03CA0235.outlook.office365.com
 (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 20:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 20:02:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 12:01:46 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 12:01:46 -0800
Message-ID: <153c451a-029f-ef03-7a57-7ff0394ac3d8@nvidia.com>
Date:   Mon, 9 Jan 2023 12:01:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH mm-unstable 8/8] mm/hugetlb: convert demote_free_huge_page
 to folios
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <tsahu@linux.ibm.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-9-sidhartha.kumar@oracle.com>
 <Y7jGyH9Atv3sPjcZ@monkey> <Y7jLVJ9kvBFCUhNd@casper.infradead.org>
 <Y7ncSXYzCmjzmS87@monkey> <0b711878-71b0-4a4b-4f0b-af157d6cac42@oracle.com>
 <Y7xbsnYSM687X8pF@monkey>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y7xbsnYSM687X8pF@monkey>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b21ad05-c5e7-4224-173c-08daf27c6076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6R57fEAWkPh8sJoCKUm9M6NEplX/8Il4ZBnDdkgJktE17qvBOUwn+TvWC9BrbubNOuXHes361R2BTxa519PyAoIxz2CumNNg6XB8XlEPKz1FqEKZtWNMv1JHxM3P2M24UOAh6oAOSH9TfzyZMiocFZ81lRSpdIz7nFBmrrjOOFCJEeFGLVJIKn4+qY+2oEJzOj2A9eJ+NW86akI2cirKgNxhRDbZPRT8sIdEQVnRT8dwQio3R2H/cqUCxS2N3341L7BZO3b1DKp38B2fIvseGZS2lom4lMNK/mfNMo0TLXDYnTi4/hz/bVwb1bDf4929u/sjpF0Q3bepvi+ZdyDlOlDvBwDEvkEdd6TN7cE6qpub4yKa1McbLYQ40QPCq/rSJWuDFkJvJqPduEOOeInacEAUnHVx0T4hFsJsiKvOMmW4FgaKcYrNrxpSr0yfMVv7lYii+Xycr1ffPAhjddZwMH5yMOP1tNBgx1DVLa0Tp8qirrYXmlqys/sR7TV3wQVldugtNtoAgO3JI1gC3Vyis07/gX+RsV+tNNu+/fh2gCgBrgiVs8Un+H0FO57f5g/aJhOZuay7fsC7mmgdGEJ2I4hYPs5YtHjqvQrJobfsgF1q2aEkc0lfS6SJnam4aUgNM4uq72iv50HzOm1qJDJhoD1chr+eIVWD3qqxMm/igD1pbePWPdmykYTsFXnEU/BPaL3oJb9QwfyEldEdZCfVCvyhc8pImqBHK7CXi7VLtwr2ToGDi8A7votcE5Y7hz+CG2jbE+H7MBO2KWH8/1BzIQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(31686004)(2906002)(5660300002)(8936002)(53546011)(186003)(16526019)(36860700001)(31696002)(40460700003)(41300700001)(36756003)(26005)(40480700001)(356005)(4326008)(70586007)(8676002)(70206006)(86362001)(7636003)(82740400003)(2616005)(83380400001)(478600001)(336012)(316002)(16576012)(110136005)(426003)(47076005)(82310400005)(54906003)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:02:03.3627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b21ad05-c5e7-4224-173c-08daf27c6076
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 10:23, Mike Kravetz wrote:
>>>>> No problems with the code, but I am not in love with the name subfolio.
>>>>> I know it is patterned after 'subpage'.  For better or worse, the term
>>>>> subpage is used throughout the kernel.  This would be the first usage of
>>>>> the term 'subfolio'.
>>>>>
>>>>> Matthew do you have any comments on the naming?  It is local to hugetlb,
>>>>> but I would hate to see use of the term subfolio based on its introduction
>>>>> here.
>>>>
>>>> I'm really not a fan of it either.  I intended to dive into this patch
>>>> and understand the function it's modifying, in the hopes of suggesting
>>>> a better name and/or method.
>>>
>>> At a high level, this routine is splitting a very large folio (1G for
>>> example) into multiple large folios of a smaller size (512 2M folios for
>>> example).  The loop is iterating through the very large folio at
>>> increments of the smaller large folio.  subfolio (previously subpage) is
>>> used to point to the smaller large folio within the loop.
>>>
>> If folio does not need to be part of the variable name, how about something
>> like 'demote_target'? The prep call inside the loop would then look like:
>>
>> prep_new_hugetlb_folio(target_hstate, demote_target, nid);
>>
>> so it is still clear that demote_target is a folio. A more concise version
>> could also be 'demote_dst' but that seems more ambiguous than target.
> 
> I am OK with that naming.  Primary concern was the introduction of the
> term subfolio.

How about one of these:

     smaller_folio
     inner_folio

Those are more self-explanatory, while still avoiding "subfolio".

thanks,
-- 
John Hubbard
NVIDIA
