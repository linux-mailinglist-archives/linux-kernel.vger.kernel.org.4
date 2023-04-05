Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1988C6D769A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjDEIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjDEIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:15:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8329D8;
        Wed,  5 Apr 2023 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680682554; x=1712218554;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iJhTkz/SNIN43IDEw6G9zmwKLL+Nm+UXFEFElFxzk0A=;
  b=fxk/6KZx5yrboO88YB92gl5s3o5FC7T5PjkQWOz25SMXk5Hm77+X+5Sb
   HxfmBCqygTxKirutqsZcsw3f+koFzytmieNHfZSwYAH7+6uh0sNfjtXPH
   USOPLyArcv2Ljc2kO0uH+KPUc1fw7SDuFGH8mqUN78WM75JL2uzrzpNrr
   oY+VCHTh0Eb+tgVqFe4bjge9X+n6AkghK9pRak0VECnbs0eFwhJ596z+W
   YK0ayxm0dwmdIGR+1TN5OGY0MZZjWBsrfxzk3+cXRHuwY25ILZ8zccoxR
   0GZIie56oEb1LxQsJoAhdOzC1hEucoQfFGOUSgO879XiSzZbgrCkyHUCM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="407473058"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="407473058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="719227756"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="719227756"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:15:52 -0700
Date:   Wed, 5 Apr 2023 11:15:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
In-Reply-To: <20230405054730.3850-2-daniel.starke@siemens.com>
Message-ID: <cd7c33c8-2634-382d-cf62-3785e391af2@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com> <20230405054730.3850-2-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> 'gsm_config_ext' already allows to force a link reset via 'restart'
> parameter.

Please be more precise, there a function and struct with this name.

HOWEVER, there is no such parameter in tty-next (am I looking from wrong 
repo??):

static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)

...nor here:

struct gsm_config_ext {
        __u32 keep_alive;       /* Control channel keep-alive in 1/100th of a
                                 * second (0 to disable)
                                 */
        __u32 wait_config;      /* Wait for DLCI config before opening virtual link? */
        __u32 reserved[6];      /* For future use, must be initialized to zero */
};

???


-- 
 i.

> An equivalent parameter for an forced channel reset is still
> missing in 'gsm_dlci_config'. Therefore, the user has no means to perform
> an automatic channel reset after parameter configuration for
> non-conflicting changes. Conflicting changes automatically reset the
> channel already in the current implementation.
> 
> Add the parameter 'restart' to 'gsm_dlci_config' to force a channel reset
> after ioctl setting regardless of whether the changes made require this or
> not.
> 
> Note that the parameter is limited to the values 0 and 1 to allow future
> additions here.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         | 4 ++++
>  include/uapi/linux/gsmmux.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c42c8b89fd46..eb21ca583642 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2531,6 +2531,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
>  		return -EINVAL;
>  	if (dc->k > 7)
>  		return -EINVAL;
> +	if (dc->restart > 1)   /* allow future extensions */
> +		return -EINVAL;
>  
>  	/*
>  	 * See what is needed for reconfiguration
> @@ -2545,6 +2547,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
>  	/* Requires care */
>  	if (dc->priority != dlci->prio)
>  		need_restart = true;
> +	if (dc->restart)
> +		need_restart = true;
>  
>  	if ((open && gsm->wait_config) || need_restart)
>  		need_open = true;
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index eb67884e5f38..33ee7b857c52 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -58,7 +58,8 @@ struct gsm_dlci_config {
>  	__u32 priority;		/* Priority (0 for default value) */
>  	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
>  	__u32 k;		/* Window size (0 for default value) */
> -	__u32 reserved[8];	/* For future use, must be initialized to zero */
> +	__u32 restart;		/* Force DLCI channel reset? */
> +	__u32 reserved[7];	/* For future use, must be initialized to zero */
>  };
>  
>  #define GSMIOC_GETCONF_DLCI	_IOWR('G', 7, struct gsm_dlci_config)
> 

