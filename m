Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382126A340A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBZUqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBZUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:46:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844010AB2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677444374; x=1708980374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yCc4efC8cY7GxC7vi0Q/diJGr+xUNtuVSECJB7VfUkI=;
  b=lap/Jh80U+mBpkKy6FP0EBJY994acBvtp31fkV83C0Q3YdcoYT7dOeQJ
   1maTVi818IV47u549NDv/ZZ6PpLE3a7aVHaV9tSKSQGAPjSfvG0P1fXR8
   1KPC72linaBZj2pprQnlv8FytVcO8D9JN7/oJqyzJVrH7W46UzChjf/T9
   5bLHkmm6BrepgBmMrwynCVEFt0OwzQsVw9onfyl1J5TQPV7Z9nNcte0wC
   wKO1CN3PAGmY5umdDCuc8aqvkISpbySTRUsWtwabE8GND8a+izP7JrZls
   /1Rg2N13PKHijmdmK0G1F8i6soHjcmp3bNrGxyfGYvuimsqqyXG5ulkWr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="332466214"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="332466214"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 12:46:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="705910358"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="705910358"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.83.169])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 12:46:13 -0800
Date:   Sun, 26 Feb 2023 12:46:12 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Kang Chen <void0red@gmail.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvdimm: check for null return of devm_kmalloc in
 nd_pfn_probe
Message-ID: <Y/vFFDiXw6J5LD3X@aschofie-mobl2>
References: <20230226055615.2518149-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226055615.2518149-1-void0red@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 01:56:15PM +0800, Kang Chen wrote:
> devm_kmalloc may fails, pfn_sb might be null and will cause
> null pointer dereference later.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/nvdimm/pfn_devs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index af7d93015..d24fad175 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -640,6 +640,8 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
>  	if (!pfn_dev)
>  		return -ENOMEM;
>  	pfn_sb = devm_kmalloc(dev, sizeof(*pfn_sb), GFP_KERNEL);
> +	if (!pfn_sb)
> +		return -ENOMEM;
>  	nd_pfn = to_nd_pfn(pfn_dev);
>  	nd_pfn->pfn_sb = pfn_sb;
>  	rc = nd_pfn_validate(nd_pfn, PFN_SIG);

Hi Kang,

I too, think the code is clearer if the failure to alloc is addressed
immediately. In this case, it seems we can't just return -ENOMEM.
The original code is detecting that NULL pfn_sb in nd_pfn_validate(),
and then doing this cleanup upon return:

	if (rc < 0) {
                nd_detach_ndns(pfn_dev, &nd_pfn->ndns);
                put_device(pfn_dev);

Perhaps refactor a bit to go right to the cleanup, as opposed to calling
nd_pfn_validate() when !pfn_sb.

Alison

> -- 
> 2.34.1
> 
> 
