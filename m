Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070766E1F93
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDNJne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNJnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:43:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2781940FB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681465411; x=1713001411;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YuiVPkjZko9epCBD1YqoZ4Z1v49ZbFwYnSLw39F6zbI=;
  b=Q+zjuCBgOkCS+UuLqLb/JUyDWaJA7eNVK+pGvADnIK0e0ngJpKxz+JvQ
   O2Dz1pDggbBGcidwdmjEpmfxQewwlikJ5lf74hDZ86jjJR/gpfbdeYN03
   +6bdWhNd6CKpTE8XPofA6/P7jCYaD9sKa7f4i0Tz52cLfnp/LyFAWzzs1
   chwLlUuTT78xvdUP0PvEx4B49A+B2C6gdOl8dJCggLhgfATZJyDsD/fyV
   dbTiW/OsCj5F6lA8UYO/jVH+xRzMePtX0kFmzNxSKlBrnOBAvya/OFro7
   0MUvIcveuLEIDlSaqLkI7SVbEQgzy2o/+/PxOdhtWYqeOFNxbt3E03i4Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="347145583"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="347145583"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 02:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="813812711"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="813812711"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2023 02:43:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 02:43:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 02:43:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 02:43:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 02:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKSgBI2jgTFAVW1GdeqCxVNqEblarQAHd+a+/ivLwy8TX5Aj/Pc9sGxgfcmTHSNOYlpCE+xbucwFVBrypjX05+xp5FN7kg3bP+eZrxnSfIln5LxRwWB842fndaDfDsRM204bKAKbSeub/764WFp+rfoKi9g50+r3QEO3Z+SHbfbcuD8c+gLBjs90xsbJu1deW426nVfu4BXXICxAkc+fGJPBeX4sMluW4sNDwrMZ6vVUIKCxz/St5vnQBt3qrTMckjWEDh4c8xq14DEa2s0TchdeSpqtUc+W9X0NIDKMxbZ7yET/VsxnoiG0I6BJ+Y/uUlwIJmq90iwa/ecOOX2IfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuiVPkjZko9epCBD1YqoZ4Z1v49ZbFwYnSLw39F6zbI=;
 b=PouSmTcd6yjJV0Myp0iwqHjv16Kv4rWyhaHtIQkzbVtLj8kDeFRiDJoS1W8aqUO+Nzy5qhXmkADxGdYzKKJURdMROW4JIvCijFRkRwJv1Dqy7C5Q59ho1MLvfq6Mi+Q57lxo4eAIyfes1EH1k2r8zHiTBgzUqeUs6lVRKZCYUAGJdKoA5q39s3NWKQ+Zl9fgfyoawXQh1kZ/WSLcnEsxMQyfEkRaMSnbwMJtjycRVEOwmwlkDr5csdBH9kC9+DuOdczDgxeWF+HDJEQL6LaB5kkXFceeic2vsZMVuA7WApTRxBdwl3PGgHTHZKiFDRxB2CXTp1/Evui5uH6pS+Rdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.43; Fri, 14 Apr
 2023 09:43:27 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:43:27 +0000
