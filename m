Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223DA5EAF61
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIZSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiIZSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:12:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93165883E3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664215307; x=1695751307;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lz0YIGSLN2ywkMkseobCRxPGJq51yOlslereRPGdyDE=;
  b=by/rZiCwEhFP+ZzW0QcE9l4XWfl35nMZu9WaVceTs9yjXo1Ky1v6KV4j
   7/hUssl9Xh+VL3xQ2dHsWsNsPBlke6PWr/9VfKskuvNjTBy529NBMedul
   idWQVhNmVsK9F2bp29LD2wOgdrDo5Qp5rL5dllsjXVJl3Zk/7NKKSSRCJ
   5UaB7QwjqRgfKGQuyjeYsPnryK+9jpzAWXR/H4UKpg5jmE8wgujU6zWMk
   p0+H6bwASHzNuTkuvjxuY5VDod7F3kz5IOkOo7iVWIaWDdpcB83S0tN77
   yQrrz5qYM1y+ei4kOTPZUb2qoEM6iPtB/EHwjDoMGvnk7YCU+g1PPfcXj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="387389810"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="387389810"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 11:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="654371613"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="654371613"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2022 11:01:14 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:01:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:01:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 26 Sep 2022 11:01:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 26 Sep 2022 11:01:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDbkL+miCNlE9BIOmqNjAD5EWoyHJ21ePFXef48nut9dxaixBUOapP/P/C4ilx/rPwnizxtYVXjxQc076ZTiDQh3t+asN6VGP3PGYhr/YvaajbhLNju+zRzz9OwBfTYRdO3pDXL8VjbI1VuUXurljekIhJ1v30s+qYyyOF4lrdIOcQxjIr1wKWn1+FSE1Ss03zlsn8sHr8jNyorQeQA0zrMcao5YWYsgZEfEW4cSmR48aSSd8TeXYvVq+xkJTyUMw+yiwb2Ugu7fph6km3iDc1IhEJLlKEwurYHie5nrhdaZwIlsn8d9C/Hy5JaaY5dUa4kAI7VpT2nxi+p5bTLmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvf7oCZQRHw78UBJqzCqXyoCBOJxgt4IJSs4pK5TZpg=;
 b=ToaGJaJg2CPmwfZ+pxLSaDpKlW/UtnsvKhe8L3cejrBWdFzkQpBPKMTO1jnfNrqzar8dTGc2chrcEo18W0qTp8TPeSxtzQbmCn1zjLiTvrNpCYxMyKaviXYTXHPibWXBdI4dB1oNu3zOk0S39uwHeAli3xpQGUougqav45Oh/SjdnegLta0PUunodzFRxDXJccg03oS8+tavvqLxXT3fi/ImJnvO3ih+q60jwJmXvGEdpelcxpyGFlKcpoVSUg9MlZ1UsDX4eSPu0jd/8LAkvmwMOJSOWRVoVazacO8eoe/dITS//OEK9ef/z8AMOVt56LuucdCv2GnBzhxRsb/p/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 18:01:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.022; Mon, 26 Sep 2022
 18:01:09 +0000
