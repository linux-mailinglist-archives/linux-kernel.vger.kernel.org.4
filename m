Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F2B5F3241
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJCPDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJCPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:02:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D722832EE9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664809374; x=1696345374;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mYSv2hTJllXrkq94O8YzfVy85E2H8SoV9Q9he9GxvEU=;
  b=TemvWb6EbgVz+L4gUWfXZ5KEut8YHkFJas5ivwBNoETbTQykKTMOv+TR
   YYq/jOAEzwCmCKS0SfVix+Qnl7O4S0tT3mLq9Fc9K4aMNaPxUXbJpjFFo
   RDc5tFfvlex6cnW/eJYaHvGVaGF5GdGjojmycxAAeBH4cpb7J68VBuJQP
   lKaeJn5fghXUV88jvBu3Ep6oy9pVbMXiPJF7it0NzZqg18gkfWT+vZ/Bm
   lxMwMUfWJEUBNAxN0pWW5vb1hOD1Tcc4FcO/KDtLOiuEW6aA+kdpIV+84
   ysdPi3EamEKhyQEb8iLktpQroNWuDXX/iPzzZD3qmKX+usEwy7mK62RKa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300260391"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="300260391"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 08:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="618757727"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="618757727"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 03 Oct 2022 08:02:28 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 08:02:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 08:02:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 08:02:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 08:02:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF6Le0cFgONUxajlkdvltdQ1gEX3weAWOUWHGEnP+lG4zVHbDlciqdAW818pvN70f/i0iaWtJNRbKeeP54mmrAAE6xb6/g4hF2npqqXGPQ5N6qiFnRah7SVvZ0uoZSqjU5Jg5HIg04yCSzHsup2/KDLRU8zsEhwiQwMVIoXylgawJsrUiodzS0lsv91aiRPta3sc+K9oD0cIWlJHbSRyjW9CbEbyb91x7GgTPTNWTSJYVlUYThlrored8s1aIuP7mWXAqm3wJ8OIzJKo9MPPu9TJwNllJZm6H2KQkDYuXWw9KsktFxsNbFbgtgIC9hTjWz6UE0FIPSnliPvSMOs/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9z3QPiTPmncJ0pIU5fXOCpww81TjLtNpG5Apt7jDNA=;
 b=dQmkyd7Fy6DEemE//712ZeK8ZMV96hatRCYw0nsroPGRiVu2gIvGheH+9XlG8P2odvVQt3/aZbTq7gKBy5yVPUDpnZYAwsb/LFv1AmOiRiyZAxAd/JWjAH+hRAt/MFM5xucckGaLYa6WIlTFWrJi80eQShvy/6WsAd0U56bOBEtOdA/VXY3DvwjWbvV4hX9PvfecRTcgSei9ByxRUd9S3ysWNo4woaxHg4ZOrpYVPpBUPUmuRWmjCJFaR/BahCy0M4HKG/xSLabL6jFk0EIRHVvTipuZlB7KEC+SIodEeGhE/yL+eX8d9VAuNZTLxK65G1MtZOLX6iZcM/yWLqbiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 15:02:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.035; Mon, 3 Oct 2022
 15:02:23 +0000
