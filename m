Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE9262DCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbiKQNi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiKQNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:38:57 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61F10062
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:38:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjPbMXishNk5Jc9wkQ6nNYYGC74BzoZtNrbbyAIR5P0WM014G+AD/u/KWGRDDzOhJGyTCWzs6ZVmMNB0li75uZAcbrDBAwXMuuxjdzQKohFNhktnoneXUHJQGtbzJpdLGtxigHIIYu07yZTV39semUdmcmBbhzKCnQFkmBo0+RRElAnkzc4NYl7cc/Vbt13h/Vf+LERe+ussfgPnbFv3UNdrubtXpj+T3NAwkiSJwClIPLTgglI5IsNDGYHLdhCTiT2ZIA7Qr1uOtIt2poRlxlS+HP61cXHpW154US2VopGzm228pGNNBl9URBrLBeHJI/zeCq3q4+rnQHI9EOd37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaP9t1KaaPvnXF2iSnaS+ai3iVGUs35lS4WArEr24R0=;
 b=OkraTz+lWsL3HlElLFvvz4R4p4if5YvNy3x9h89HECViAokFXsVkTjZyCgKiSM0FYljrSkky+kByp/FnJMlwjrBgvCi6c7Pt3OmWCwbrCFITmCP6gheAO9a3lxOXDGVuw+uUw82Ix1Jwjkf4yM3MQwkdWVQF00k7S7SofuLzu+xg5BpBRhONPHKfNO1q2DyFQ49bycSTCrxhq0fyUUwykM/DI6VQBBdUG3KghsX94exBjg0fIf8Z/IworPYSu/SUPih+3fpAXcJw10tU7SU57cJq0hCpNb79R/icj63E+q+DAJ3ybqpPvudWS0UVn9si+gVfHcBCdFeOygFhR5S6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaP9t1KaaPvnXF2iSnaS+ai3iVGUs35lS4WArEr24R0=;
 b=WimU0S5eTQIRBteobfdTH2giLbUuSDspv/7A9qFEku1MYO857k72sT5X6OtxU/ZxfyNUqUhcYR46i2Y3I7ix3qnqETR1o6yWVtxJn64vNf8Z2KtiAcnJg6Itk/IvPUHB567nDqizxlrLCfJZaLb0zEAcJvvTgH3GCVZEuaxz9rQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 13:38:53 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 13:38:53 +0000
