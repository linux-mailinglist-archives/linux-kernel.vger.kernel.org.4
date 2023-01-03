Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261A965BD33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjACJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjACJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:31:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7272AE3C;
        Tue,  3 Jan 2023 01:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672738299; x=1704274299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UApoLp6+oH1gi/b0JWDUcLwn1ffTUCy2mro5a6NzxgA=;
  b=h5cjDmV63HT0rxkPB0X8a7Zgp0+bI9lxeBjTnJooKsNHIdgunddw3Prn
   4uLoADArAKI1mPSoySBU2dYf6J8C5pJV/7Jop41uRObjRTb3ufTeOVUuA
   k2MpUpCYstRtN218xS7EW9WICFDALOMPuV0S7Vlul5Ek+y7CHCh1+lbmZ
   JG+BRv1PoSr9Bzv3LwI7tEk0ChH+CvzKn87muVTTrBWxx7j/BKrglhccM
   qcCMelco5NwhhDITYAGBcyd9aRy6mlmeikblE5kYh4m/JMMNANmptuR4N
   90WAVEzrEvuDVMIPfUCTSHsvx+fFJJU0uPrN689AmOaD3TB4psaAacIBN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="383921004"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="383921004"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 01:29:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="797131070"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="797131070"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Jan 2023 01:28:55 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Jan 2023 11:28:54 +0200
Date:   Tue, 3 Jan 2023 11:28:54 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/2] usb: typec: intel_pmc_mux: Don't leak the ACPI
 device reference count
Message-ID: <Y7P1VlECj5XwBNyP@kuha.fi.intel.com>
References: <20230102202933.15968-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102202933.15968-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 10:29:32PM +0200, Andy Shevchenko wrote:
> When acpi_dev_get_memory_resources() fails, the reference count is
> left bumped. Drop it as it's done in the other error paths.
> 
> Fixes: 43d596e32276 ("usb: typec: intel_pmc_mux: Check the port status before connect")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index fdbf3694e21f..87e2c9130607 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -614,8 +614,10 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>  
>  	INIT_LIST_HEAD(&resource_list);
>  	ret = acpi_dev_get_memory_resources(adev, &resource_list);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		acpi_dev_put(adev);
>  		return ret;
> +	}
>  
>  	rentry = list_first_entry_or_null(&resource_list, struct resource_entry, node);
>  	if (rentry)
> -- 
> 2.35.1

thanks,

-- 
heikki
