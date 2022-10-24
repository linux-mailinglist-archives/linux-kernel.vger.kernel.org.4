Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8846609B73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJXHha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJXHh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:37:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE94AD6A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkLBF+0Pe7V+h6MTj7xppcqYCPuhddd/H45DZXnQueN3o/1UZLGrvyFQVKHkmZBLHfD9qkW1V/GUfYhc1jx6xoKXwphf2l63rgY+8W5R/dpukEOkXgFsObSUuXItpsEGM5/9N+mfOwCe6S7/EO2ud6pDwmSw/6gbNZnB6JYVs2ayG4F+tzyBDkRtIR0h2cmXFOuAM9yN3bzNUr5MZ7H4Czo3BQPqY1x16YCucFUuP0aKHucopwUDywMPbqLGaYExIe//g40cNdo+/OVBC7V+Xh2dnqYPEd5Z70D0fMCiFv1fjuHakvmiuWA9FEUCr2eMklEwjgDAaALRLnxlx9BKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3wJ+1G21+Hv02Pph3DC4NlWR9itnRTc2MzhYxWbiaU=;
 b=ScXPCY7lIukWeFtjJ6DrY/PtNfZZZmFiKYuIDh72/oZqAursS22EYZ8Cf9i3U4TxFHjRTIDvmKPqiBNNW8WRFmzcT1a48dBuHHPwTvQCCpPel7awRc+e/QUdqYrXNUoGdxlNs2y84947c6gI7cNVRd+bjG0/J0AHtLekfIX1pUPyjmVKWE23/YamypZ1/9mO9v8k+vrAmMu868IvxbUwKoeyQobWzTzhRTPmQb+BFCEATOSW7VDhhEUnmwu+yiIcEUysWJsr1I9QnRQ6PQ0IAujmMMM76KqVmJ0jDIztIuRPEizKyR/T/NnKIw90IYRo2+gu3qBv6DeFDJKMX2epcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3wJ+1G21+Hv02Pph3DC4NlWR9itnRTc2MzhYxWbiaU=;
 b=AWZsULpjAMHIS6rPxdIxj00HG6nNXEYgjN+XjnNbV9NqFW7LMKyfVQTZPLaMf03GW1u4DqIFDBP4L4zm3er1PgyXV822xrl/YoI4vOPoxO4+JMtPVXLxtf95EkQO4qRBP3+BZXywilTSJjigsouUJYdbW/ornDSfBWm+knN2n391MH4bnLQav6EhwOs0wkrrXyov6Q+6IA7InNrvEe4u8icRDfUScRiYNdeFpbwGdcNwliIikq+WgTKJcZRqSDi2/G5fTBDMrdBOmdeAnEBLflHsmeCzlG7B25zitnNdK7kqja4UDGun4TMVf+FnHrWFTxYd6t1zkEjWayWUfplv7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 07:37:25 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.034; Mon, 24 Oct 2022
 07:37:25 +0000
References: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
 <87pmeiq6qc.fsf@nvidia.com>
 <4fcb9065-0d0c-7bd3-d4f9-5830792cce60@linux.alibaba.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        ziy@nvidia.com, shy828301@gmail.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
