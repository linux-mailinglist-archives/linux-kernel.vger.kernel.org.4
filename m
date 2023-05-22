Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF4F70C244
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjEVPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjEVPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:22:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD71A118;
        Mon, 22 May 2023 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684768959; x=1716304959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IQ2+8qfjoJ5i8IamNG6HFwxGEud7KiyzPsQbHf9j/Pc=;
  b=gKwN5VMs9HA4I3lHjPLwtbgLH6/Gf2sjn+KwUSMI8KJbn2E8IehzCRoh
   qjPFRIxcQS1Pihj4Hy5bhnz0BzJ5yJFKte/fV7w7qLpopcY4YPgipRSya
   9+Surqdl0wLW7m5xvC1nzZE5Ygxvdo5Bxo7cy3zDvhRIstv5/Mom/6yNW
   7DdMsV1J+pg4nIrclk50Xom+J+86Vml4ip1G26EZmtV8dkVJD2dMMvnsC
   wmn3L/FBsCKiCq6pvMvkdQuEUgL+r9krbok63JCskBjdJ3sgZxgaKumZT
   gwx2dmDutu2DZtOvDDo4fPsycikWFw77M4tKB01st+7dLTPjGQzLHfi/5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="381182120"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="381182120"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="703554951"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703554951"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.173.219]) ([10.213.173.219])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:22:26 -0700
Message-ID: <780579b5-3900-da14-3acd-a4d24e02e4ba@intel.com>
Date:   Mon, 22 May 2023 08:22:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] acpi: nfit: add declaration in a local header
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516201415.556858-1-arnd@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230516201415.556858-1-arnd@kernel.org>
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
> The nfit_intel_shutdown_status() function has a __weak defintion
> in nfit.c and an override in acpi_nfit_test.c for testing
> purposes. This works without an extern declaration, but causes
> a W=1 build warning:
> 
> drivers/acpi/nfit/core.c:1717:13: error: no previous prototype for 'nfit_intel_shutdown_status' [-Werror=missing-prototypes]
> 
> Add a declaration in a header that gets included from both
> sides to shut up the warning and ensure that the prototypes
> actually match.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/acpi/nfit/nfit.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index 6023ad61831a..573bc0de2990 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -347,4 +347,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>   void acpi_nfit_desc_init(struct acpi_nfit_desc *acpi_desc, struct device *dev);
>   bool intel_fwa_supported(struct nvdimm_bus *nvdimm_bus);
>   extern struct device_attribute dev_attr_firmware_activate_noidle;
> +void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem);
> +
>   #endif /* __NFIT_H__ */
