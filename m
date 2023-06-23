Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173CC73BDB7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjFWRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFWRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:19:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EE919A1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687540768; x=1719076768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tHIsAlqWAAAaC4HEnIaNnd12wvkLuC4p5w8WFJFAgUo=;
  b=jFWN6tuEQ7WGDNiB1tozmvMudSwtyNUxuOgFoO/QhNEbgOWKJWzyHv2A
   hHGCbRJgdEoG/AY1rRH/PamZn/BdGPhQH+74SzlZRu1iY6DvyW/bs41I3
   XQ5ub1zJ13UiyRiMdfegJYX1t77tXUdTMRJUUYsRtQAScOrLvz3v2sj3F
   hLjZPjRnJRb097NQ630rMbA+zq4RrARMAYCqIvEwPkuFqe0EyjUrKmPil
   SZnoPK7g13OWx3Ob96SVojGjvIv00KdearGXpXNqvLArFg4tWE7lpBMNi
   7hkYtbVbS5Zl2augqz2L4H3z6RXhceE3d1n9ljuX34cVC3Jy6etFrkliG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="350584218"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="350584218"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 10:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="692736025"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="692736025"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2023 10:17:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 10:17:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 10:17:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 10:17:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 10:17:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFyrHNHoa+nKQXJI2TjMAfLz4ttmqU0+yo3P4DlrXr7oPqeSCl51QKg838frIRwmzHYy/pwJu61c4uoc2ri2fspafVRa496/gu6OEZI68aBqtAh4GeOV4r+LLW/CqFJ3PmBOfKpwRvEltzGafXEJB7lkl+JHLSDA3Z4VGlZL6pgvjJhTQeMo3qV34dTd+P/5ojvjO2wpn3HjbrJM91QLlE3TrsFp7a5r9U62icAxzOD9a/zi0GNjSN/T6+zcw/Ad6wRYJfiNLrj4mAWKkKKtYR7bB/ls+Y6XdeURDDF7opAh15D7+2XB8ZylJdUyRZbksybfbhjsY3ed4dCJ190KaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8lU/R8ij8+VNcvawlP88cqz5hTTwpEPie7Ua3QPjM0=;
 b=i52Wb3ZZH70chhJ04Im4vYkzgqlbD08IESaGYpXLPCxPLAvjqJzdgxM9uneo/XUQqaXnewE3RgHJx/kkTNGa3L+J8n8PlWh9TrSMDXjAvxKQ60Sf7SPo2VU2wscjyVqGRBY5Zu5roxF1N050Z0Ghowc39X1wlKa+xi+iiBF//9d89hU4+jjdz1Gi6GOSlZ6/ovZ8gA0HZzO6sGLkhA1DrHS3gctsA7TGsvAPWVU9Qktvxu8+B0bdl/F5N5Tk6/VjHsUeo3kZNuUAz5IKyzOnGPBfEwwJv4XQhOvQOqbaSmeI9I2XTY/OeE1ULfEM0yWtLlhlv8mRVRLXjmCLgLFGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 17:17:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 17:17:44 +0000
Date:   Fri, 23 Jun 2023 10:17:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <oohall@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] libnvdimm/of_pmem: Replace kstrdup with devm_kstrdup and
 add check
