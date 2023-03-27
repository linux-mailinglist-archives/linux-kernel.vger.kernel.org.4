Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7922B6C9D21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjC0IF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjC0IFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:05:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D1749D1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679904321; x=1711440321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bF6FvUsBWv5aao+c+XUQZz/pLDCLvZpbUI0Ma9Oo5XA=;
  b=nRakkajxQ1ODVbP2W5ty4Mizu87dQ78ydCC+FivSWOGwNeGQfXq12jE2
   2EggbGNa4hOeATrjVMB/uCwDvgXtGjpTgq/Qa4eCrqzWYyq4+lsvVd9Re
   vG2eJxQ97NS9+ko0pi3+n4qiElfINYji2+VCM6GfcR2KKgVM0VmE7On0r
   CkfTQAvog4N0LFNucspMAHUhGrRkmz2brK6h+5CdAw2cvfN279Ea1X2yK
   7Dolw8CCVusRSEhVN6OLEBiulLOg9r/pa4cdzWgcSuqmtsJprQrm7QQjI
   Vpcdm3vGeCEiKySLGN6g5fZk1NWm+eBIaRJYVzt8f9ipZBS9kl+Q7a9SW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="338926243"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="338926243"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 01:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="752601955"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="752601955"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2023 01:05:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 01:05:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 01:05:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 01:05:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 01:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juhzNdSreKJDgLaaIlua66uLMUsGPZPxbp0+5jpMesz4xjus6tGGSfWzpcBkJhSa0V10H53lqDNh0T0TvPv+IbBiof/4e50SHNHSNpTzOzmdmCuB7nReTj0T6OqM3YItYTiZCl+mUf6TNylvCklcrLbquKOGjsRCuTsm9U0PEKekSow3h3uPFaID/a6fmzayA/DJM/nRNdpqr09oozYsNlUXupzLfi4J/ZUGlpjCJACXVVhIXIohPFtNsNnNqacLSMwpbdApL59hNXPJ6o6oEjwonk/JvjheXKlf249/8yn5Nma7hVxOxaVaTU0RxdSJpGQ32Fe65tPkBxg4kC8/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyrXOHCjLjNBrCbhGfxJFODYI+kXPg4QEe1VGAap2wg=;
 b=SCTZeC8r0Qjnf04DWha2J1LYUUx5HA6nC43g7RNH1EhId94kH+I7QL0SnAjOOlI8SjSbUEM1FZ72kbJIXMMNC6ZVGDs/FeGonODk0uqgQShn0DAHCeTJDLGVvs/2ZQeb2xvcpMXjRuyI8O7yZJlAMlAOqFBlPxvy1Of2XYECwgEEwpxv5L0Y4e1pD+5Xcp7zIVF8ZP0oQ31uoDgnV2rUtHsKMnCjHBCc3clQRPV0vYud+dtR8iWQEjoWlJY2FhmeYZr4dMHMl9mgi6hyRHlz6jIsC0hhtkDfYempyBJqydsuIjt7abjuO6X7fy09zuPZjQq4vNizMpyuCtF0M9mW4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 08:05:11 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 08:05:11 +0000
