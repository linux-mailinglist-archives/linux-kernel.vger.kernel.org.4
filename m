Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2045EDA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiI1K2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI1K1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:27:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E166068D;
        Wed, 28 Sep 2022 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664360869; x=1695896869;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=UPOP4zy2+RZxs9nh7xPczTJr2ZNNw46ro3LoeELleUA=;
  b=Vx7YisJHKQYz3GvHlJ94riI0l9dPlZTUG01mwt1Z0Ao0lKnnlOKAndvq
   ZGo3zITBQGlRKtsTgY6WHd8QzdQyRKwVaam+yPdGWNgco7oSD0j+o3W1r
   QxBJVqFX54VwSVajO1JPozI/Htrz9mxT3vWkDj0vlGZtG6nfy2YnGmyYO
   MT379d6cwQZpPIlRwR+7k2UUER0+vu1UEV9ZPv2TNDtYxa+k5elzpO1Ld
   ywrQnKup2poceeXo9VjqwHcW5dYyR4sZAvxOtfDeJXKtS4ufC12Dxn6ZU
   Kel8+U6MEiwfhTAMJYgmxLmvNCfoPuYl72vPr8h7b15KRprJMpU67mzYa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327931213"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="327931213"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:27:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="599527471"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="599527471"
Received: from kjurkiew-mobl.ger.corp.intel.com ([10.251.211.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:27:46 -0700
Date:   Wed, 28 Sep 2022 13:27:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 4/4] tty: serial: do unlock on a common path in
 altera_jtaguart_console_putc()
In-Reply-To: <20220927111819.18516-4-jslaby@suse.cz>
Message-ID: <fdfd4174-37d1-fc0-9a5-57f5bcebbe7f@linux.intel.com>
References: <20220927111819.18516-1-jslaby@suse.cz> <20220927111819.18516-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-563824784-1664279489=:2334"
Content-ID: <78633e35-13f3-5850-e3da-3034acded541@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-563824784-1664279489=:2334
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <6f950c7-f56b-16df-48e5-54543459eeac@linux.intel.com>

On Tue, 27 Sep 2022, Jiri Slaby wrote:

> port->lock is unlocked in each branch in altera_jtaguart_console_putc(),
> so do it before the "if". "status" needs not be under the lock, as the
> register was already read.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/serial/altera_jtaguart.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
> index ac8ce418de36..c2d154d78e54 100644
> --- a/drivers/tty/serial/altera_jtaguart.c
> +++ b/drivers/tty/serial/altera_jtaguart.c
> @@ -310,11 +310,12 @@ static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  	while (!altera_jtaguart_tx_space(port, &status)) {
> +		spin_unlock_irqrestore(&port->lock, flags);
> +
>  		if ((status & ALTERA_JTAGUART_CONTROL_AC_MSK) == 0) {
> -			spin_unlock_irqrestore(&port->lock, flags);
>  			return;	/* no connection activity */
>  		}

There braces are now unnecessary.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


> -		spin_unlock_irqrestore(&port->lock, flags);
> +
>  		cpu_relax();
>  		spin_lock_irqsave(&port->lock, flags);
>  	}
> 
--8323329-563824784-1664279489=:2334--
