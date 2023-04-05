Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32206D77A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbjDEJAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbjDEJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:00:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479354C26;
        Wed,  5 Apr 2023 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680685237; x=1712221237;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zNd4QNauho2B9S7q4taI3HGIdrkY7fbxy/Q2SsKQaFo=;
  b=bBkRWoPNfebBul9vtMlsQWFXUiDFmDeEWuKq0+PTXVz28ptr7J5N6lyx
   44wzelxfYJo5wc9L02PbG+NIQY/eoQJMaFIxDW/VsX83pwlE1JPSpgTa9
   iAkNCAKZPDzgFuhfog8N8+3BTViwTz4MgdF/X35YL6E20/obAEDzPvZsY
   Z7IqSkbgIAEbbS5pP4Yy22IJ1W+Pv+uIb7pqwiHDRVAOkQRFW7ZMbq7Vv
   JTlxTOj++HQ0bGErf059AWvC3rPv78e7w7N8n1l6b45txjdWFsIxmA+cQ
   iWJq/x1tO3/9ZdTqG/XWFrEPDzQ89hkbJcL6sgWsfNqYrxXNdM3lT3Wtf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344118641"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="344118641"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 02:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="636820172"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="636820172"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 02:00:30 -0700
Date:   Wed, 5 Apr 2023 12:00:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] tty: n_gsm: increase gsm_mux unsupported counted
 where appropriate
In-Reply-To: <20230405054730.3850-7-daniel.starke@siemens.com>
Message-ID: <fe8c6288-1df-bdb0-34d-68e6cb983a7a@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com> <20230405054730.3850-7-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> The structure gsm_mux contains the 'unsupported' field. However, there is
> currently no place in the code which increases this counter.
> 
> Increase the 'unsupported' statistics counter in the following case:
> - an unsupported frame type has been requested by the peer via parameter
>   negotiation
> - a control frame with an unsupported but known command has been received

So inconsistent/unsupported adaptation doesn't fall under the second 
bullet?

(Please excuse my ignorance, I'm trying to review your patches with 
somewhat limited knowledge about how things work).

-- 
 i.

> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 317aa67ed169..49cb2dbfa233 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1589,6 +1589,7 @@ static int gsm_process_negotiation(struct gsm_mux *gsm, unsigned int addr,
>  		if (debug & DBG_ERRORS)
>  			pr_info("%s unsupported I frame request in PN\n",
>  				__func__);
> +		gsm->unsupported++;
>  		return -EINVAL;
>  	default:
>  		if (debug & DBG_ERRORS)
> @@ -1896,6 +1897,8 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
>  		/* Optional unsupported commands */
>  	case CMD_RPN:	/* Remote port negotiation */
>  	case CMD_SNC:	/* Service negotiation command */
> +		gsm->unsupported++;
> +		fallthrough;
>  	default:
>  		/* Reply to bad commands with an NSC */
>  		buf[0] = command;
> 
