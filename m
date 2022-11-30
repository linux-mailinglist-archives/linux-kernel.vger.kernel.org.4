Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC60C63D98E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiK3Pgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiK3Pgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:36:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7106248;
        Wed, 30 Nov 2022 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669822606; x=1701358606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mFcTuiZmYcNs/FSZXRnVW3rxXkLgXGBo1VexLnJfNBo=;
  b=HHJGGG2bBRsv0BFULKtUVARiHFyDMHh3QYvpm7o6C8+NTWUZYEJ6Tg8Y
   Vj75Qlo8xmUUeB5AiiL2n8snbRq4tgfiOUVKJ2rHVa0syaVAxA+eVhFnu
   68EQdJdUBO9tPlImyfzYgFbosvpRj4W1IncOy4P8DYNBlpkjTAFaurHYy
   SbkT16S5Y5FrktIBRMc0wchyzHlaJep31W1NbCi2iiK7ZZ+VHgXJaHMfS
   3jd/fIdo5n94XdCGlHZfIEG1cOKcvPBChsojbnEUhBUPRTmuBL3SBLgmk
   BGpbPCOXAMjVHaAL4p2zHLT4YJQxEoMJyFCxC2+OVE7vtvVDT5iwJOLTI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377585572"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="377585572"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 07:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="786503452"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="786503452"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Nov 2022 07:36:40 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 30 Nov 2022 17:36:39 +0200
Date:   Wed, 30 Nov 2022 17:36:39 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH] usb: typec: tipd: Set mode of operation for USB Type-C
 connector
Message-ID: <Y4d4h6N6EyOozkYS@kuha.fi.intel.com>
References: <20221128162304.80125-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128162304.80125-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:23:04PM +0100, Sven Peter wrote:
> Forward the mode of operation to the typec subsystem such that it can
> configure the mux correctly.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Looks OK to me.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 982bd2cad931..46a4d8b128f0 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -14,6 +14,7 @@
>  #include <linux/regmap.h>
>  #include <linux/interrupt.h>
>  #include <linux/usb/typec.h>
> +#include <linux/usb/typec_altmode.h>
>  #include <linux/usb/role.h>
>  
>  #include "tps6598x.h"
> @@ -257,6 +258,7 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  		typec_set_orientation(tps->port, TYPEC_ORIENTATION_REVERSE);
>  	else
>  		typec_set_orientation(tps->port, TYPEC_ORIENTATION_NORMAL);
> +	typec_set_mode(tps->port, TYPEC_STATE_USB);
>  	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), true);
>  
>  	tps->partner = typec_register_partner(tps->port, &desc);
> @@ -280,6 +282,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
>  	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
>  	typec_set_orientation(tps->port, TYPEC_ORIENTATION_NONE);
> +	typec_set_mode(tps->port, TYPEC_STATE_SAFE);
>  	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), false);
>  
>  	power_supply_changed(tps->psy);

thanks,

-- 
heikki
