Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9F6242DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKJNG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKJNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:06:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867071C42F;
        Thu, 10 Nov 2022 05:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668085586; x=1699621586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=an1ylUNuZ2dll3Mmjef2xo1ov+81kI78C4VBcxjtKwk=;
  b=d6JFuJyE5p/lS5R6VnKgeswIv7s81gtfieH3TLkqNBvCIGlqQwn3n1gg
   14Krj1x6HA19NSD44iqt2Ez0WYmBJacLqcVTPCjUH72e05PlPCzPX+1e7
   ksdSO7mLvEvX3PlzH+QGyFQBonJtlFvKC4NExmj4Hu43Fk2C9Yf+aa/73
   muUqLWOAfgHuS1gV6ZQA3GNAitRrCItQqt0ngkLOBsOP0RrkKC5jMIqx1
   Mw/rFPdmj6WlJvCqTP2Omlq6Y5CFX282EyBaT0Fz+jH/anB32HnloKTUZ
   Wp5sXAf7q9ec2J0bVzxfILTaC9BnnDIrMr+sFy4VicPKs7zWn+taraFMR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="308925386"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="308925386"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 05:06:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="779766240"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="779766240"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 10 Nov 2022 05:06:22 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Nov 2022 15:06:21 +0200
Date:   Thu, 10 Nov 2022 15:06:21 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Message-ID: <Y2z3TdqouULfKyrN@kuha.fi.intel.com>
References: <20221109221749.8210-1-ftoth@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109221749.8210-1-ftoth@exalondelft.nl>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:17:49PM +0100, Ferry Toth wrote:
> Since commit 0f010171
> Dual Role support on Intel Merrifield platform broke due to rearranging
> the call to dwc3_get_extcon().
> 
> It appears to be caused by ulpi_read_id() on the first test write failing
> with -ETIMEDOUT. Currently ulpi_read_id() expects to discover the phy via
> DT when the test write fails and returns 0 in that case even if DT does not
> provide the phy. Due to the timeout being masked dwc3 probe continues by
> calling dwc3_core_soft_reset() followed by dwc3_get_extcon() which happens
> to return -EPROBE_DEFER. On deferred probe ulpi_read_id() finally succeeds.
> 
> This patch changes ulpi_read_id() to return -ETIMEDOUT when it occurs and
> catches the error in dwc3_core_init(). It handles the error by calling
> dwc3_core_soft_reset() after which it requests -EPROBE_DEFER. On deferred
> probe ulpi_read_id() again succeeds.
> 
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> ---
>  drivers/usb/common/ulpi.c | 5 +++--
>  drivers/usb/dwc3/core.c   | 5 ++++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index d7c8461976ce..d8f22bc2f9d0 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -206,8 +206,9 @@ static int ulpi_read_id(struct ulpi *ulpi)
>  
>  	/* Test the interface */
>  	ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
> -	if (ret < 0)
> -		goto err;
> +	if (ret < 0) {
> +		return ret;
> +	}

No need for the curly brackets.

thanks,

-- 
heikki