Date:   Mon, 24 Oct 2022 18:24:34 +1100
In-reply-to: <4fcb9065-0d0c-7bd3-d4f9-5830792cce60@linux.alibaba.com>
Message-ID: <87lep5r7t9.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fc603b-db05-41e2-4805-08dab592981f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpRl2y7i59QtqWVKJ6Tj5qM/KYfGgBqNGqTah/tKF/74tA/sX1y00bKbWacoKZdCLagQtxDDSd9Ia7Q4rXTWAr7d/7IGh+zSmVYCZskJD7DfRoxGpR+nfvqKnvRMCrmSZ3eaglwb2sGwOL8YhA/fyZrAH+R82nH+uTjTSLwZ0FPrjAVT19DxpdKZeztEJb9Tb44lV5vF4xOaWNVJ5Gdp/HZREjaGoWfZYy0I+FsoDgjw6z1PDNgIe7qn99yzeaSaZ9KEWGBK/0Vx3UzmPmaxShGVGHVRjnxd814bLzNewU92PeolzB0hgH1zvKw4WtgF2RLORlWEX50bPQIcFsPdYQNpwcZZdlrCWL6HLQQE5XqLWBuVZrpuKJFoqq8WqDo8tzi0BhxsHY/AOp5xgk4vfDBI5DVJVZyPjCvq7l1xAcpFAvzsfe8En9oIWD9LwaDmmBhghMm3CNHXhPxKEQlYNfZKKmPkyBlpzAF+x6PFplvdU/QkbteJLVSnuP7hIpYEIsfMED3fzya0IGnBHqvhWhlDv9ebOuBmEh8U6e4Z25iBuk9EYKX8H6L4vNXq9/R5inYvxReXMunAQIwpKs+xPch05eB76HUouGF0YJORlC7MnmyzaMgO+UxJ7+LsVdXugNrcZN4vXjsWLZk/OvNQLldi1wJkYnUmYYua3wGPBykD4j7ibMQ2bCwO/VIRK/uhnykCLq4Cb67vDPmYgDBJKd02YJ+iQPrO1dpRi+q/zKmHnkv9TEhjfFPEyAs+NTg/v7nF/ZA6OYTkDC0bW3vNFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(5660300002)(41300700001)(66556008)(66476007)(8936002)(86362001)(2906002)(83380400001)(2616005)(186003)(966005)(6486002)(6666004)(478600001)(6506007)(53546011)(26005)(6512007)(4326008)(38100700002)(8676002)(66946007)(6916009)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yoGeNa0pVGLvOE3tL7hNwQVpEFwguZfNba00qLtBgGh1Q6fVdhCjdamISG11?=
 =?us-ascii?Q?vs5t4whMoI9hIPNDEN9IgzCLAZ5FBSYdf0VFuVYl7iEo2rZaR/PdT1e7dV5S?=
 =?us-ascii?Q?oa7N5TwreDlHgmiDW3WTdNGX6GbnlhTVkH5izsybSAtjriW11Rufbc5zp0DD?=
 =?us-ascii?Q?EC23Y3p0p0WcDwg0zhXGxT7Uj7nFkXLrsAZ4DCXeUL0COQPYB/qY0/8Af6Az?=
 =?us-ascii?Q?n5HQxQLnUjSRX64wBriI/ICoyZAVQak/03cWbmyO39bRXyuDRb65/LPUn4o5?=
 =?us-ascii?Q?hfN8VU4jLrmEXlwKPgk+PMcpaN6IFz5nWhR3hgtWmQ2C1Kj8l0z8U6pr7d3x?=
 =?us-ascii?Q?qaWlj+EYOYYXAir3FGPv1wM8N9lEEB5ilOEMhc6LatOn0bWpWPGixA1qdzyI?=
 =?us-ascii?Q?/bBlmx3fhSlGB3L+fZ94mw1m6V4wrNzjHxnJJneismpmdn7l1HUVLkKlg49E?=
 =?us-ascii?Q?reT1dp/ZaTIDB5LZtCK+63z2lylMlxGaj1iaAvMfZv4yyHIzYZMm+cL9xmxS?=
 =?us-ascii?Q?HsV7WZ7ee7+fUE28OxazSIvzpU5FPygSQ6hTCVKFOh8qvoNRfUquTq1aKKSx?=
 =?us-ascii?Q?wcyL885eV2/SvfLp0iTu6ANkEt1xmvSsfxDMxGmbu4w2A+aZQxXKzC1EXhaZ?=
 =?us-ascii?Q?JbET0ber35ZxejAep3R8F8Qs0l+phugltPBZOulOqN2zF4GnVBgKJT7bEktK?=
 =?us-ascii?Q?ATLlK9QcUKuqBK+2O84N8AnmDtgxZUxBUqB9XOyECDN368VTEix8BzNBfZ1v?=
 =?us-ascii?Q?ayR90MoSA4bVDcFD3epaI8ZxDCH0eIkZZRPvcHwQV/G5s5G7lDFPcpPEjzSz?=
 =?us-ascii?Q?yLZBJ7BsAHRKlkBc/HNGAt1K+qlilCWGH3In5zcDh9C53p6CbiQlkNI1DHCK?=
 =?us-ascii?Q?tj/ZUhAmdAHVCZaojrcKVZHv0Fth7aPsyRXXeJzg2OW4czS63FZJwUZhVxT5?=
 =?us-ascii?Q?JBVznfzyA5ErM5iRgsS+lEWFaljI8s+m8owqYCJstcKhgfku7HxRJjDa2ndN?=
 =?us-ascii?Q?XWsyY7HzPm9o+1VvzrF+wcN/Jf7cbB8H84Al3tLWIZ3WUkBDUuF+1ACrpwDY?=
 =?us-ascii?Q?RJk1pqzLzq4QYCyEmFloRH0CYEpwyjDMfJNnvpFreSYalUhayDFXj68eyR2I?=
 =?us-ascii?Q?EcRbE21/5qrURh7SE6SOWz6dFOQE9QdCNKzbvxT3mRPT58+HObf0pXICwX/w?=
 =?us-ascii?Q?C7pZMWfc4eevmGEHlEOyUivuG9verb9LBprwNNht7MYaQWIjqr1mR/1zrPCu?=
 =?us-ascii?Q?6yu5egP2xoG7PPWTZT2rMFWqA0GejG/bDZueEoN9lUWQwb+mHW01HAMh6hd8?=
 =?us-ascii?Q?CGNBIMZzxGRN04dZLbHtDxb/7Tm09rxFg+ioKt/1JxSPZ+WwNCWjLDTSE6Rs?=
 =?us-ascii?Q?dBKFwvFkPW45OMEF9PzNCcmV90DhpahC4Evg6gtcpsuuCTck6vPhqoLjtbW6?=
 =?us-ascii?Q?vLTsKCVa8XhjLlvWk6Ec/7L2ApxhW8gCervgmOfI7qb7ylyZtYKJLplyz26t?=
 =?us-ascii?Q?hnPTTqT+CkrsYEsz3NwtU31e6be2Zl6WvW8ffDNHocLWIGkxtZWYGG/yNELi?=
 =?us-ascii?Q?EH8HwlN8wUDGCCfXiP36esQFW5pS0SmA0TL50Idi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fc603b-db05-41e2-4805-08dab592981f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 07:37:24.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viyGp3i/sV+GIC4fTm1r7r3N3iIEV+PazqB4L1E9e2CH8P72nQ+wLaFZKridEKWXrEKHcRWznU8Ua4gj2QROUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 10/24/2022 10:36 AM, Alistair Popple wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
