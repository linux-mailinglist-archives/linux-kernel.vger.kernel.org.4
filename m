Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48A6D76C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbjDEIXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbjDEIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:23:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249061993;
        Wed,  5 Apr 2023 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680682993; x=1712218993;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r504Qe8P4MHFcScLYxteLcGwz6RXRu5O8J4JW4W87o0=;
  b=GZNeTiga5r2eTOS0bd8C7vVVeaW35a8WZJIRmjYie+Jsbp0Vr4JYTETz
   jBIAAyl7hmTsm12qkRSB3oUm2UvDaQq3yAqF516M2qhmaG97Sh9pQJqSK
   MPfUCme3LKmHKOabQuZpMZFBaQy1olXoG4bOd9Ewkw3+lThPiKmV1Va7j
   zgCXm1tavYdQcS2RL+0UzP9VVE/JvVmRA7CVvP9a8i1l0bz7zjMMlslt0
   O+nXDMI/KTIbFT5FiOdwZ+jNAvTA+RVctL4mFjc7OF3Oi/lk/3hnHP2W9
   vjJVVmEnnt1Dh/u9GXczydnUZb3oQAWyp26a9bykJaHJxdr4z7ZXxhDxv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="339892296"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="339892296"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="1016393497"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="1016393497"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:23:11 -0700
Date:   Wed, 5 Apr 2023 11:23:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] tty: n_gsm: fix unneeded initialization of ret in
 gsm_dlci_config
In-Reply-To: <20230405054730.3850-4-daniel.starke@siemens.com>
Message-ID: <2d67db22-3a5d-1ed7-cfa7-d549aa1475b@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com> <20230405054730.3850-4-daniel.starke@siemens.com>
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
> The variable 'ret' is not used before assignment from gsm_activate_mux().
> Still it gets initialized to zero at declaration.
> 
> Fix this as remarked in the link below by removing the initialization.
> 
> Fixes: edd5f60c3400 ("tty: n_gsm: fix mux activation issues in gsm_config()")

This doesn't "fix" any bug so Fixes tag seems inappropriate unless does it 
fix a compiler warning (in which case you should quote the warning in 
this changelog and state you're fixing this warning from compiler)?

> Link: https://lore.kernel.org/all/b42bc4d1-cc9d-d115-c981-aaa053bdc59f@kernel.org/
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index eb21ca583642..d42b92cbae88 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3276,7 +3276,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
>  
>  static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
>  {
> -	int ret = 0;
> +	int ret;

While at it, I'd move the declaration into the block where it's used so 
the scope where the variable is used is easier to see on the first glance.

>  	int need_close = 0;
>  	int need_restart = 0;
>  
> 


-- 
 i.

