Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010A770A417
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 02:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjETAqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 20:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjETAqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 20:46:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0221A1;
        Fri, 19 May 2023 17:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684543601; x=1716079601;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QnNVI0lR8sTm5KjhSfEEk16054xwVQVZbJR4kx4TGDg=;
  b=dBjPUlBJGa9pYlvXwbljhd1FMM1LK4q0xSXfwbhuGCtROzysCFlkgGfC
   IQ2sYwEJJhV9OTanZUXKiuytrHukYekWVfdL2GySYkkzgAbpp2EsregnS
   Pm+mVSuoWVtfmQWmYD0nT+DPCIJtk1gA1mNBO4PTNQzYyRkemqjGXxMfK
   j1oHIInA5/IidVv7f1gJ0jYs7k0wqC7ZW402N/tbRZJuNUc0ckn6/L0Wa
   vlaE/BaI3GGTXIVgmmHAtoSbVVJFGuwr1+8qeMc7b1JLt9kmkq52a2N4d
   6PiQwQkYv5MtKJgwxPck7F9v5grSdyMW3JOky67HVSZyEk2As/DfDPbUr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="352541364"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="352541364"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 17:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="653253749"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="653253749"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2023 17:46:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 17:46:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 17:46:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 17:46:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 17:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqSeBp9BoVUUDLMp6XlA0tBNo3rSLaJkuHDh/ACNk5o6e08LO/+xaw+3F7bl+3Gi0R+IZnkjnD+uApIi6VSS+/GNw/YHGY5VkU4YkXiQE6mjWkDGs3YAZQqvLEH0L9CRRnRvmzahcBI/mE0GJ/zy57S7xNehgZp26ZxahT5rphUgckkOU3bVa7r+5IDHtdotj/xuoqv8dwqU44l163MGbVBjmJaZm3DbhWnzhZcwRiq9qpLA+Lo/TTWhbSBJGs1nsbVHsw5hYLELe76swAGPIa7CKMPG7/i3BZHN4q1ZLBN55JyUKgIpQCX5nXtaMJ+dOuaThgPToiGkbUoo+LVuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTiJeocoZwo9RLk7Q1NFIgCSlO2KuHtouOJ8CPisk4A=;
 b=KEF1hSNi9VLVP+dL9WCezvCvJsZzbnFpeTKPw8mEDsiF8T8tCZFr2+Z0xn2QPd/K1XE29Hcg8Sdo00AtbWHs9g2vCxT6MjB3kNf0TxjsG1Y1FQfefHOXnnkRknDFOExfVcOiuq9M4txZ/jAs6I2Ou6osw7uW69KbKPJTdyE5rrWLNcjnDNfFZeDPEbkyyICH5kdHUREI0qhslQlYrDw4cAD1CNxob8H+Dfdb0HOBa9BLl2c7Im65137NkZaOg2Mm8GIxbFSHpDs8IUgN3TSlui9W0AAEZ6eKJhwesr+PUd8Xbjcn4xOWnsjz6Oh2+6yBc8YVD5lsa6XXRqEUbZ1/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Sat, 20 May
 2023 00:46:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.021; Sat, 20 May 2023
 00:46:38 +0000
