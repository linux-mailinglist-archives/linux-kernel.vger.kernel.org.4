Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7F76D772D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjDEIpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjDEIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:45:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE49271C;
        Wed,  5 Apr 2023 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680684303; x=1712220303;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3sqXoIPUjY4afSckJEwfJnUsTr4G+vOtyvu+UoguR2Q=;
  b=RsYAG4UAFdKHLDnmdjR4g3/dg7eDd5uhdTFc/NIO0L2vYWBnJI6tC9hH
   ZlwQ3pEPQYA3AA85ced7yQ/7HeTPsaUx5vlrOpP6BoPARm4pdf0nc5HGG
   m6QWDbQ+d1UBxGuYaSItata63TxM9oqETvzYmDClN6t2BR+XLFbOSsE/Y
   lnlZbiKWLp1xamzMpqOd2ttKf2qp9XJSL+mHmKnGRnp2TXhdl5j6dSPEP
   h8hRdj6jPShnWp/yLmSaZFoFJY5TIXX7L9vqdAyhDzSQ5n+rmU7t/845l
   trZfwbGV/em1hfKud80QiRmw/zTWMzm23Pb6n58bm6Eq3HsnCCjgEfyDX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="326435327"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="326435327"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="751193998"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="751193998"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:44:59 -0700
Date:   Wed, 5 Apr 2023 11:44:57 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] tty: n_gsm: increase malformed counter for malformed
 control frames
In-Reply-To: <20230405054730.3850-6-daniel.starke@siemens.com>
Message-ID: <90b8e37d-2f53-af8b-535b-3ffad4b43e31@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com> <20230405054730.3850-6-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> The malformed counter in gsm_mux is already increased in case of errors
> detected in gsm_queue() and gsm1_receive(). gsm_dlci_command() also
> detects a case for a malformed frame but does not increase the malformed
> counter yet.
> 
> Fix this by also increasing the gsm_mux malformed counter in case of a
> malformed frame in gsm_dlci_command().
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 9f6669686c59..317aa67ed169 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2454,8 +2454,10 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
>  	data += dlen;
>  
>  	/* Malformed command? */
> -	if (clen > len)
> +	if (clen > len) {
> +		dlci->gsm->malformed++;
>  		return;
> +	}

Should this change have a Fixes: tag? Or is ->malformed just an internal 
variable which is not exposed anywhere (in which case state that in the 
changelog)?


-- 
 i.

