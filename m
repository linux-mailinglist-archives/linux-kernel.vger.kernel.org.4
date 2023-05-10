Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806466FE6D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjEJWCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJWBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:01:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547EF5FC9;
        Wed, 10 May 2023 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683756113; x=1715292113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8NBU2X1YXCT43bLFziLD+Ho5B1j9Yv8Sft6XqP+RU1Q=;
  b=Bx3/X/xX1X9VM+5p8taqxztGj8MH+kPSmivQxRW5/NJWtISkq9cRraBn
   jJAKZ/3HUgY8nGj4Y4LHIs/owOmnig3ZIl6yVcQughtPyT2pwHIdpjD0G
   sc+j9aB2KvLjqz+kwTy+8zLYZWkhrxdS+09KIYuNtMfoLAQlKB4prM0Wy
   jVsr3An2EJ3rsTaxV92V9huEvAk4ViR9ajIGNirP7sUVz7jRRBMhmaPbw
   SBLzRH2HBr/L0uB0VZd+0C4ahr88SVXtbGxj21kdgjSD+HuYhxYtrsCBY
   uUafr+740dQVEtZ6tEf3cfJk4kcAn3Z41sFbkoLInv0+XebGLqBQYE7r7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="347799448"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="347799448"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 15:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="649890991"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="649890991"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2023 15:01:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 15:01:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 15:01:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 15:01:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 15:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2b1UTmOT462ojoBgFq16B6OgW/e591MUF63C1gSNTH5fr7I7jezcvYsRpunA0meIFFV9Di+Lys1wClLXbp4c/tVFfeL+T3YUbhH3odt9RcSRf6RM0haZcVX1z5L6Y13WevBAJ70qGEv7g0dvxEkr7Oofxjan5mCOtm2NHUCthSRfc7kiA1YnVGsJPO9r6MHWKgCn9eQpq8wYN0E1hCWTVGibSCmlxEKAcyQS+w1xEwt7+fk3z9EGPXYMXyhe1ddCBwqTDSgo7KhdrVCi3TzoMriKC9B1YH48Z+4PPHjr5xCxViojVCjPtuNztprOTIgqWWIvWSnvC2gx1AcZ5LD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OASBJYU21F44tUNHlAU52Bg0XyQAN/7LkHfgexiGnac=;
 b=SxYpJvY97jG37s7QzSAHTscoGqd86Vum61Z4P9DKoxBv+DdLLE3IBQJcqaPyxlcqz3w9GxHTBb8tl2qTowMpylvdCL67o50PzW+MgnuiTmYlIVXZaQrW4dFHcfMEeX8Xwu7E6U/s9Gnhb6csaGl3EKq4tIYZzyLK3MN26CNN68BTE5ne9T3rH9vfxNCn+VB6vXuy/v1/78ah4BCsphYnh6ZIIEMqnDsxbDW61xYUzBDAvd55vdxJodrrVTcp3bcMmiFA7sib0CVqgl2BWIRT5ZUWkv0K1DTbhUgcbY+yur0PXLxiGwNIGtSnNyIm8cfA7w4qG6AbGPs/0ZRVG/8Awg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 22:01:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 22:01:44 +0000
Date:   Wed, 10 May 2023 15:01:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Raghu Halharvi <raghuhack78@gmail.com>,
        <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>