Date:   Mon, 26 Sep 2022 11:01:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bo Liu <liubo03@inspur.com>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: Remove usage of the deprecated ida_simple_xxx API
Message-ID: <YzHo4JOZ3wF57vLS@iweiny-desk3>
References: <20220926012635.3205-1-liubo03@inspur.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220926012635.3205-1-liubo03@inspur.com>
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a4cd30-4a29-4126-cef4-08da9fe91750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laFWtTd9HLIYFdXzgxubttgj/OspS+/dk6k/LKWsE1ZVqh4hOvnbKupzaFK4FBCh+w17rgTaqw5rp4NVlCzBPdiWec86b5KpiIEsu2zSEDF3loMdI6ytA9vKP/NdB2sVPsRuH2WQSN22ZiZmPot+NGoHcaAE0EYlig6i0AEsaL2NEfNbEkDqmg+1WvLazaJZacNhe8IGNx9eD89RnPcdOuS4PLjapa/JRlxPO7O4HH28DoQAjOrMFhMsJh0pegw/xMq03k4/Z0+uuyZO4gbnb7KNXcAAYOnBWJd8KkAtKPhynvO0hvQKAvCeq3ZmWH4R0rqJ+yMpJpTmxju7gta6aj4kxlOyzXN/PKuWE9A9WIRquNeocrsHVpxyKTLr3zH8xWsOm5xcXyH1JfDBhfHLLSv2fgZe2XCg40coAsY8eyGtPw8pb4d6GBhIft5lUl7Jh+wIqDpvfyyfPSUK+2nVJ/kMKZCNFLelY42qcPCQSzDa55JA297KG3IFvsBxRWKg4BO8WFcUsdNbeyX1quRS2J6HeVn1+DN1FFK3YJWy/ZeYwwjHk2Cy8T9OvR2Qv0kuuK9KVKnuRx3L8MYK8QquDMCKdNQALuRQqEsUgonl8bfQTRSiSDQ2Lj13+UXb9eNyLTKLc7apQ6x4GdNViBwBj+v7Sh9a6h3P2Y+yCW3ui/mOnIUW4Or5NjGDVihYbtnm8s/PgljjI69J3cE8sdDkN6x5cWTkjZ9Ph85WeYQSDnxeAw9bedE08nXIQcu7A+hE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(6512007)(9686003)(26005)(44832011)(5660300002)(8936002)(2906002)(66946007)(66476007)(66556008)(4326008)(8676002)(6506007)(6666004)(41300700001)(38100700002)(33716001)(86362001)(186003)(82960400001)(6486002)(316002)(6916009)(478600001)(83380400001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZFXdyu81/+PIAt9Ax7JIJaNK/DosWJBnmL3vVwrcKb1IY/+qPkpq8g201wq?=
 =?us-ascii?Q?0qJxbARuTFazUVf9UfjEuhS+JEwcKX2Z1AoiD7ELL4nNi97J0xqre8RyUnB8?=
 =?us-ascii?Q?ns+pi4X4v5Poiu649C40VmMVlwYdkccfO0wsUiesIAz5/WSxv3pZxznoRVFA?=
 =?us-ascii?Q?mHLtBxPvbIicFMNf1dNKgOmFjnLjK3N1B2lRwJvH/cR6xxin99iNWPXOY5dQ?=
 =?us-ascii?Q?dM25/3ENBnFTViusYizhEXQnETg0y2T5cu6Ry8NVwFl+TnzP9DufeFQ3Ka4g?=
 =?us-ascii?Q?7391dhK3Tt38b1vZO43LlMYjYIhMrRG2KUEIYPO7Rqe1d4M+cvqDd4Y1+2rx?=
 =?us-ascii?Q?LU8MoBmgVU/cZmuqhTLpLrkl8enh+rAPzvQQnz5s2WF514t6FQEfIc43fU4H?=
 =?us-ascii?Q?wqfGHx/bV+cjSp7jl+uFV4cvJ0GHjbrYXUCKkX8HVJeAqjeCXRrYEIYLV8sS?=
 =?us-ascii?Q?jT3o+DR6ixikeVi59z9rL0rSQSz9GCpxbcKy0BFnSQMUjdIiu0Xi/whjdgdG?=
 =?us-ascii?Q?icibgjWI3Rfxir7VAqN8JbIBi1I7ny+3Y/F/xdmMeDnOkvnzfmHAnrJjV8/8?=
 =?us-ascii?Q?4WDT++hN35SKlP9iWHF9OSwTX30LUT3HXJfPu8ncKH5rcTz2vkPNaBXyolEa?=
 =?us-ascii?Q?RRqFqTry+H+9g3FrzOZ1HlS3THOMaL4yC/MRlrTwMUzPgGH4EQtAHLxDeJ7Y?=
 =?us-ascii?Q?kB6anEb+0xRUvGiqUSFk06FajeK4HG5Hxjjkbr0DCnr9gBaaB9H9PJWcjMiB?=
 =?us-ascii?Q?7Q9l3SQHwIeyPnSwMs18Vaib3NtifvbZU0gfEVTTVYZaLt8VRdTTXnUBGZcF?=
 =?us-ascii?Q?mSK+P93tWImFBMX5DXLdoWNs3WIAk9FKUr2mr7L8/C3kfPdG9VhpPK5Ray+Z?=
 =?us-ascii?Q?AV/QtF/wyMCZ6+iKk3S4UwjpZ4p+hqfmAaUYDv1t5YPEkMcDbqQSWiqN0oD6?=
 =?us-ascii?Q?UQHiutS6/ovtBhSmfIKYhdK2/vKdMgJrOk4Vh7UDc9jOyZp/6F0QFaUTL5ao?=
 =?us-ascii?Q?b49xW1wQL4UkWOpp68CyG8ucoujgj08ImBFJ9eN2jxKy7Rc0GSl9Ictf5mcN?=
 =?us-ascii?Q?AhYJl2ZQ1QuewD5Unz86k/dQ1oVNBwOgSVuJWstpi8+mUNDLRXjxsaQqH4Z0?=
 =?us-ascii?Q?LMOlFUuhsq0HgJBrdt1JamqA5nkg8wET+d8QJNJSwVZ7bMFCgo2rRUB7zOCC?=
 =?us-ascii?Q?Rw3jOA7azSe0BQ7+AQ5I2d8CoATK0MIYP40cQDn+cYBzIs8AfOsWPhqUoXn3?=
 =?us-ascii?Q?DNjTG0KR98zDV0RwcQS/Q65tIu5mD1c+i6l2p5frbXLZcwRwggrCZArZ6IPP?=
 =?us-ascii?Q?UslWKJe7HOSCHH/QuuDPxg+CdQvi8u5fajoQU0u4/xu+FYQSn3jqkbJ9a4UL?=
 =?us-ascii?Q?a+ZkhwlWtmRKvIT9HSOVODGISuZZdPyAwad920cQSpy/N62LUGacOLtZ+xfg?=
 =?us-ascii?Q?iYyMt1RhBDO29IlnGWw7lHKjBS9GSl8TxrG35gj7+y8RPtMIOq7giSasSFkw?=
 =?us-ascii?Q?hC7KA0MFp8PDd/wr59o3bNmzFWzvV7ZYYBUjNSx4WuxwwUn7u2n9v6k5mzio?=
 =?us-ascii?Q?9wxHc0MtbL2z94iF8nVFsQvJPpOg+J95/+dOVHGm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a4cd30-4a29-4126-cef4-08da9fe91750
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 18:01:09.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YreBaKbfxq5vqdbCjDu4cVBV+O7wrfLN3kyFvLVBA7AHxnIVss1esKJ87E8WjQEm2FWYs/HqagRsEE0TfmVQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 09:26:35PM -0400, Bo Liu wrote:
> Use ida_alloc_xxx()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/dax/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 9b5e2a5eb0ae..da4438f3188c 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -363,7 +363,7 @@ static void dax_free_inode(struct inode *inode)
>  {
>  	struct dax_device *dax_dev = to_dax_dev(inode);
>  	if (inode->i_rdev)
> -		ida_simple_remove(&dax_minor_ida, iminor(inode));
> +		ida_free(&dax_minor_ida, iminor(inode));
>  	kmem_cache_free(dax_cache, dax_dev);
>  }
>  
> @@ -445,7 +445,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>  	if (WARN_ON_ONCE(ops && !ops->zero_page_range))
>  		return ERR_PTR(-EINVAL);
>  
> -	minor = ida_simple_get(&dax_minor_ida, 0, MINORMASK+1, GFP_KERNEL);
> +	minor = ida_alloc_max(&dax_minor_ida, MINORMASK, GFP_KERNEL);
>  	if (minor < 0)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -459,7 +459,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>  	return dax_dev;
>  
>   err_dev:
> -	ida_simple_remove(&dax_minor_ida, minor);
> +	ida_free(&dax_minor_ida, minor);
>  	return ERR_PTR(-ENOMEM);
>  }
>  EXPORT_SYMBOL_GPL(alloc_dax);
> -- 
> 2.27.0
> 
> 