Date:   Mon, 3 Oct 2022 08:02:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Message-ID: <Yzr5e9tagtsDq4WY@iweiny-mobl>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <20221002002326.946620-4-ira.weiny@intel.com>
 <YzjfcW6OGcPP075q@ZenIV>
 <20221003071718.GA1986@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221003071718.GA1986@lst.de>
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1d7259-2703-4f36-1ddd-08daa550471d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTiU6knOtpTzsAyfw/0RXzRT2wnKRX5ego+6Dm/kZnUml48RV9FhOHBSYECE1z8ecOQDqfxguRGGHdRI5FpggTm9uF4speHgqxhF3uayDudJYD2FoBxYwwx3xjjplT/eFwfQkTahxk7zYOBiPebKhnqMfeXx8Uet8rRgcm/w2SafAEIDwcssggArtnihJn589DNNHQSegFnm7xtZuMcd6RM3hRqxTPUoWYJJLyZWx1TkW4OwOJlOOoMGsopItwQDZL+f+0vRUCevHmSJgzFJgzCrPA5mQNGW7tmDZ7n4sxB4fcwccwu8HgjNuu0XmzqZyGGY7EA7zRkGm8RUnsYN7vA94IqYhEqdTvQaOfsijLqSM8aArYzg/8Ipvg4ds76xLOKc5CK8CYaSgHiLyUjS0vLt1xKkE5DAGPuOigiFEWeqs/cFc7yAIDV87y9Spl15Z7/1Pj1T3IHKaHWklXZzJiN+HUvzXBHOLJbs6svwNK96Oq9RSKG1UZ7T9kYLYc0LpHiCHufUizyzPSBjWb7KwLCPiRxsRQPIEcW505iMf/P9CIpu6RQ8x511W+4NhsW1RFN4zO/puZ/Nl01eomh69L3018tr8G4CIAuJh2cK+5pPvICri8TWvkyvhxEfxqhknYRvXRz6+Ebxt7lCLNBlm2zL1dpXXRQM1ZuZAOwBJCA5TwZd6XizWmma8ngqao0v0r/prJ4jo7361cjSsMLTmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(54906003)(6916009)(6506007)(316002)(8936002)(26005)(82960400001)(6486002)(41300700001)(6666004)(2906002)(478600001)(38100700002)(8676002)(66556008)(4326008)(66946007)(186003)(4744005)(66476007)(7416002)(86362001)(44832011)(5660300002)(9686003)(6512007)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oGBjjAlzBujJbwyaSe9YgH9dGzHAO6+tSzwbeTsg024zrzBhH9ot+VJov7Lf?=
 =?us-ascii?Q?uwlYXJP3dIS/cZ81pziTbhWAGQpwOEH8c3jaOV9mUSaLmTXe8EneoSXLsfSD?=
 =?us-ascii?Q?9301r9HHj0UVjRCgwf5OUw5yVOYj0wi4IiHNySMm4th4WHo98c79z5+OJKeG?=
 =?us-ascii?Q?WAZ3eIhNO16Dk/HlkqOWZLxS9kCqilQGzPPvKMTASMOi08M/lekiEpdn0+l/?=
 =?us-ascii?Q?d+TU7ruMtYHsAPofAd9T5LfXQrrLco2teRmiAwJ6TmzCQAAEBftdVGAY9G/1?=
 =?us-ascii?Q?+EE4XmpgWQaRav2oEla1jbUfE5ctr/AhIj07yVdy6LXsF0K4ROKNEdwxxGwD?=
 =?us-ascii?Q?lvaQkEEIPwRJfE7wqbiCK054qbK6NfXcAtvXXNMuNEIQYRBEHYb6gn30CZDg?=
 =?us-ascii?Q?CiqwsTNsZdSpNC7/nC8GcfHjmopEXq4hGX0tsB8pWu+13NOBbxbjHAR1CTsR?=
 =?us-ascii?Q?YpPCS5Libz/kaDl+BvaqI/zNpfp44WlxAK4C7+zaRGmW5wCxFY1PE4oAN9P/?=
 =?us-ascii?Q?c8aPPaQWGvYShGKA1Z+q4kOg+KunJBFInAgagzBX2rodeHE2fZraRzbmq35I?=
 =?us-ascii?Q?LauwkXE/nWY5mJJoJI3a4cBfBzlSQCEMoGUkfXvbqEjhDOLNM6aVrUmdhFCS?=
 =?us-ascii?Q?+ti0eWo1HUqmkzcZ6ACC4t9Af7WGlHpsURTOhUrk31MVvkH1mdu0D7K+9ss9?=
 =?us-ascii?Q?MgX4Xcs4ITZkwxWAZ/mp/OnEIskKrQZyhd3VNcPFHrbHG9i2lm7JNUMKLaUM?=
 =?us-ascii?Q?fLSgLuvknjvP9rqhngwBJU5bCL4RxbpWHkNMllFZ5MtNJRyNVx1uRGgR6H2H?=
 =?us-ascii?Q?X0FxOqgKpfeKf4tXPJ1WhbDK+5obOo1u1vrEJDUW8VlafdtextIfIXOJgAp+?=
 =?us-ascii?Q?EB14W1UyAYzFL47CfK137ahp/hU8PjYqNtgwTEqERYbK4Hyer2PkKuXKYSda?=
 =?us-ascii?Q?KEaquBNaN2B+DB3CshER7ogh1isHr+PR6Ivx2FRUF8HmwUmO79K9ckTUDQNo?=
 =?us-ascii?Q?u+opaE4PVlDfX2CDhrhwgyQVILBdsv484AsfPkoDgZaVcyWwGnQPoHuIGtoY?=
 =?us-ascii?Q?Uv/XN5PZEfV/aIeUgGEygUyHxScavVBLqdaHfGPD3btAwU/iVLIYqCM06Xx0?=
 =?us-ascii?Q?+C4VvjgSBCqFV8zgUO+ryPIazS6PaFBsmiFyZo8aeVCaeFzO0xpDlKLQiQWo?=
 =?us-ascii?Q?DeiJQ680JcTgjvSc4le2uA4kl5EQ25ZYzejDYYNVWSogfKtBORfQ8yhfRz1K?=
 =?us-ascii?Q?NLq/+ZQ5lIoEKez856K6eSsLKDD+K0QJtACHpxLX2CkgocnrVXr0fGfHjhAm?=
 =?us-ascii?Q?+6HOS6FzighigmW/1aYOUy5wjtSoC6RaDcbBGzjepJ3swLuhY2PMy1n0MaRv?=
 =?us-ascii?Q?KDcMN2MwRUYSFn/7QbmUFQ9Byz6SjcV8W+esglTht/9oj1Hi6ytNC4m4M21K?=
 =?us-ascii?Q?1HfF3VQ6YW/rNrG0fxm6MsW/iodVu6sGZzcYkLputZY6TQ3laKeXdgG/8z+h?=
 =?us-ascii?Q?Ma1dHPlDewcAhB/BF8FU1CgccbhBG1Ik0XMuKPmf60x8mxEDmP5qoe3gKxa6?=
 =?us-ascii?Q?/87z9yq3Sn/Ryj5G6bn+fVRHrX4SSqWZqU7KbdK7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1d7259-2703-4f36-1ddd-08daa550471d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 15:02:23.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAgphuW5vvc4ic3lIElHCcnw/zizq8Mxwq6Qm/tRj5Wat25xgmIIUScUonTr2RWDLdC3iBa1KXBqmYZq3haoEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5530
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:17:18AM +0200, Christoph Hellwig wrote:
> On Sun, Oct 02, 2022 at 01:46:41AM +0100, Al Viro wrote:
> > IDGI.  The only thing in kiov[...] you are every reading is
> > ->iov_base.  And you fetch it once, right after the assignment.
> 
> ... and that's exactly what I pointed out on the last version of the
> patch ...

Apologies I guess I missed it.
Ira

