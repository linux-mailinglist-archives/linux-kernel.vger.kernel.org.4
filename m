Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B16F0C68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244538AbjD0TNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjD0TNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:13:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F4B19B6;
        Thu, 27 Apr 2023 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682622802; x=1714158802;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DVN72tvsumoBnFDUkjdAOM/YMgu0hMCasdCzM8jxs80=;
  b=bPaFB+XDI04crJRgJvNhJHq6CfbHs64aN1hmYTyPiSz5VI70ln2AASbR
   /xlnY1lEoqFPBHFqGHJ+eqfIergcj7qYyS6KU3jBygN1U6F3MU1cRGsJN
   4rSzGRiszWewSf4N8lbFOLQRIXkOQyrhhvCX/YqupJqhxiaWAEmjaCOt8
   CYPDGyvTcMS3wCPPHGhru642VuqXqE4+xwAwVcjhL0w4L9fKQCjF+4w1L
   H4BPTlvwlN/rbUcJz/5PgCx4FtlptdsLrGK23rTf5hSCE1nh9XtwNeSWG
   ADL+2MRoE5xMEy+UDWQgK0ziBNxes2e9heTPH3W0rFbhwVV6fIz616csY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="349531954"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="349531954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="725046129"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="725046129"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2023 12:13:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:13:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:13:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 12:13:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 12:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f09Ww0x9ZrlOyeEXG0dl5K0HDvB2Wyu8cyBTM4bfT46Kmih94xWrfNMZuO+Y91UCRurlXqh90SaCEOp0vRAu40xk3699o82Okjsbg2EREQZNidvKtuvtilh0rE3u7hndOygNEyNJ5kKjUWonc62csyBOJCldL4JdoJ4YECPElDKEilh5zXBmLvz32I3osjrLJUm2crQCacJ5BgmBQ3mVH3amcIBJhOEMf6EzlsQ0efE0vx3W4tIMSInbdem7/FHZ0NhrSDsw0wrKOmYzUmoOZ7jQ5LjsNkckhfnZtGzN/sHJ95xYQ6Z7ww5KOVSFtXEObP83wMq+zTufuXyf8BHXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0GF7weYxbhP6XTb+GDzxz/9UV/gWfBSGHRnmOUIllo=;
 b=W8bIQWco8ogsG1wQtjlv6IBXwsA6dNkcXzq7gZ8iLBXGWddOSXLKtkDTd+nIGVD6RMs9IoXH6xeM+5VqxJyISxGqvgObxg428Ahy/yeWd/nZqDf3IEjE/TS9nmLWTC1Qt1mPCbwxJCTyRGRfr8cRMQXe6Rxu+fDj34mZFgdmjom2YoATIGD40rj8tPHR1kKace9R9+8nsy7puJoeE4XdnDQx1SixqoJXx7IKUqrdoAZjFX25V3ru7NCMGFfVY230MLl2YZiE1lFOcCBGZUiCXkqnhMlCkT4fJWSMRlJ0MM4ACPtOTdUZf1TFiKTAETPmcRVZsNB6HWCN++iCrb7V5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7790.namprd11.prod.outlook.com (2603:10b6:208:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 19:13:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 19:13:19 +0000
Date:   Thu, 27 Apr 2023 12:13:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Raghu H <raghuhack78@gmail.com>, <linux-cxl@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [STYLE v1 3/3] cxl/core/region:Remove else after return statement
Message-ID: <644ac94ad6977_182a92946e@iweiny-mobl.notmuch>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
 <20230419111443.231151-4-raghuhack78@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230419111443.231151-4-raghuhack78@gmail.com>
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 26551b40-b49b-4ca4-2b4b-08db475375c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ipl+CXQrsoKGXYHL2lXjTNHDPUnOT9Od10YEWJuLZmLz9nD3YhfwVTSfN1M4NE018FEDk7T7MTbCvqW5X1H4JTYij5O2lx/rCxLk2L0ZjgMPOdgz+B+D3aDAw1lDo8Poh835Wjhu2tqr2pLg7RUVDF1T1dEhjshw74kkmWvJTF0aNa1HSIHZYKs0FLVDsjnDudAHvLSOBkm4MRxNfQhdQB2uP8Ll6XmVDxwQBmt6/zEuyStC+6Sn2F2/rdBR/bzPO+4wTX1PZRNLqZhrcpVPNRQcl08NzrOWqUTzFC1/ok9Haop2JIxtfNJ35KwtTNz5uvRoXmWRTdcQmqHZ8EZIg7hJK6qa6k9zfS3pTU1BrI9t/avXQgbUVf7sjF03j1BAHm3X22p5UX9f39rh4Xk0H4OLR1pr+9HRApG14/76CBJ0UtDVDXo9KHZ9SZJFoK4y4YJeHCgX7q9K9p+kQlgVo9y+0tJdMnyhMBNu9op5+sLv6MzCkXtmIXO0boTXIXmHFd6u6NY0BlYkl8mv1TO4VEuPuAc2wxFnh4WScAnNHf7J9oY4XZCX54BS7+eramBT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(6486002)(6506007)(6512007)(9686003)(478600001)(26005)(6666004)(83380400001)(44832011)(316002)(4326008)(86362001)(66556008)(66946007)(66476007)(8676002)(8936002)(41300700001)(5660300002)(110136005)(38100700002)(6636002)(2906002)(186003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ntj7Mi2ox9HDCQmxTyGDFpP4FblrDNDiUTtxyC7DSjZl5gmp3wrUcs+PyMG9?=
 =?us-ascii?Q?nGUkbu8PNSjO6Ilq8oVCPQiofivVvsr24n8JpvAYm1yR6DgmS4O6gBB3uGbp?=
 =?us-ascii?Q?z5O8qnfwf7JCRb96xKwkhNVhTkZ32TUpErezaiXeJhhlhIldkj4Nxkah0SYW?=
 =?us-ascii?Q?wEXRiVaacRtWKX/IYjsrKq1qJRXnEAvSetDydTdYUEksZX+U7mfRVUxnPZiK?=
 =?us-ascii?Q?jfX5FU6cPN3NAk48OYp3Kqyqh00M6ppjoVlIxbC1pkyJV2GzCOr7HN6HEhl1?=
 =?us-ascii?Q?+efPUUuqrNZ1dk7Zp2d/GH4kRX5IitZnYN6NkgOys+HPy5G1GtzDTl0U+Jou?=
 =?us-ascii?Q?M65VthrEwU6+DLBOG05h/KKU0RzVPvY58sI3kTEt1Ntk0d1drSJPfNMoAp4x?=
 =?us-ascii?Q?oY1v60rAJ8pb7R2zkdt3JCoTkFCC7CgJzNRta1UzZN31d/UuwGTTzAkvmTQF?=
 =?us-ascii?Q?hpcRS+B4m7ZPuRTUvu+yVtoH5IckrwjUz1Q/SWDnrTuqYSxFDzYzbKQuZj0Y?=
 =?us-ascii?Q?ejXwX0W4Kcqm49cQNXAmoDCzvpQ1+vX+ghNHkmuYD99di3tt+6bOd+FPVRbk?=
 =?us-ascii?Q?/Uu49DcYz8nkln+zC20EN34HajfXN494zR0eNsXwdbMB8RuIlPrbhiOe+PnV?=
 =?us-ascii?Q?5JEHBJlkNZNPmbMJgNQWMeLUAX32BeUjPxxYcj4c6dfeQ17bWWC/WSliU/Fa?=
 =?us-ascii?Q?Wyg6zf6+XSWR/4+Kg+uapH8yvhHsTeGlt7TdlSWSl7kMl41/RvfamNVE5vl7?=
 =?us-ascii?Q?LGbVIUQtg2U+h8NOmpYGxTHPXfm4ZKjg85TfZwEdItHWRsN8YadxAW6/QCXz?=
 =?us-ascii?Q?iyARzVNKrjUsrdfczxidUf7gqNcMBn6dNZuSU7kQpyV01P/wizSJIwrsVFwZ?=
 =?us-ascii?Q?JinkO9q2OnqQ9Pf29ht1KjrVz3yl3Bri1DetK6W2HdjEH1dgQcGc1R1LbhPp?=
 =?us-ascii?Q?cI0W+k0rth7GAra121YVXmgCEAa2Nswp2Gvp/tWrEH3ZOo3HMgvPAXudAq1f?=
 =?us-ascii?Q?sPG/VfQKUlaqbpOXX65RoW9MBkjL+oHb/OORgK1uzOrd1ONsWItxsWnqMTQy?=
 =?us-ascii?Q?brzgE8cpEVVcwKDMNT2ho8o9Q7vpqRD/6z9Iq3XKHR+4a/2dMEtU0FxPiM4q?=
 =?us-ascii?Q?vl9vSS1seSSS21S4lggOSwFtnEpYSlc7otF0PhfSHW6ueJcWjFv2gJDr/U3H?=
 =?us-ascii?Q?ycOjRsCHAIJFeSUlKT37vN4+agWSryxTxND5IxkGtR1Xw1JYPihz651cFDSo?=
 =?us-ascii?Q?B8j1t/MqHUDroXB/uk/njmYEebSUqGGs/g6xCSS2Xcx4bOIzuX2S4oA2MAAc?=
 =?us-ascii?Q?MaSbDLAwdXZuJwxl9m10gq2YN0T88rOR6V3jf/QxClY+2/6Y0EZl8C6mZydY?=
 =?us-ascii?Q?pR5asC/PizjqArP6kazt52apRATZGt60NK3pZi12WfuLteku2rjola0fmTxM?=
 =?us-ascii?Q?b5dkArpBiFkOn/g3NxOprOx6I4GNxYX+iGCy/QPRzA6fB+0kBKCOxlZf2QK6?=
 =?us-ascii?Q?7Pjf76PY4+jNIlrjbFn6c6gBnToZ/6IKhaQY+8sc/80NH5wfWsR3Gei7Muev?=
 =?us-ascii?Q?ENZ/nhAyXISwu0POBgzGnVA71GXfywL5RfISy2rY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26551b40-b49b-4ca4-2b4b-08db475375c2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 19:13:18.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVcDhSubpNsYsTwxhUl2KAfk0AnP7eJybqAx/Szu85OtqZm1rQibKivQQProAOiL8cyk6bO+Y1bC+tufcLcnOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7790
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raghu H wrote:
> The else section here is redundant after return statement, removing it.
> Sanity and correctness is not affected due to this fix.
> 
> Signed-off-by: Raghu H <raghuhack78@gmail.com>

Ok, per my eyes I would have liked an extra space before the dev_err()
but...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/region.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..1d695107b4a7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2666,11 +2666,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>  			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>  			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
>  		}
> +		dev_err(&cxlr->dev,
> +			"Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
>  	}
>  
>  	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> -- 
> 2.39.2
> 
