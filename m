Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238856E4B94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDQOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDQOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:35:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01892
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681742146; x=1713278146;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=59soud3ZVPF24XKGntxNV2rXm7hsRRLDATDpC2PciaM=;
  b=gZMfFH0yPmKBe7N2K3o1oymIzTT/mWMDIvd/Tl5k6/POQaiuHqYqEyLr
   FydtPHFp0IT+PDFjIennNfJNTugYqmdfANzF5htIQgwpsbEud/mIz2Ot3
   XJypC+IBMVa9ZpFj+IX4zWD4wJIm6l1EMOW5JBxIoVzgbEoY6xRtA7CwZ
   xCb96YAIOnaQe1KsoZus8OSic52KxXfqFc8KKEVLSVJn+DMxdn8o+dX9v
   3ChOc/bIZ6Pj3TNB+OTQx8WkIFspW7xzSYDBFNpPdEttWo8N/0qWHdrAj
   04dLBj7nztYfzWJB9qtEpOR22HIg//q+crk+mFDQBb02B4LYccOiloFDM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="343659521"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="343659521"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 07:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684170049"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="684170049"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 17 Apr 2023 07:35:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 07:35:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 07:35:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 07:35:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 07:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avgnr9i6MtnVeMU/e7eegdLpmB1ou8TfIUH9W17yvVWgFV9E/Z02ILHV3hDxb4mCbdw0GgJqaMCphONllu+yr2i6wrtrzESVnBbk3HMGmJ5sIXdOJrz+X5sPs7c5yubBmy5V/HXeKLdjkdomIzRn1HaWCDYnNEBz7hwKt6+NV8C1LQcvDiU+g2CsgMg9Mrfn1Ij80OED5pEXQayHZhzVnirZPVN34lMMZn7L04myMFmHKHO9wvgIO9hbeFs47QJHbn21L/TS1V8BUxz0lOA1KiFMoSCFZUbfK+CMM4npwMZUymxHbWg79iOLOc8u9I6FaPCaaHu/5Jnqau7QTfSJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKOw4ZnNGZoRHt/C0VR/opz6la5x7SDCRcD017uxI7A=;
 b=HKTR93iIppEyhjAG0tQ2FxMPCbMOzZTXGxYC3X8E+8B9aMfu26yOLIIWlzY1pTTKBOpTjbX0nYRuOlKngv6L0enAu9HXaAXI7ggbQWV7fy+406isa/6OK2Bl//vxMoTp0joV10wICm2mUWC2jTZ8bmmavcQFATm9yhoy1zvACd07N8ESKI+/mg2Z4S/Iz5wAbZMQ/8yOKqR4w8TdGd7XqUQ3UaYt8y6P8tXSPl63hXFI0Xe6THeANoChpToPVElgny7SLAU5g2vNeuuNHk3kL1d1EiYwTFpHzu/mRg+830E+tArcZz2ZuoBvZhwINzcMZLLd+p1b8hjYHRb5uymjBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 14:35:42 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 14:35:42 +0000
