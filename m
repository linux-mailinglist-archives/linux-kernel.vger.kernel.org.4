Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677972B72B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjFLFDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjFLFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:02:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16107E78
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoSde5uT6So1EoXo2jUJIOxxqRse9ogREqi1RgPFBp3d59HnNRVUZpTWRSN2QIQsBp4LNrYJUZRv1lgKyb5XVIsdzk+MMaFGQU+3gzTxj75hsPsxXKnYcX3K/B8mSmmKLy5Ld1aOmt+YYheYGG4dhCm72EvOWdxnwZMKztc0eqHns/Fjaj7cpxSrpZF33jiIPLKhSWSII+Sl5VoX+XoT0S7pR1zdezkNuCbhuHKyb/BFkRihL23wBw40fuSUOhBpyMl6TK1+Tql9XYefAGZBZn6nJP5/qFxQRVCgSIRcHs3WCy7ykm/gqNv7l7b1FYNv8NTuFpnhvLv5ZOSeUgDlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq5FJpkYY5S6Hrlg+j8e6ywDJ/uA+b8nu0rUik/4QPA=;
 b=Z2xvhHO1I/XPyFxFdzNU86hxfWkjhvGzhbQJPSzgP18vF7YSV0xhpeWSDXEbK65ipCwXXO2ubbX9+mhFb0jwZuKmkcid/ebEQ4SVZatGavcnjkRIFxUmKGZ/d4e9TAkbtKtGSrob4ZIpCrlufoZpE7AFy4ASJzrV8kPs9g/AFohK5+AMREqoshPW2+0AJ1krZISqJOAsmujE0EQGyeCmuzNqSYlrVnc1Z7+h/aWoCAgg4mGz8CVqGboUydpKLm5Q+2fX0sSq0bxMuHKdJ3sY8uQcVH4Gk2ubauKBM7d9ol2ZJlQOqj6bBwpNliNZzzH4Fs6OEn9JutZ0H0dRaTmrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq5FJpkYY5S6Hrlg+j8e6ywDJ/uA+b8nu0rUik/4QPA=;
 b=tbTS4aJyKy0n48s4Kvko9kaMEsGkR8ORUUmLkv1NGNAHz3AhxdPH9Q7FEJrsEp/U8jXSO/Y48/0WvEnv3XgaP5hRu1FVXC/ru4jCdSrtUYqLX3cktj9Kyenv6et50K7UfgwAxUYKZtQHjLHtvZDbNKSmqyq2TcewOmkAD3ZQsW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 05:01:56 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 05:01:55 +0000
