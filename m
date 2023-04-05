Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EDF6D77E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbjDEJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjDEJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:15:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095643599;
        Wed,  5 Apr 2023 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680686140; x=1712222140;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bHy1m8omGSbY31gJ7zZnNXDyunNZY0LNuQxVb0Jyz+w=;
  b=TrZzEWmgYRs3PT6XfYCsQlRWaPHlS4COPIC3/Sc3lcbCGo4tCHoL20ld
   Hlh41SBuiRLntOY7X4HHHZMQyt2ujRbW10DLx+gmdKASsxGb40i9LNtsT
   6yVAurCUwpfjRgw0rsef4qyekKOdaF1oFk7yKljO1msMkBeayTz9usED3
   oB7sGY7jIdwSZofV9SYwhWBFOmCu/Clx+0saeZscdnku4c5QH+uBz5mxN
   zwP40MPHSWULAbP6UPDudg4WcJT5KCSgjUIDS3SyCxfsbX/u3weDZ/5Tu
   YluGBq/XFln773LcE8HlXK2aqTgDYhQru9EERWCBQBkuxDO4p0XfPDBKD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="405179446"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="405179446"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 02:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="1016409697"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="1016409697"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 02:15:24 -0700
Date:   Wed, 5 Apr 2023 12:15:22 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] tty: n_gsm: cleanup gsm_control_command and
 gsm_control_reply
In-Reply-To: <20230405054730.3850-9-daniel.starke@siemens.com>
Message-ID: <345feade-76b0-b8e4-60fc-6ce03df3ebe1@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com> <20230405054730.3850-9-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> There are multiple places in gsm_control_command and gsm_control_reply that
> derive the specific DLCI handle directly out of the DLCI table in gsm.
> 
> Add a local variable which holds this handle and use it instead to improve
> code readability.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 61f9825fde3c..87720ebc38d7 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1454,16 +1454,17 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
>  			       int dlen)
>  {
>  	struct gsm_msg *msg;
> +	struct gsm_dlci *dlci = gsm->dlci[0];
>  
> -	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
> +	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
>  	if (msg == NULL)
>  		return -ENOMEM;
>  
>  	msg->data[0] = (cmd << 1) | CR | EA;	/* Set C/R */
>  	msg->data[1] = (dlen << 1) | EA;
>  	memcpy(msg->data + 2, data, dlen);
> -	gsm_data_queue(gsm->dlci[0], msg);
> -	gsm->dlci[0]->tx += dlen;
> +	gsm_data_queue(dlci, msg);
> +	dlci->tx += dlen;
>  
>  	return 0;
>  }
> @@ -1482,15 +1483,16 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
>  					int dlen)
>  {
>  	struct gsm_msg *msg;
> +	struct gsm_dlci *dlci = gsm->dlci[0];
>  
> -	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
> +	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
>  	if (msg == NULL)
>  		return;
>  	msg->data[0] = (cmd & 0xFE) << 1 | EA;	/* Clear C/R */
>  	msg->data[1] = (dlen << 1) | EA;
>  	memcpy(msg->data + 2, data, dlen);
> -	gsm_data_queue(gsm->dlci[0], msg);
> -	gsm->dlci[0]->tx += dlen;
> +	gsm_data_queue(dlci, msg);
> +	dlci->tx += dlen;
>  }
>  
>  /**
> 

IMO, this patch should be done before patch 8/9.

-- 
 i.

