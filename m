Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3F71FDA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjFBJWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbjFBJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:22:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D818D;
        Fri,  2 Jun 2023 02:20:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGv9JACjypeQo4ma3PZaGyuGns48z7qeHsFWTV2ySiQm1tq3ee8dhjb98Wu33LGKxxoROJKz1O6xJ2r5Qw4qy6XqAeSnBOkCg5Px/zTPxFGIOACxQbIlL+AhsSIl6HnFW2zBnRhmSPyJXmL3+trMXfpOQPEUAVSfoRpgZMos4UB3HjxgxroP99FUHZRvlxQu77XYGgChNfuBx14kAI8yBGozljgpVa1ZhL1LF4F78aciWPEHQNG9ZwJUJxUm1v+7lhYxDACWMwEJoVcvRZdeIl1vaSsqqGnz+yQ9pIFGpL8C1X8/O2kEGGyZleRMeCyCAjMeuFHaND7foTauv6bIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R88IspOr4eaHIRYKxaCHdLZUMFmAHWJWLHEd1TrtsnU=;
 b=Jn6kKzJPRyjCaF6yUKyY9mVCDPKvnpV3C6/HcWewVRPBeHFaHgXiHeXa1WBIevl8cRSEr6uUhsffqbUQh4t23eG6tsOa5K4VhIRUKDdXDqvgLCZl+dsKBs91GJTy+/B6RLCEJqVJj4OspAriCWEJlRDLnxtZZrw+b2tFlvrax6/j0DYV1dAuBnQkcAnR67x1oiu8/Mkoo65bhRBF+GOKkcIGGsdY++jSISJbMLPFDxaM4KRB/67AGW05EFsP0qPowYM70cm7udC9a71VmjE19uDVKiTdDCx7w331j9yKwCwEJP9MgWOTDDKiTK92TwpDfqne5Ox+Dd1JpKas71B8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R88IspOr4eaHIRYKxaCHdLZUMFmAHWJWLHEd1TrtsnU=;
 b=dIOyv9KhkAs3yucQvWG4EfUpyDouyGfhi+VFPNp+hY1LdpifhMMMifD5k4qRX2DHLYwsmkZGRFZljDKLSI5ZrecvB6gA/Xg2s1GyJtpJoBhk/KLJWQ+dabdf4IrPZ/IfUO365HnZ5XwjoTPxcd470lv7eZ9GL7/XH7qjk4a3kAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 09:20:05 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 09:20:05 +0000
