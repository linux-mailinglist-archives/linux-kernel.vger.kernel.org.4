Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F316D769E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbjDEIQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjDEIQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:16:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7EE4D;
        Wed,  5 Apr 2023 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680682578; x=1712218578;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ex8tbN3S36AvX1h7p6j4FUqtHtDawlFDD/rozOdZF6I=;
  b=B+AP+ERA2CGZEAyeWWtAWfPvRXc9RRDr7SeIZnNd0vEMpZI1ee10/RTb
   25cPQhjoF0JPK/pm5btS5DyFmfyslgnzJlNnPoww6seOgQmrJwQ0FPblw
   Q65c5+prPcjmHAQ7Dgd+UU54gZo0271cn5YdQpXboO0Iu2VwTUOydpTAS
   JlYmW4c3TIBBY0ZC/0ZVFJMqS4GdOke4TdDYVCUM6Zr16mpHaQyoQK7jr
   qKhfcxGz8WXX2/2TVMnh57jUV0S+gqYFon2PsiUZTZLQLl3Ai4QdoE5U5
   o3JGHj/gntAxpPOrAb0ivCwFkFV0de4zeMtbMtwp9cWHDIwxwspNIIKlc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="330997841"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="330997841"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="755934098"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="755934098"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:16:15 -0700
Date:   Wed, 5 Apr 2023 11:16:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] tty: n_gsm: fix redundant assignment of
 gsm->encoding
In-Reply-To: <20230405054730.3850-1-daniel.starke@siemens.com>
Message-ID: <adf7aae2-2fd8-b191-f37-75185167f418@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-943274229-1680682577=:2159"
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-943274229-1680682577=:2159
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 5 Apr 2023, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> The function gsmld_open() contains a redundant assignment of gsm->encoding.
> The same value of GSM_ADV_OPT is already assigned to it during the
> initialization of the struct in gsm_alloc_mux() a few lines earlier.
> 
> Fix this by removing the redundant second assignment of gsm->encoding in
> gsmld_open().
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index b7e1369a035c..c42c8b89fd46 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3585,7 +3585,6 @@ static int gsmld_open(struct tty_struct *tty)
>  	tty->receive_room = 65536;
>  
>  	/* Attach the initial passive connection */
> -	gsm->encoding = GSM_ADV_OPT;
>  	gsmld_attach_gsm(tty, gsm);
>  
>  	/* The mux will not be activated yet, we wait for correct
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-943274229-1680682577=:2159--
