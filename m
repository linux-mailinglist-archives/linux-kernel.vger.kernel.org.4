Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6A65BD34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbjACJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjACJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:31:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C1A2B2;
        Tue,  3 Jan 2023 01:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672738300; x=1704274300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7GYie6ztkC/m0OEhrktbGz9gHldom1EYLxQR6sG4Ps=;
  b=jWfu2WDXH0Vai4F48IH5z2786fbsPr+vHwhWTg7ftcyzVx3dEA53XeNT
   2YT6aPzGdBPubQWpbvIKDH4b8Q0QbW5LaLfpdH2z6iqR34XRiT0YOUzPT
   4IbdFmYw42/8vxJEqbftRvtrCmOIoJUAJ7a2gpgGBA5hm03JcJw7Rpk7u
   B2pR8WEDkUEjzZQeIL/qaDfnbL06cEUOyIHeKWUOD/nAr7j6rVeTqWmqa
   Ui22ereOXztZCbc8A+zrF/ENrWQuLUnwCJ7Bn9fbXb9vC39ScgbjyfLKa
   DrGPR3xFJleelzZImQyuk/1lOIx93gnMlpXEMJzxIg8m0xdAX2V74AYkq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="383921007"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="383921007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 01:29:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="797131086"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="797131086"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Jan 2023 01:29:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Jan 2023 11:29:23 +0200
Date:   Tue, 3 Jan 2023 11:29:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 2/2] usb: typec: intel_pmc_mux: Deduplicate ACPI
 matching in probe
Message-ID: <Y7P1c4kZ3r2NrV6+@kuha.fi.intel.com>
References: <20230102202933.15968-1-andriy.shevchenko@linux.intel.com>
 <20230102202933.15968-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102202933.15968-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 10:29:33PM +0200, Andy Shevchenko wrote:
> There is no need to call acpi_dev_present() followed by
> acpi_dev_get_first_match_dev() as they both do the same
> with only difference in the returning value. Instead,
> call the latter and check its result.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 87e2c9130607..34e4188a40ff 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -602,16 +602,15 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>  	int ret;
>  
>  	for (dev_id = &iom_acpi_ids[0]; dev_id->id[0]; dev_id++) {
> -		if (acpi_dev_present(dev_id->id, NULL, -1)) {
> -			pmc->iom_port_status_offset = (u32)dev_id->driver_data;
> -			adev = acpi_dev_get_first_match_dev(dev_id->id, NULL, -1);
> +		adev = acpi_dev_get_first_match_dev(dev_id->id, NULL, -1);
> +		if (adev)
>  			break;
> -		}
>  	}
> -
>  	if (!adev)
>  		return -ENODEV;
>  
> +	pmc->iom_port_status_offset = (u32)dev_id->driver_data;
> +
>  	INIT_LIST_HEAD(&resource_list);
>  	ret = acpi_dev_get_memory_resources(adev, &resource_list);
>  	if (ret < 0) {
> -- 
> 2.35.1

-- 
heikki
