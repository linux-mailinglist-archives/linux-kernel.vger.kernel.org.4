Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B5770C246
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjEVPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjEVPWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:22:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C319B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684768967; x=1716304967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CnP71/eCe2UsTWRS40zMOMu+oOUjG/L/UA4c/oZhaWE=;
  b=W7n/AuG75/PBxcOiHB4yIIyg5iEMMq8pFv5IWJeFQl7R2e7nmE4Cbd2J
   8kMbrfXxoGvRQwrAxmEj7T+2nEGWzhKVYOV0naake/RMnrO2pTWoGRBu9
   pRWRnIlhJPEg5BVKN4/A4tswABPZPVyElsZbE+TqF3DYTlosa4cx67giG
   QAX0IIx44D5vyg365CpKIa7BlLGOJvxfXVIZwBxjkybimRvFdMNngADRI
   fzH+Jz2xlDM1r21bE3dSmOsbRYmFE2mgTTrockWESAiR0dxXcmbo913IZ
   5rdTd6LIxs8a1MJ9Zx1edat7HmOCgscbaTER5y0xH6sWpVIGqb/w8zSdy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="381182154"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="381182154"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="703554960"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703554960"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.173.219]) ([10.213.173.219])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:22:35 -0700
Message-ID: <61a4a468-8530-d082-b03b-a06c14c63517@intel.com>
Date:   Mon, 22 May 2023 08:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] testing: nvdimm: add missing prototypes for wrapped
 functions
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230516201415.556858-1-arnd@kernel.org>
 <20230516201415.556858-2-arnd@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230516201415.556858-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/23 1:14 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The nvdimm test wraps a number of API functions, but these functions
> don't have a prototype in a header because they are all called
> by a different name:
> 
> drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:74:15: error: no previous prototype for '__wrap_devm_ioremap' [-Werror=missing-prototypes]
>     74 | void __iomem *__wrap_devm_ioremap(struct device *dev,
>        |               ^~~~~~~~~~~~~~~~~~~
> drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:86:7: error: no previous prototype for '__wrap_devm_memremap' [-Werror=missing-prototypes]
>     86 | void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
>        |       ^~~~~~~~~~~~~~~~~~~~
> ...
> 
> Add prototypes to avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/nvdimm/test/nfit_test.h | 29 +++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
> index b5f7a996c4d0..b00583d1eace 100644
> --- a/tools/testing/nvdimm/test/nfit_test.h
> +++ b/tools/testing/nvdimm/test/nfit_test.h
> @@ -207,7 +207,36 @@ typedef struct nfit_test_resource *(*nfit_test_lookup_fn)(resource_size_t);
>   typedef union acpi_object *(*nfit_test_evaluate_dsm_fn)(acpi_handle handle,
>   		 const guid_t *guid, u64 rev, u64 func,
>   		 union acpi_object *argv4);
> +void __iomem *__wrap_devm_ioremap(struct device *dev,
> +		resource_size_t offset, unsigned long size);
> +void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
> +		size_t size, unsigned long flags);
> +void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
> +pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags);
> +void *__wrap_memremap(resource_size_t offset, size_t size,
> +		unsigned long flags);
> +void __wrap_devm_memunmap(struct device *dev, void *addr);
> +void __iomem *__wrap_ioremap(resource_size_t offset, unsigned long size);
> +void __iomem *__wrap_ioremap_wc(resource_size_t offset, unsigned long size);
>   void __wrap_iounmap(volatile void __iomem *addr);
> +void __wrap_memunmap(void *addr);
> +struct resource *__wrap___request_region(struct resource *parent,
> +		resource_size_t start, resource_size_t n, const char *name,
> +		int flags);
> +int __wrap_insert_resource(struct resource *parent, struct resource *res);
> +int __wrap_remove_resource(struct resource *res);
> +struct resource *__wrap___devm_request_region(struct device *dev,
> +		struct resource *parent, resource_size_t start,
> +		resource_size_t n, const char *name);
> +void __wrap___release_region(struct resource *parent, resource_size_t start,
> +		resource_size_t n);
> +void __wrap___devm_release_region(struct device *dev, struct resource *parent,
> +		resource_size_t start, resource_size_t n);
> +acpi_status __wrap_acpi_evaluate_object(acpi_handle handle, acpi_string path,
> +		struct acpi_object_list *p, struct acpi_buffer *buf);
> +union acpi_object * __wrap_acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
> +		u64 rev, u64 func, union acpi_object *argv4);
> +
>   void nfit_test_setup(nfit_test_lookup_fn lookup,
>   		nfit_test_evaluate_dsm_fn evaluate);
>   void nfit_test_teardown(void);
