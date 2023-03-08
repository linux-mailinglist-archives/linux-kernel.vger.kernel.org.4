Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193086B0D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCHPug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjCHPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:50:29 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF742C560E;
        Wed,  8 Mar 2023 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678290618; x=1709826618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GZQqCG8YbLknd0IuMXthLn8/SmzMsrOGTTUmqOEcoHk=;
  b=UHxHUG4ZrV2mPJPLdbr0R7SWyMA0nFlRcIS7i3DPPAe87F9g3uwuvbfo
   mGNBPHj9JyNLj21oBL2jWhOYxPQG/52PgmFmdsH2OYj0/gu+3F8ev34ti
   /8sLbS1myKzuWVwn2G+Mks4U35FO08omOxlrn/HP7pcO8OLyfGgRjigpg
   CCvlbrlq2aKTTuzZQINJAzSok3UVzqaXccNv+ELt/koRzEYqsbuKCwlN+
   nbaQNFVC1FLjw79F4Wk8RbLwUB3uF5k1gzqZF8VdgSZXeY3JrXYJ52FLu
   +jgk00hrIWbE1ms/KYlzaaFbLYb1+LaSGP+hBu9k7vFqCRGMYv5cFuwf1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398768049"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="398768049"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:50:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="820273640"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="820273640"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Mar 2023 07:50:12 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Mar 2023 17:50:11 +0200
Date:   Wed, 8 Mar 2023 17:50:11 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/20] usb: ulpi: Use of_request_module()
Message-ID: <ZAius+X1eX0BaOkg@kuha.fi.intel.com>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
 <20230308153200.682248-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308153200.682248-7-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:31:46PM +0100, Miquel Raynal wrote:
> There is a new helper supposed to replace of_device_request_module(),
> called of_request_module(). They are both strictly equivalent, besides
> the fact the latter receives a "struct device_node" directly. Use it.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/common/ulpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index a98b2108376a..6977cf380838 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -229,7 +229,7 @@ static int ulpi_read_id(struct ulpi *ulpi)
>  	request_module("ulpi:v%04xp%04x", ulpi->id.vendor, ulpi->id.product);
>  	return 0;
>  err:
> -	of_device_request_module(&ulpi->dev);
> +	of_request_module(ulpi->dev.of_node);
>  	return 0;
>  }
>  
> -- 
> 2.34.1

-- 
heikki