Message-ID: <6495d3b226de0_4ccfa294f0@iweiny-mobl.notmuch>
References: <20230622143232.16863-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622143232.16863-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: SJ0PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f6401b-bcbc-415b-99c4-08db740dc1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSQ500rp8P5vTxCOzwXjxT7kRnRNPiRS3hV71UdZ2qN96eebBTyVNUQ14wrRzq0NInFysSfZNKOiwok8NijDSn2sdIcGtxaHf5Qtqa1ZFG+qyHkr/lIonAfPX8ptZ3dN3Lv90+Qn1IjfakZEKRWWAz9eNthskDQsMsZZyko7T4EoZL/+1t0ecFEp1+gM5bjdtuS9aDc0fwOItuw/Vz77mLm7zoLPiQ7F8iL2XUNVsNMVxm9IxKfVw6yYjLW14toRZFhADfAGvsvrFmQ0OkABwa0inoQ8asUF+F6GSm8f/5+vIJHzVv5RmlfRdfasgka8VpWjCyMxMxdP4pvQibNw1WZmmsJ3Yf7bTs8S9h2dY3xJpsdVXTtIWL2K7uZiS1P9LyPVlgkBVdJ+wzcNKitbnqJidNz8cF1Lpd/orGeM33eL9PWc/75rCBGkPaDViBOmmsWUQJeYf87kgf2rM+a7Q+R11TtX+RsPWtQ9I65qZ9LuKF4OgvjQ8xhsmYTPDQ1mPaJF2u69zEU6YCe+vUf2pqLwRY7CqOM31nMhlSK6lY7uxWo98vsq1FUTyzyjn13t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(478600001)(66476007)(66946007)(66556008)(41300700001)(8676002)(4326008)(83380400001)(38100700002)(6486002)(44832011)(2906002)(6666004)(86362001)(5660300002)(8936002)(316002)(26005)(6506007)(6512007)(9686003)(186003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0uiube4jq8vs8ebvD4l70KzpKH88f1mtEvvKqYTffkNZN81msXzTdsqMHBj?=
 =?us-ascii?Q?5ZwS9Ovih3IYk4mCgayQOQjGzf7kYWNdf0yjfD6Zv6H9iIAcooNYgAPcbNbk?=
 =?us-ascii?Q?R31vzYJPtLquKhVFdjB/0hCg5IZ6em5nV21IfbkaC3KaMPEqqcGhMzCUyL2X?=
 =?us-ascii?Q?o1Kc/ZjDOc7G6QDOAFlqMgyRwb/CYsAYirNz59KtqgqGMeNW0rANt+idHadR?=
 =?us-ascii?Q?bXLthuwTeiDmxtFY1trpmj+SgKOS12Wu3Qso42ebg1IXJjsQRHtEXGd7oQNm?=
 =?us-ascii?Q?ETssN8B/buNT71sSRZuOouBXD9NAWEaKwj2KcY3NuCBtO5nhKPnWMGx4XxBZ?=
 =?us-ascii?Q?actsza//5+bpUETVr/hQy9gZTP1slynvLiOqdAXSbEG2yfbV4VVBbJgcLSz0?=
 =?us-ascii?Q?7z7HBFO63XLyFX2jtnM5I97+eros8kb64WpKTqrO327gBP7IxaHoJ/2x+Nob?=
 =?us-ascii?Q?dOnWUq7qM3eImqVpAyADO07N3x4UZZtkbGmWzRDxfqom1basIMW+GHwUvzop?=
 =?us-ascii?Q?1wZzZ3KpDMZBXQFYV2AwnESLkeuSxXeSevebZySYSCaEGcklRFSWEHlMhDFw?=
 =?us-ascii?Q?UbekA8knn2biSyY6xpiA3W0KVXoWYV/OJ/sQfJVB/zRaxI42CEdq/OuFsY5K?=
 =?us-ascii?Q?VF3y7HnvHRlT7MldMsjeP3srj4ep5HmDV8H4D3XwHADpJgjdDkmvsyKa/mj3?=
 =?us-ascii?Q?CHtVy4u/khqzdiJLXYUm0w+1WgCoSZM/R/c1HcmRQ6Vsw36P4PsWkjdwG/2q?=
 =?us-ascii?Q?eBDdBMTNWQ7+yjUttrNKw9A27Bf55oSLyUF/YCBNg1yqMphf0h6v0N/ooUTq?=
 =?us-ascii?Q?x24Sb7/XGgCjG38V99M5RZmJJvUhIvstoSwW0DlVxuUEPqCcqH+HKfFFnW4J?=
 =?us-ascii?Q?fFF9WKYao79FsVDkwk0cxAiLNVtbFFFPyF95GjEQRqPmV6wM5+ecx4YxOKKd?=
 =?us-ascii?Q?vUvz6Ja4cBQ6s3DIEBAb5SZMJGJIFKSOVxdHhEDzbLdhPRH5uN1PXfCwQT/1?=
 =?us-ascii?Q?1HU4d1kB7wPxk2vUD9QCa3Ws3TXre00PSnrNvHfQMkHUnGwZ2RcPjcDbwKc/?=
 =?us-ascii?Q?S4xTbSKL/rMYIOlABUS5CuChywwNGOlFZSDbtY4DL2y/XZ8lW99TI6O5qKwz?=
 =?us-ascii?Q?rBedFhLKt/oHnPpmv66KOt2jxt5tvwhY5kvhKZy/vljOfItfquK8DOq2dgnh?=
 =?us-ascii?Q?CPA6qr/hPEhT+rgEHFfYWsHVbfYBZZpdJAE+LWi8ZCIKboRJaBK/fQzkY1jv?=
 =?us-ascii?Q?TOM+RYQAZ9lzw2lQg1MdaOzyAK6OeYccoLX6n6Jmb38G13czGbaFx+7grz2P?=
 =?us-ascii?Q?jcRbvW2eIuJbG5E7KNrljDaCWd0OUSYcJLbF6boMbjxIF0G3gihUM3/X7w9p?=
 =?us-ascii?Q?CajzroKfU6hGDe6neTf6AdCUB7EGwBPH7XOVy/Bt/que16Z6YpDoKzUGRkgk?=
 =?us-ascii?Q?PPpbwZEOUAvTs5CZVA5dBKPQYpphbfFze9KM82LAiDMxLycn4IamTpLEM4Xv?=
 =?us-ascii?Q?khx9kGjxtaQ15dZByWRIU+iRplH+uPM4kmF5FpFCICY2i2zytFheBf0y5yZZ?=
 =?us-ascii?Q?Ot3gQzyatNPqpMAhwhoM7alziqTla7dhMhhOoukp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f6401b-bcbc-415b-99c4-08db740dc1ca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 17:17:44.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIa/5JFFaHTuCdI7R2UYCwpzjl3Pq5gLTzu2gWupRrVe06Foz7IjjNaEAl1s+qOtV7o2idOXzkvu5LBxIBvKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiasheng Jiang wrote:
> Replace kstrdup() with devm_kstrdup() to avoid memory leak and
> add check for the return value of the devm_kstrdup() to avoid
> NULL pointer dereference
> 
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

V2?  references to the first fix and review?

> ---
>  drivers/nvdimm/of_pmem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce..5106dfe0147b 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -30,7 +30,12 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> +	priv->bus_desc.provider_name = devm_kstrdup(pdev->name, GFP_KERNEL);

Again, thanks for finding and trying to fix this but you did not even compile
test this.  :-(

/**     
 * devm_kstrdup - Allocate resource managed space and
 *                copy an existing string into that.
 * @dev: Device to allocate memory for
 * @s: the string to duplicate
 * @gfp: the GFP mask used in the devm_kmalloc() call when
 *       allocating memory
 * RETURNS:
 * Pointer to allocated string on success, NULL on failure.
 */     
char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
                   ^^^^^^^^^^^^^^^^^^
                   ??????????????????

Ira

> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
> +
>  	priv->bus_desc.module = THIS_MODULE;
>  	priv->bus_desc.of_node = np;
>  
> -- 
> 2.25.1
> 


