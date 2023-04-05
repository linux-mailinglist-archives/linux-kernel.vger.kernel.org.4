Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81F36D77DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjDEJN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjDEJNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:13:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EEE2D7D;
        Wed,  5 Apr 2023 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680686033; x=1712222033;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ltGowfGiSJUISqq+PWEnU9/sTDkgAoz888rS8J9FGoM=;
  b=UuzFNTPSnmDI2/4DR5hsDGK4x5dHiaCFy0oB6DwhQzno/ZQaZamqyCN6
   GJF+u4YOIOQiB9+x2tlw+2g3Thlq1Lv5PXwWCKjStLkDAeM3nqggm0qOk
   lJuY+Em0RfAk0nPHtu8lRvjHqYkBJ+p1iHMmI2LboUPrTTCHDgNwOWAWX
   rLYj4BKJ6dl/jZ25tSLvSp/f6FIPFW/gnGfZFPzwZZ/8QK0hOqjuBSHgi
   xX/JiJAKtKM/l5fHItH5P3sz51k+wTGda/WGOrmFuC3txGJZ6bmYrD77M
   454eW5p5XdlXWDlB2ARCR4AVLipWVVmDZfQ/upEAF8+76vyYJ4zRiquRI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="342424577"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="342424577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 02:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="716963709"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="716963709"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 02:13:51 -0700
Date:   Wed, 5 Apr 2023 12:13:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] tty: n_gsm: add DLCI specific rx/tx statistics
In-Reply-To: <20230405054730.3850-8-daniel.starke@siemens.com>
Message-ID: <6db04388-7f41-86b-a3f-29b2ccd9b51a@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com> <20230405054730.3850-8-daniel.starke@siemens.com>
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
> Add counters for the number of data bytes received/transmitted per DLCI in
> for preparation for an upcoming patch which will expose these values to the
> user.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 49cb2dbfa233..61f9825fde3c 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -185,6 +185,9 @@ struct gsm_dlci {
>  	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
>  	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
>  	struct net_device *net; /* network interface, if created */
> +	/* Statistics (not currently exposed) */
> +	u64 tx;			/* Data bytes sent on this DLCI */
> +	u64 rx;			/* Data bytes received on this DLCI */
>  };
>  
>  /*
> @@ -1215,6 +1218,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
>  	tty_port_tty_wakeup(&dlci->port);
>  
>  	__gsm_data_queue(dlci, msg);
> +	dlci->tx += len;
>  	/* Bytes of data we used up */
>  	return size;
>  }

Reading the function comments and your changelog, I'm left to wonder why 
gsm_dlci_data_output() is supposed to increment ->tx but 
gsm_dlci_data_output_framed() is not?

-- 
 i.

> @@ -1459,6 +1463,7 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
>  	msg->data[1] = (dlen << 1) | EA;
>  	memcpy(msg->data + 2, data, dlen);
>  	gsm_data_queue(gsm->dlci[0], msg);
> +	gsm->dlci[0]->tx += dlen;
>  
>  	return 0;
>  }
> @@ -1485,6 +1490,7 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
>  	msg->data[1] = (dlen << 1) | EA;
>  	memcpy(msg->data + 2, data, dlen);
>  	gsm_data_queue(gsm->dlci[0], msg);
> +	gsm->dlci[0]->tx += dlen;
>  }
>  
>  /**
> @@ -1849,10 +1855,13 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
>  						const u8 *data, int clen)
>  {
>  	u8 buf[1];
> +	struct gsm_dlci *dlci = gsm->dlci[0];
> +
> +	if (dlci)
> +		dlci->rx += clen;
>  
>  	switch (command) {
>  	case CMD_CLD: {
> -		struct gsm_dlci *dlci = gsm->dlci[0];
>  		/* Modem wishes to close down */
>  		if (dlci) {
>  			dlci->dead = true;
> @@ -1931,6 +1940,8 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
>  
>  	ctrl = gsm->pending_cmd;
>  	dlci = gsm->dlci[0];
> +	if (dlci)
> +		dlci->rx += clen;
>  	command |= 1;
>  	/* Does the reply match our command */
>  	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
> @@ -2295,6 +2306,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
>  			need_pn = true;
>  	}
>  
> +	dlci->tx = 0;
> +	dlci->rx = 0;
> +
>  	switch (dlci->state) {
>  	case DLCI_CLOSED:
>  	case DLCI_WAITING_CONFIG:
> @@ -2327,6 +2341,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
>   */
>  static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
>  {
> +	dlci->tx = 0;
> +	dlci->rx = 0;
> +
>  	switch (dlci->state) {
>  	case DLCI_CLOSED:
>  	case DLCI_WAITING_CONFIG:
> @@ -2346,6 +2363,9 @@ static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
>   */
>  static void gsm_dlci_set_wait_config(struct gsm_dlci *dlci)
>  {
> +	dlci->tx = 0;
> +	dlci->rx = 0;
> +
>  	switch (dlci->state) {
>  	case DLCI_CLOSED:
>  	case DLCI_CLOSING:
> @@ -2422,6 +2442,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
>  		fallthrough;
>  	case 1:		/* Line state will go via DLCI 0 controls only */
>  	default:
> +		dlci->rx += clen;
>  		tty_insert_flip_string(port, data, clen);
>  		tty_flip_buffer_push(port);
>  	}
> @@ -2782,6 +2803,7 @@ static void gsm_queue(struct gsm_mux *gsm)
>  			gsm->open_error++;
>  			return;
>  		}
> +		dlci->rx += gsm->len;
>  		if (dlci->dead)
>  			gsm_response(gsm, address, DM|PF);
>  		else {
> 

