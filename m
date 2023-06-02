Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC22E71FD26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjFBJJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjFBJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:08:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB28E68;
        Fri,  2 Jun 2023 02:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoO2fy8DYxqr676BuA2p6KaZWbx+hQVJZAV28hlXI7G6zH7qP19ZT+ClhNoiUIF42wsFRmI9hQCcXWlUyH/rpprNOyD8s2dnbLYWUyB6FNOi5cFytIQfWE5pmlev6KvoJVUlwehwTUmGdhglJkEarlL/NNVBE4jGqvy6ojPdOay9Vl08pdSGEVaqHNlsVBkFWLdg3D7qj1gYvJ9+TWKjkiyVsBPsVi2hxR103Je4hpgstIucbWhjqX2tNil8iCClwNouYGBqli0DL/ySQMxl0lrUVSL7fIyGFBxwwGqa6FL42uez6BSLWGL2IlJ4Q2oG7H1FlfoJhGo6FvMX8TUV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FeiWQgMoksWBE3u/hZhAgV7nSI4Jyldab7SYVsIB+0=;
 b=gtFqPdI/cKL1PkWX5REZWD8jtVUe52CEhe/vgqgzG8HBtHkLbxBkxaNEyWUbIXgpQB5lhOmOtHGFM3WJGIUetxXIKJFFLWb9WKcpSETGeT1EOi/EKHsnjHDSg2FClJVrspY+vZTf9g1d0JlJDyctevkP3Hjb07+rjL3UwC4upk7SkVWJXzkV9ylQ0Sdi4nuxb79Txwd8Nkz2QKt09nwVhzhkk8wJSObi655wRSQh2ZuRa9TSXrl9xSazhceYWZgPN1uTSbTAxCFISS+FWVsui6s0DxehEfcoynfAeNSxea4rQyOZL+wqrs1+CQdu5E/ryT+38zhQiw+q55+SUfb1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FeiWQgMoksWBE3u/hZhAgV7nSI4Jyldab7SYVsIB+0=;
 b=WkxLIASEZWUPhHXtgqHbKX7094OsyzfnQr63PY1L0WquKKTZAJYi5NkLXUVbMTMvEvQiQW8Y3tRMJ21y+CzXw6HcrcsrSeqbRe7y/d+Z5XE3aXqvd99YylTaSfOsiVR9BdUK4sdhpV1UhFAwtwQdIIVSh802oS8RNxtqZde4BGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 09:06:51 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 09:06:51 +0000
