Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C94750BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjGLPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjGLPHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:07:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC66D1BFB;
        Wed, 12 Jul 2023 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689174427; x=1720710427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7qPO5ZC8PugsPSPcQTXfdqjF2EFoTAyaJlrSxXwwINA=;
  b=VO0WWxGRDH04xNFjPWhqcb2OMKaDPlX/jlVQB+utXe9Mrwd62g1pjTgx
   gitczehii6Wn8dX28pvJeXpbY+geK7yqYEpuPTTEfbLgT0HQ2WjcgWYaE
   DAXEiZ/DKxQ0LPYQQj4k0rBZ1RMSISgqUdhr77/kchPKiPb1StV4EipDV
   Bgyn4FSJrBcaYMZF7dXCvJACr0zFWr3k0anoJOIuVVKYfvU62wmU4jhEc
   VcYuLN9Yh1j15y9F5rjs0vL3wDXToW30XGcmppKCgjU0JKMklzaMoYim8
   g1yius3ZLOv5FxRyujPv6Is9zLVFP7Tkx63LA3xghgz8+qe55IPw6NN5u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431049521"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431049521"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:05:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="845696460"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="845696460"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2023 08:05:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJbP5-0029vK-1V;
        Wed, 12 Jul 2023 18:05:19 +0300
Date:   Wed, 12 Jul 2023 18:05:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] platform/x86/intel/tpmi: Read feature control
 status
Message-ID: <ZK7BL0GIPgr3alVr@smile.fi.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
 <20230711220949.71881-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711220949.71881-2-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:09:47PM -0700, Srinivas Pandruvada wrote:
> Some of the PM features can be locked or disabled. In that case, write
> interface can be locked.
> 
> This status is read via a mailbox. There is one TPMI ID which provides
> base address for interface and data register for mail box operation.
> The mailbox operations is defined in the TPMI specification. Refer to
> https://github.com/intel/tpmi_power_management/ for TPMI specifications.
> 
> An API is exposed to feature drivers to read feature control status.

...

> +/*
> + * TPMI PFS and per feature memory size can't exceed 4K.
> + * Also PFS start and feature memory is 4K aligned.
> + */
> +#define TPMI_MAX_BUFFER_SIZE    (4 * 1024)

SZ_4K from sizes.h?

...

> +#define TPMI_CONTROL_TIMEOUT_MAX_US	USEC_PER_SEC

> +#define TPMI_RB_TIMEOUT_MAX_US		USEC_PER_SEC

I think it's easier to get in a form (1 * ..._SEC)

...

> +static int tpmi_wait_for_owner(struct intel_tpmi_info *tpmi_info, u8 owner)
> +{
> +	u64 control;
> +
> +	return read_poll_timeout(readq, control,
> +				 owner == FIELD_GET(TPMI_CONTROL_STATUS_OWNER, control),
> +				 TPMI_CONTROL_TIMEOUT_US, TPMI_CONTROL_TIMEOUT_MAX_US, false,
> +				 tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);

Since you have "false" why not use readq_poll_timeout()?

> +}

...

> +	/* Wait for Run Busy clear */
> +	ret = read_poll_timeout(readq, control, !(control & TPMI_CONTROL_STATUS_RB),
> +				TPMI_RB_TIMEOUT_US, TPMI_RB_TIMEOUT_MAX_US, false,
> +				tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);

Ditto.

> +	if (ret)
> +		goto done_proc;

...

> +	size = pfs->pfs_header.num_entries * pfs->pfs_header.entry_size * sizeof(u32);
> +	/* This size is coming from trusted hardware, but verify anyway */

I would move this comment before size assignment that we already know that it's
from the trusted hw.

> +	if (size > TPMI_MAX_BUFFER_SIZE)
> +		return;

-- 
With Best Regards,
Andy Shevchenko