Message-ID: <8b8b3b52-be6b-3978-4a4c-b72323cf2bd8@amd.com>
Date:   Fri, 2 Jun 2023 14:49:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230602065438.GB620383@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 6842006d-9881-46aa-c7cf-08db634a8d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWSezlL63Xbnb0zwXOvSAlEPXbBPBQw4TcxfmAcapQzthbIGh8Uho8pI5E2NZRbe8oxL6GIhE8n9eL0Z8PSLG/KFAhWEd3+Lh61H0GvjUGVqaif2QNmSMkvmt3EoccTO0COLtFci1YNXb6qaBzfptEsdc5McBAnR5zlUryQFffcfpy9+q5po6kJoSTyEQHhn8eP+h4uPGzaqQkjefTvLS7ECw/5OR7F2VLhD6igpMSP6Omu6zeT3Vnj/9uLIjmMWVOiSVjaRB7ekCi1jB9zGvge1E7f2lH13SfwJ9+3YJ4KWHwOPzNenCrXpWJ0FJBtUNyF4rsXh4Vv7TQE9pPgS5cYkKUyLav/jykCuW7hlZsHXap9aRnEIs+o0q+/id4uGsTJ+WinqwRCNvA/9kDYtFkU4ZpL3b/7kzFxQroJNNbEM90TXSCswuoqobx8LeIZY23RC9grJLIhvySfbGh+HZrCNpgf/qtJbUJKAJz5Nb7IzbRtLmHC4qDaPtzhMOTyN6pyQ9K+cm8JdyQFcOyUW+UpEuEwqdDbzhcXhDrjo4ADWbsaHjX6gYGNO0bAhmXDoEczwVU8o39HCISVLeqp0/dD8jAYq0TTnIcx5Nk5dPFPdUV6Obv+/0CUIx2sqeP1IqbcNRPbHJ5ONmZzTHn7WiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(66946007)(2616005)(83380400001)(186003)(66556008)(4326008)(6916009)(66476007)(6486002)(316002)(478600001)(6666004)(54906003)(8676002)(2906002)(6512007)(6506007)(53546011)(5660300002)(26005)(8936002)(41300700001)(38100700002)(36756003)(31696002)(86362001)(66899021)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2hSMEo0Y05UZEcwdWJ5Wlc3dlBsemtsZFBWeEpUZ2hGamxsdzNMOUxpRVZD?=
 =?utf-8?B?aVpsSlhoWWZrRlFPTnV3em53TWp5YzhlR2o1RWRFWHhvb0ZGWWhseXNOS3VE?=
 =?utf-8?B?Tk5UbzkzVk03RHUzRklST092RW93amhrR0s2dVRIS2I3RHZXQ1VBYVJLZ1Bk?=
 =?utf-8?B?V2h5N3BvWk4wTkowU1FvZVIrdnl5RjF5ZWJwSmxNbFdDS0RlbU1wNU9uVXNX?=
 =?utf-8?B?TWt1VGtGSWI1RDRXdUZKaEtmbDltMGlTQ0RJRkhyZnR0V0VnR3VBbDJKSmxi?=
 =?utf-8?B?MGJoYmRLYjdvWlI1ekRRY05qZ0lRbHpKVXpObXBWdDAxSmVOeENQTU16MGZP?=
 =?utf-8?B?T2diWXlzc2haWmsvNkxsQllXQUNjU1BjTWV0NS82cXIvTVpUelNxNjBjTHFx?=
 =?utf-8?B?MmIyWlpNVXA4VndseVNvRXZoY2JaeFhhZlI3SWJrWWRMVi92aDZ4cHVwSCtn?=
 =?utf-8?B?RGNzeERSVG1hY1Z6T25QblZPQnpyMkc2bnJVL0ZOTkFJT25JWHUxTThReGpQ?=
 =?utf-8?B?NHczNDJJeGVCbGxIWFQ3Z0VheHd6Mk1qZVBpejBqR1dERjhBSjFRU0RKVzlY?=
 =?utf-8?B?clE1QnBpaTl6NlB0UUk5TWVsQTMvUHFDRjAwQUxpclJUaENLRzh0VHQrVDFP?=
 =?utf-8?B?V2x1YTU1RXBGTzRtRmN1aHloT1lsMEpWbGlBWEVwaFc0MG5FbmlrdEFoajNv?=
 =?utf-8?B?ZGIrQ084TXdGZ0V5RWl6OTZzYzRxTGNXNGhQeDF4VTZEUjZKVmQvNm5lODZn?=
 =?utf-8?B?akJqRlR2Rjd0a3JLSTh2Qm9OdjJRR3Z3N2xqTUIyWEh0VDFFRVNUaCt1NS8x?=
 =?utf-8?B?djlxOHhSTnVram9kenAydWkxaVBIcEp1Tmh5Zk9DcENSTVZ0NnJPb1h3UFhX?=
 =?utf-8?B?NHNUL1lNaEhLSjFzTXNrcFVzbVNJcS9hODRjYmNlS0hEejBpV2ZIYWxDNVF1?=
 =?utf-8?B?amVsbkpLMGNFMFVwc0tQOURJNjNjNW94bmtVTzY3M1I2eW9pZlJUWG9kRWFP?=
 =?utf-8?B?Z2NPS3RUZlNWSGlhZUpXUHBKcUFLNGJNWmtjcTM5YWJOa0xweTFYbEhldnBQ?=
 =?utf-8?B?WEpPYXZHbi9IYXlpeFRmdEI5NWtTdHlyVUNJTXE3bFNYRUpEc2pVaW5FN0JQ?=
 =?utf-8?B?bGRySGhndTVsOGFSYm1BWWtVSEpITGdDbThhV0RTMVFsREtITmtzZlhVQ2k0?=
 =?utf-8?B?L0o5Ym5yemhGOWxtdlN0eDQ1MVlsZ00vbzlRbUVyWHA1a1R3TXdrNVBmci9x?=
 =?utf-8?B?VFFWTXNCRk4rMVZhTVMwKytvV3RPVXdWNmhON0VsY0FVSTA0dEtwSzJ4dW5U?=
 =?utf-8?B?TTcyTGhwSVFSRnRMcytKajBHOVFNc0djM0h5bGpxRE5UNktadHhIZmpaV3NK?=
 =?utf-8?B?N2lTQlgrRFJva05mS1BlOWFwbGxxRHpqTHBjeDA4MlRiYzZOQ1JNRk9mUk9K?=
 =?utf-8?B?R0dzcVhEOFRwSVk5S3grRFdOU3NBZE9GSVUyU2pTUG9kQ2M1NFZhOCs3eW4x?=
 =?utf-8?B?SDlhNVA1V3FyT09jOEpwejgzd2tFWDVVeE80NFFuamRJU3F0ZHYrMmJ6S3Nx?=
 =?utf-8?B?UW85aDkxSlJBMEwzeFlQYzZ4aUliM0VZWWREY2FDV21lZElaRXF2TDdKUDZh?=
 =?utf-8?B?ZGxsb0tBSmpZbDdrbW5sa3ZtZXcrSmZSc1BSSHZJMlVIZlRLMjNmcHN5anpF?=
 =?utf-8?B?OENIbll1VGJXUHlSVXNyM1Z4amlwbm9weWpNUWFGYW5nMDdkcUc5aUxCSEZR?=
 =?utf-8?B?NVdlaTk0aTRtS3Y0amFsWVhTM1hQNmdyRVVDSDk3bWV5dUFjbEdqY2JCUEdz?=
 =?utf-8?B?TGQ1NGdxc0FkRGt5YVpjZWdHMUJzcVlKYnZFTEllbVJ1bFFIOXR3WWEvc3lt?=
 =?utf-8?B?V05JVXVCUlNpQWRzazlrTlVUU1UxVFQyRFVmcENhZlJRT2dtaVpOUWVmWTRW?=
 =?utf-8?B?a2hyQ1NGMW1ncUI0R2JDUzVDaDRjaWdiR2d3ZCtuMWY0SHhqTmpla0ltWlpR?=
 =?utf-8?B?U0xVR0xNMldqUWo5Vkh5ZGc3Q01lWVlFZ0FGODhOc1JMd090T1pNcFdpekFn?=
 =?utf-8?B?RzdpQlFadE5mWlBCQmdnOE1MdFFSUmhVd0FnWXFRSUl1VytXc1g0enRYS2NG?=
 =?utf-8?Q?XqQVIfUD6Vs5H9URZB6beOpUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6842006d-9881-46aa-c7cf-08db634a8d28
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 09:20:05.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt1WK1WFGOn9mFT4lyaTbvP//3AY9pwXM3++pnxAlV7adraG0dd2OyTKgr1b5QA/6Jku0K+vlXnAdaxIYSg1kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On 6/2/2023 12:24 PM, Peter Zijlstra wrote:
> On Fri, Jun 02, 2023 at 10:43:37AM +0530, K Prateek Nayak wrote:
>> Grouping near-CCX for the offerings that do not have 2CCX per CCD will
>> prevent degenration and limit the search scope yes. Here is what I'll
>> do, let me check if limiting search scope helps first, and then start
>> fiddling with the topology. How does that sound?
> 
> So my preference would be the topology based solution,

I agree that is much cleaner but workloads rarely like clean solutions
nowadays :)

> since the search
> limit is random magic numbers that happen to work for 'your' machine but
> who knows what it'll do for some other poor architecture that happens to
> trip this.
> 
> That said; verifying the limit helps at all is of course a good start,
> because if it doesn't then the topology thing will likely also not help
> much.

Queued some tests on NPS2/4, and also with the "nr = 4" heuristic.
I'll share the results once they finish.
--
Thanks and Regards,
Prateek