Message-ID: <7d830cc8-1463-d3ae-74cb-a908ac19a400@amd.com>
Date:   Thu, 17 Nov 2022 19:08:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] perf: Fix sys_perf_event_open() race against self
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, nslusarek@gmx.net,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
 <700710fc-1ac1-1b39-0e63-eb86adb4b984@amd.com> <Y3Vkmvi2vib7fwHn@zn.tnic>
 <7bf54a3f-07f7-5471-f6c2-88d3d9bc7a5e@amd.com> <Y3YPjo5wdKGVw7c5@zn.tnic>
 <68df3063-3fa2-9332-1705-631716589450@amd.com> <Y3YiCkjsa3NLIpq6@zn.tnic>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y3YiCkjsa3NLIpq6@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a27bd9-11ce-4ba1-477d-08dac8a1115a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuMXbzFEpussnNJU0M1h/hgtEbPliHt8UqexyyiVgJoQxjridkII2d27tsyiKeAJwwd1ZuGuWacZKVUBSC4w9s5sk86MphDHIkZQ0f3njc6p2H3DMUiyLAyqRBLBNw6NkzMCGLcTjtVynqlIvPLWRl5Vdl37Wv4VsuB05Z5PDjKAFywGVUNq8mAF5A7UTETyT96IplUKFEIFUDdf/kWbmps3bF8QAzX6K9JCqamP070/IL9Q3deqxYdZuTc4yZPXYSelEN3sg4+fksdwKYN/zakkU8gXrkrYrODCsptp1hIzl1tWhQy0O/Jo2n8pG/xUr8wPM+ozyuB1l9fm/HWBT+KUr8lc5QiqtPsa5PNxZwlbSeXZV0KqduMZ12wYEgjftYvXbuxDq4J4xD4WbdIwD65HIVN1TSlh5CnFciJTb7n1V55ra3KfE8IoSP5lYET+HckkcUgf3M+BpCuIh5PX4wi0Xk6CKPsAtoNGlnSKoInBEJya7y74foIz4V+n7e/iy/8aeXei85l/R35UzoTENlDTE77jsTjDpBryAfV1wv1DmnLYrqCJuaf4RMEpK/AvzvOlaRxMeTD5lp0yJxatsaW5gCP8Oz8eNiU034qwoZGKOpsLnCoRG8EKmmQEVSIhlpgVlZIvdcwhzTvPSV1k62NRTXQnGPW/m6dzGTUEsZaSKjMKyNc1dCwH96i3qI2L4+UyF49HgkFKXoDjfXzmRsDTdOJpv8irmMXZHFTJG3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(86362001)(6512007)(5660300002)(41300700001)(66946007)(55236004)(4744005)(6666004)(478600001)(53546011)(26005)(6506007)(31696002)(44832011)(8936002)(36756003)(316002)(6916009)(54906003)(38100700002)(66556008)(4326008)(186003)(2616005)(6486002)(8676002)(66476007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3RnNFhRd0d1Wk5GL21jTkdpRXJnVnAxeGN1akc1L3d0NHVaRzhFQ00zM0ZU?=
 =?utf-8?B?cVJBZzIweU9obDd6ZFo5bWpSc3ZSRytpOFhyMXYrMTBiQjhMLzEyY0V4cHRR?=
 =?utf-8?B?Y3JDV05QbUpzdHF5VVJNTFFFa3R4RmVlU1JuRHJGcE9hTlZFWGhxSTRxWVFW?=
 =?utf-8?B?RzVMQ0J4Ykc5dnBVYXJPV0RubkNoSm1HN3VRVVFBc2dXbE0xcjlaRTZNeHFY?=
 =?utf-8?B?WTJSVmc0UlVKUnZQUmhhTmFzQmNwYTNkSW1seThmL3JVZUNDQms2OGV2T0F6?=
 =?utf-8?B?eTI4WXltWXpOY3ZLTm9aSG5MVkIwVkE5elNiWFFlUHdkaGpUakg0MnRtakZq?=
 =?utf-8?B?cldGRTRrYWhPaTZMOVlpRWgwNE83REtBd2ZLcjVzaUI4dUJSRURZVEIySkZ0?=
 =?utf-8?B?eStRcXZOY1loVFNjSlJQTUx5NDJwM3V0bURjSmR0cjdsWmowTWViMUlLaHQz?=
 =?utf-8?B?OExhM1dIalFTOFVMemFJTUJZek5VRUxuY2dRL1N3NjlrVTZyTm82ZStKYitY?=
 =?utf-8?B?c3JwMHBLaEE5RGxiNW5mOTBTSTZjVHZTUFRqQkV6aEYrQkxZejkxeHFYZE8r?=
 =?utf-8?B?TGhqRTlEZExhVFVzc2M5ZGFha05aZlFKRFNkb2lpTXlKZDV6VGVFcmExaTMw?=
 =?utf-8?B?YUd3YjJEVXVMc3Q2MjlmWUtaUXJ2d1QwUHpjRGt5OWJrOVl5MHNTQ0F1RUVo?=
 =?utf-8?B?bzcxUE5tSTBRem1vQmF3aDJHanZ6c3ZkNzk1YmxseWMyVnFjUmQ4TlJUMlJW?=
 =?utf-8?B?ekJMTUFFeDVVSW1LS1YwbHFNM0hBalFQYy9zbGVtYWRqWG5MVGJ0VVlIZk0x?=
 =?utf-8?B?Z3hXK2RSUm9hYXVIS2lXVHJ0Zno1bnd1eC9CK0hUUWZvNjBJQnV0SE5iUnAx?=
 =?utf-8?B?bWxJRTV6QVN6SjlLOGFWazFGVG5ia3B3SFh1YWVzM0llb0Zld0JNN3lwWlh6?=
 =?utf-8?B?YjQ1NXhlcjVLbEIzVXh3dldyWHBHdXR4akp3WkV4dklWTXFxVy9Tc1ppQ0Fp?=
 =?utf-8?B?b052MDByTHBxN1BxYmpXazRCWi80Znp3QW9xWFB5cm5qQnlIVWNmY2FpMXpu?=
 =?utf-8?B?YVh5WWtQYmtVSTlhalozSzU5Rm85ZCsremZtcU9oR2YvTVJJWFFQSWpjZjlp?=
 =?utf-8?B?ZHdBYkhvM1hOM1pKMVlwSkhsb29EZldtNUI5VzFDSDQ1ZU0yRDRvZlhsOUs0?=
 =?utf-8?B?bTBicG9Fc2x4YUkra0dKNysrYUpqallkbkx4VHZ3UThVSVg0cEUrOW9SVllZ?=
 =?utf-8?B?M3ptbGdBY05pWFVETEMxNkVSQ29uK2ZQMGd4bnJZcE9JcWQyaFlRU0Z0SGZT?=
 =?utf-8?B?emk2blpRelpwemNwVXF2eFI5RUtwOER6T3lVLytJaTFxZlQzcTBwQ0JvYWc4?=
 =?utf-8?B?MjduWjQ2QlJJTmRxUU83Zk15ZUk3dUl2V1ZuQTNCMDZyL2tHUFV0bmdZMDQ0?=
 =?utf-8?B?SnNsY0lremZMU3ViM0s5bzZNcnJ3RVVJd05GdE5Qam41d3ozbGdjdUpIaEZQ?=
 =?utf-8?B?SFJrMnFKL28zUTVmWmdvRnNEN0FWaUw5VWQ5QVZUMzdHK3Rnc09hbVNqMFBP?=
 =?utf-8?B?dXFMcWhRQWpRYXdtdTlpNkJ4QVUrN0w1bVQvdTZmb1dqNEtoTm9ha2hDM3Bz?=
 =?utf-8?B?TzVmUjJQSkkvYVFLcWovTHpBaXAyRm5jOXFYb0g2T2V6TXhrYlB1VFRWY2J6?=
 =?utf-8?B?Y0ZhYU0vVUNIZ2Z3S3RUd1FSZ0pnL2J4a2lEbmcwK1JDUzdlU1ducHRURzdy?=
 =?utf-8?B?UzdJajgwSys3WS9tV3BYRmV2SFRQQzNEZEExZjlWUkt6V2dNdUl6bkNQWFVQ?=
 =?utf-8?B?bHJOWFdJa2s0a3dnRzJ1NkJKUVU2eTZYZXRBd25Mdkd5dkk5TmFReWRNU3gy?=
 =?utf-8?B?OUtBRm1uTUdSWUFoZkJkRzNMbXBOMUU4bm4wSS9tWHFXeVJRQ0R4dG9QeVpS?=
 =?utf-8?B?Tkp1QUdxR1Q2U3RlTEg4MzhHaTgzRjJpaWkzK2VBYVBIbmhnMHV6WTlyRk9C?=
 =?utf-8?B?RHJyNmZjNnB3ZDltTmV1OVpjMTdvK0dxTU1IbWZKZmg5dW1rN1dzRnRKWHVv?=
 =?utf-8?B?Y3JWMVVUOW1xc1pSZWtiUVJCYmErSFk0VWhIeWVIUytWRy9HSFpzeFV3UFU2?=
 =?utf-8?Q?fuLh3NfDkoB5X1KXFuY39C2i5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a27bd9-11ce-4ba1-477d-08dac8a1115a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 13:38:53.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcLewT4MyIDhh++bBBmU66VXEmnGPx4XuyORofKWaF6hAUpyYhCLiliGafdPPYLqjKhHp2zeYzm02jDb1LBuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Nov-22 5:29 PM, Borislav Petkov wrote:
> On Thu, Nov 17, 2022 at 04:29:31PM +0530, Ravi Bangoria wrote:
>> I do agree that more tests are always better. Though, this simple program
>> was to test a _specific race condition_ which no longer exists in kernel.
>> So even if we add it, what would it test?
> 
> It would make sure that race doesn't happen again. Or are you saying it
> will never ever happen so no need? Because we never ever rewrite the
> kernel?
> 
> Lemme save us some time: this test is dirt cheap. It is good to have so
> that multithreaded sys_perf_event_open() is exercised. And once it is
> there, someone else might have a look at it and improve it more or reuse
> it for another test.
> 
> And there are no downsides.
> 
> If you're still not convinced, lemme know and I'll turn it into a proper
> patch and submit it.

I'll do it :)

Thanks,
Ravi