Date:   Fri, 19 May 2023 17:46:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/port: Fix NULL pointer access in devm_cxl_add_port()
Message-ID: <6468186b29617_682c12948c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230519215436.3394532-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230519215436.3394532-1-rrichter@amd.com>
X-ClientProxiedBy: BY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5ecc31-1080-4986-3181-08db58cbaaf4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJtRQ5O7uXPpbKNhGltszOwvUUk5SE6AMkNjrlI7icCydOtiCOwlpW0SY2EBNI1X3+lbL5M3wpIgewKwJUDdZNA98FVINESiAe6RcuJFJBTZcHWHOI6mFi1ZipxQ9Nb/STZr1mW1dR8GXCGSQRRtEu9ierxNO9j4pasuKzw64oN04CuofnYb3osXOTaAyCV4jLFCMPN3hkhKnSAcysNIUBSQvSikyt6trYLSE46XnCsiErw9aB1sGYj2z47sjJnnjhkgR6VESMfPCRR1D7mULLLgcruBKF8SMUSFJnHmv7spbEvIkjffUblP3w8saSX5KslI18MeGJon3hY7nvapDe+Fas5+rP2zT5YCKnXUhwXc9sGAcb4yY394XcY6Bhgdi7V7MACciU2d8jpoocLJLh0gVQWvAyKVkz7me07sx/nTAN9ykHBPczsuNkCUrZaP5dnX5W+MRFRfqearsWA2ZRukNP9x+JVg12z/9lsFfclJVCu1n60vukDJL17XpTvj6XbNOBN2uTszaSKjP/gyGWBkOw1dqwEXwItMdUAMUwS00NbvwpX/z8ahdVUFul9u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(38100700002)(82960400001)(6506007)(86362001)(478600001)(110136005)(6486002)(6666004)(186003)(6512007)(26005)(9686003)(66946007)(4326008)(316002)(41300700001)(8936002)(66476007)(8676002)(2906002)(66556008)(5660300002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KM2m6ZQDxNqLqbqNcg868ZWjd0E3VaS/M/5oqONzv5vr4PrXLD/Q81RecYR6?=
 =?us-ascii?Q?sXKHFI8SEYzap9QA7ei2WVbEnRXlqBZ+TIUUuLltMTKKfZz9/MoAB4eM+Gar?=
 =?us-ascii?Q?0/W/sDUcA8POvIDZwgROaNKKL+iib1C4gu4cEHA5XA8+Is8A/LQ5CDmgc1Z1?=
 =?us-ascii?Q?JKVTl4Z7wg62biLAc0x7hR+EgwQOrZM/gfFSFtxZkUIzgWYHB6QOcYUF4LYn?=
 =?us-ascii?Q?FEBePtH62TYNlDO5XYXmriwPbPTfm0SnHsx+8qT9Fz+3XWykHpejayXSmTmp?=
 =?us-ascii?Q?Ni7JgNnhpjOhSmYONpuy4EosdnKJWJ37FSxQ2Mfs5boAy3/PkSENu56I43UU?=
 =?us-ascii?Q?+7Dpu2lIUIc84R2NA7p6XBLYqcKvky2A1IM775RpHRvgWoMGwXMZpZwWPHkL?=
 =?us-ascii?Q?v43iAcgtOsWSXdf2lxPC6gWgxt366VFV1KLiGozV4SkHr0zEW3pvc8kdPXGz?=
 =?us-ascii?Q?XVCk+EU62MZI8VCp0PjOfqIt2NUMyBJc7BAgDXRhehYlNEwqV4eWEdecD/88?=
 =?us-ascii?Q?IT8JyW42fn6KzzxjIxeMNW8RINfOLb8UOJ/6YVu7fyWSDoU0IY6r/7ZBMtPD?=
 =?us-ascii?Q?yzL0KazLvlhHzMd3w7TJEux7bkhfLTV6+Er6n0x22dumHVIuWtuqMHH77mtb?=
 =?us-ascii?Q?ku4KL29x8hdxTFRPxhTQuMejF13N4m3ghPEbNfzLbGox2mmLmIhtyxyTdRTl?=
 =?us-ascii?Q?IAqx7WRJ2CWlrAMb2mDuAR1uyjDMfAO2LGb6wngx8pAQCRBHlpGhtr6LP3gW?=
 =?us-ascii?Q?q+T5Ybg2c91nceQ17EyqxjaAQiGVvNeIn5Tmxj9eFoxNwWxt6lssZDd/9X1g?=
 =?us-ascii?Q?RCpuSxzxxKCpHV8e+8hlaXaqIrv/11poWJ4Jdw8H96X9FOFMqCV91D9Ajer9?=
 =?us-ascii?Q?RMmje+TLzVVadYoFxoqWevkR+2Ven5D5BuHURywOXWiggujuLDUsWZ+Y2jzF?=
 =?us-ascii?Q?zqFOWPTH3tcI3WHXY4cR0WO9xGhz0KybMtnOl3dqrVMWiYLx3e8V+ZIBmjDB?=
 =?us-ascii?Q?DXjijen5yLY2Z7F3V6w0CA9CjFiDAIeqfAW24WET4C8tfHGPjEIoeD9Tj+wX?=
 =?us-ascii?Q?ZoEJgNk9b6vfSdxGkvrppi7dR5JUSD87Twgl1QxiFw7I3Q+RlOW0QcbUxjR/?=
 =?us-ascii?Q?XM7AT1NCAq0xwLfx5YklHPSFoRNUjfDWMk1BLwnKWaRxPOCNk+TqtOsPXYtA?=
 =?us-ascii?Q?OYMacYLm2c/gerawwXJjN/GDiOfN5Nm6iVKKAB2/c43i8TqHgHhjWNwIqP28?=
 =?us-ascii?Q?snZ2dAbGt2Id3mCpRavHfacY6GsnaaI0GpICn/50WVdAMY6ItV11V2H7/6rI?=
 =?us-ascii?Q?rfJUAHEQds1nk7psdxmr27ofoAGXxKXtnoh5CiSudER56pOd+F4xh/G4DbgH?=
 =?us-ascii?Q?DVl+4pvMr0t5zpGkyJpuKIa6chC9wna3R19sqa0bWb0Vovfe9XOQacwc0otB?=
 =?us-ascii?Q?lBC6hZmnFNFkecc0YMkk/rSeNAo/qo3CQMBH+O26GvSHSND53cnjBoRmkd5g?=
 =?us-ascii?Q?211ryZ9C2WpmhKWF/of6Hs2yTudptrT9GmwBWlpDXl7BphXwKo8/Wp7z5rp6?=
 =?us-ascii?Q?yw/zu0sExk4N61E8UONvBnn3h3sJCn3Sm8KA0hQbzV2HSMsw/S27Yaoca+eG?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5ecc31-1080-4986-3181-08db58cbaaf4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2023 00:46:37.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rflr/FEWGHDoy+BfTsn+r/YS+sfqRlVXQbP592qMjSDSuuSw6PUZAopJkwpnJCW0WIplZmF73QezXi34Zw0Gbh9VLW4cSC5kBalQml6eqtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8498
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

Robert Richter wrote:
> In devm_cxl_add_port() the port creation may fail and its associated
> pointer does not contain a valid address. During error message
> generation this invalid port address is used. Fix that wrong address
> access.
> 
> Fixes: f3cd264c4ec1 ("cxl: Unify debug messages when calling devm_cxl_add_port()")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/port.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index da2068475fa2..e7c284c890bc 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -750,11 +750,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  
>  	parent_port = parent_dport ? parent_dport->port : NULL;
>  	if (IS_ERR(port)) {
> -		dev_dbg(uport, "Failed to add %s%s%s%s: %ld\n",
> -			dev_name(&port->dev),
> -			parent_port ? " to " : "",
> +		dev_dbg(uport, "Failed to add%s%s%s: %ld\n",
> +			parent_port ? " port to " : "",
>  			parent_port ? dev_name(&parent_port->dev) : "",
> -			parent_port ? "" : " (root port)",
> +			parent_port ? "" : " root port",
>  			PTR_ERR(port));

Looks good, applied.
