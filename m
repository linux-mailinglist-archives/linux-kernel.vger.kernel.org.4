Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFF6E89FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjDTGA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjDTGAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:00:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB54218
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681970419; x=1713506419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FHT+YLzyV1aZfAYQcOGSzZ0h/rFoL18T8yM7LNYFlgQ=;
  b=DzNx+iTla+eHhJCGr4iXOEyk5K4IExrxDU2ibrrlSY0W+P0FlQHRpFjZ
   WNTHL9X5w0XZ5H6l+w/jpX/7o61upFw3v0Blernx/iXf/sgCCKa3pjiZv
   NNy+PQRLO2Zk9J+2yPEqEE3Om+vopbvRtHKjnMqzBZPA5fCRMa6qK27lK
   Gt5tPyqJnWlm5fYSCtSEayEDMfh3Xauku/G6MxR5kJrrgecG8ExgKlyYY
   zL9hF3F0+V1Y9ZkMnzlP9XINpd6RzR86CVBDE/hG11tmgAAzDrEbWhJqX
   aEzKhYhUg1eoyentcdJdpvCtlVs87eBlC8lrDAu7SvtDYC4TiSF9zM3+C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325251668"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="325251668"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 23:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="761012448"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="761012448"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2023 23:00:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 23:00:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 23:00:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 19 Apr 2023 23:00:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 19 Apr 2023 23:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsysvB4V9vJM3MDaJISkC023EIcumDi+t2ohivmhNfas+uDORGc736f8fqzCY+7UR6FVRgOXXrExMVaa+mfP3UyjOOfRjjUiVcLkK2HQGWKe3LXK0gFVl88iaAiSDItdfwmyIG453kFDEF9asQumByVjZhOpDsoAl478Hm/6NdasmRhslYRX7xzvr0Y/cPR1YoDve5Svf+rNxwTGivOMlvgY6i/LO0iNs/rdFL8A/Jg8n3AaOsZof99hVwvBTe5+/Kb1iIxeX4RKaR9QLYmpmaYnW8ctpAAkjLsI1K+m5uBjDZpDoQToKaLCEcoXdvD6bQe3Zo/7ZZHKHginF2Ci3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7jJ4dVlTgt3QAOFFBRVDfENQwn/sGRu/qB6qg2xG2w=;
 b=apEHxv3vgYBsCgXZ153tYCCQF9wg5pdfhWE8annP8G3Y2DIJbeWAuVfbo3jkTslO0HOMf5KG6LbC5ywewH+1taYT/BLjTwTT/jJ4wc0WkgB3nYr1TTQaoz2ncwX9ID++zdzGBlEjj7+9RoZzc8sfZby6/+fR0giBacrzV0QGUfeoCoyxIgtaI4sPdbRx/QdjgV7duqh7JoaGo8GH8iRr0plvc2zKgyhl4N7hgfS7V8cUQDy1P+3fGtRNdanZe+Vf1Zmd6rQhlNGHB/yArAVYihJoLxdc0NHsg+160lI5Z7dWtg8gQu59NrOae3bw23WRMEtw+HxASt9lR9xP+qEtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 06:00:15 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 06:00:15 +0000
