Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1C6795F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjAXLCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjAXLCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:02:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E16A6A;
        Tue, 24 Jan 2023 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674558120; x=1706094120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vAFJXbptyBjom+Zl0+Qw8s7l1uWyT2WT30fX8zlGXXQ=;
  b=LmjjegjCUkGt0r5byO8NxDPk/g/KoYGIxvpbnBKbtpWrrq6ZN3rvDTm1
   90XeNPQWhb+PaaPqaVI/wdAnGwDRxC8Z+0ZIrkgJRRYDkNRoWYWluHgP3
   Hrvz0C3gP1WolKE85Q/GizKr+qUMAjkj0oowtTo9XeMdQIxgnSTSMzkuk
   XAP2j3sc0/0BQpTCGyX4+SPf5Eq9gaSc0sNvr3HP9XExvrsUecRsFzXse
   kWhoaKbCJuf2xqJV0qHPjLgRzIztZXN9e1+bJ7ufgXd3EMaWRLoy3PnO1
   74xXTjJ9+o0IdZXFhtGKN3zoItK0iRQO3T8/es1m14RqgnmuF/KGk/BSf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="306624042"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="306624042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 03:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804548334"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="804548334"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2023 03:01:57 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Jan 2023 13:01:56 +0200
Date:   Tue, 24 Jan 2023 13:01:56 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, gregkh@linuxfoundation.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/2] usb: typec: altmodes/displayport: Update active
 state
Message-ID: <Y8+6pA9XHRA/mEH1@kuha.fi.intel.com>
References: <20230120205827.740900-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120205827.740900-1-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 08:58:26PM +0000, Prashant Malani wrote:
> Update the altmode "active" state when we receive Acks for Enter and
> Exit Mode commands. Having the right state is necessary to change Pin
> Assignments using the 'pin_assignment" sysfs file.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v1:
> - Dropped the Fixes and Cc: stable tags; given the discussion in [1]
>   I no longer think this constitutes a fix.
> - Added Reviewed-by tag from Benson.
> 
> [1] https://lore.kernel.org/linux-usb/20230118031514.1278139-1-pmalani@chromium.org/
> 
>  drivers/usb/typec/altmodes/displayport.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 06fb4732f8cd..bc1c556944d6 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -277,9 +277,11 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
>  	case CMDT_RSP_ACK:
>  		switch (cmd) {
>  		case CMD_ENTER_MODE:
> +			typec_altmode_update_active(alt, true);
>  			dp->state = DP_STATE_UPDATE;
>  			break;
>  		case CMD_EXIT_MODE:
> +			typec_altmode_update_active(alt, false);
>  			dp->data.status = 0;
>  			dp->data.conf = 0;
>  			break;
> -- 
> 2.39.0.246.g2a6d74b583-goog

-- 
heikki
