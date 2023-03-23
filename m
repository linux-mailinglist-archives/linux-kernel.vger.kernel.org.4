Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD56C6444
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCWJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCWJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:59:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6B37726;
        Thu, 23 Mar 2023 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679565461; x=1711101461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DhNvJanMfI5gxE8/3gWcmZn+Slv9NaGLkvVQvdgDb9s=;
  b=eN6qHLW/hIIFEC3LYPkPAGYfhLOsx5IVYlZEGdf2zEsDQh/kU2+3RqM4
   5y+AwRiFnyFhE6/A9l/9/GgVnr97h6LfR1BP4uqwn09O+LkB0rU/RtkF8
   fjpbV2G+40Ijzg//ZhjiBdJerTkBeiGvbqvObDGPJkIa8pyMAVvEGxUp0
   JoRn0KhxSSaMKxJ3ivT+V9Tena/4tXUBbsXNYtmXTNQfC7XLCtpeqEW+x
   Bo/lQmlL5uz3SsH+Zw28Iq/5a5OFEklrK+ga798R8E3iyAgjcblDSQs2O
   UHWSxd3BXEX9EqtluNdU8CQBxVR2pWoE1wQ5e52j7rOb0wu4FZktwnKeA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338165702"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="338165702"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 02:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="825762247"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="825762247"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Mar 2023 02:57:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 23 Mar 2023 11:57:37 +0200
Date:   Thu, 23 Mar 2023 11:57:37 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Remove notifier before
 destroying handler
Message-ID: <ZBwikZ0wyQ1LGYBc@kuha.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230321190136.449485-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321190136.449485-1-mpearson-lenovo@squebb.ca>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 03:01:36PM -0400, Mark Pearson wrote:
> Was debugging another issue (since fixed) and noticed that the acpi
> notify_handler should be removed before the ucsi object is destroyed.
> 
> This isn't fixing any issues that I'm aware of - but I assume could
> potentially lead to a race condition if you were really unlucky?
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index ce0c8ef80c04..be3bf4f996d3 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -176,12 +176,12 @@ static int ucsi_acpi_remove(struct platform_device *pdev)
>  {
>  	struct ucsi_acpi *ua = platform_get_drvdata(pdev);
>  
> -	ucsi_unregister(ua->ucsi);
> -	ucsi_destroy(ua->ucsi);
> -
>  	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev), ACPI_DEVICE_NOTIFY,
>  				   ucsi_acpi_notify);
>  
> +	ucsi_unregister(ua->ucsi);
> +	ucsi_destroy(ua->ucsi);
> +
>  	return 0;
>  }

Calling ucsi_desctroy() after removing the notifier makes sense to me,
but do you also need to unregister the instance after that?

You may still be in the middle of init or resume, so I think we need
to accept notifications until we are sure those have finished, i.e.
ucsi_unregister() has finished.

thanks,

-- 
heikki