Date:   Mon, 27 Mar 2023 16:05:02 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: rq lock contention due to commit af7f588d8f73
Message-ID: <20230327080502.GA570847@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM4PR11MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a88c45-2113-4a77-bc8f-08db2e99fd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/O7VsDD3lzLFWjBOItp2Fuj29R/fKo3kr5pA3/ZWXvViXJXEkCtcCCQuCAvjCLE12pxzn8KJ5gW/Hwjd9X/qpYLy3hkxRbpmeQYY1T4EXVyiEynTulljg7mQHo1gLnLkz2/sLgYV3tYt+SOxo/KLMb0ls8NWSKa1ef2/nf4JVlTtzMbCJSTTeh8YkNr5jS22SzOFK5Z2L8Ujqwp7Wr0X0U+WHWM8utQFl+qpaDBuw30wx0bsklPErutttmrMDM/XNdXwjFrXnAzS4+l3pDciY6b7GjKLUGugO8z0f7eOsjRi5a2AdVeNCKRMYGdXvXk9ogpvTTo4Jgc3nPdfgFunmIZrEzqV7pC6L8LUiIYhdjJVOZp2F2U2Codli1Sc9CyyictVbZYteRlySxgLmxWvT8LHmdN2/A+y6CjYnd8kOafKGxWQSC/BUTvudliFp52DvKtFGLxF1/KlRBR48PU7G3wTHlJVJmlb8XMOJJOjMr1Ip2sVGF1Js9vFTGIN9I2Scv2T468KctAl2r7hsYPTHakZLVprjfuSbk5vkzTV9Jx3TBaA3wace7QfngMOz2InjCZP6djb0jATKrCC4p1gSZNb/SFn15g/KPRvnJfdvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(8936002)(5660300002)(38100700002)(82960400001)(1076003)(9686003)(26005)(186003)(6506007)(41300700001)(44832011)(83380400001)(2906002)(4326008)(316002)(966005)(86362001)(6486002)(6666004)(6512007)(33656002)(66556008)(66946007)(478600001)(33716001)(66476007)(6916009)(8676002)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xi9rybDLydYmPZDfiRX00JKXRmkPCAi9LjM51/c6lwLxCZUwYpLVwEgUWEv?=
 =?us-ascii?Q?jtVysNywd9aidhp9PNYJGv8YO4g0H0iidVr24LNNyRaG9/GSHCxuPlasiCqc?=
 =?us-ascii?Q?bS1luGKBx1ikbT0PvQhLJJNcF5Jm9Hyy4lg6hDXQmJA4OljfrB80s0W8qlMc?=
 =?us-ascii?Q?9H2orvVxNsyR545D+1NXUZ4kz0KJsE6ZMLGw3PpPwS+q2Vk/Y51y34AFznoP?=
 =?us-ascii?Q?4Sxds+yYfkH/8Lsyo7n1cAHOyK2kKV0mw7ZaHUuyLCfTA2bnmWynx2qu0Duk?=
 =?us-ascii?Q?35vwZTw/avoRRZhc1viSSQfrXONkUcfq3JRU8i0ABR62BPrD6Ld8BCbkfY+t?=
 =?us-ascii?Q?WacxYs6eZKlY4A0c6jOu3uZcNb/oIw3x5cERbDkUgtbHO9kFna95t1aNfw0A?=
 =?us-ascii?Q?Lb5/23z3+PTPK1snHi6CT/qkpFkmX8IJPkTIoT7rUmMftFxvcU6ztziJxBtf?=
 =?us-ascii?Q?ZoWK4b+zqlHeloP4ZooRHyWfxyVWq0ROUodPEnI5J5tRaDjxeziMuQ6MSWvz?=
 =?us-ascii?Q?/0/WRZjSkZ+Z9j4d1QZeW3G3fJSWeNXhPm8qi9qb0jILvSHr90eCH4F4op1w?=
 =?us-ascii?Q?jsGPzwzxDG43DnBQRw6nJg96j6USUnVVgjRLNLCF+SjxVJZ8+9d4uYYZChFK?=
 =?us-ascii?Q?FnOG/WACLCrO0O2WTixScLXhgYVS7QwrVB4zti41PMZ6h0c2feqVXEuNd4I4?=
 =?us-ascii?Q?8pGyUOuG89NSk3gjwF+aznU7Z+0DhoPLUgg7dRljt4qH3/X8ULpC3aX2Ep6P?=
 =?us-ascii?Q?Zc60rLxu02zqHHesTaDD0tMC7fNU9FLsMYNIGZTjAWCg0Xi8nUXIO3Ab+weC?=
 =?us-ascii?Q?mNKRcJToCSnLY1H8JY7hKDOvsOeL9a0NHHoUEDJhXJGS9l/kcRTqYJHJSprK?=
 =?us-ascii?Q?8mdOccz5SKHyKLm1WQHIluRDOpfPrTzuhwBjy3a/9ETENShBuRF2WyaO5Aou?=
 =?us-ascii?Q?d8SF92odTKGwoQPdTKXo/Dpzd7FHYF6NZjGRsivnYcgiamds4xQY4TseZ+TO?=
 =?us-ascii?Q?gsuGDZ3yOy588ta3hSstsm9SY1rvZ+SWb8VUtsWIn3j+jeC8HKkRLe0iZRPu?=
 =?us-ascii?Q?BBnQ6WfGARe2IrIltT+VMT9O0ki70sBkqCl/NKz+QSs+IBQG7hMrWvAK80GM?=
 =?us-ascii?Q?XLDAgFPm2IsXef88Pa5Hdxu6sSe+ohqGPWkRhMA+BuOR2otYAw996chaPMIz?=
 =?us-ascii?Q?wFIi19+TklTJ/TuVyCwhD45E6Ghl26vyWSRnhJVH0Jllc1Xd4Z6P9lgHcJEh?=
 =?us-ascii?Q?EtFejkxMBvneZCf9piyeichpFO8swQKfpge+1Mgdgz/rUkLOUkF/uMm319FM?=
 =?us-ascii?Q?3r1lw4Kg2Xn7+Hi1+Tu9xsj4J9zD2XxGMJ1LBuk/BKh8Qs01yCBORbkIKJhD?=
 =?us-ascii?Q?rRn6MNBg7QSNn4qyOoA/IUNgdlTH6O1A986igHFhDxc3m3cOOhFLmLd6FGdo?=
 =?us-ascii?Q?Nu0zWXczl2qv8Xpp4YYTuHbvRItDSh5zH3RTuod2+zag4QJ2iF/5pgtIQnce?=
 =?us-ascii?Q?WORs6ru2GUf7xbvao0CPdrEiv0Vp4OrBONLeU9q71AwCVzjY+yxTzdCT5i5c?=
 =?us-ascii?Q?tjiKopgySdYDGmd/ijxAPrhiGN31E/90117KnCwG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a88c45-2113-4a77-bc8f-08db2e99fd22
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 08:05:11.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Puj2MxOJ0iJVDNXXplC/HfNndPy3tc+mAYUCBBuK1bRO4myfANyg4OrzwaRkG+diKtpFNxAKA6j8lUQkCX+4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

