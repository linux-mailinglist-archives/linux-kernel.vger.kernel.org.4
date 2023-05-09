Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0544A6FC699
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjEIMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjEIMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:39:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C299A469E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683635952; x=1715171952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wd04ijxppdvr2I9PyZKHDlJVnhsnmKO4X4fKV87YfQs=;
  b=f5V6ab3aOpcgSbx9rMJJsqMGPcVza33nzUb8IdZh6csSBAbeAm2WmurI
   58vgq+Toaar0QG6Msvs/YmuQUAKzJ+tPP5QWYWawI4nwsODZAjtFSsWYf
   yTfyy6huxbu7j4javi2zhuSSv48GzlZWdXMY6mTcG5CC6s0oSAmoqVHFF
   HpA/ARerfQYOMGnw+XJTWMlO5yajmOtd7l2cknVngi2nWT2ciXz202Hz3
   00DiLazDrkc0JIr2hsR4wfQFth7yVszvaSvB7j0knYNYvgay3gUEpY4PG
   R8y07g9j7LwMDfpPRtrRzLgCMCA2beUUBc3Cu/g0KcGH+mwxDo4uY+5nV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="347370632"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="347370632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 05:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="843083048"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="843083048"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 May 2023 05:38:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 May 2023 15:38:58 +0300
Date:   Tue, 9 May 2023 15:38:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org
Subject: Re: [PATCH] platform/chrome: cros_typec_switch: Add Pin D support
Message-ID: <ZFo+4hsf4g+BQJm1@kuha.fi.intel.com>
References: <20230508183428.1893357-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508183428.1893357-1-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 06:34:27PM +0000, Prashant Malani wrote:
> The ChromeOS EC's mux interface allows us to specify whether the port
> should be configured for Pin Assignment D in DisplayPort alternate mode
> (i.e 2 lanes USB + 2 lanes DP). Update the function that determines mux
> state to account for Pin Assignment D and return the appropriate mux
> setting.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_typec_switch.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
> index 752720483753..0eefdcf14d63 100644
> --- a/drivers/platform/chrome/cros_typec_switch.c
> +++ b/drivers/platform/chrome/cros_typec_switch.c
> @@ -51,13 +51,18 @@ static int cros_typec_cmd_mux_set(struct cros_typec_switch_data *sdata, int port
>  static int cros_typec_get_mux_state(unsigned long mode, struct typec_altmode *alt)
>  {
>  	int ret = -EOPNOTSUPP;
> +	u8 pin_assign;
>  
> -	if (mode == TYPEC_STATE_SAFE)
> +	if (mode == TYPEC_STATE_SAFE) {
>  		ret = USB_PD_MUX_SAFE_MODE;
> -	else if (mode == TYPEC_STATE_USB)
> +	} else if (mode == TYPEC_STATE_USB) {
>  		ret = USB_PD_MUX_USB_ENABLED;
> -	else if (alt && alt->svid == USB_TYPEC_DP_SID)
> +	} else if (alt && alt->svid == USB_TYPEC_DP_SID) {
>  		ret = USB_PD_MUX_DP_ENABLED;
> +		pin_assign = mode - TYPEC_STATE_MODAL;
> +		if (pin_assign & DP_PIN_ASSIGN_D)
> +			ret |= USB_PD_MUX_USB_ENABLED;
> +	}
>  
>  	return ret;
>  }

thanks,

-- 
heikki
