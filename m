Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A50734B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjFSGNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSGN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:13:29 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE6D9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c33W0mD5D+DHS/f88sxg6V7s/e3yNEQ63PtObkJPlX0eDty1PudrOpEkTVNfqwPFGibQrYnD7tcBx5F6k02vJz0ECfzV39/juVPEKsYSrBvdwnLrUWouchdrQ/SGwcAOKyfxrDW1J9JAQngCcBtnSaTGdys0loZmuv8zIqtD0f+U05OECPsR6umSahsqoun7QZFmDwlfPtO99Cany+tBnQQfHWxfTxVT/eRbyuvm4Jwjo9X9O8/Ei76t+Z9TRry9ImivCvgXn8iY9X/jNe5OitjgdbXnLTtM+4yA8TuGhlbcyK7q6tbrIlGmAg9ThnCJL/UCgZa+BMlwBdWhBjQnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptb579KyEyY6+SW9P55RuzJ03tUeMRmLWj3V9mGVCPs=;
 b=PdN2MDWxfbVYsSv+4NJgorEtRv3yiERz2MqvcNBgdMx0xgsAbzdsGvsiC9KEdhov716IpN+n29lH7FcrJjOgk9a5WrxpaHCZsutg78ykvuQZti9pMeNx3F0eV0YxixhyK5JjBMQabumWarx1WyJKGx1PbpkuOJAEOn7iGFu1XZ/TWbx/Imsr4xTHS0wv63XBVa1jnSsmQxXL7jvpneMMudAn/500AV2EdleX5WDQzKzVec0Lcql1lAzMG+PlLsEeiAQZNSCPaOJauIERRIvsDIKX30I9B7Q5oyveE4VNuxeFpCENk+w2g72scDOq0phZcoPKw8h40gEM0H3YvnMxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptb579KyEyY6+SW9P55RuzJ03tUeMRmLWj3V9mGVCPs=;
 b=unz+Rj+5EAfjBAEmTJ89WR2VEDwj4wOCH/OY8K0kRxw7KndlBOMT2rPMJVAX3PeJUI/M5uTNCMej1QEZyRUrHS+J8jRFe6HWAypNASP/BEjlp3nBrhhaj6wOSxMBwQ4fynr6SalniklCfD6hQ8dBQZ5P9IUck/JGHXLJHTySoLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 06:13:26 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 06:13:25 +0000