I was doing some optimization work[1] for kernel scheduler using a
database workload: sysbench+postgres and before I submit my work, I
rebased my patch on top of latest v6.3-rc kernels to see if everything
still works expected and then I found rq's lock became very heavily
contended as compared to v6.2 based kernels.

Using the above mentioned workload, before commit af7f588d8f73("sched:
Introduce per-memory-map concurrency ID"), the profile looked like:

     7.30%     0.71%  [kernel.vmlinux]            [k] __schedule
     0.03%     0.03%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath

After that commit:

    49.01%     0.87%  [kernel.vmlinux]            [k] __schedule
    43.20%    43.18%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath

The above profile was captured with sysbench's nr_threads set to 56; if
I used more thread number, the contention would be more severe on that
2sockets/112core/224cpu Intel Sapphire Rapids server.

The docker image I used to do optimization work is not available outside
but I managed to reproduce this problem using only publicaly available
stuffs, here it goes:
1 docker pull postgres
2 sudo docker run --rm --name postgres-instance -e POSTGRES_PASSWORD=mypass -e POSTGRES_USER=sbtest -d postgres -c shared_buffers=80MB -c max_connections=250
3 go inside the container
  sudo docker exec -it $the_just_started_container_id bash
4 install sysbench inside container
  sudo apt update and sudo apt install sysbench
5 prepare
  root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=56 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua prepare
6 run
  root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=56 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua run

Let it warm up a little bit and after 10-20s you can do profile and see
the increased rq lock contention. You may need a machine that has at
least 56 cpus to see this, I didn't try on other machines.

Feel free to let me know if you need any other info.

[1]: https://lore.kernel.org/lkml/20230327053955.GA570404@ziqianlu-desk2/

Best wishes,
Aaron