Date:   Mon, 12 Jun 2023 10:31:39 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        bsegall@google.com, bristot@redhat.com, prime.zeng@huawei.com,
        yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        ego@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxarm@huawei.com, 21cnbao@gmail.com, kprateek.nayak@amd.com,
        wuyun.abel@bytedance.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <ZIams6s+qShFWhfQ@BLR-5CG11610CF.amd.com>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-3-yangyicong@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530070253.33306-3-yangyicong@huawei.com>
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|BL1PR12MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf1df22-ff66-4b36-baf4-08db6b02248c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4xNOZlKhnk2sORau7AgWVrbee1qDrHfPsl0FsL7gaEeiZwCO5Mg9epPUWKyfXTkegip3SxOQ4rIupxG/dAFN3BkB1EytzY6tXHPZSMOWzVFPgkDTVFnrnloUhXvJCfGO7px24OiEYEzJ7pm1jFQrfRthFt8o1giVs48WOWeo2aWSf0TVh1qpforeQt6gKnJrhtfhnkYqGKetcoo3+L+ezAsRQ7t6uG9ySIy5zoma3QzQTcLJmKMQjV8i/PN3XTNfIiJXk/h62jJx1mh3meRy3aVK6eDDWxuhqr104H6j8PBlX/hyIlFtmrGD2v07aVQRIDUHq3z3m2+Q3HfiFVkydBTgmNiCEAxOhhHpevuClHbqm1bT6JP4wpHwqCtE2Ye5XcuOUeePhntPDWcLAO0nNtk6vlaReSIwGip+3CV3IGrR+4G57TDnzI3k0wdqABJOafgvhDjy8Y2CqHNdBCKKCietAQawtsrLHaGCBc74ncXZTLFRI6e7xG9WAajAaKqaJPli8Hh7XBpOYsD0SbbVJmDJdjB/db02VyC1tl2ZWSatgqHA0ViamhxlJyST0CfWQL1J0rF/DbV+HY4aXbZkQ1sSypTRXmiMOnQ3lwwI3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(86362001)(2906002)(7416002)(83380400001)(6486002)(6666004)(186003)(6506007)(26005)(6512007)(6916009)(66556008)(66476007)(8676002)(4326008)(66946007)(38100700002)(8936002)(316002)(478600001)(5660300002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mF5n4VMshU1iK7L5Jnh6HV4xrhND2hd2hl6m6wgPC58NQ0dPYcExPvg9PHvZ?=
 =?us-ascii?Q?Qu0JJmREdroWcQBhhFSlJ3K8FSN3h34Ei5htfMLnbn0S4VjnzcdS84mn4c4G?=
 =?us-ascii?Q?sWxu+AYCK8mcl97Pq25wawioNmWojd0BzwCYnARThxR2xAsiC7kcXsTStWI+?=
 =?us-ascii?Q?kAZWaXxnaCDsBa8vUiZz0gzhYT+sVmFXIWf70sL8xos2aYwfkEoFvI93//Lc?=
 =?us-ascii?Q?KtuQv8KokMxxEXNcC54tdoXiPrHeTa8GkBXmkyM5oyaASPtMqRWsgSALFLqK?=
 =?us-ascii?Q?xtRatRWeb9xR/aRg7ym5y2FeJbWG05c+/IdIV8VvtFtRdJfuGdVWNg1lv1PV?=
 =?us-ascii?Q?PYl2kZwUE6YlMb7CANtEvTvTa85v9WE/Buzp3bh812VaFYPFUSykfpgG8O/Y?=
 =?us-ascii?Q?AnCK2Cn2L2vJmMAHOxMdYKHj5b/WOnM6luqc5QzVcchqPE02Be+CF0RtUEsz?=
 =?us-ascii?Q?9c2pcjEOTCj4yXoh5w3+OPBLJ1sNeasB6m2ZgwCReYOTuyYvahHDbuDEMRue?=
 =?us-ascii?Q?9Fqtr09cS4yoh7q043nZQtTWfASt4/ENSniJaDkSGW9dDYDJ1P/EitxFhkpK?=
 =?us-ascii?Q?JzqlFnFTIzHt5WsbSS00oMGtQs+/V8FENqDYN4CviGWYjM6xN34h0D6jv3hG?=
 =?us-ascii?Q?WsAivBskcVJeNXRNGm3JnxrUbUQJ9SEjl5FQenoiIukFvCIRdMsc6iRMnXS6?=
 =?us-ascii?Q?BIbXF1Rnm6QgIN4r95tREnvo7Ea5oZEMjhWqsp5AaQ1tzXOE4buQkaD+vtqI?=
 =?us-ascii?Q?WWDS5L0Ga3O0jMuvqEeam951H3TtRzY5UULtiTSWeHdfilMGXSfCpNUvrjFl?=
 =?us-ascii?Q?TnoR1YVNNLqlpnEZdusDUHl3nsVA2LdezQeofjrZEyY3Xm9T/RHq4PEPbivF?=
 =?us-ascii?Q?UmQBw6z24crV9L7COa6ceFT8h+JARASzZayEI/ujU/mySuwhk66bSbX10g9h?=
 =?us-ascii?Q?dD8jBXGYk+ae3g6T1b4MOvzK8PXa4RAioE3r/0QRWK5G0ANxc/Vp5qwidQdK?=
 =?us-ascii?Q?vyFsVWIhhuGVBZ+LK7D67Z3bBnjc/WBvsFbvVhiXWuEmGLJcFe4Won21QXu+?=
 =?us-ascii?Q?aDJ1RXYyT3+xwiUo4FM66BKZD461Eiv4QTk7jKwuQJHbyQjRIQ1rfqfsmIof?=
 =?us-ascii?Q?hyExwU11aaM5GixbhXPPa180zF8CppdM5daJ+pH051x8kE/hJ08k3ziEFLxB?=
 =?us-ascii?Q?VU5WR38umLe/OywkK6fQbnZl6SavC4wcEKQ6qTN2Zzm+VJIIOITI+liremZc?=
 =?us-ascii?Q?mId12DfqlrMso/BboBroOtoDT+7uWDAhAUnEM3XDFH68gvibZ+PEhD4uNkQ+?=
 =?us-ascii?Q?82VByIqUNQ+LJka6PDLGis3hJhSxhBrdga8GRKHVCWyivgLYf5s8qN4aUaos?=
 =?us-ascii?Q?4M7w/qpCVoLYGtowSrEPNW58znh2VtKBR1mmA/NsCBXfCIilNkt3AY2EwXDx?=
 =?us-ascii?Q?qNt0DLhnT63Jmi/9URhtCbdnjrW0KE7s23EjwinLPL+LP4CpSDNIk40gRtRe?=
 =?us-ascii?Q?7XLVgmJLfsxgH5OulvTRdILltboGceSaaC7lF/ITtTZE+qjzeG/N6zkKNbpz?=
 =?us-ascii?Q?8NERyDghFAmhMIpJ/aIwKZGGyPczXalQH45sV/iD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf1df22-ff66-4b36-baf4-08db6b02248c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 05:01:55.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaXF85hhVR37L927apRbPxTpfE5P7LpfSnFkHgh9rbGwQmdATXCCncZFsCsFop6pDXZzYTSDe1SkX9US42Roxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yicong,


On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
[..snip..]

> @@ -7103,7 +7127,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	bool has_idle_core = false;
>  	struct sched_domain *sd;
>  	unsigned long task_util, util_min, util_max;
> -	int i, recent_used_cpu;
> +	int i, recent_used_cpu, prev_aff = -1;
>  
>  	/*
>  	 * On asymmetric system, update task utilization because we will check
> @@ -7130,8 +7154,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 */
>  	if (prev != target && cpus_share_cache(prev, target) &&
>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> -	    asym_fits_cpu(task_util, util_min, util_max, prev))
> -		return prev;
> +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> +		if (cpus_share_lowest_cache(prev, target))

For platforms without the cluster domain, the cpus_share_lowest_cache
check is a repetition of the cpus_share_cache(prev, target) check. Can
we avoid this using a static branch check for cluster ?


> +			return prev;
> +		prev_aff = prev;
> +	}
>  
>  	/*
>  	 * Allow a per-cpu kthread to stack with the wakee if the
> @@ -7158,7 +7185,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>  	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
> -		return recent_used_cpu;
> +		if (cpus_share_lowest_cache(recent_used_cpu, target))

Same here.

> +			return recent_used_cpu;
> +	} else {
> +		recent_used_cpu = -1;
>  	}
>  
>  	/*
> @@ -7199,6 +7229,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  
> +	/*
> +	 * For cluster machines which have lower sharing cache like L2 or
> +	 * LLC Tag, we tend to find an idle CPU in the target's cluster
> +	 * first. But prev_cpu or recent_used_cpu may also be a good candidate,
> +	 * use them if possible when no idle CPU found in select_idle_cpu().
> +	 */
> +	if ((unsigned int)prev_aff < nr_cpumask_bits)
> +		return prev_aff;

Shouldn't we check if prev_aff (and the recent_used_cpu below) is
still idle ?


> +	if ((unsigned int)recent_used_cpu < nr_cpumask_bits)
> +		return recent_used_cpu;
> +
>  	return target;
>  }
>  

--
Thanks and Regards
gautham.