Date:   Fri, 2 Jun 2023 14:36:37 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <ZHmxHWbkQWvcq+bZ@BLR-5CG11610CF.amd.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601145113.GA559993@hirez.programming.kicks-ass.net>
 <a78b5df0-2374-29bf-f948-3054f1e7e46c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78b5df0-2374-29bf-f948-3054f1e7e46c@amd.com>
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9399f9e6-3d1f-4b00-49a7-08db6348b388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrQzDZOqcEuY1BO0BopD5SBHASZYAbRog5UFVZn8ByjgSCygvOj52SUutzlOKNktWDxv/SQ4i/CtkGt9n69e2XMvductwvdGP0mn2DbgRgaaL0tRJvb8T0qYHqC0nsmMIf/vcGfy6qwkUgYfodZq9A3s4O15sFaRm8+37Bmq9bXl0lmJwW71rRtlA215It4Bji04LwN3plaxUupFanAFBrEtrqskvgoGk8uW9f9yQoXF7gCPnPCAK1NOcid1kY1ffDm6BpHAkeRP3NY1rOVWkRSbexQDezXoFciqe8dkZoYnkNCczNxw8scCFS5v/dFOQ6og5AwRZHYKQwUAOHLyt2ADRG4QNSEEy/CSFDiO7Ws9Mpw5KcXGuZ9zNxr4CUVd2DoE+xNiFuMVcIn3sYIYSCtHjMLntkvwdh6f4DSCj/5Q8mZ+xfTXqnLWc1A03w/XyFhXDRTls0f3d31HZxhA9vv/l3zta8rt8elCLuOdFLag5G393yfj23NvwaVWZOIXx7KQ6pfOkX8wMR3M81VynlFLyEdTJVm2Yd8T+e2zJXO3cScp99Jpz+DBmjHP1WFwqRO11m6aBbCoM80AFT0MDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(53546011)(6506007)(6512007)(8676002)(66946007)(966005)(66556008)(66476007)(26005)(38100700002)(6636002)(5660300002)(4326008)(8936002)(6862004)(83380400001)(86362001)(41300700001)(54906003)(316002)(6666004)(6486002)(186003)(2906002)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L05m/iCiBzhsDcLyHoUyA+3/5ojqnRt8WgP+8mdb3WSDNuP2un35mq/eSmH6?=
 =?us-ascii?Q?48vVrDDrE+t/nArdiWxqLJITOP9LNaRYvsi5Hp3CcGLYaUGbRJiJucB8s7ZD?=
 =?us-ascii?Q?Gz6K/goITKdXt4to0bysXB+5m+KEQfkUup+POHv6/Rp3K5GZPAlIUBMkMqaU?=
 =?us-ascii?Q?ZsMsg+Nys7P7zSZDD0sNMrT4Gp7JQmmRpGmlj/rpOX0OYt5ellUsTt7ZUnVq?=
 =?us-ascii?Q?xlal3SmkdX70CeI4AfOTrGHDgefo9CK/gxkBxolOOaf7eAjm97x0YbRsIXbw?=
 =?us-ascii?Q?MVJgWZmoCc1CYI9k2NmDR4pT8Ty7Ljx2a2oLM71/NZibUxU2J8tCXdelVb5s?=
 =?us-ascii?Q?e+IjRc4XppeNG5QeTigg9nk+4cisC5NostiTT4+32oZyrMd0v+x5Hycbpqqg?=
 =?us-ascii?Q?p5K1oS7JvZf7PbURotVErgSZPhTyvXkTrxRtQta/e9NWv8oOFGSZtY20jEAg?=
 =?us-ascii?Q?h8VptA47OwMNSTdhOhFqObOgkRUuWUWVcAj4XS53KMzBkfuEaNujd/Xc1YcQ?=
 =?us-ascii?Q?nu3U8ubc6/sVZtdRWkyfH/ROb27ufCEZDNRvsZRZdz+lrAewEE9Nx6nmYKmz?=
 =?us-ascii?Q?PGuxDXTwL2wDwzhiIkSt2W974ZG6iQbbzCarQYO/NVl/WAIKZGWLn+V2xKUt?=
 =?us-ascii?Q?a06FrJfkUQeh4h6lUKRQVw69uwzgG1TltcEDinCPOPk+DIaPxfhyzxvQ5AME?=
 =?us-ascii?Q?fsqKyEqNjxtpVsKSOE1QRHweBfSD4Fidlyh++ZsCY4yAqQMj4VcB1kK9AhM/?=
 =?us-ascii?Q?VhVERQoEbMgj/TkpJRD1FMmZHzF1r7/9oN015H/mdDNdhh1u+TuyAzh/EFG8?=
 =?us-ascii?Q?DRRXYULrXEy/tYZm3ZaGpF1YPvuHjkR79nwX72iuunGbCZUmDPUgEFx2W+02?=
 =?us-ascii?Q?1jzsgzBgv3IgmVvGo+TpngWhKrG1NPtIxv36ddDsZQyZM/5sLGQO8aSxZVIZ?=
 =?us-ascii?Q?xWR9b1IC/oVWmuCN6UsKML/cX0NqWltV2SH1VG6SyCYwhUSqBVu5QZcOxSpV?=
 =?us-ascii?Q?XZ1HnkyW2ZltFD0wp0Zkgy1wCJnn5CTiCssuyMQl63c8GA462ShlqcH/1FnA?=
 =?us-ascii?Q?Mp+JaeD+Ppxs8H4HXRCx0GzYpuHf8EceCBjwfW4CYZI5fqFUhg45P4K+Dri/?=
 =?us-ascii?Q?8xHILmgF7ELeN0ZCltlBnCRO+B3im85yr/bTytSxRxE742cRuTBqWanDs+LZ?=
 =?us-ascii?Q?XjFP+TONgaHuqy/BKyhaZD/OexEB5ddEWE8zHiKxkKmxPVYZkHKZw8d2RwjI?=
 =?us-ascii?Q?u4UdknWECbPgZsyYaIPBnxb205WNX9Jri89ktn/XL6Nn+XDrp8NzntwRh1d3?=
 =?us-ascii?Q?ItKWCBYvvhKyyrs+jZu2qLAhCDboorNguUwaMjGKV4WW8Ee+/magX9q+HsV6?=
 =?us-ascii?Q?07nRrew0bejcil03E3IOX3Gzw8VR24dgnFjxrUnOxIyDcypoOOVq7POoCNI8?=
 =?us-ascii?Q?o5b4j0qF85LWu7JRhNMP0JlrY6Yt1MKlTUT5cPkN32EIqnyZRhq94iwIs04D?=
 =?us-ascii?Q?LqwZB8orO+lFEn1861tfLm0RjJtG2XrxDEZrncDgY//6UT//3VwTQyIwEsFU?=
 =?us-ascii?Q?doULhOHFU9rBI0+sW8qZRivkDghEuvKXPEQyrX+e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9399f9e6-3d1f-4b00-49a7-08db6348b388
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 09:06:50.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9XMuNknEcr7KB9+vO5MZQTbQLxJe66Ceh5bOELHx4MFwZZg2poWE9l32X7Mca1Syqa7K/xnoOfxtbUwQ6htpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On Fri, Jun 02, 2023 at 10:47:07AM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 6/1/2023 8:21 PM, Peter Zijlstra wrote:
> > On Thu, Jun 01, 2023 at 02:00:01PM +0200, Peter Zijlstra wrote:
> >> On Thu, Jun 01, 2023 at 01:56:43PM +0200, Peter Zijlstra wrote:
> >>> On Thu, Jun 01, 2023 at 01:13:26PM +0200, Peter Zijlstra wrote:
> >>>>
> >>>> This DeathStarBench thing seems to suggest that scanning up to 4 CCDs
> >>>> isn't too much of a bother; so perhaps something like so?
> >>>>
> >>>> (on top of tip/sched/core from just a few hours ago, as I had to 'fix'
> >>>> this patch and force pushed the thing)
> >>>>
> >>>> And yeah, random hacks and heuristics here :/ Does there happen to be
> >>>> additional topology that could aid us here? Does the CCD fabric itself
> >>>> have a distance metric we can use?
> >>>
> >>>   https://www.anandtech.com/show/16529/amd-epyc-milan-review/4
> >>>
> >>> Specifically:
> >>>
> >>>   https://images.anandtech.com/doci/16529/Bounce-7763.png
> >>>
> >>> That seems to suggest there are some very minor distance effects in the
> >>> CCD fabric. I didn't read the article too closely, but you'll note that
> >>> the first 4 CCDs have inter-CCD latency < 100 while the rest has > 100.
> >>>
> >>> Could you also test on a Zen2 Epyc, does that require nr=8 instead of 4?
> >>> Should we perhaps write it like: 32 / llc_size ?
> >>>
> >>> The Zen2 picture:
> >>>
> >>>   https://images.anandtech.com/doci/16315/Bounce-7742.png
> >>>
> >>> Shows a more pronounced CCD fabric topology, you can really see the 2
> >>> CCX inside the CCD but also there's two ligher green squares around the
> >>> CCDs themselves.
> >>
> >> I can't seem to find pretty pictures for Zen4 Epyc; what does that want?
> >> That's even bigger at 96/8=12 LLCs afaict.
> > 
> > Going by random pictures on the interweb again, it looks like this Zen4
> > thing wants either 2 groups of 6 each, or 4 groups of 3.
>