>>> When THP migration, if THPs are split and all subpages are migrated successfully
>>> , the migrate_pages() will still return the number of THP that were not migrated.
>>> That will confuse the callers of migrate_pages(), for example, which will make
>>> the longterm pinning failed though all pages are migrated successfully.
>>>
>>> Thus we should return 0 to indicate all pages are migrated in this case.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>> Changes from v1:
>>> - Fix the return value of migrate_pages() instead of fixing the
>>>    callers' validation.
>>> ---
>>>   mm/migrate.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 8e5eb6e..1da0dbc 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1582,6 +1582,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>   	 */
>>>   	list_splice(&ret_pages, from);
>>>
>>> +	/*
>>> +	 * Return 0 in case all subpages of fail-to-migrate THPs are
>>> +	 * migrated successfully.
>>> +	 */
>>> +	if (nr_thp_split && list_empty(from))
>>> +		rc = 0;
>> Why do you need to check nr_thp_split? Wouldn't list_empty(from) == True
>
> Only in the case of THP split, we can meet this abnormal case. So if no THP
> split, just return the original 'rc' instead of validating the list, since the
> 'nr_thp_split' validation is cheaper than the list_empty() validation IMHO.

Is it really that much cheaper? We're already retrying migrations
multiple times, etc. so surely the difference here would be marginal at
best, and IMHO the code would be much clearer if we always set rc = 0
when list_empty(from) = True.

>> imply success? And if it doesn't imply success wouldn't it be possible
>> to end up with nr_thp_split && list_empty(from) whilst still having
>> pages that failed to migrate?
>> The list management and return code logic from unmap_and_move() has
>> gotten pretty difficult to follow and could do with some rework IMHO.
>
> Yes, Huang Ying has sent a RFC patchset[1] doing some code refactor, which seems
> a good start.

Thanks for pointing that out, I looked at it a while back but missed the
clean ups. I was kind of waiting for the non-RFC version before taking
another closer look.

> [1] https://lore.kernel.org/all/20220921060616.73086-1-ying.huang@intel.com/
