Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906165EC1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiI0Lrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiI0Lrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:47:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B442B6D1F;
        Tue, 27 Sep 2022 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664279260; x=1695815260;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s6AJoa89+cpJOlqj7hRJRgtFtDN6+afMKye4KWGWigU=;
  b=DrcSQExnoZQ6pHR4MEZR2JyPkb5lbQBOrPJYby9PUfb+zsw3bbBVJ8G/
   oL201zU38ScuJqxwo32g7LrkB2m8+Xnoz0CofGe3J9Q5DAgFHGNOx5FKU
   FSmyPMVIrrq9nHvDMtP5uPQtUXSgUvipPjguWZK4Osetg9DS1IC8HrwLE
   aLo5w8syPwt/DSMhe3zQVMIYKOORgkym2Yk2k2jGNeCewQ6T6+amrK5uj
   4vMjChe5sepUYAcZWzl6Y4Y7mJA7k1M3gktiUxayn/P/4MBpumFwfjH2o
   BXcJDw6w7B/xO3X3uNlZ45YP8YoKh4THYgb800Nit9CmXZaBuhNIY7rFW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="301272305"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="301272305"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 04:47:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="710531219"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="710531219"
Received: from aksaxena-mobl2.ger.corp.intel.com ([10.252.60.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 04:47:38 -0700
Date:   Tue, 27 Sep 2022 14:47:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] tty: serial: extend lqasc_tx_ready() to
 lqasc_console_putchar()
In-Reply-To: <20220927111819.18516-1-jslaby@suse.cz>
Message-ID: <b46d3edd-adb8-c91a-c1-a2cfe39205f@linux.intel.com>
References: <20220927111819.18516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-268247081-1664279261=:2334"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-268247081-1664279261=:2334
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Sep 2022, Jiri Slaby wrote:

> There is one more place where lqasc_tx_ready() can be used now:
> lqasc_console_putchar(). So replace the open-coded variant by the
> helper.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> ---
>  drivers/tty/serial/lantiq.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 6da1b7496c6c..ba9739af30ed 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -606,15 +606,12 @@ static const struct uart_ops lqasc_pops = {
>  static void
>  lqasc_console_putchar(struct uart_port *port, unsigned char ch)
>  {
> -	int fifofree;
> -
>  	if (!port->membase)
>  		return;
>  
> -	do {
> -		fifofree = (__raw_readl(port->membase + LTQ_ASC_FSTAT)
> -			& ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
> -	} while (fifofree == 0);
> +	while (!lqasc_tx_ready(port))
> +		;
> +
>  	writeb(ch, port->membase + LTQ_ASC_TBUF);
>  }
>  
> 
--8323329-268247081-1664279261=:2334--