Date:   Mon, 19 Jun 2023 11:43:13 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613052004.2836135-4-void@manifault.com>
X-ClientProxiedBy: MA1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: e5927a0d-d34c-4c72-c2ec-08db708c4a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58SQuLtVHuQtzqQT4pshAwM6WlUMzgjyXxFYMkVVhZAR4YxJMB6iVo9qMvWLRfYe26KDWrEQ+fJMca1fYVIugacRD+tBjl/4I5ttGan6XP24vWvhTtwFtBenbwSQcu0OKDUEEx4Wu9cpIdfGgvikmkcMlxwNZ7U36l1IiG1TEKQLiST5Uo+gB4VviCTI/e9ZTrxvG2GvR7kSBvlLZu7meAys+l7aTBzUlLHEb4NGAk8DI/paSINr+bAurQYzhhmhFW+j8e+wVEkmn/EvTHld2KybXbLCB+vunFa13xhs0PaLHmO+PPqJLiRiLjVce2Cr0bM5sflrVh3trz5C4oY2gMFuuKH0HDvJWfozcIvOmIiAI0Rq6oCJTvi5IIr7k6G8GYaKJFnc+wixvo/+Kfw2JuRVRPbf0xWXUTo1Hgxp9p9Y8WN8u50gG4UAGTTAE+Z3zb85R5CWaYg3Q06Adg6aVh9Vxkpcd0lClzUYU2iCgtmumSchtPvJd79tQ9YNB9+/cf8CAQJWUnNrKP81y6kaLc9qmpukvyrcOGeC/uIGVlVeKCmgufXzfP1IyWnzcqkY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(7416002)(83380400001)(6486002)(6666004)(38100700002)(316002)(8676002)(8936002)(6512007)(6506007)(86362001)(26005)(4326008)(186003)(41300700001)(5660300002)(55236004)(6916009)(66946007)(66556008)(66476007)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HUp3BSLVsChkErfDMowfLqgFohSqnfOV/BO5orlZ4/iuXufvWwBEGdx2IKtt?=
 =?us-ascii?Q?5sUjHTS9cjNI0u2Mqg5pDgoNHUQIqLLhr7i3l0/agYIN0jOOy8vD0mNjORJS?=
 =?us-ascii?Q?C1Icv7VFHsCL5XzYGPFJrNFriiE2zr9K61oA+tiT27eZcArfEhsVod++sIjv?=
 =?us-ascii?Q?Qsdw4MzYkDWqI0FNcBl/Z2QWVhqJg3EdlhdAVnK2L/ToXCJ7Xywgi4HKgXOn?=
 =?us-ascii?Q?8ogWk2lD5z2s3Ibm+oLOeNlGMGBvwKD8da1TqkZr9GWvHOU0F7mSznJ9zso/?=
 =?us-ascii?Q?fmNu85N2zexuY6n0zBG16DQknulQ3+TpGT1/ofDX83+6bG22NvRU1lLZtjgw?=
 =?us-ascii?Q?38b+G1+vvmBDXZofLmEA88uY0vbDdQZK98DruiurmlHnUweSxV3vCpLgilea?=
 =?us-ascii?Q?uG12V9BQPUeh2dHHUDqiWvp6Nd4iRy5N+kz4n/Eu5Imq9QVF/8hG/Vtn/Zgp?=
 =?us-ascii?Q?H7E2fJIpOdKOu32++X9hKVc0/t0xD5YMseRjXiu3C6cgllaDtfDBOAdpLxzM?=
 =?us-ascii?Q?/tKbG9jfj8erBOW2AIMXHhAg5E4Dhz3C5AEVpr3yxN2077YARLeY66sn29ds?=
 =?us-ascii?Q?CiXWFyfXZjcHBidA79YMtTQqjqPpJNDBW9yIlWk/MsadYCeWLfwCufrZYuOq?=
 =?us-ascii?Q?23OZIauM/h7XRlSkEW9Uokb4stEtwRGvIBQu7AxvvAROZbkYpO5A4BSRVx9P?=
 =?us-ascii?Q?kzoyWB7G2uD1lBoOI5Tcaur2EgMWUj2P7xiQx1qyJ6K8O5q1RBSGSpWf1+i2?=
 =?us-ascii?Q?SK4zZNC3zhUE+kq9KQbk69l03/WYykaG6b17FnvE6bbqUEZT+Wr21L76885X?=
 =?us-ascii?Q?hHHhPpQjn4l9YRoho9mlYVfq64w60w4TAFnZ87Tj7xnRooJV559uvlr4HOm5?=
 =?us-ascii?Q?op8T8KScgrVHfO4hHHHhSfUSZDF2qMZv4//sxdKSqlDvk10cLEjVkOgYTnkL?=
 =?us-ascii?Q?p0Jldp5TOzSUtihpfZZtBstyzSkM8n+moRmHiysCjz3WlxAyCfgPS5i5xYcU?=
 =?us-ascii?Q?jAuKolLPuEvTser6or+oJfKP3erSvWgQVXHoz7LssKxxbCImxvKhp5AvSfwf?=
 =?us-ascii?Q?KcChBrcTudcNqqmOx3m1FUeTv2BPYmJ/2OpUbC6h2NdGS1Cpku0eCTbUzwnY?=
 =?us-ascii?Q?AcY7rSFiCIMI52cqa+9DycbwxmFvfo7qxd78krZbsMWxgSD4pyFJSDmC7p+e?=
 =?us-ascii?Q?VpSBPzlnYF5fk1JFsBq6pSjx7xAxraGYNvONyeo4iY11fzvDLHPrls18yyf4?=
 =?us-ascii?Q?IrEXwkpByefr1KfA1IKNcYFimj0KZgZ1Lvv9hPOdOBGa7CbKrKHlS83vLvhg?=
 =?us-ascii?Q?f6qw5WMYF0wj7QD7i/r1lJbXPt15K2YueGECocmcd7xdlXecFr9JYwd6jmoQ?=
 =?us-ascii?Q?fuZ4sWsuM/Kw5wLwPMnqGuGl2Iu+V2J1fLINiEgiHxEmJ6b9S88+JT/HbtCR?=
 =?us-ascii?Q?a/wRqB47EBl63CUF2uuXQzA+ZSW1OFsMoqvgnVYk32wscjSTHWa9hgaWL4dO?=
 =?us-ascii?Q?KH7RV07s0NuRilqXULFZv3q/5h1WH35X6t87BlprsVFbIHQ2h0WIlpAoNk2u?=
 =?us-ascii?Q?Wy0UVfFdcHlDO5H4ykcZGSd6c988Sqh2z5gPAR1B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5927a0d-d34c-4c72-c2ec-08db708c4a92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 06:13:25.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9D8u3by1p3cIimGCfnU03duZlbmtaykwxr6Fvz5uRAqR1c2nGbg/yzEsXErXPH9cgTGrT1xh+yG9z/jiRzYwgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,


On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
[..snip..]

> +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> +{
> +	unsigned long flags;
> +	struct swqueue *swqueue;
> +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> +
> +	/*
> +	 * Only enqueue the task in the shared wakequeue if:
> +	 *
> +	 * - SWQUEUE is enabled
> +	 * - The task is on the wakeup path
> +	 * - The task wasn't purposefully migrated to the current rq by
> +	 *   select_task_rq()
> +	 * - The task isn't pinned to a specific CPU
> +	 */
> +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> +		return;

In select_task_rq_fair(), having determined if the target of task
wakeup should be the task's previous CPU vs the waker's current CPU,
we spend quite a bit of time already to determine if there is an idle
core/CPU in the target's LLC. @rq would correspond to CPU chosen as a
result of that scan or if no idle CPU exists, @rq corresponds to the
target CPU determined by wake_affine_idle()/wake_affine_weight().

So if the CPU of @rq is idle here, can we not simply return here?

Or if the idea is to avoid the scan for an idle core/CPU in
select_task_rq_fair(), then 

Perhaps I am missing something...

> +
> +	swqueue = rq_swqueue(rq);
> +	spin_lock_irqsave(&swqueue->lock, flags);
> +	list_add_tail(&p->swqueue_node, &swqueue->list);
> +	spin_unlock_irqrestore(&swqueue->lock, flags);
> +}
> +

--
Thanks and Regards
gautham.
