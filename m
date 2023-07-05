Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4B7491E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjGEX2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGEX2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:28:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD93171A;
        Wed,  5 Jul 2023 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688599721; x=1720135721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=td2zakmKMwosjr9MPPIZfOYBx4d0YM0sNWN22EecsJg=;
  b=erQwLJzP6cpiI8cW2wQAxVKTTkDhMzwI0bPwCkCrmyRO9c0DH8Ng6bxj
   v9fWS/gg6RwdqcGpbp5RfHaDhFLjIWdpb5US5PW5PPKOfbatnf50Sit4j
   4pEqgEDd9FhcYg4F5Frztsgg2QpiXtMIc0OGtUwmD00xu7ritYcBt98k0
   p781M04qWZ0y1Cx9U79oe+oso7xI1D4m9HkKaU7am2BgCVA6dxkNCZecw
   +WKyjDYhs3px9MW4XooxGdAQpXFdES6+4FBYeKBkiz6n2thOS26T1JLLM
   EZDSgSWFatXVwN+DZSmnHTNiE86zq6r0nEHhnxgPNyiiLgGDQwSQ4q0Ve
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362333954"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="362333954"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 16:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719394171"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="719394171"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.61.134])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 16:28:40 -0700
Date:   Wed, 5 Jul 2023 16:28:39 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org
Subject: Re: [PATCH] ACPI: NFIT: add helper to_nfit_mem() to take device to
 nfit_mem
Message-ID: <ZKX8p0/H2OKKSh91@aschofie-mobl2>
References: <20230703131729.1009861-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703131729.1009861-1-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 02:17:29PM +0100, Ben Dooks wrote:
> Add a quick helper to just do struct device to the struct nfit_mem
> field it should be referencing. This reduces the number of code
> lines in some of the followgn code as it removes the intermediate
> struct nvdimm.
> 

Hi Ben,
This a useful cleanup. Minor comments below.
Alison

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/acpi/nfit/core.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 0fcc247fdfac..9213b426b125 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1361,18 +1361,22 @@ static const struct attribute_group *acpi_nfit_attribute_groups[] = {
>  	NULL,
>  };
>  
> -static struct acpi_nfit_memory_map *to_nfit_memdev(struct device *dev)
> +static struct nfit_mem *to_nfit_mem(struct device *dev)
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	return  nvdimm_provider_data(nvdimm);

I was going to say add a space before that return, but checkpatch
beat me to it, with a warning. Please fix that up.
WARNING: Missing a blank line after declarations

> +}
> +
> +static struct acpi_nfit_memory_map *to_nfit_memdev(struct device *dev)
> +{
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>  
>  	return __to_nfit_memdev(nfit_mem);
>  }

I was a bit puzzled why the diff looked awkward because when I applied
the patch it fell nicely in order with the new helper function first.
It all merges the same in the end but it's easier on reviewers eyes
when well presented. Consider using diff.algorithm=patience (output
shown below) when things scramble needlessly.

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1361,18 +1361,22 @@ static const struct attribute_group *acpi_nfit_attribute_groups[] = {
 	NULL,
 };
 
+static struct nfit_mem *to_nfit_mem(struct device *dev)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	return  nvdimm_provider_data(nvdimm);
+}
+
 static struct acpi_nfit_memory_map *to_nfit_memdev(struct device *dev)
 {
-	struct nvdimm *nvdimm = to_nvdimm(dev);
-	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
 
 	return __to_nfit_memdev(nfit_mem);
 }

snip

> 