Date:   Fri, 14 Apr 2023 17:43:17 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v6] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230414094317.GA265612@ziqianlu-desk2>
References: <20230413223356.17195-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230413223356.17195-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ2PR11MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 577d9a88-5341-4ae3-c8e9-08db3cccb1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kz0oHDyo1Tys01JuPYWbXe+twhmBBJrBYLYd0UsTHVUQ1BE8LztmS/6BdeDl40ZRjZHmirkeokEEuua6u/jOci/qtwbxpbnpqCsZVV/+9Nbj+U3B4lhnEyQUmPq/swaHqMzzm9W4i7mDohtxds10k2OvUkyWz1WpoVpcZ9H2165nIG0mGQQiy/llzqvWOtl7wiAqgpnLVWHLX5DWNLaK6SOHw4zPvdkdO9X37lrah9ooKzkPm2/9DoKzr8Ok5blPzULNm0kZPScPz1wbcKH6MLR7tVv7vT2Ogcw4pMNVqXzfSEBq6joNVcVYvfePVBXcS2Zc7HnwBWzkD0XERmPlTcrTIcy5v5GyqTmLIgRsmwcHU0EZHkG4b2XR4peSqQ3qsyN+M7tcYJwPIvW8x2mA1sq9es0sUmSc79T34BmuvIOBjhwWR05CIAnttxmgse5zYTjzFmWHXyymScFp//0kHAzhtiyb7aEFl9/ykpSGz27NylAMQc2j8e6NvuE468fsgeDC8NyX30o9xiWbeb4VG0emWVaW4N+W/3DTUp5mJMsJC3UBDG+InpzSs2awOVK6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(26005)(1076003)(9686003)(6506007)(6512007)(186003)(478600001)(33656002)(316002)(33716001)(54906003)(6486002)(5660300002)(8936002)(4744005)(82960400001)(4326008)(66946007)(8676002)(2906002)(86362001)(66556008)(44832011)(66476007)(6916009)(38100700002)(41300700001)(6666004)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PySJdH8eQmq+goApbl2NANCYk5ED8N6ldugp1QdcjzYvfpt6Hpsi3tpLkn64?=
 =?us-ascii?Q?v5ZcCOtbOOr0ctRCrwoiUaXzMuEe7Y+Nh7yw8LrwlJ8jEQtrRrD8Hdj4hMQR?=
 =?us-ascii?Q?PLp7zmyPTvi4qwmo8WNWjpUCTx2G3MVcXPZtwWRwtkTpMe6b8VjiQ+CQcbJw?=
 =?us-ascii?Q?MIVHdMuc5d94+QNrru9vVbGCNnstaVzGRKU+WLz7D41/FJfBtZt9lObxLMqM?=
 =?us-ascii?Q?YHDRJ9KDv/E1sasUKvJVoxp9LbfO8Prz/I1VOFBWOj+b5RYrIA2REZJCTlT4?=
 =?us-ascii?Q?4A6zhXjyaQp576XmmRlIUEmhT1ZUkC/tc3dVJC3dd2unEloVL9PVFRhOymqW?=
 =?us-ascii?Q?bQmvj3EqcOH8byvPS2Ptlgn+/946GHHa6ZF3ZJyhNAc7Sy5MmfgHvxq7j5RK?=
 =?us-ascii?Q?aJ3QpCUQR4sRnPc6F5i6w8wHvkwMDvmUpfJJjc0Km40ReM1eJoyIllNhob65?=
 =?us-ascii?Q?UKX86pNlyBYO8mMJFcfF1pmOgKaCXDi4Drjrl9A1B/fysubIPx7+O2Xapn0+?=
 =?us-ascii?Q?rBJ/1wJtDu7j6aCsFX88LJ0f7AFcmWwhWV/pjZe/zeMix3keMJkGwCV+JKhK?=
 =?us-ascii?Q?wt4zvRxLHZV+lhPvvrF0AQYtW4agD8iYwS30O3ztlVbAi+cUchcTYXGhwxAn?=
 =?us-ascii?Q?NoBldzGmdjEMr/DfVLqURs2IkR5G0WCReIZxjlh24G3I+hAnrLl2DjpDXxBk?=
 =?us-ascii?Q?7jZ2JmEmGdlHwVa1uHg8gtqOLfS6IJC+tpPF4pZYpfD1T4wu38v5hiByIlsB?=
 =?us-ascii?Q?HnUQQqgWRKgAXmN6p1p1r0c9XzB2yhYn85jZ0MkB/ZsymxaKXrlJXDhr4Hkn?=
 =?us-ascii?Q?/ryxxwMw1kvppXh+aYiMgLZLYYhpMStkPPgOaDz4Az6B2rt+oRwsek29m2JL?=
 =?us-ascii?Q?hOS/ymA77lTFLt03dgiS9ePZHFR95cWe1Y1JJZq+MIURcFKxTQoTf4xiAZkX?=
 =?us-ascii?Q?qWCGbTL3hFn5UWIgj+uYMBp/95s8YvNI+I1hk4q4aUyJS2YaVOV+zbRQptG/?=
 =?us-ascii?Q?euY8o1HkD1wwoxB7gfw6FURNfDXsOsEDnBmVgV2flIZncOc9UOEDBHLxOJ8n?=
 =?us-ascii?Q?PLNxC+SUWhy2NZcJC6gghtUXM7r5U2THoBxnWwjiLLGK4Q+gPD1EBmF0hVfH?=
 =?us-ascii?Q?RPQNqkN6d3ECwO0vMVIqjaNoEHxQpni4LJH58mk13b8DLwpIsI+AXGY9elrt?=
 =?us-ascii?Q?xFRg5CI1hiR90kZrDPnGiip71JSrttVpYMK8phH/tbIJM+wW+NSqw8Bj9s5X?=
 =?us-ascii?Q?aNx6m0m7/lr2hVRKC93DtfhXjMqrW9tXaVwHu5tWczm+QNUjuZmtKRDtP4Cv?=
 =?us-ascii?Q?3E5s+TrN5XiGqGfb3GaAfRFcqAmag7C8N1Wf88vTTY/RPjC32wntBYYFcDoj?=
 =?us-ascii?Q?0JEEwo+KO/L5NqpJeCA7uUDBF6k1D23tQZgJcpgvYjQRT6MHbk+lz3PsbukV?=
 =?us-ascii?Q?BroTESWQfYsTM94aL3OAMHZYhZur8jJF4MQ24Rx5SpIJQf+n0sY/yk4YoqkX?=
 =?us-ascii?Q?Bm3W98DGOS2Pca2Z2VVNefmH331vPUVE9Tp/iBdtLMDDisKvFXHWqeAx4TPd?=
 =?us-ascii?Q?lodcqy0+UWfmMwPMjDhItgtWEK8o763wKQLRAiHU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 577d9a88-5341-4ae3-c8e9-08db3cccb1cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:43:27.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pggNJ7MMqEenKvn1RY68f01ziNnTUi4J/5RaCjc3vnMAbzVDkzyMRAjMbs3nDQ/huemCl87xH2AdkAAvknaeBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
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

On Thu, Apr 13, 2023 at 06:33:56PM -0400, Mathieu Desnoyers wrote:
> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> sysbench regression reported by Aaron Lu.

No lock contention from cid.

For postgres_sysbench:
mm_cid_get() is in the range of 0.2% - 1.2% during a 5 minutes run.
Other cid functions are pretty minor.

For hackbench:
mm_cid_get() is in the range of 2.x% - 7.x%. Other cid functions are
pretty minor.
