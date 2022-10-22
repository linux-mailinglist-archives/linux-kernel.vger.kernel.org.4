Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E260903F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJVWOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVWOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:14:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9398B2317A;
        Sat, 22 Oct 2022 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666476879; x=1698012879;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=riEy9inmj2eQG4Bfbb5wn4XQjnyWL+iX1yhgUdhiJQA=;
  b=nnMA2yX0sQ4yEc4Ztrj1YUNadfNV+aG22J5Xywa0c8OsqST1Gw5AQg4X
   fBQtoH5z7pch+X9zCFiaqJxn7d49inulM0/8XtoUkPSzeTn3NNOx/cfdO
   /yk0PQeBcBSvF6GYC+mLqXuQGEsMG14zSf++WI3VKHo8dT+1dUvLrECI5
   p6PYq9PaU0SCrmGrGqoZ4k0zFz22wMZILWRIN3tDvMTtqCyeM6a+156E/
   g+bWjAIQABFg52I+XNV50uLnBBL6fHLOxbduMX0cOywc2JtKa/GdWutb0
   DJmW2oOMsQaf7rHI/Z6Fpd3RYN8LyuiBlvQhpLMZuzyDyZc7MnOzr/Ash
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="308310094"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="308310094"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 15:14:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="664135833"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="664135833"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 22 Oct 2022 15:14:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:14:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:14:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 15:14:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 15:14:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdV/fep3DyfvZeG9Iiuu+5kiQAsrW7aEHnESNPYHW4iQgG29ylzBEbIaBRfsS+MQ1lsKve5cu0RLe5mgxLlR2FvPTgcBYnIP5HC9ecbrEfUazgcyT5V38GbpLP1nIWwj69TSbK4hZCHaOPKbVaTvglqbrn9mkIVwC8wRrm5Yp7Fb8yL0U8vEudYLkT/YSElWBcFmOIiOqtsDxSMAnBHTYwO2bB9QhvepayIgDbazvviYcmEw1+Xguqr30yiOikUVhaTR372fpnhKJGrk8dsSY1EXP+sAjihvjYPRTqb09ZtljDrCRzujsrkVC2VE6mAbXa9y8yUkUSiX1vhzQ/SoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaiIqWEHB0XowT6HOq+veOSZDQUKrjUFZZu//B/XaQ4=;
 b=claq5bo10zTkKSA3Pr4uW5qflpxh7/1PNEdlNO0NgRlxraxRd6rP2X8gjlwUWiy2IBUlni1dpX/cTD9rrUHXbF+OIj4zRmD9yAriJqudlZ944f9qziingGq+QlNeEfFLYa3dxMXnoK7cHiKLH+rLTzXO7Ep+Fl1SMZUhVXoSTBYZyQ5cmi10wNGhfKaLeIuPntPiVS2fheN/WmFlwy71dBNTJ7NTt7nSjVsHxAgo6aFxUyOTMiFlyVcrSPFZyB+FnFcWfYYhNnyjxeEUhYd2DPxE1P5OB/ryhEk1DH5AFNSBwweTXSAI5AX1Sq44NVoabzrX7b8FghIMK7t6jxvoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7017.namprd11.prod.outlook.com
 (2603:10b6:806:2ac::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Sat, 22 Oct
 2022 22:14:35 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 22:14:35 +0000
Date:   Sat, 22 Oct 2022 15:14:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/mbox: Wire up irq support
Message-ID: <63546b48dcd31_141929434@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-3-dave@stgolabs.net>
 <20221018103815.00003cb2@huawei.com>
 <20221021172324.efg7vzrguvd7m44r@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021172324.efg7vzrguvd7m44r@offworld>
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc55831-8162-491c-4bea-08dab47acd7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJ1MyuL0/TR+QT3cXaVPHO+Ogw6RtkPPl8PyRazxgB7+NJsXRUwDklMyzI8P3YrdB4MyzfGnG7os9ZUPUnn1nKVMGxdHuhxFsM1wKWR9k2Fad0b1MvDOhFR7/qzZTzIhq+86weX0WFZ2qr93AC7Ax8m0fVJBRZqgzknuNdcdXE9PLi9uJhCHWAoTS+0laBlw9Jl8CCK3UlvgU5X7+D0sJmNx6KaPnkDhvH48BUaEhR7n84MmNztS46fQQf4UV24OI/HycK8JBJvQiyS2IU6JZtDQ2VPexmt/7BNH4ba1N2zJQectFIDkul58pgsxw0dNiwwsLG3s9q4Wn4znhpWAOR/cj5Fb6ErkLTfukpRawBr3h5v47S6gCrjwQHDA1GB9RgbLP4mdt5ELuwae9/zG3To9cSWe3C0uqWiLEXQv/sJh2Az/6wj8OpTv6Y0UyJmmnwaF1NRz5ApL9taMyUJbN6HVNB2Q7WIuTfYCKWMf5NxYHAEpZo7lDT0OMhapTYz6etfRKlZp7W7C3wSuw1HuJYeKnL6C2QDODnhSV+qVi/j+UlgBMYjanyG62e10HNM+gdCdnNRS482ODi5GEGys1zkzMspQxD///xRbp8ExkIbF6bStFSpluf7ysbNgzKS9F89YVgQnMC6/e76nPM5+Gb/KiHNoCai4MWeBUT+MqC2xW6rvQQCJe2DDCY3toJBV1A6lPxH/LgSRUv9x9e33Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(478600001)(26005)(9686003)(8936002)(5660300002)(316002)(6512007)(6486002)(66946007)(66556008)(66476007)(2906002)(4326008)(41300700001)(186003)(6666004)(110136005)(6506007)(86362001)(8676002)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lnLguBG5nmEo50owKALgbmoLlAZJR9EninmGdKdnsaIlsXUHpqXQUl/AkRCo?=
 =?us-ascii?Q?N+axBTBVFOMvumZJGHs3kXHI9u7OOepdXXPtOBmQkiKsrGt0P5JkLjjVUxCa?=
 =?us-ascii?Q?xuq8asS8u5/ntDGgRBiADFuJcWwNbSH4UeqHBLOkh7HZkWclR5hUtBdN9jEy?=
 =?us-ascii?Q?Vc0LfAEIbYl4RIwvz7vv2DfKNO7MfpXSPcCEkc2/bA0Z/zxpQdO9ivggILbl?=
 =?us-ascii?Q?vT0+3ApdvaJ4ZIRxxThR4atxq/cKhLnwasKZBil8mzmhtmLFa0rx0kCartFJ?=
 =?us-ascii?Q?nhgtf3j3HbeB2xOsoVknIu64CL0yuC65yzfmTbB4NHs25p3ouivxOycWeiIm?=
 =?us-ascii?Q?nmeLCs5AQs9yjXAMDAfAeetYkgbI9iqmpqzt8tk+OTJtVmhZtSt2KHqLrDWC?=
 =?us-ascii?Q?C18E+M7GgNw5csDwDBrX2wiMAz7SWGJFjx3KqkVgM9T0CTNP+PiRX5J+xIJa?=
 =?us-ascii?Q?FVabkTX0S/04uASi1QWyC78QBWD6lZSu62qaUgSfdps5b3ZujRBdFGiqbcVw?=
 =?us-ascii?Q?CA6aPdC3cTj1Fu1J7Ff9TB/CohQI8Qo6r+6g4H6osubWTXtvwYmzqlqWcYpq?=
 =?us-ascii?Q?66eSMS3qwA3aZ5/1xaClODqLAmvfGy6/QdY9E2sF7tH2CMlYS2llGOqhqIdK?=
 =?us-ascii?Q?Um4AsJiK0IG6z6OfJ0ZR5QZLCYNVNKg7F7Sro0zF8isBgTIQsXGZ1f4vlhqv?=
 =?us-ascii?Q?gcl96qXGwUGyeeppEDm1quUVIHJuAn4cIDA6q96LfBwmh5OA58Tbh6E0nIu6?=
 =?us-ascii?Q?T0SrTiY714wGK6+VPdawCMyWumZCCh5r5mCz63DJ2I278Vmg70UpwkvtW6Bo?=
 =?us-ascii?Q?qrhoSMTPX9MDggES9MJS4kjznND+vYFo+hqXCZcW3RckeD7syNi0SFyq2yCU?=
 =?us-ascii?Q?1HCQg77ntxF1Iw8HyJIO2Brqn33ksuptJq/Kmk+wCqQjPkJ1vo9MF2VVQAFE?=
 =?us-ascii?Q?i80UTKOtaXeSHo31wLssyU0mF5f04vKjdPLtyD/sBomJIARZSF9KSDM+NmH3?=
 =?us-ascii?Q?FT3L9NaElGElC5P/nPfRcmst3e1vwkiJzPtTnMI7UgxXmYJ1D2AndqVcvcJr?=
 =?us-ascii?Q?A/AySsdfnCBWCvRji+sCkVoypRlYW0iOq5NDQULhx3rGaScCb9rgR5orcWZn?=
 =?us-ascii?Q?W9/82nQtwilyMPEVTAWWz7rvywuY+xUpbnW26E7DrH4WO5TT3CFejTTMmchz?=
 =?us-ascii?Q?oieJ92G7RmV2s1c5nhQIAqyUnJJfFmoem2ZwFN8kND4VH6dtvB0EM2bVQMlP?=
 =?us-ascii?Q?ZZCRVmsV4kv5bED12DYfommX4lLrH/F3c785Gm4RPPjeFo453QX2iW73+dU/?=
 =?us-ascii?Q?UlARJwr9uYZkXnhF7WHBKtihZ0iwUDYy7phYROpGOdoozSs5WM/sboD5X8c7?=
 =?us-ascii?Q?ktf91QnzPzDTxFBRl4z7aRJse9H0oh4dxJRhf7tNYQLhianfvXvlmE4t37Ng?=
 =?us-ascii?Q?m/1VBuE0/5V8dK5qt6F/8rEhXLG40u7dRIuHy86zUptVCDZmb3GEnf6Thq+J?=
 =?us-ascii?Q?8dsRXtbRcqXo4RXbr1RZ3XYY1SeJaLX4KtxvVp+8To96vtU17eq+qDy4fefr?=
 =?us-ascii?Q?q11vcBhocLrznzNxAVRj9aVyr2mAZ8k7j3t2fZgBY5H/bGNQbF7BLfHxgneC?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc55831-8162-491c-4bea-08dab47acd7c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 22:14:35.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFStdMAEGbgFlNrA3nL+/CAW3VFKa0rT6FHXVLY22Z8ds2xRSa7xvAMI3PfWMLjObq4lH1nKsvkUsa7802o4uW6YkkCBlQcCGZ4ET4Yp66s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> On Tue, 18 Oct 2022, Jonathan Cameron wrote:
> 
> >Whilst I get the need for an example, I'd rather this didn't
> >go in until we have that background handler in place.
> 
> One of the reasons why the bg stuff hasn't been re-posted is
> because the only user currently is the sanitation work
> (and hopefully maybe scan media soon), which in turn depends
> on the cache-flushing thing to be picked up (unless someone
> starts ranting again against wbinvd). And that is in Dave's
> pmem security series which I'm hoping will be picked up for
> v6.3 at some point.
> 
> So I guess we're a while away from the irq thing. I was mostly
> suggesting sending an mbox-only just to layout the
> pci_alloc_irq_vectors if we're not using the common table,
> but per the above this might not be sooner than the pmu or
> events stuff...
> 
> >Unused infrastructure tends to rot or not be quite what is
> >needed.
> 
> No arguing there.

I do feel that event notifications are likely the nearest consumer
because the whole reason to do the RCD work is to support OS native
error handling for these CXL 1.1+ devices that people can actually get
their hands on today. Error handling and other RAS flows need to be able
to hear the device's screams for help.