Yes, this is what the topology looks like

|---------------------------------------------------------------------------------| 
|                                                                                 |
|   ----------- ----------- -----------     ----------- ----------- -----------   |
|   |(0-7)    | |(8-15)   | |(16-23)  |     |(48-55)  | |(56-63)  | |(64-71)  |   |
|   | LLC0    | | LLC1    | | LLC2    |     | LLC6    | | LLC7    | | LLC8    |   |
|   |(96-103) | |(104-111)| |(112-119)|     |(144-151)| |(152-159)| |(160-167)|   |
|   ----------- ----------- -----------     ----------- ----------- -----------   |
|                                                                                 |
|                                                                                 |
|   ----------- ----------- -----------     ----------- ----------- -----------   |
|   |(24-31)  | |(32-39)  | |(40-47)  |     |(72-79)  | |(80-87)  | |(88-95)  |   |
|   | LLC3    | | LLC4    | | LLC5    |     | LLC9    | | LLC10   | | LLC11   |   |
|   |(120-127)| |(128-135)| |(136-143)|     |(168-175)| |(176-183)| |(184-191)|   |
|   ----------- ----------- -----------     ----------- ----------- -----------   |
|                                                                                 |
|---------------------------------------------------------------------------------|


> I would think it is the latter since NPS4 does that but let me go verify.

2 groups of 6 each is the vertical split which is NPS2.

4 groups of 3 each is the vertical and horizontal split, which is
NPS4.

In both these cases, currently the domain hierarchy

SMT --> MC --> NODE --> NUMA

where the NODE will be the parent of MC and be the 2nd level wakeup domain.

If we define CLS to be the group with 3 LLCs, which becomes the parent
of the MC domain, then, the hierarchy would be

NPS1 : SMT --> MC --> CLS --> DIE
NPS2 : SMT --> MC --> CLS --> NODE --> NUMA
NPS4 : SMT --> MC --> CLS --> NUMA

NPS2 will have 5 domains within a single socket. Oh well!

--
Thanks and Regards
gautham.
