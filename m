Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A066731B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjALNYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjALNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:24:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E903AAB1;
        Thu, 12 Jan 2023 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673529878; x=1705065878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+lriPcXh6VMXAhZsuIZVfsY1OyEBUI9UJKk/Tq6maM=;
  b=DGnNOZtHH+cf/gE/KmylyYYQsztA3dt98TugtI9iux0BiIDliHFUvWaF
   5zaHWOuydiiESJdjCHr6oxPCzgP+vse+kp4ZHno9lmfGVlhUKU8RmMS6b
   9hieZasVHDm1boSIEXoYLLZdKICKNbdUEqpdzSoEkGCxV6Gjid4rkGLmt
   KThiZbq4C0QMqbI3uyA5cjg20pMjXC0sd5b5LPg/D68+l4nbjvnAh2aEG
   FaH2INZlAHq+2sBmIEN7z5H2CuZN/DUCA29pvqEJ/aBcnY6AUl2DF1W2/
   wp9wQXUTwrPagylViEYPTF2X8LFRL7hJkrG9apduo03RuUFDYUMEVTWfH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="311525713"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="311525713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="800208558"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="800208558"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Jan 2023 05:24:34 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 12 Jan 2023 15:24:33 +0200
Date:   Thu, 12 Jan 2023 15:24:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
Subject: Re: [PATCH 3/3] usb: typec: altmodes/displayport: Use proper macro
 for pin assignment check
Message-ID: <Y8AKEZzbxyYaYjg1@kuha.fi.intel.com>
References: <20230111020546.3384569-1-pmalani@chromium.org>
 <20230111020546.3384569-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111020546.3384569-3-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:05:43AM +0000, Prashant Malani wrote:
> While looking at the DP configuration VDO to determine the peripheral
> configuration, the spec (Table 8-5: DisplayPort Configurations, VESA
> DisplayPort Alt Mode Standard v2.0) lists the options as "UFP_U as a DP
> Source/Sink Device".
> 
> So, use the correct macro while performing this check. Effectively it's
> the same as the existing code, but the proposed macro describes the
> state a little better.
> 
> No functional changes introduced.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index c0d65c93cefe..746bfbf3d557 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -426,7 +426,7 @@ static const char * const pin_assignments[] = {
>   */
>  static u8 get_current_pin_assignments(struct dp_altmode *dp)
>  {
> -	if (DP_CONF_CURRENTLY(dp->data.conf) == DP_CONF_DFP_D)
> +	if (DP_CONF_CURRENTLY(dp->data.conf) == DP_CONF_UFP_U_AS_DFP_D)
>  		return DP_CAP_PIN_ASSIGN_DFP_D(dp->alt->vdo);
>  	else
>  		return DP_CAP_PIN_ASSIGN_UFP_D(dp->alt->vdo);
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 
heikki
