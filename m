Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14546E26C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjDNPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjDNPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:22:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28EEAD36;
        Fri, 14 Apr 2023 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681485757; x=1713021757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B0jHdxZzYwrgZFCx/7w9FS8F32WExkZ7+uG6frX+Lvc=;
  b=V83k496Rx1j1geu0WtVEaz8fhj3D+3u5qTjZ1Jnk/WdR+WjrxRRK5ZN0
   VyEmFkOpT6UENcbgpQyCE/cQQNxvp7LcPrR3aaGu5VAfRmZ1NAGGd/1GU
   9FY4TDhPMUyu1V2Ttd1JSyHgKmYbwsIEa7lrlO5Cr6gCt6xK9Aq1ASjpO
   8+LMIPc1b2s4X3SJTTQM2R8m/qKaXTT+lwPbBQO3VThMF9mAOHHTwHKYz
   yOwrbmTOgyo0A8wiT06hQwgQeElWOUNcF7Q5O2BMqwNppp6PBxysO0Gz2
   NHH/PSqfvHv4YJkamnqe3GpoNdZFxUUtohajHoiQ9c4rBIHHRWCV1RQeS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="324116538"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="324116538"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="667220419"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="667220419"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.243.67])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:22:36 -0700
Date:   Fri, 14 Apr 2023 08:22:34 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, nvdimm@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: Replace the usage of a variable by a direct
 function call in nd_pfn_validate()
Message-ID: <ZDlvunCNe9yWykIE@aschofie-mobl2>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d2403b7a-c6cd-4ee9-2a35-86ea57554eec@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2403b7a-c6cd-4ee9-2a35-86ea57554eec@web.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 12:12:37PM +0200, Markus Elfring wrote:
> Date: Fri, 14 Apr 2023 12:01:15 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “nd_pfn_validate”.
> 
> Thus avoid the risk for undefined behaviour by replacing the usage of
> the local variable “parent_uuid” by a direct function call within
> a later condition check.

Hi Markus,

I think I understand what you are saying above, but I don't follow
how that applies here. This change seems to be a nice simplification,
parent_uuid, is used once, just grab it when needed.

What is the risk of undefined behavior?

> 
> This issue was detected by using the Coccinelle software.
Which cocci script?

> 
> Fixes: d1c6e08e7503649e4a4f3f9e700e2c05300b6379 ("libnvdimm/labels: Add uuid helpers")

This fixes tag seems to be the wrong tag. It is a tag from when the
uuid helpers were introduce, not where parent_uuid was first introduced
and used. I'm not clear this warrants a Fixes tag anyway. Is there
really a bug here? Perhaps I'm missing something in the previous
explanation of risk.

checkpatch is WARNING on the tag format:
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: d1c6e08e7503 ("libnvdimm/labels: Add uuid helpers")'
#17:
    Fixes: d1c6e08e7503649e4a4f3f9e700e2c05300b6379 ("libnvdimm/labels: Add uuid helpers")

checkpatch is also WARNING on the commit msg:
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#5:
    nvdimm: Replace the usage of a variable by a direct function call in nd_pfn_validate()

Also, possible only my pet peeve, the long commit message spoils my
pretty 80 column view. Please trim it to not wrap here:

$git log --oneline pfn_devs.c
52b639e56a46 nvdimm: Replace the usage of a variable by a direct function call in nd_pfn_validate()
c91d71363084 nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE
6e9f05dc66f9 libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
81beea55cb74 nvdimm: Drop nd_device_lock()
4a0079bc7aae nvdimm: Replace lockdep_mutex with local lock classes
322cbb50de71 block: remove genhd.h

Alison


> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/nvdimm/pfn_devs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index af7d9301520c..f14cbfa500ed 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -456,7 +456,6 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>  	unsigned long align, start_pad;
>  	struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
>  	struct nd_namespace_common *ndns = nd_pfn->ndns;
> -	const uuid_t *parent_uuid = nd_dev_to_uuid(&ndns->dev);
> 
>  	if (!pfn_sb || !ndns)
>  		return -ENODEV;
> @@ -476,7 +475,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>  		return -ENODEV;
>  	pfn_sb->checksum = cpu_to_le64(checksum);
> 
> -	if (memcmp(pfn_sb->parent_uuid, parent_uuid, 16) != 0)
> +	if (memcmp(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16) != 0)
>  		return -ENODEV;
> 
>  	if (__le16_to_cpu(pfn_sb->version_minor) < 1) {
> --
> 2.40.0
> 
