Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649146BE812
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCQL31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCQL3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:29:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2D1CF6C;
        Fri, 17 Mar 2023 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679052563; x=1710588563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G4rNx2RU3zkGwNxmiB1UsH9E7nuazXvTQuuPP4knva8=;
  b=Xb3GL/E2Z1dXoDWE5keaMRUimY8hxUGH7ajZAfa0muE9nRicd6CbNWo2
   QpJfOTOUvaZv9Wg/uakQbuPrq8RszpfFyAblcuvXlD48irCYmZWNk0PK9
   0amI+kpMfmVQo7JvJy3CIEpJ78+PVbUV1HlMJUl0dOY6RYlpyP4iFUeAe
   UeQYV6Ee1w6lwM227xpFG88alUKHP9ATy/ETssgsNEr/bThGsB8EQhBqm
   APGgC/yjC7DmzG5Hqg2AdtBr0NTRSGFjEOGmOzLyQPWm2+T0TdnB/SSeR
   bqnW1m/wid3alO0r4zyCwdZoVa2mte8to/eMM3ctfN3w1rG84mDf1vklR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424511779"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424511779"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823638969"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="823638969"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2023 04:29:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 17 Mar 2023 13:29:19 +0200
Date:   Fri, 17 Mar 2023 13:29:19 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH] usb: typec: tcpm: remove unnecessary (void*) conversions
Message-ID: <ZBRPDz4vn0x8hzd0@kuha.fi.intel.com>
References: <20230316082338.18388-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316082338.18388-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:23:38PM +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>

I would have prefered that both drivers are patched separately in
their own patch, but that's minor. If Guenter is OK with this then:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 2 +-
>  drivers/usb/typec/tcpm/tcpm.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 1ffce00d94b4..4b7b8f6af3ca 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -190,7 +190,7 @@ static void fusb302_log(struct fusb302_chip *chip, const char *fmt, ...)
>  
>  static int fusb302_debug_show(struct seq_file *s, void *v)
>  {
> -	struct fusb302_chip *chip = (struct fusb302_chip *)s->private;
> +	struct fusb302_chip *chip = s->private;
>  	int tail;
>  
>  	mutex_lock(&chip->logbuffer_lock);
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index a0d943d78580..e8bfe3f57ab4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -737,7 +737,7 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
>  
>  static int tcpm_debug_show(struct seq_file *s, void *v)
>  {
> -	struct tcpm_port *port = (struct tcpm_port *)s->private;
> +	struct tcpm_port *port = s->private;
>  	int tail;
>  
>  	mutex_lock(&port->logbuffer_lock);
> -- 
> 2.11.0

-- 
heikki
