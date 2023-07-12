Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58986750C03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjGLPOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGLPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:14:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885931BD5;
        Wed, 12 Jul 2023 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689174841; x=1720710841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=McDyxkwnxT9tOe4gScF3++qkPO8J13ZGJPNthtJNADA=;
  b=aFpfmVlfY1cMeOCqq0XJhg0qL//I1KWrSh2ePdji4GGU1O3bPnzWIoc9
   jzOHZ9GOp/A8A4aSovyPRVBT5MTxQw4/LQNuwskGUkaHA7MJ/batfaZoY
   ToQHBDUzQ6bha6Z4v38Q8Q6K4fJ5ouer0/xxuTu4sUjafpSq3COAl39Si
   NOcOgA2nWfmIUv+Kou1gP01L5l+6KaZ4XXPPgQQggLQn0FFVNBGmLbjEo
   mnB6/b+rBqzEHbWSVJWg9NFLtW33EnSTxxywN1flQ2sZbckWTN5P/B2Jt
   OI+OSZJv3Gy/H+Y0eIlK0GVlq2lty6rQqEUGoNnSWdOlqky/u1HgTrxUQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431052422"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431052422"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:14:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="724901331"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="724901331"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 08:13:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJbXR-002A1Q-2h;
        Wed, 12 Jul 2023 18:13:57 +0300
Date:   Wed, 12 Jul 2023 18:13:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] platform/x86/intel/tpmi: Add debugfs interface
Message-ID: <ZK7DNdlUvUZ5deho@smile.fi.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
 <20230711220949.71881-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711220949.71881-3-srinivas.pandruvada@linux.intel.com>
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

On Tue, Jul 11, 2023 at 03:09:48PM -0700, Srinivas Pandruvada wrote:
> Add debugfs interface for debugging TPMI configuration and register
> contents. This shows PFS (PM Feature structure) for each TPMI device.
> 
> For each feature, show full register contents and allow to modify
> register at an offset.
> 
> This debugfs interface is not present on locked down kernel with no
> DEVMEM access and without CAP_SYS_RAWIO permission.

...

>  struct intel_tpmi_pm_feature {
>  	struct intel_tpmi_pfs_entry pfs_header;
>  	unsigned int vsec_offset;
> +	struct intel_vsec_device *vsec_dev;

Hmm... I don't know the layout of pfs_header, but this may be 4 bytes less
if you move it upper.

>  };

...

> +	for (count = 0; count < pfs->pfs_header.num_entries; ++count) {

> +		size = pfs->pfs_header.entry_size * sizeof(u32);

You already used this once, perhaps a macro helper?
Also you can add there a comment that this comes from the trusted hw.

> +		/* The size is from a trusted hardware, but verify anyway */
> +		if (size > TPMI_MAX_BUFFER_SIZE) {
> +			/*
> +			 * The next offset depends on the current size. So, can't skip to the
> +			 * display of the next entry. Simply return from this function with error.
> +			 */
> +			ret = -EIO;
> +			goto done_mem_show;
> +		}
> +
> +		buffer = kmalloc(size, GFP_KERNEL);
> +		if (!buffer) {
> +			ret = -ENOMEM;
> +			goto done_mem_show;
> +		}
> +
> +		seq_printf(s, "TPMI Instance:%d offset:0x%x\n", count, off);
> +
> +		mem = ioremap(off, size);
> +		if (!mem) {
> +			ret = -ENOMEM;
> +			kfree(buffer);
> +			goto done_mem_show;
> +		}
> +
> +		memcpy_fromio(buffer, mem, size);
> +
> +		seq_hex_dump(s, " ", DUMP_PREFIX_OFFSET, row_size, sizeof(u32), buffer, size,
> +			     false);
> +
> +		iounmap(mem);
> +		kfree(buffer);
> +
> +		off += size;
> +	}
> +
> +done_mem_show:
> +	mutex_unlock(&tpmi_dev_lock);
> +
> +	return ret;
> +}

...

> +	size = pfs->pfs_header.entry_size * sizeof(u32);
> +	if (size > TPMI_MAX_BUFFER_SIZE)
> +		return -EIO;

Again a dup even with a check.

...

> +	top_dir = debugfs_create_dir(name, NULL);
> +	if (IS_ERR_OR_NULL(top_dir))

I dunno if I told you, but after a discussion (elsewhere), I realized
two things:
1) this one never returns NULL;
2) even if error pointer is returned, the debugfs API is aware and
   will do nothing.

Hence this conditional is redundant.

> +		return;

...

> +	for (i = 0; i < tpmi_info->feature_count; ++i) {

Why preincrement?

> +		struct intel_tpmi_pm_feature *pfs;
> +		struct dentry *dir;
> +
> +		pfs = &tpmi_info->tpmi_features[i];
> +		snprintf(name, sizeof(name), "tpmi-id-%02x", pfs->pfs_header.tpmi_id);
> +		dir = debugfs_create_dir(name, top_dir);
> +
> +		debugfs_create_file("mem_dump", 0444, dir, pfs, &tpmi_mem_dump_fops);
> +		debugfs_create_file("mem_write", 0644, dir, pfs, &mem_write_ops);
> +	}

-- 
With Best Regards,
Andy Shevchenko