CC:     <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v5 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Message-ID: <645c144483244_91698294ac@iweiny-mobl.notmuch>
References: <20230509165218.139568-1-raghuhack78@gmail.com>
 <20230509165218.139568-2-raghuhack78@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230509165218.139568-2-raghuhack78@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: dce16d54-b791-474f-de69-08db51a22484
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSEEcfyilcW998/enj1Plv8WYPbm18fdnMD6vxV8YdOgdPjbT4909xU9UdskP7YECTZ6EA44g0XQWbtanCS6BQ0lCTl2HrnxHdoLRzD203tRwXdf1a3kNGfGvb754/tUrFEksrRcjl4PLrYhG8MhFIv6vBfOiosf0O0V7tpau/7AKY4ohbRP7fStsTEhD83Zh1KQlh2XofBrdTrDGkPjrSj5HtF8iR3TTxRLnHpOw20FaEMfB/rp2iuwfyI/GtEyxB42MgxIZe9yPVsxS/rmAsABzpqwgQ0KyLf9TINzrf/d69ciEUz9xSSCcS3TIb/9D22Hg9E2bkjbiCgFI2FHohpStRnYk6pdj24OUOCzONL75ukGAmXG85jztyKmxObd05nfrtiiHSJj/t5opJZEoWtcCSn9eRdl1jjyB+a+5vdrOe+EHva5hvmtNVAzWaxIBEqJRmXje1LgH8NPHlF1MAiOPwVV1+YAtjZyAMDXH3358v7vSLrW4Wu8WPnbn9VwUmhwa1DeEh0w/Ie9yYdJk1EPts5SpAXBH+UtGlHGdYN3j5GDWV/RmZXYDzcE3Dsh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(44832011)(8936002)(5660300002)(8676002)(86362001)(83380400001)(6486002)(6666004)(110136005)(478600001)(66946007)(107886003)(41300700001)(4326008)(316002)(6636002)(66556008)(66476007)(26005)(6506007)(186003)(2906002)(6512007)(9686003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fgnoxI9jnL86yRV6zud/0RGHPFaiRlrDpjbGK6zkNOZkwxQ7br4xhUyH7zv0?=
 =?us-ascii?Q?e8ByASzcnNryk3IlipYkyfWJiOU4fAJufXlOcpxN/K0bNZcIYzFXrSTkSsQs?=
 =?us-ascii?Q?jqDcEgAxA9+wSHEFXWGY5D6m/n4YAHccIrM84SQrlCtwuGgpGpgjDqjP4k5g?=
 =?us-ascii?Q?kK2zLpZNlwkzUf6vwWVH065UPia0EmDC9P1mIdkJdRgw9TozUxDfPHBcR97l?=
 =?us-ascii?Q?Q5x4n84RcIAC3f7p+8noTWJ4k8/d4ye6sLEMzyo8nK/x9bet66FweMrP01IZ?=
 =?us-ascii?Q?/EpzWSuct/q/OJquGf5b42GBq/qDm6wVxXvcKz69T6O7Z6tdsINYxt+Vl6n3?=
 =?us-ascii?Q?ix/jwTqRHBAm1Uo+sXqMgo8s0UfkDK+peli8lM5MZuKHSjNYxMerozRAmg50?=
 =?us-ascii?Q?QdluBZIcfVRCWy3LCaVfvoeYNUiZlx7+r7wwR+wHiIKOvqyKGg13dzySQCKo?=
 =?us-ascii?Q?LdiJzgf0fISo1CyuBaccRD6VBzw357pbBNTmTRjKDNEF0+5RXPkobtcWjhqZ?=
 =?us-ascii?Q?y1BheHca7TXGBMntG1++2Xp354jImoCGEZtkfgXF+z8FtbEcmyJkjrHryDe0?=
 =?us-ascii?Q?wv5F8w2MHxTSIh4nAbYRQOBH+ktqH/sT5CiBL5HmgunBhUcoH9F++H6aRTnF?=
 =?us-ascii?Q?IA2gzqRPFO+N5TV1SYpL+WhbDlnen1sMWCDhTKJm5DvV6el9QLPlmfzcu29i?=
 =?us-ascii?Q?JLES2JeOgoTK4NoT5MmFkjuSGJZcEpQxgzJWMPrDph68iyKSbW/gLQVfINb3?=
 =?us-ascii?Q?kIx5WydlwunDBjmzy5tlqrpjHu0cNSxnYObg3WxkZ2OQjNMNSH8BzONYdVzM?=
 =?us-ascii?Q?XOuehaFj0ec7x5+90G61Q/ZLOk1Dc4gZoJLHBIfcOneUtM6rxwB0oQBxo1Jd?=
 =?us-ascii?Q?huw6BAEobZzTyL8UYNWrfCb8ps/H7ssVedal7Hd2SvTUUkr6QDD1P5E/M9yU?=
 =?us-ascii?Q?0rldOTVYiuf72pfF/kvPuIOWhyQGxiBAEJJcokPjNShxUedXdQjUBfYu9uu6?=
 =?us-ascii?Q?Z0Z0iScJ3g/v8byHcbCfGQvpxesUyvrwUHFd+lODcEV/Yz42nF0LKEIXAIoo?=
 =?us-ascii?Q?vrkOTtQnpXetnbj3emLtYCTnUXLtzk3leci9fGY86HeC2So99EUHrFCkA+rW?=
 =?us-ascii?Q?01YfxXe7Yy7ieTQ3Ez28r2gUsmjr7WpyxpD+WGKsFyfQQDIn2XTTOjvKWzcm?=
 =?us-ascii?Q?wk6giUquEtmg3xM+1U4PV8G/Lpr9q9526ToS10JXYAAFYrVdShOIByl7eLfC?=
 =?us-ascii?Q?De902DVyZR8NTZWqBf9NxR9NDKxnADBeYPjw8jWm+4P4Kb2EgImoDxRPu6a/?=
 =?us-ascii?Q?jVAXKj45REc8B2Jp8xFf4gF8G2OiOwUA+Y6tDO40ds7RuEUqbapfffANBdPN?=
 =?us-ascii?Q?lZwdos7bBi5SATX0b6lQq7bUTmaYchQ+MnaDjZRyYK4o+E7EdVFzmr481lXT?=
 =?us-ascii?Q?Ebhd1ZIMXCSSocl4R0BoKv8wDB9fNpQW1evh1onUvOPN+tXuqw1K1Q9OPyrj?=
 =?us-ascii?Q?ogFemo7+ik3DWRGsuiLOw43iNMu9/tc2XrCkdty8G9wEgZ+H2LrGWFEP/QAH?=
 =?us-ascii?Q?5LOI32S2VHHQ1i1fAuPzkfk6eapvXWNiy5NkuOpF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dce16d54-b791-474f-de69-08db51a22484
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 22:01:44.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GnsOt1SMwk5RoUxvuI9zdwKZsG3xSYfoLC4VIdG/ETKF8NTaClCiuTtA2kqKteQSVv7jy1BY9gCQFF2GGGLZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raghu Halharvi wrote:
> Issue found with checkpatch
> 
> A return of errno should be good enough if the memory allocation fails,
> the error message here is redundant as per the coding style, removing it.
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
> ---
>  drivers/cxl/core/mbox.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..11ea145b4b1f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1112,10 +1112,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	struct cxl_dev_state *cxlds;
>  
>  	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> -	if (!cxlds) {
> -		dev_err(dev, "No memory available\n");
> +	if (!cxlds)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
>  	mutex_init(&cxlds->event.log_lock);
> -- 
> 2.39.2
> 


