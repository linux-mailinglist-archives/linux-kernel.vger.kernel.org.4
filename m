Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3A26D3B24
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 02:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDCAiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 20:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjDCAiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 20:38:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9190
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680482276; x=1712018276;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zTgzi4U7Pjr/Z4S6Wv7WfwGxO3/3sGX7GW60S2rb6gM=;
  b=QIJdcPDUrztcsgSRWlrsfIx1yC3jaZ2TBB7hxgUuFRyLUTkdUL3UtZLv
   rTwE/UL0ycF/oVRH70Mq9+DbcastBZHCe4pwkm+v1AhapEUxLlHGoi2+5
   +Fj1mIgDsJainQk9FI4y7TGwWyWOVC00MIA9bUvlM1V9kQ+ld2E1zXvTg
   4kLHiYHQnpic2SwczUqffIDcmRWy/VquZdI2jWu8VxgTosOLs796ZlOv5
   yafbuqCiiqIkq3jSpqW7e1zcqTjphS6lbR07nfl0pq4668TLncmQEvmrn
   L2NLN81ImKLh4ZUglvF26P3NQcRbjSj/juOpGs1QOhvF7vEqLR9u6ACIf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="322174791"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="322174791"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 17:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="755042883"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="755042883"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2023 17:37:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Apr 2023 17:37:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Apr 2023 17:37:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 2 Apr 2023 17:37:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 2 Apr 2023 17:37:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKCT73PcSGFC4NvlGyIEXKcH/ObCyRTsZQbK8TU6WtlopCSukDOEwNXjmnfCxhejZabvvU1lBeHTk3KI5FsQny6s7+7lgWIiFgv29cW1dP8MykKF9SrGoyRo2F9NOoDBwclRUVmpwZFmpltCp/bWhgWpJMGTcTagnY5Jo16l2icEgAfPHPlssIoYjZ0kvyd5hijFRBHAJzaoRW2dR/E8mbcZXgEIyB6r1Ei9TwwOD7dE94vSY2crLRSN1K9qeynjxuu05fEdeoW20mAaghWBAVdXONebXWbODpnzep2hCBDgY0z74zK8dc8GNfZMiDDbOxgjyHY/j28vJgiAKUZ9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EpbVt8fngyUxn3Mxp4dCB4rRRd0RrICviycoGfHxdk=;
 b=ApcRbzp7YAaft8dcp4e8TPmRJsUxMEVCsuFgtvjNk9eLQZ4A/vYXWVjLP3NA8SAuL+QQoemU+f8Yy7gC9mJeGg+vaIgrMlmEkSmMVrVgWVuUeONQW3gOgu04tp5iBTQUOgJeDa09JfD+bWObU5FW/gLCKRAJNSQdKIRS13XfbgHH6exRxzXsFJhUtkdSoldY5kInaAdAWtkyeMGE8ow1F3eKANmzjwEKiC5Ni3SwExhmyL9VQFblkb8FKGEFKbs5X4km+dk1kQfGatvnJU0tuKGDvYqjQs9417m1zsjYHpNTYY8GqG7hjuIsYSnUM7DkjSZLb+KwtuVFwu7Zk+Cf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5281.namprd11.prod.outlook.com (2603:10b6:610:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 00:37:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db%8]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 00:37:51 +0000
Date:   Sun, 2 Apr 2023 17:37:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        <outreachy@lists.linux.dev>
CC:     <hvaibhav.linux@gmail.com>, <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <greybus-dev@lists.linaro.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>
Subject: Re: [PATCH 1/2] staging: greybus: add a single exit path to
 arche_platform_wd_irq()
