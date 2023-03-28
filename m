Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499716CB78C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjC1G6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1G6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:58:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36B1BE9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679986716; x=1711522716;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tjO+xAd2+CyRNUaoL08hECiwuevaT8FfjH/5TyKvhkM=;
  b=hU6jQQwQlKpD9Cb8j+zMdWkRhIwaWfvOkW5MpqpPQrNiqFPGa9ArTRPi
   31nJSsXCi/2CsYZ5q7CqXutP8e0Djno8H39fAAj+n2bRZ0nfs4WkpGWQJ
   qDSsy9jE02qJDk3Dv2FBN1K7t9W6/8/Y4SMUjgi//BSd6nevszmJ3xqgE
   zRH32OuGPt8i6cBm9UQJPikqCCZeeAj6TZBgH3cASnpE2/KGoUtDgy+JG
   h2k+jjUh7qw2oRNR4L8bJYjs+b03HqXmTNgFvtuLPPrZgrR0GKGIRF8Vl
   pnsl6VN6lKM39wPC+MbPZmknW0kX0FpIJphBoQf9TnCJ+gkEzwiCJ/pwM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337993583"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="337993583"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 23:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="748291642"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="748291642"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 27 Mar 2023 23:58:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 23:58:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 23:58:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 23:58:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 23:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRZXAW0BWksZzk8gFzpaPTLte+zcixqe94be3xVuXwObmIfU3PQ9PRdJ56Bw5s/+GZ1MUvTJestzZdt7Y3VGu6nxnAJS2WpWAk2ZuajPyzU/m9KY3/QsKixQ+t2EaiCN54l2IQ+pWPBBm+zpQeyeLZM1e3g1cjsPHvhWOxc/DzAF+kjG2H95imnnT4QhzD4s3EO7IaknbWWKjzmVpxC6naAyDChJRDh137z2wS0LSCPVKZeIEEb1BBzse/2CnDTdn7oXj9N5Lp3BijWHzpJrY9uCMCR9YwXmEGS0hYvS1sXvTc+H0vWdODTT71bnGfffWXfWgcfpcDDOdEbmuLJMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUCH5YYUb0EqPFvd8qRY0uunde4Nkdi5snEHraWQ/UE=;
 b=S5VnESdpJxZjsHEq4aRhp/mCLe3lVeN2yLsFHwt7sfXBLiqCDqxhtzdo6btL/O60wmC9C5xSYDH17oBCTB1Qt9zxsD1aM38caVgoqRFZN/IxqYC4dYH933Z7W+ul6lxyC611978efzVQ22AQTv2f2/zfejRh7yUrjKyug3MTlTohR0dIRTdWlB9JXzBTmgi+WN8Uha1PrxDFXYFj4VMe5bwPPlneXodHrf4cwhPSE8WdywhvyJ0wm8CnAisdQ3kcVam/WNai+aF8Ocv22i82TB5W+5VtZ02JaBFHF//wSJ9zsHFbLWBSfCLrYALxxXJ7Z0guTfHfJZ23hr/Agnv6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY8PR11MB7265.namprd11.prod.outlook.com (2603:10b6:930:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 06:58:27 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 06:58:27 +0000
