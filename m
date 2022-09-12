Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937415B548A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiILGaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiILGaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:30:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB110FF0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN6KBzqT83KIeNGN5oYYSDZGdV//V58exCNZYGNu+RRY3M5V0J9QC4PC/Bhlbo/k3Aeae3rfkEn2YK1KYnt9tY4FgRLvybkMC76K8ccXLqNQHQZriIGBZNVuOC5Yr5cqzzz0pn0VqAwhZcW5LMYpCHKeHtV5DSIckEI9zT1k+rUrCKUefEeQv1DuRjhXLhhTXIAuDtt9V2ocnglFzn9oDxA6w7H6AxiF67ZW4HAa8hmcdM/uOzMaW04Ib1/KsHOdd11LOHGYFRCJMEoPBngrNu/JD7fVl+QGVyH7oo5pLDh2DL/nrWWOkEntB+RZYROxWLjFNlYrmWbxAx4VlGc0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4qTQQjyOum4civ6JjbRuMHNg7mRlXOMsayRhhcbhKM=;
 b=b+iWUZnqhf+Sc2g2pELXprcqkOpM65tH8G0TxO1lmZrD64T/70piICRxx1MCCj4Bo65SmN8xbruXqz6sUTDTd3vQkf1XCk+8IH540g6QmP+QBNsVI5BmadBoV4uLqmaiz5C4FPSVpIFul7aw7ZOevgYgB059/HgCZgTns6axpGovTr1LKUcmniXCcYZrIj9z8Wa6VDMj8czDQOqLkEJ9wLBWYI/1YnC2/H7sVsSIvYUe0NJgWfw8/mZl8nbkA4jr+HXo7tUi8cyLB7SGi1PpqBzqqzGuCwytuDkSpFCEuDLTwbNtMS3/3GrevLo6naZ39aLh7GDQNmDzufDZgD9Utg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4qTQQjyOum4civ6JjbRuMHNg7mRlXOMsayRhhcbhKM=;
 b=HfYxyjb39P9gW6SjMMJ9Cx3R8WoYDehs+4u7y14GsF6AwHb6xGEZJaR0jjCgBkyijLkEBsOBJctJElJiNS+/TH6t3CXwklTEYrqbUeOkzfJno2nX7fUU7hFebSgWKSfvRgwegd32rMoY1Eu8h3hFCN9JAFKHdsSc/n4UFHPbAhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 06:30:00 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::c534:ae1c:f7a1:1f33]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::c534:ae1c:f7a1:1f33%4]) with mapi id 15.20.5612.019; Mon, 12 Sep 2022
 06:30:00 +0000
Message-ID: <bc788935-f1f7-35ed-6c3f-ac22dd3d2214@amd.com>
Date:   Mon, 12 Sep 2022 11:59:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/5] sched/fair: Add exception for hints in load balancing
 path
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        peterz@infradead.org, linux-mm@kvack.org,
        vincent.guittot@linaro.org
References: <20220910105326.1797-1-kprateek.nayak@amd.com>
 <20220911080547.2709-1-hdanton@sina.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220911080547.2709-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::16) To SN1PR12MB2381.namprd12.prod.outlook.com
 (2603:10b6:802:2f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1c2e2c-0e9d-4b7d-a939-08da948837c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmvNgjo+ao+HSG4R81YPDka+CpKCyQT1y/qkKxRDoGDEdZ8+6o1E29DexRO+qtk7i5fSsJeDBclCOX5QY///T4i1UxbZGSpyNXWx3ibI7+Rnl6gbrfsYiPcYQVZ5PJSSPAgOmJB6bdE+BfSzkWA8JBkYu7HP+lrn/KYrQGmscQQyfG2xpy7emvfQv/x8XsIpCmzs4oLZEw1tSjhl+wlJBuXsYbC1DCc6+dD8i2QyQFJ3VG0FShLgwFlgixlAUmOzEcNhBnPhB2Ew3tnEYkgLRXG11AXTmRGv8EqM+Ft5fFOHVDEVi7wEPVYk7Vbsto4fn7RU07TRr8BtGCIz2fe4O95U+IUERHq0o2ilclc2SlGi/kEgcr0WhjmJo/zAQIHALuLEvJBkzk/xXqdd10SpQbjLQnIzk52IFXKfPAXSq9goiEjGjfUHvU4fiPC0yIsculBCOjOtzcMSgin1qPLAnIVgzhsQFuslVmM+XBxbdh5HmhxNarKhQCfW5zCJjFSxRh0R8lrpJeq7BU3my7qO+h1GHDNiTWGr2p+bi5i19vaqvo93EH9sk4sA/ZaEUIkGsXqGw1g6jzdtN19aDk2DwdJw014TS1dLlu74vlHHITB4RYIFCMljoihwhWiti6bYd0zAo+33wU/yrLo8HlQPxnse9hFGlYA8Te9gGOrdmi/imbHVd6YUfnkJIdAQgfNT+9FLtb8HAWogd0rQ/Yt7lkPP6FmLvVox7FC3MBNK1sdu14sthnGqnc1N3KEqLk15t9T3T1vVlfxjo2FObUTekgPa8WDPNBPpFc9Cnc6Jkh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(53546011)(6506007)(6666004)(6486002)(478600001)(6512007)(41300700001)(26005)(186003)(2616005)(5660300002)(8936002)(2906002)(6916009)(316002)(66476007)(66946007)(4326008)(38100700002)(66556008)(31686004)(86362001)(8676002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBhemxpSE54d3IyMEdLbE9FenhTS3NuTldrTnlPd3UwblFQbnh5WFhVV3FP?=
 =?utf-8?B?STNpSEpjRVF6Tm42Z014RktJdmVya2ZjQVBSQTBLdTF6QlUwWXhocjZVWGF4?=
 =?utf-8?B?SlMvRlkwcWcxNFVxTFg3ckxDcjYvU1RVaERocFJONUU4U2R1dTZkeU1SVHNU?=
 =?utf-8?B?NXFnMVdCYi9TRnFLK050Vk9mL012cEVFWjRwVDRVamZjSVNXRHlUd3l3U3pv?=
 =?utf-8?B?NzNPWndaTHhiYnRpTTlJTXFWUnlJazhBVjVLZUJycllOWUdyL0hOUm4vbzMw?=
 =?utf-8?B?bVJROGQ3dDJENUNOVGU5STJjaTlQSzhkZ0dPVjNkaWN4QUs4dUdjRitYOVNp?=
 =?utf-8?B?NUY5andLZEFlRytCTVM1TWk5bThCcTNwSXpaK2FjcytmQVlIWlZsOFJzL0h6?=
 =?utf-8?B?dGpBMHhRbjA3THJyNHhlZGhtbW9BYlN2dGxEcnRqVFVyRXI5aExEdEp4bW1y?=
 =?utf-8?B?ZGdaV0JzQTJYbEc1RThkY2pCeEExeVJkRzNQNi9GUU9VV1JxbGFtUEJuTzBa?=
 =?utf-8?B?dC9iMVc4Zk5aWXpoRmcrbzBkTW4rRkZtYUJxWVNvc1hLTldoZG81VDk2cUxy?=
 =?utf-8?B?NStSd0t2UUw4aGo1LzdSN1JFZHlSSlpUVzRQaVp6RDJ6bzZ6czJiMWlSNjkx?=
 =?utf-8?B?bU5HSDdQdDlGa2NxNnBOZDFpd2VLNzVTUEJTTm8zL2hJQWVlZE5Kck5nK200?=
 =?utf-8?B?bkg2YTMvZVZaVE53L1FKcFU5RVM0M0dZakljVTllbytLMy9CbndYNEJFbURT?=
 =?utf-8?B?KzVIbUduOUZiNnMvcDNtZXJENnAvYzBFV25zT01Lb3VSWkpQN0RBUlFQZExK?=
 =?utf-8?B?ekZOVElxanhZMnZrWm1yWGw1c0EzSnMxYUdUZ2xUbTc1WW9ZOXVPMm11RytM?=
 =?utf-8?B?Um9ZNW9LM1dNekwzc2NZUktyeVY5VE85NGx3cVpZVlZKL1lFYlIwMUpDeVNF?=
 =?utf-8?B?UmtycUJUNXd5ZWp6bFJvbUNCNldHS0doeGg2RGxndy9YWUtZblVVdXVPaURY?=
 =?utf-8?B?OWE5ZlBQOVR0aUdha29DdVoyMU10YlpmUWFvemZnMnB1WUNTVFVNT01mYWRu?=
 =?utf-8?B?Vy9oL3pKSVNBdE8wY0ZLUWdxT3VVNmF0emlnaGtzRFBROURNU0crZ0pJZkZT?=
 =?utf-8?B?a2pnVnduQ2lwSzZlZ1BNL3RiZFpucDJsVk5wZXJHeGp3VUhLUWF4Z21JMXNF?=
 =?utf-8?B?YkQ3TWRWWEplOHpXVTNHc1dRL1VIYzdRcmgzTHFiUWY2dkkwNFFEMVJ4MERl?=
 =?utf-8?B?U2JSbnZUTWx5SDVxUzR4KzBCRXpzUkgxdkxia3VZR1dlWHE2dzVlaG9wLzNN?=
 =?utf-8?B?enVIQkhZZDQ1bVBlWVhCcU5BbTg2MThCWjAxNXJ2MnVMZVlpdGYrSXJCVm4z?=
 =?utf-8?B?NjRzR25yWE9VSERDZ2xmYWQyclFmSFZvQTFTb1JHLytnWDNxbVU4Sml2T1JN?=
 =?utf-8?B?a3I1ZUt6bnVCajdlWkd5cC9weXdTNzJoVTVIckhicjJvMkkwOThqNkpSRHVh?=
 =?utf-8?B?YlBLd1c5WlVYUFFVWnF1ZkJrbktSNEk1RW1BNVM5Zk5Ld2hXYTI0cHpwaEhj?=
 =?utf-8?B?WVZ4LzJDdms3eVdISDkrcVRWeUMveHEwcCt6eVpUVWh4REJQaVUwMkdwZHB4?=
 =?utf-8?B?NVpKZ0M4S0k2OHA1V3A4bGdjWlMvUHhrZWg3YktkWTlGT1lrRzBzNU9kN29B?=
 =?utf-8?B?RS84YzFBb2Z1L25mWDhqYUx0dnFlcHNNUXQ2Yk9JVTZCSG1TR3l6Nm9vSDFL?=
 =?utf-8?B?K1hxdXA1dWIrQmlyU0ljZGQyN1NCT0RVUU9odkc1MnFrbUNkaVdCS0J2RUZs?=
 =?utf-8?B?TUM2Qkc5OEI4K0hydklCYnJrTHF2SnpPZXBWekFQUWJvbWtsNzd4TkJ6Q3Y1?=
 =?utf-8?B?ekQ4L3pteGZIeC9HZ0xGbnM3c2I5TUpCOTFHRTlMa1VaZ25DVmE5dHd6L01h?=
 =?utf-8?B?ckh5SzFXc0N2VFpUVmtGYUVYQ1U3Q0FvcUhvRUJ2RSt5S1lwaWlUTUhYTlIy?=
 =?utf-8?B?U3IvaWJEcHIrYU9DbEZPQTJhTEtOeXpnWi94VHk0RjY3bVFOcGhPZ05LV2c5?=
 =?utf-8?B?WjJtYUJYRW1zVStRb28rdVlJdFdqY2NqQWxxL2drK3RreUVzdGx1MVJ0dUN5?=
 =?utf-8?Q?4qsLiZjOuhjXEOyLD4MDfjSrI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1c2e2c-0e9d-4b7d-a939-08da948837c0
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 06:30:00.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cd4qI+5GAI5FeiFXwb49YibYbVkN7ZncvIz9r44M3ww3snvz0hGS1y1EoEykqebEXfJRFiEyKBjqrejYmkth6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hillf,

Thank you for looking into this patch.

On 9/11/2022 1:35 PM, Hillf Danton wrote:
> On 10 Sep 2022 16:23:26 +0530 K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>> - Load balancing considerations
>>
>> If we have more tasks than the CPUs in the MC Domain, ignore the hint
>> set by the user. This prevents losing the consolidation done at the
>> wakeup time.
> 
> It is waste of time to cure ten pains with a pill in five days a week.

This patch mainly tries to stop tasks with a wakeup hint being
pulled apart by the load-balancer and then end up moving back again
to the same LLC during subsequent wakeup leading to ping-ponging and
lot of wasted migrations.

This is not a complete solution in any form and was a stop-gap for
this experiment. I bet there are better alternatives to handle hints
in the load-balancing path.
I'm all ears any suggestions from the community :)

> 
>> @@ -7977,6 +7980,21 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>  		return 0;
>>  	}
>>  
>> +	/*
>> +	 * Hints are followed only if the MC Domain is still ideal
>> +	 * for the task.
>> +	 */
>> +	if (!env->ignore_hint) {
>> +		/*
>> +		 * Only consider the hints from the wakeup path to maintain
>> +		 * data locality.
>> +		 */
>> +		if (READ_ONCE(p->hint) &
>> +		    (PR_SCHED_HINT_WAKE_AFFINE | PR_SCHED_HINT_WAKE_HOLD))
>> +			return 0;
>> +	}
> 
> The wake hints are not honored during lb without PR_SCHED_HINT_IGNORE_LB set
> then the scheduler works as you hint.

Are you suggesting we leave it to the user, to control whether the
load-balancer can spread the task apart, even if hints are set,
via another userspace hint "PR_SCHED_HINT_IGNORE_LB"?

I had not considered it before but it may benefit some workloads.
Again, this API is not the final API in any form but we can have
a knob as you suggested that can be set for a class of workloads
which may benefit from this behavior.

> 
> Hillf

--
Thanks and Regards,
Prateek