Message-ID: <642a1fdcb2648_394c3829469@iweiny-mobl.notmuch>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <e670baa9bde47a3bdb02e59ec37a438a62c52dd1.1680185025.git.kamrankhadijadj@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e670baa9bde47a3bdb02e59ec37a438a62c52dd1.1680185025.git.kamrankhadijadj@gmail.com>
X-ClientProxiedBy: BYAPR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a006c4-4b11-4454-9a81-08db33dba828
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBBeMTftWQEGgl31mDIzj5waPPpcUrHO2oXlGtKgfHyQIkTt6N93I1mkt4K9CyuTMjyU0g079/Pzf7SegiPOqykfaMTI1UFod+te2wfCy7qP7AFEc1xtsFTHfc5ZBBY6BOmITS1K8Fwrj+oo6L/1r9kWwGcAMuk04GMxCOMf/c35OaVrU1k0h6haB+XguMkQO328vZD6/AePsQ8d5wpe0nOU+lnvveLNBp8q7NoPqq+JXplWwg5CJxPR/V604UyuCx7se321LG3n4Rb22LCGBzQ/W/9xkWzmZ7pAZxZsqCgbc4bPV9p17FZrMUqkvajkkoMGduMXqaL8tyTv5fnWFQyngNtS1dJjhYIsaqIloXox4jmPdF1htajkXLmRkBO6vtonWfAdO+Mll1KOw1NXdTkVRJhnzu9oe0wAuG5Q2bM9syRHGn+/EZXRCJcTlyeWhKFaJkXScPP8SWoSagyIXYYR64L3gu/S7atww13Y0Enq2OMFrnhjAAt5UgcBYWIh6lhdL7LVOMTEuTYK0GPMkR5KDOeC99rC6+mqm1wo399Huwm+dgVh1BrApMmuS3RA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(4326008)(8676002)(66556008)(66946007)(66476007)(478600001)(316002)(8936002)(44832011)(5660300002)(41300700001)(82960400001)(38100700002)(186003)(83380400001)(6486002)(107886003)(6666004)(9686003)(6512007)(6506007)(26005)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0NvxRInSpm98Zfi3UxYx/g2pHiOqDMbpMpmMDphHojqi/mcRTXLG+fW1l4I?=
 =?us-ascii?Q?ALFQbvIb934TV/H4eYU1QLD1TXQ8273kdylBxbr7ZOGu3FsfLNSS93PNtQml?=
 =?us-ascii?Q?8/2QI0rrN8KfanpNuAna4wKYWQ9qI3d3TYz0wWqUdDFCaQ4KYDJaZvq10pkZ?=
 =?us-ascii?Q?Xn/iPiLw4YyA0WsL12ip8U+hNmuEhOvZrdjyE+eqAFfJVU4cK0Mhof+/gGKg?=
 =?us-ascii?Q?U9vocvTEfcCeJ334ouZI2yY+EubjfxrNoIifKFZtJ23QvxI85uR68woVwbON?=
 =?us-ascii?Q?QqK99rBb3b0dhl6Ga6HubrUmkHT2U/ArFFrwNELyd5+DaUcyo5EetUOlIrF9?=
 =?us-ascii?Q?HuDOKkXUwiko0+qgTpXh3FjBj8fMu2pmzpb7qi4FR/ojjex2gFWMeSvCh/px?=
 =?us-ascii?Q?h1z5dJ3LRi6iqQajtXKqVUy36FhJT4wFV6H1NNax+meo8+KUrjAcAqNtl38V?=
 =?us-ascii?Q?t7xcCX+2M3qAvQoUOvsBf2qfAGA86X4txU7flSL/hwMthanRjRrhiXCo5oHL?=
 =?us-ascii?Q?WdpWBFw9pZe6xUAwOYj2DK9CXoOguxu2skAqaaE1w8DEVMfoBIomzELrJ+el?=
 =?us-ascii?Q?7hDOq8CJ6/L85vTeMuZQo5HbsZ2T0Ds2rquogAR/l1JIDCDa4V+wo4FZevj9?=
 =?us-ascii?Q?y8v8C+xa4wO8iAfC4Kw1DYkshFCGbs7C4kuT7kjjQ3KWNNlJbRijxHINYKBt?=
 =?us-ascii?Q?kJMmZEtburToMTA2ZKyOlZvFAkapewVTttYLQyuJTJL7sl7NYLdcY6/R0ikI?=
 =?us-ascii?Q?pNKRYArC22vg04hxMlJjKAQZKmRQMBsoWNaZOX2ssxOMC4ejrdq4fZ+1WDZP?=
 =?us-ascii?Q?nlsqUG/Ffjogv7rjhFOopJGV5PmNjUf80yijGZ6N2aCbEQ6yH4+pqG5vVGKY?=
 =?us-ascii?Q?vDnHTdYaHhUFZsGMkahAKwJarSmf5FapbFQsZtjalKqkyPTfbiV9KRECvBiD?=
 =?us-ascii?Q?ZQXN4spnwzFFpgIZQ6QeDHKjcDzHtfrKNulYWbDclMsu6htaMehTUjQg8W1O?=
 =?us-ascii?Q?m9ev7//beCt91Lbh9/UdjHFD16i/+8wAfNeuqCoaHoRpkZ1ncYmiutQK/YJ1?=
 =?us-ascii?Q?12R99lfARoZXlEfnMcBe3WyaIqCOiFHVsVr2sBtg1tYTUqnF1ci6s5b9XSLH?=
 =?us-ascii?Q?vT4OIiJTv/jMP4LiAe2LLHG5y45ib5PL7+KXjMuz7f3/MUUOOnqLgjpTUm+Z?=
 =?us-ascii?Q?DJj1l54uUAa/oxykYy6FyvMaA2z8p4VsJtAq6SZkVJN+kz38ViF0n4NAk7um?=
 =?us-ascii?Q?35VdphapH9f45djYEkj0UtFyr+/834wL0w/ZEwBQJ6PMdbZgDXzX6eaH9ai0?=
 =?us-ascii?Q?mRWK+VozelRiQZBoEG4ZKic8TY5qcZqsKGPxJizZ3B4L/H6rP3CwbKiXHNmL?=
 =?us-ascii?Q?39Io9YAiZkB+67UA6NFkndRhTwQ/pLuhDifHAAf83SaFLYq8jxcakXWGiQfb?=
 =?us-ascii?Q?J+rZ1jKr1ADkfOiBJLMDv2XdvNnlv3KqU1pHn0gJN+ehnjtggeMiFifiZP6k?=
 =?us-ascii?Q?HrTUpJ178uqiKp5Zr8lrO1kcFdZWz7ftvPhOmcvlykFqW6mkOwoy4Yd5nqvE?=
 =?us-ascii?Q?uknpWRLnxS34ssbIhg0FQxl0HLks+Axbqv2uPZ8V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a006c4-4b11-4454-9a81-08db33dba828
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 00:37:51.7045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiY5U2vZeJGTidp9QcRIY9Mf0VEibyevH7lpRRaDqcMRXzHgbQA/kiY8/cXyca6K32jMuenp9XYgofg61H6teg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5281
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadija Kamran wrote:
> arche_platform_wd_irq() function has two exit paths. To make the code
> more readable, use only one exit path.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/greybus/arche-platform.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index fcbd5f71eff2..a64c1af091b0 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -153,6 +153,7 @@ static irqreturn_t arche_platform_wd_irq_thread(int irq, void *devid)
>  static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  {
>  	struct arche_platform_drvdata *arche_pdata = devid;
> +	irqreturn_t rc = IRQ_HANDLED;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
> @@ -180,9 +181,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  						WD_STATE_COLDBOOT_START) {
>  					arche_platform_set_wake_detect_state(arche_pdata,
>  									     WD_STATE_COLDBOOT_TRIG);
> -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> -							       flags);
> -					return IRQ_WAKE_THREAD;
> +					rc = IRQ_WAKE_THREAD;
>  				}
>  			}
>  		}
> @@ -204,7 +203,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  
>  	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
>  
> -	return IRQ_HANDLED;
> +	return rc;
>  }
>  
>  /*
> -- 
> 2.34.1
> 
> 