Date:   Tue, 28 Mar 2023 14:58:09 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: rq lock contention due to commit af7f588d8f73
Message-ID: <20230328065809.GB4899@ziqianlu-desk2>
References: <20230327080502.GA570847@ziqianlu-desk2>
 <b5e09943-36e6-c89b-4701-5af6408223e8@efficios.com>
 <20230327140425.GA1090@ziqianlu-desk2>
 <fc66a0a9-aeb3-cc80-83fb-a5c02ee898ca@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc66a0a9-aeb3-cc80-83fb-a5c02ee898ca@efficios.com>
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY8PR11MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cb2031-d75f-42d2-9843-08db2f59d4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAE/HlvNkWYFrTAp3vHoaZyhRZR+wVdbrRIUOTSBnQm4wV8qfh2cUO9lABSNL4pTG8bXVKZjF0Gf4LTVicEkMRmk9lzyqNhqcuMRp+punq6xzq+F1wUE/ZCipZqusDXmhH8R8tCKdJ49smPMAQvPkMrWyYcE0e656bEA8d6fmqW9uYMX868ii8eSUwShiH77+FpDHquD2r3iipbzFgMJCudYLM2Ulko2IMeTa13F51TyaOF1h5FXYRs/7HYOD815ECXGsz6o6ItVhFy2OFuZD93yY2pPrGarTGzGVh3DG2+Vv+fcNlY8JJ1U9uyY2xn32A94X7sucVg0rbVsMdeNVEXk+8eCKyWdP7x/vdHfXp6oCcYcz18B5j7njd87fRiIpnoCxgnTg90wgaD5y127aZuBjBXmiqHgC4dGY98rsDeUlN2BCkY4hb2/dNXL8Js/WLAaE8DcSU+Pf3YMMjthEU85M5JPXPzJSItAHvcWWakImJF76R+QgyfL6Y22FE4+JV6IDDQUrcU4WbDnYJI0X+rZFCe44kSK7sV9SHwfuRBhUoSlWrLzqoO2lWYAjSl+H+yOK/WUtQsn1g1X0rE9av/ZPfvEKkioYEqJAu3LI5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(38100700002)(82960400001)(33656002)(86362001)(33716001)(2906002)(6666004)(4326008)(186003)(478600001)(9686003)(26005)(1076003)(6512007)(5660300002)(8936002)(44832011)(6486002)(41300700001)(966005)(6506007)(316002)(8676002)(66556008)(6916009)(66946007)(66476007)(83380400001)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4QQs9VYWf1B9Q/W79F1qvYLfRCBwmjwssN94dMGZNfmHw+omuXaK8QySTQj?=
 =?us-ascii?Q?RQjuJlKLmX6AWo38EuXWE3pvyQbK2UIBDfVnhuefzTf7eV1UZ6q+qQyi5lPJ?=
 =?us-ascii?Q?rcC8ugKIcnnkOx1unvdmiMaVUBqSv1vbVMvnZ7KCvnud8vhbkDEH1ZjSa1Ui?=
 =?us-ascii?Q?22swrmIZ6CfQJaXAL2bY47zC3djboLkF8Tp1R1SLlrmnkOjfeJh7tKHXg4To?=
 =?us-ascii?Q?f7t+ee3lV62w2jKcFYy9GTTVCbmvXfPyK9y5cNkUAVsWJhtlVO/bOi+mjDpO?=
 =?us-ascii?Q?T0H8tXiiVBiPGe25X68qS4ES0qPHxj1iU3SaK0J+q1SNSNG05KHxDuNQGN0o?=
 =?us-ascii?Q?oAS3a27pNEDdJqJVFHxA5dnpr0OtlMiMLBwRyilhYn4/ZwtbYAx+5Nqt1znn?=
 =?us-ascii?Q?u/ywIM6ZnvFGUC+RGirI4wqFSZiS6J2t88G9B+UpR60Vwqn4WdeIjgmbmnJY?=
 =?us-ascii?Q?6w0iEIUE0f5O+FOh6m7h8tQsICLGc27G0kosHvoMHD9qqgiKc2LwqutJMVDv?=
 =?us-ascii?Q?gkoEilwT4CjYNrknxN7H05Vr57eHuBUNyJTj0ACL65y1cby1bnEbYG1H8ypb?=
 =?us-ascii?Q?f7IDQih8Z/+UxU+RsRNZgzIZ4XAgSiq7HNL6xbNJwCGQMgOT1HMO/QMeNs6b?=
 =?us-ascii?Q?tgPfKcBvJ5LUvFH1Y9RNyR2CYcMwk7NdkTR4vox+Xv1m7Mrvc0nrprY+q5j8?=
 =?us-ascii?Q?FlcdfTrVpDZ5XNrfGDtrbXt+Uv45vi5Uk9syrabkp9cJkCGxS4syFdwe3kXm?=
 =?us-ascii?Q?32AmBJe/D+dTpHdZNlVRkX2zCmIGp9X6tnlBnEhwkCah84j1CHUHm2QUGRJO?=
 =?us-ascii?Q?ju1i+om9zmKrBQ81wD/Mcgo1bbf8IxooCbEnvuYuR8MXcah0HxMTb8OKXwWx?=
 =?us-ascii?Q?RDR70OuHf+mBkILqSWgeAXdwqjl9Qb83q7WFuH4N9IoCrdJUsbgKrqVsjL5M?=
 =?us-ascii?Q?7/JjzwPwLYYKSCLlBCVRTaN3Siz5LiiCMaTIQ6G6bxkmHttC21JyxbL2/5b+?=
 =?us-ascii?Q?xSFG7MHs9j/MlELyt0JN5ASSRsJsWAJCZ6s3P9536p1o3CsPe0PCFMF2WmVM?=
 =?us-ascii?Q?JpF8iGmHFpR6O5hCu8YwengsxlbOCzw8tb6Ak2DwzkHIZUa6ELKiBxpjHItd?=
 =?us-ascii?Q?DYdTc6ztlQL9fjgv4NRY8OT1YcWIKEM5qTMPYCs/zEYf3ictV/CE/Wq4PKJq?=
 =?us-ascii?Q?gn0H8IfDskQ7QWjwgWgX2AdtM7xOA5V51LtywA6cW+dMZZxxcc9PVkjZXq4B?=
 =?us-ascii?Q?S5yHS5JOPluY8VqAMuelzfnS6rdOm+N/0Gp4JnlKOMsh0UAsFQ3JkGq4i3rw?=
 =?us-ascii?Q?SsDjiplqukCNlhpS8D81PjeeDeNndC27wxR81ZGkGvg7g1XJsGVlh5+W8dSM?=
 =?us-ascii?Q?/p6D/CswQFtTVegljt6Qq8ok1WAuXCd582xc1HUYvo7gukGaHSw5jMOp7NWA?=
 =?us-ascii?Q?wzqUn6TWDzrJZH+Dx1n5XwXmDGaUwazSNHWVJ2CgEgjhxeJrAi0y+PB2OcTH?=
 =?us-ascii?Q?9mP4LTqRiYQ8h8hJ84trR8lh8IMj2xMs0V87dOD2wqZ4Ygib6Fu13Shqepkk?=
 =?us-ascii?Q?A6uo9jl4JSjw2Q1TaDeieKwh8mkxYD9vqjB5Zayo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cb2031-d75f-42d2-9843-08db2f59d4a6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:58:27.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFntxkOFNLaMRl+USUfTY1xTLOKPtXUBBLfTrSdNEwYKKr/ArzWgbCYESTtzvbDklHNiam+NjbV4VdDM5afVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:57:43PM -0400, Mathieu Desnoyers wrote:
 
