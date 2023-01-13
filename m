Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6014266950A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbjAMLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbjAMLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:10:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C3777E2;
        Fri, 13 Jan 2023 03:01:12 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtdfT4ckFz6H7Dt;
        Fri, 13 Jan 2023 18:57:21 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 11:01:09 +0000
Date:   Fri, 13 Jan 2023 11:01:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference for resetting
 decoder
Message-ID: <20230113110108.00002122@Huawei.com>
In-Reply-To: <20221215170909.2650271-1-fan.ni@samsung.com>
References: <CGME20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06@uscas1p2.samsung.com>
        <20221215170909.2650271-1-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 17:09:14 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> Not all decoders have a reset callback.
> 
> The CXL specification allows a host bridge with a single root port to
> have no explicit HDM decoders. Currently the region driver assumes there
> are none.  As such the CXL core creates a special pass through decoder
> instance without a commit/reset callback.
> 
> Prior to this patch, the ->reset() callback was called unconditionally when
> calling cxl_region_decode_reset. Thus a configuration with 1 Host Bridge,
> 1 Root Port, and one directly attached CXL type 3 device or multiple CXL
> type 3 devices attached to downstream ports of a switch can cause a null
> pointer dereference.
> 
> Before the fix, a kernel crash was observed when we destroy the region, and
> a pass through decoder is reset.
> 
> The issue can be reproduced as below,
>     1) create a region with a CXL setup which includes a HB with a
>     single root port under which a memdev is attached directly.
>     2) destroy the region with cxl destroy-region regionX -f.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Explanation seems correct to me.  Only question (and it's one for the
Maintainers) is whether they prefer optionality here or a stub reset()
implementation for the pass through decoder.

either way
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f9ae5ad284ff..3931793a13ac 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -131,7 +131,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  		struct cxl_port *iter = cxled_to_port(cxled);
>  		struct cxl_ep *ep;
> -		int rc;
> +		int rc = 0;
>  
>  		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
>  			iter = to_cxl_port(iter->dev.parent);
> @@ -143,7 +143,8 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  
>  			cxl_rr = cxl_rr_load(iter, cxlr);
>  			cxld = cxl_rr->decoder;
> -			rc = cxld->reset(cxld);
> +			if (cxld->reset)
> +				rc = cxld->reset(cxld);
>  			if (rc)
>  				return rc;
>  		}
> @@ -186,7 +187,8 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  			     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
>  				cxl_rr = cxl_rr_load(iter, cxlr);
>  				cxld = cxl_rr->decoder;
> -				cxld->reset(cxld);
> +				if (cxld->reset)
> +					cxld->reset(cxld);
>  			}
>  
>  			cxled->cxld.reset(&cxled->cxld);