Date:   Mon, 17 Apr 2023 22:35:32 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v7] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230417143532.GA491276@ziqianlu-desk2>
References: <20230416223217.191261-1-mathieu.desnoyers@efficios.com>
 <20230417101855.GA485797@ziqianlu-desk2>
 <5abacbf4-8101-7931-6dee-84f4f004240a@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5abacbf4-8101-7931-6dee-84f4f004240a@efficios.com>
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ0PR11MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cb4d4b-966d-4c13-47d7-08db3f510527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8BB5awWRFRSUxZWqOX1LsM9IhsoJb0s4dAp0rm3M6p29q5zw9ndCX+zkbpmE8C13Pdg/sIJEkDlyzBGVf0pWzXp0Fp9sg7kxsdhhxMbYQs+8gV6Mydj3bvOLyOfikVl614TQDxb3EetqdZ36eilWvg0UR8gcCow5imo3bhtOMgEss/x5j89ux8uNJWGBRxtkN7IU7L7G8BXH/F1H9Jbd66fRuFrgvW46UUHXvp/ovpMnSK4ElJQC8bv8mTIJzt+eiEFr7dIw/DBycwX0KboEideRJpt4RDqfCVDZ2s6iY2fWXXUWjznqvdj4vKHG80ETcQ+nBKHrB5ItyjGBYc3HjR++lEKvVVt0QOiJCpjeaPTk8qY464ojo2/hKYwiukKUaxayQx/7loJWa0ZmV5W60eAMSPiSjckFxrObqQRYAVesT02zW7eMWH1L4Tm44zo7RtzNP6r7H7bEKAc4ksUpTTvmI46+MdQib3t2qN5jbqw3iZFrHZ3+ybKFi46sT7/+EN5IL1MheZUJQFaO6OjezBS37+fz5aFcNj2jrkSC6kxU9QCepPIum+7tTdDPjG7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(33656002)(6916009)(54906003)(4326008)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(6666004)(5660300002)(8936002)(8676002)(41300700001)(33716001)(2906002)(44832011)(86362001)(82960400001)(38100700002)(26005)(6512007)(6506007)(1076003)(9686003)(186003)(53546011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/KVZPl5eBJRjTi3OcajpbDKV0hQQ5xO5GvHg/X/T6Cta36CE9/X/wTwXzyZr?=
 =?us-ascii?Q?TF//oD10JUlEiCTHRSVU3zp2Z/jgKndlcJcFBl1p/FTevRPtoaa+PfczPG5t?=
 =?us-ascii?Q?DdfF9wIYqfQjx3dgMZy8D45PEBX3bs+63SIMw4R7pAEBt7P9WQLHGtd9KNkH?=
 =?us-ascii?Q?jd2a7IrJ74DsY3mdCDuLD7U1Vy6Zt1qC6kmMRaBUVlgdo1IpCEUh7r7kUMg3?=
 =?us-ascii?Q?j6bPVDooNmlhkcEfIIg+5ZXjaoBMyyPzye0kdm1RVKNJo7+SU+H2pzKZ1Beg?=
 =?us-ascii?Q?43HGuiK/0hVbw8zBKRIppIBaB50LD0iKLvghxgv8ztfC15TEfbbEBgMo79S/?=
 =?us-ascii?Q?I1o+F7NQ2Wp8gvJFBIFFxIHd8BLcl7s+frlGqSommU31wRhYLi0A9+ipUNGY?=
 =?us-ascii?Q?/gVXZdKHDY+66kfZil387sUESGaMsk6hshrNsv/cBDk5f1wHRX7XpYYCihEv?=
 =?us-ascii?Q?FFCSKYSknS3Inay0qhibhY/Eq8T5wKC9XmWeWz9AlKYmDxFiKOVaKUQAg65y?=
 =?us-ascii?Q?QWO5NwYBgsLBNpSSGW1u+sq8OhPPSoR5Jmdh9L+il4dYZS8p9vhNZPmbTvQm?=
 =?us-ascii?Q?lYREacWht2HGQF62FCVSXQ6pcQCKIyyMESspFBppS1aHgG8NdqUPLu6B3Ano?=
 =?us-ascii?Q?zhmZTVUhnoFzOH6AKOXQJKhrMrkdzLJW2dMmTZldMPyU0VqpdC6Cx30aLpwB?=
 =?us-ascii?Q?t63vRbt1rePd44lsofapysFSSCDUXLQPdX7Vm4MIS2diKaDIUh9Xf2/+fT8t?=
 =?us-ascii?Q?H+D2NlDSMxLsPyCxEtURTxSJHtWcflHWjb6ZWueAEW8BOjq56vxJrrMH5KYb?=
 =?us-ascii?Q?AaFpB2imAWnDs7x3eHuHNVNRQDYUu2UkqbVEXTvzkDsIWQqcvrMYHZc82AEY?=
 =?us-ascii?Q?57NKCBQ+BdMVyilBvOFZ0M5nPO0xjrNdx/UvwLOxlKHO1eaX6wmoWruRrisa?=
 =?us-ascii?Q?wIUEEmHf6rKZKTBFYbbkQUAMkPQR6iGfwDv895DrSVzJD7DvQDJLLHgCcnUv?=
 =?us-ascii?Q?qjNxNeHLu2rt4IhuTl9e9v5AprdJzqf227hE0DtMfcLJ1RqhTSRAMTK0yWT9?=
 =?us-ascii?Q?qDpnHG/YKLVDL9dWeNXppK59WNBBp7uiiUpoHmIyhNpMpAWF2vpce7GAMPic?=
 =?us-ascii?Q?VogcYNCtduH6tQrLEpPQmZOR7oJ2S6yTFbPr0Ne3KG1nLFBcMDREEgy/k23E?=
 =?us-ascii?Q?QwJfWs2XDpbozEEiostm607ez+t4y+/wenCPt8If4Ek0C4ERnJBcmFu3Q5LP?=
 =?us-ascii?Q?jfUwFyxZxYHA0iPllK+oF56i2/zdsVSn7mVovk+I62vGi65odjOiXc9cuKwc?=
 =?us-ascii?Q?Qg9guQuDKV3td2oY3p7Q/jIWb4d/pPjAM8jXYLbsn0OY4dQt3a8KdmXecbKM?=
 =?us-ascii?Q?CjZzlboEgN/8djdk9CcZJJYLfi0WxmudL2Gnk2pHV2ZA6Jhv5IX0Dy+8D/BO?=
 =?us-ascii?Q?zYIWDpIY/OB8ygemsKk9cHwosFkBkBC6oYRLNOZOBncxHb4XahRnG0VQjV5P?=
 =?us-ascii?Q?/19ThHBFnbZpTw9F23yIyUGLkqRq5ClrWohfdWJq9/FPvxnxZIuaC4gTMxm9?=
 =?us-ascii?Q?SUJicSrJbify5Ma7aIG0myzjXr7+aH9ldkao3H4H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cb4d4b-966d-4c13-47d7-08db3f510527
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 14:35:41.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClDc3kPcrgmYJUhHrCbTlbB9NHbok8VxKR2+P3GEz82VEHW3nDyS30tPOp6DyQF2xU21xwlpVETSYeXNdzSFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 09:28:54AM -0400, Mathieu Desnoyers wrote:
> On 2023-04-17 06:18, Aaron Lu wrote:
> > On Sun, Apr 16, 2023 at 06:32:17PM -0400, Mathieu Desnoyers wrote:
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 0d18c3969f90..9532cf1a2a44 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -2084,8 +2084,10 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> > >   void activate_task(struct rq *rq, struct task_struct *p, int flags)
> > >   {
> > > -	if (task_on_rq_migrating(p))
> > > +	if (task_on_rq_migrating(p)) {
> > >   		flags |= ENQUEUE_MIGRATED;
> > > +		sched_mm_cid_migrate_to(rq, p);
> > 
> > 
> > I noticed you did this in previous version too but forgot to ask:
> > is it your intention to only invoke sched_mm_cid_migrate_to() for queued
> > tasks, i.e. tasks that are being migrated due to load/idle balance etc,
> > but not those tasks that migrated on wakeup?
> 
> My intent is to also cover tasks migrated on wakeup.
> 
> > 
> > I saw you did the corresonding sched_mm_cid_migrate_from() in
> > set_task_cpu(), which on the other hand includes tasks that migrated due
> > to wakeup, so it kind of feel weird.
> 
> I'm probably missing something here. AFAIU, when try_to_wake_up() moves the
> target process to a different cpu:
> 
>         cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
>         if (task_cpu(p) != cpu) {
> 
> it ends up calling ttwu_queue() with wake_flags |= WF_MIGRATED bit set.
> 
> Then ttwu_queue() ends up calling ttwu_queue_wakelist(), which may initiate
> an IPI to the target cpu which executes sched_ttwu_pending().
> This function will take the target cpu's runqueue lock and call
> ttwu_do_activate() with wake_flags=WF_MIGRATED.
> 
> The other path that ttwu_queue() can take is to issue ttwu_do_activate()
> with the target cpu's rq lock held.
> 
> ttwu_do_activate() calls activate_task() with flags having ENQUEUE_MIGRATED
> set.
> 
> OK I think I see what I missed here, I should change this to:
> 
> void activate_task(struct rq *rq, struct task_struct *p, int flags)
> {
>         if (task_on_rq_migrating(p))
>                 flags |= ENQUEUE_MIGRATED;
> 	if (flags & ENQUEUE_MIGRATED)
>                 sched_mm_cid_migrate_to(rq, p);
> [...]
> 
> Because flags is received as input parameter as well.
> 
> Do I get your meaning correctly ?

Yes, that's what I meant.

Tasks that have on_rq equals to TASK_ON_RQ_MIGRATING are only those
migrated by load balance etc., it doesn't apply to tasks that migrated
on wake up.

I think your new change looks correct.

Thanks,
Aaron