> I've just resuscitated my per-runqueue concurrency ID cache patch from an older
> patchset, and posted it as RFC. So far it passed one round of rseq selftests. Can
> you test it in your environment to see if I'm on the right track ?
> 
> https://lore.kernel.org/lkml/20230327195318.137094-1-mathieu.desnoyers@efficios.com/

There are improvements with this patch.

When running the client side sysbench with nr_thread=56, the lock contention
is gone%; with nr_thread=224(=nr_cpu of this machine), the lock contention
dropped from 75% to 27%.

v6.3.0-rc4:

    75.21%    75.20%  [kernel.vmlinux]          [k] native_queued_spin_lock_slowpath
37.30% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_sys_poll;__x64_sys_poll;do_syscall_64;entry_SYSCALL_64_after_hwframe;__poll;0x7f943d6fcff8;PQgetResult;0x7f943d6f9a2b;0x55c7f9bde88b
26.01% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify
11.36% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64_after_hwframe;epoll_wait;secure_read;0x55c4d1363867;pq_getbyte;PostgresMain;0x55c4d140c828;PostmasterMain;main;__libc_start_main;0x5541d68949564100

v6.3.0-rc4+the_above_patch:

    27.86%    27.85%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
7.31% native_queued_spin_lock_slowpath;_raw_spin_lock;try_to_wake_up;default_wake_function;pollwake;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send;0x5637a602e4cd;0x5637a602e98d;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
4.62% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify
4.20% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64;epoll_wait;secure_read;0x5637a602e867;pq_getbyte;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
1.66% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;_raw_spin_rq_lock_irqsave;try_to_wake_up;default_wake_function;ep_autoremove_wake_function;__wake_up_common;__wake_up_common_lock;__wake_up;ep_poll_callback;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send
1.65% native_queued_spin_lock_slowpath;_raw_spin_lock;try_to_wake_up;default_wake_function;pollwake;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_data_queue;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send;0x5637a602e4cd;0x5637a602e69e;0x5637a602e7ae;0x5637a5e5f62e;standard_ExecutorRun;0x5637a615abeb;PortalRun;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
1.63% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64;epoll_wait;secure_read;0x5637a602e867;pq_getbyte;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
1.40% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;try_to_wake_up;default_wake_function;pollwake;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send;0x5637a602e4cd;0x5637a602e98d;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
1.20% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;_raw_spin_rq_lock_irqsave;try_to_wake_up;default_wake_function;pollwake;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send;0x5637a602e4cd;0x5637a602e98d;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
0.83% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;__task_rq_lock;try_to_wake_up;default_wake_function;ep_autoremove_wake_function;__wake_up_common;__wake_up_common_lock;__wake_up;ep_poll_callback;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send
0.65% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify
