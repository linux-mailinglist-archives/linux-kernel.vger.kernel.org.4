Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824786DC3FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDJHpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDJHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 03:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D183C20;
        Mon, 10 Apr 2023 00:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8025C61187;
        Mon, 10 Apr 2023 07:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECC2C433EF;
        Mon, 10 Apr 2023 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681112746;
        bh=t/KY9hnRvPrQKkPlCnL180pm6J2CY1USbVAOaF/2POQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6OPvVGFJnoAqWMK0YdevoA5VrZN6V7CGXYMj+TXOwhgLqd8Ei0KasbIxwOIIjyCF
         SyQ4HbELHJyz06RQbJWEO3Z2P2vOmAC6Gegg/OWlOgq55icI0umbUXfERaU9BTe2Bt
         VKnCPp6g/V7xLjqquZFufYICDeE9iU0S656QP7vQ=
Date:   Mon, 10 Apr 2023 09:45:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around
 tcpm logs
Message-ID: <2023041028-irritate-starless-a42f@gregkh>
References: <20230410073134.488762-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410073134.488762-1-badhri@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 07:31:34AM +0000, Badhri Jagan Sridharan wrote:
> This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allows the
> logs to be wrapped around. Additionally, when set, does not clear
> the TCPM logs when dumped.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/Kconfig | 6 ++++++
>  drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index e6b88ca4a4b9..4dd2b594dfc9 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -18,6 +18,12 @@ config TYPEC_TCPCI
>  	help
>  	  Type-C Port Controller driver for TCPCI-compliant controller.
>  
> +config TCPM_LOG_WRAPAROUND
> +	bool "Enable TCPM log wraparound"
> +	help
> +	  When set, wraps around TCPM logs and does not clear the logs when dumped. TCPM logs by
> +	  default gets cleared when dumped and does not wraparound when full.

Kconfig help text needs to be wrapped at the properly width.

And you do not provide any hint here as to why this is not the default
option, or why someone would want this.

So, why is this not just the default operation anyway?  Why would you
ever want the logs cleared?

thanks,

greg k-h