Date:   Thu, 20 Apr 2023 14:00:04 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v8] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230420060004.GA52173@ziqianlu-desk2>
References: <20230417150831.264780-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417150831.264780-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SN7PR11MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 54846c83-9c40-48d9-91a2-08db4164828a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAXrh+XP41Tfnx220jGTZF8ENFkPHH0djGr3fnvfjOZUeLjGl0xJpB+41TIqsrCm6iBY2xBxKuUSPxQi8yDr6kynZL8TIJPKLRQzf2fhjSM/NV13+SnhRobRFu0EbhwTWStLeGqONOYrJ9Rz7s5KlJnHPTatJ4A0oMpy7joKfBa9LfWmZl7GBPUlyiuDVa3c7mKvX+1KUUSg+vh60m2dlEyBIrGOu3TQk1BcTjlH9bIRzKj/hTM1d1tYxkUSFQZzlAgWE3w9JaBBGZ25E7uWZYeJBlMpe/iOufx1/145t4ss3VklR7aIW4mMRe9c5o31i4IRSzJvmaR3TCWsYe4Cn8CGKfhdn/SQO24BF8HbhIXukrtUY5nuG/Mj6Twf4KloBKFoujXwrtBWOBO3rYQ20InkFgE7Vtl7Chu2gDep6Qe9fuvZVYei5BkPZMTXADDHYzbgPxcMayriuXIWZ/Gu1s3hirUmZm7JUrOD/oHIQiD23px55xCZtc0c1QzvtvrkUhBWJRHyBcuYSyH5xd5SVTfVVN1GX22B8aMQgDPiICHMJbuQ0X0BMN8Bspa01ywH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(38100700002)(2906002)(8936002)(8676002)(86362001)(44832011)(5660300002)(33656002)(33716001)(41300700001)(6486002)(1076003)(6666004)(9686003)(6512007)(26005)(6506007)(54906003)(45080400002)(478600001)(83380400001)(186003)(316002)(82960400001)(66946007)(66556008)(4326008)(66476007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48zFbFlZQlXgAq5x/gItXn/XG+i2XWGWmYYjrTf64SWj+H7ss/mW5lz/Ux/B?=
 =?us-ascii?Q?IyhJqPe1/2fRCmABKdjDrngZkbm++RTyhMkukkUQcVWFDfflmfYpXbbpekeV?=
 =?us-ascii?Q?qPvCfgWirlGOWq5X6k2ZTF9OtNVVWDdw/i9e6YvnPt5O7uOOwIKRI9A3PIsG?=
 =?us-ascii?Q?guCeRBtdDj9RzJteUNN5OF/D00vHjcyjkI78ZstYBYrA3gCDq/wX/4OTtiY0?=
 =?us-ascii?Q?1ElzXhifKkDrkqebPVLm0Cx3zbrFMlnKyaFt6/pZJx0nTHO1qskLTczXKJmw?=
 =?us-ascii?Q?j64jp10dDJ+OeoBJ1GGLB4yEixlDePin5lciC8EK0J+BUgKyIu1csUBbUEWY?=
 =?us-ascii?Q?cU8QZviq0gHwNRsYvTI3deuVAaWZFLRIviCa+efcUrqzUakdoJm61DhVKpTB?=
 =?us-ascii?Q?Rn+BtSM9GLD3NAHywMuq1pVNyilt5GZXlTtEVmWCWkUJI8MCuYN38r5cpngO?=
 =?us-ascii?Q?spMmgk72RU9Wocs4J1v67NOfIVPBMPN3nao7zPR8oBIHeRGphN2WvvqBp9Ce?=
 =?us-ascii?Q?4cBtM7mVxzjTIuQZedq4fFj3tIyoFheW50+Nhpu6NfoUZa+eHUq0D5R7gF0e?=
 =?us-ascii?Q?32PcBanwglUoTlUBHS9TSx/0Zx+zAFM8RysNYYIQHDyWuwGQDG6XTfVtHuiV?=
 =?us-ascii?Q?vOD/g4LgWI1bR18IbdcgwqC9uUn4dEgqG51SLiICeIpzZ7Adg9Ion/EWShXf?=
 =?us-ascii?Q?WAg71hQscOfSCjqDI5anCzExPOScDij9KrG8OY7jn1sD7DSRNUJUUsj7qv6L?=
 =?us-ascii?Q?B0Yo7GwWWVygyvFGMdKpow39aADLplXkAltpyoKyuxDL1SyYyfSkTu+Hteam?=
 =?us-ascii?Q?kx+pv4+Yn7Xu8HrqHs6+4ygfzGAVlkkMeh3MrpQg8DG6b7y9w0m1poLpx2o2?=
 =?us-ascii?Q?Z89w7cThMFxf8Ae6QxsN9pDYMQNrHWBDGr+RIIdp1oa6BCNMIGmsNzU3ybeX?=
 =?us-ascii?Q?/0mKRtDLI88wD4UQt1i2gwQRn4gSpslPYtDAq4A/+FIrZv9MezDDNjS91PlR?=
 =?us-ascii?Q?yQlop7beOv7WX2zTX3yvMWp4LfuHDw+LImwEJeWvwKtMvbl54fEWOs9Hi1eA?=
 =?us-ascii?Q?mi+ydkQ7xvO+qiBN7Hgt43s6iqHK9gJK6iiQQ6HkWGv/KOBFi6f5DJL0f2vH?=
 =?us-ascii?Q?Hh3K4gIG8RtJz37nEWu9/vWgzkmi77fhVUyV1V4JXeuWD8SWt8qnomnWGUcy?=
 =?us-ascii?Q?yE41VjkFEaZrqAanSKwou+kFv7bpeeaxCt2s17SM/YZxtfBxFqfQ0MDrDFVo?=
 =?us-ascii?Q?0cV1J8cbS0dWkw6dg4nnxJsgJcuXbfvRp1h3lh/553HGJxpBLnEbEq0EDG21?=
 =?us-ascii?Q?Tp7pNy/WBTEcS9lzmy8nKtWiKtxfOYZilX9iwqiAAel2rv/EHY6zz2J9ppPk?=
 =?us-ascii?Q?Z35HjTr2Rl1XWQ4cQa1wn4jTWerTSfelo+/wasVptW7bAWJ7gUskeEao0B+Z?=
 =?us-ascii?Q?AiCwqrK6UNZvxXTwt1g3xPLPN80oxPfqUl5w9CYPVet25XonwMPwXXXJoVEi?=
 =?us-ascii?Q?waGo3UuQcVvWII57dFdzDHGa8KBvoYP/YO/njMfzXxS5Bq4iCT7TQB3Z3p1c?=
 =?us-ascii?Q?4NopFiaN8TEx4SQwDdWpQVUwOL3kuQGY+qWDuWHw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54846c83-9c40-48d9-91a2-08db4164828a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 06:00:14.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8cbDwrnT5RZmKNkDLqnlPWyhLUyKk0donC0HWayy/notkXwre0LVNt3bKQj6wrMbr3DABuM4XnkkO0Wg+HGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:08:31AM -0400, Mathieu Desnoyers wrote:

> +/*
> + * Save a snapshot of the current runqueue time of this cpu
> + * with the per-cpu cid value, allowing to estimate how recently it was used.
> + */
> +static inline void mm_cid_snapshot_time(struct mm_struct *mm)
>  {
> -	lockdep_assert_irqs_disabled();
> -	if (cid < 0)
> -		return;
> -	raw_spin_lock(&mm->cid_lock);
> -	__cpumask_clear_cpu(cid, mm_cidmask(mm));
> -	raw_spin_unlock(&mm->cid_lock);
> +	struct rq *rq = this_rq();
> +	struct mm_cid *pcpu_cid;
> +
> +	lockdep_assert_rq_held(rq);

On wake up path when src_cid is migrated to dst_cid, this rq is the waker
rq and is not locked, the wakee's dst_rq is locked.

I got below warning on a VM boot with v8:

[    2.496964] ------------[ cut here ]------------
[    2.497499] WARNING: CPU: 13 PID: 99 at kernel/sched/sched.h:1357 sched_mm_cid_migrate_to+0x2ce/0x330
[    2.498478] Modules linked in:
[    2.498481] CPU: 13 PID: 99 Comm: kworker/u32:5 Tainted: G        W 6.3.0-rc7-00002-gb8012ce004f4 #32
[    2.498484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc36 04/01/2014
[    2.498485] Workqueue: events_unbound flush_to_ldisc
[    2.501094] RIP: 0010:sched_mm_cid_migrate_to+0x2ce/0x330
[    2.501099] Code: 45 89 74 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 8d 7b 18 be ff ff ff ff7
[    2.503101] RSP: 0018:ffffc900003d7ac0 EFLAGS: 00010046
[    2.503608] RAX: 0000000000000000 RBX: ffff88842f3fe700 RCX: 0000000000000001
[    2.504313] RDX: 0000000000000000 RSI: ffffffff823ccffd RDI: ffffffff8244e8fe
[    2.505000] RBP: ffffe8ffff20c268 R08: 00000000954b8e6a R09: 00000000950aa3ff
[    2.505680] R10: 00000000f950aa3f R11: ffff88810005e900 R12: ffffe8fffe60c268
[    2.506406] R13: ffff88810005e900 R14: 0000000000000000 R15: 00000000ffffffff
[    2.506935] FS:  0000000000000000(0000) GS:ffff88842f200000(0000) knlGS:0000000000000000
[    2.507375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.507678] CR2: 00007f0aadff6db8 CR3: 0000000106ba2002 CR4: 0000000000770ee0
[    2.508050] PKRU: 55555554
[    2.508209] Call Trace:
[    2.508342]  <TASK>
[    2.508492]  ttwu_do_activate+0x129/0x300
[    2.508727]  try_to_wake_up+0x2b7/0x8a0
[    2.508963]  ep_autoremove_wake_function+0x11/0x50
[    2.509259]  __wake_up_common+0x83/0x1a0
[    2.509481]  __wake_up_common_lock+0x81/0xd0
[    2.509738]  ep_poll_callback+0x147/0x310
[    2.509965]  __wake_up_common+0x83/0x1a0
[    2.510185]  __wake_up_common_lock+0x81/0xd0
[    2.510463]  n_tty_receive_buf_common+0x235/0x6a0
[    2.510728]  tty_port_default_receive_buf+0x3d/0x70
[    2.510987]  flush_to_ldisc+0x9b/0x1a0
[    2.511191]  process_one_work+0x27a/0x560
[    2.511420]  worker_thread+0x4f/0x3b0
[    2.511657]  ? __pfx_worker_thread+0x10/0x10
[    2.511930]  kthread+0xf2/0x120
[    2.512108]  ? __pfx_kthread+0x10/0x10
[    2.512340]  ret_from_fork+0x29/0x50
[    2.512552]  </TASK>
[    2.512679] ---[ end trace 0000000000000000 ]---

$ ./scripts/faddr2line ../guest_debug/vmlinux sched_mm_cid_migrate_to+0x2ce
sched_mm_cid_migrate_to+0x2ce/0x330:
lockdep_assert_rq_held at kernel/sched/sched.h:1357
(inlined by) mm_cid_snapshot_time at kernel/sched/sched.h:3355
(inlined by) sched_mm_cid_migrate_to at kernel/sched/core.c:11666

> +	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
> +	WRITE_ONCE(pcpu_cid->time, rq->clock);
> +}
> +

Thanks,
Aaron
