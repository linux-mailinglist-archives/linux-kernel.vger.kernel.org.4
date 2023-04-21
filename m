Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F596EA8DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDULJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDULJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:09:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511369EC9;
        Fri, 21 Apr 2023 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682075347; x=1713611347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rZwTsejC2mJApJ3bCH/FR+Q5/YQX630MzFVYcEDFrCY=;
  b=RIK6k8KrRp+QdMQlH0CPByFdlHp5QQm368vfg4vE2trhQXUjIx8RQP+H
   wguY1pnzboHDbB+gvt4jWwCMV2CJ7/Aqar7GZxSKej8TqmXbjr7bXb4UO
   fnVrrpgTPJPA0qGvWvDsngZAUmuJgQZaKmDfzd43bbVEH2xYO9E3+IdZd
   eZ63oyABVWj5fUPT2UqULGCS3RV3fzrcvg9+pWo9JNz8HyBd4+KBHb50i
   cxH0ygvAhpEA7GLJNdO43I5GNG4+fI2epT6azDXj1yoXWCWEw/Lg2rl/z
   Tr9n6VX6yO/nm/n6esD4WOwvTCuWPMGjsoSMv6GJhzdmcMEugP7rSP6mC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="347870256"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="347870256"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 04:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="836146196"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="836146196"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 21 Apr 2023 04:09:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 21 Apr 2023 14:09:01 +0300
Date:   Fri, 21 Apr 2023 14:09:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     gregkh@linuxfoundation.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tps6598x: Fix fault at module removal
Message-ID: <ZEJuzQSwSvP6p9gR@kuha.fi.intel.com>
References: <20230421101720.34318-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421101720.34318-1-rogerq@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 01:17:20PM +0300, Roger Quadros wrote:
> We need to cancel the delayed workqueue if it is being used
> else it will cause paging request fault during module removal.
> 
> Fixes: 0d6a119cecd7 ("usb: typec: tps6598x: Add support for polling interrupts status")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 8b075ca82ef6..438cc40660a1 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -886,6 +886,9 @@ static void tps6598x_remove(struct i2c_client *client)
>  {
>  	struct tps6598x *tps = i2c_get_clientdata(client);
>  
> +	if (!client->irq)
> +		cancel_delayed_work_sync(&tps->wq_poll);
> +
>  	tps6598x_disconnect(tps, 0);
>  	typec_unregister_port(tps->port);
>  	usb_role_switch_put(tps->role_sw);
> -- 
> 2.34.1

-- 
heikki
