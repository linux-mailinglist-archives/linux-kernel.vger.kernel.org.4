Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E7629DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiKOPi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiKOPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:38:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFAC2A246;
        Tue, 15 Nov 2022 07:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668526699; x=1700062699;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h9Dz/FHEPC+309z8nlhNqhBZsEpwoLFia6iUlxl7tOw=;
  b=L6RtAlvmwp9s3tFDD44xZbjh9TjEwcKDW13KoDFJVj1WXkknc46b5apj
   sbnJ0aNw6JxDz3ODzj1RK0f4UM4xjFfG7x4J8AYsLao4FhHXKYNmK7dOz
   BTMQuvOk/JMuxt5KOlnN0ndiOG2F8JH20Db29XYMkk/11NfG3gkQ6mt6t
   djNFQkGsANA3zkzthjhQFqHWgfEYCmdLyiIU1F3wJwaP2nhmEluVhXtoY
   0WdV7el1Pk6l9K5muFmTfXE/PVZPi/PYW7fwTCGt1lQ+ilbAcDU61pu7j
   NqNub6IfMenmwN/bc+rbWf19aOt9rneMm1M7e5+NVO9rZ9oXKGJoOpRMp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398571060"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="398571060"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:38:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="763952893"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="763952893"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:38:14 -0800
Date:   Tue, 15 Nov 2022 17:38:12 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 06/14] serial: liteuart: move tty_flip_buffer_push()
 out of rx loop
In-Reply-To: <20221112212125.448824-7-gsomlo@gmail.com>
Message-ID: <fd1b8455-47eb-3161-4076-136e3265155@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-7-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1333663003-1668526699=:2268"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1333663003-1668526699=:2268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Calling tty_flip_buffer_push() for each individual received character
> is overkill. Move it out of the rx loop, and only call it once per
> set of characters received together.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 047d5ad32e13..ff3486860989 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -86,10 +86,10 @@ static void liteuart_timer(struct timer_list *t)
>  		/* no overflow bits in status */
>  		if (!(uart_handle_sysrq_char(port, ch)))
>  			uart_insert_char(port, status, 0, ch, flg);
> -
> -		tty_flip_buffer_push(&port->state->port);
>  	}
>  
> +	tty_flip_buffer_push(&port->state->port);
> +
>  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  }

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1333663003-1668526699=:2268--
