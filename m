Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9430F6EA5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjDUIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjDUIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C0B55B2;
        Fri, 21 Apr 2023 01:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCB1D64EC4;
        Fri, 21 Apr 2023 08:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90346C4339B;
        Fri, 21 Apr 2023 08:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682065271;
        bh=H0Vn9+rqm4T+2n7QD2ANiByQbTsDCUR61d3OOzbyGvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E77q5lP+IE+OR9wtlOc+yCwlWZVvjbY/xeo1zAeoWVKzwecOO95KaB+JHc2NDXwOv
         WTCZdrz1iMsEKAU2Bg9u3JGas3Z4Xv7HMTmIIeX0UYKlQtMAdyr+NWg4K8GEPsXIAm
         HA+LRQAz/2LQZdFKBhcp+41okiXSJhqL/d78NXkI=
Date:   Fri, 21 Apr 2023 10:21:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: phy: add usb phy notify port status API
Message-ID: <ZEJHdCpLZ7f0946B@kroah.com>
References: <20230421080333.18681-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421080333.18681-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 04:03:31PM +0800, Stanley Chang wrote:
> In Realtek SoC, the parameter of usb phy is designed to can dynamic
> tuning base on port status. Therefore, add a notify callback of phy
> driver when usb port status change.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  drivers/usb/core/hub.c  | 13 +++++++++++++
>  include/linux/usb/phy.h | 14 ++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 97a0f8faea6e..b4fbbeae1927 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -614,6 +614,19 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
>  		ret = 0;
>  	}
>  	mutex_unlock(&hub->status_mutex);
> +
> +	if (!ret) {
> +		struct usb_device *hdev = hub->hdev;
> +
> +		if (hdev && !hdev->parent) {

How can you have a device without a parent?  And why does it matter?

And how could hdev be NULL?  And if it can change to be NULL, what
prevents it from changing right after you checked for it?

thanks,

greg k-h
