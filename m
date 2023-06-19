Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1564D734B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFSFq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFSFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9A194;
        Sun, 18 Jun 2023 22:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F7460F01;
        Mon, 19 Jun 2023 05:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBB6C433C8;
        Mon, 19 Jun 2023 05:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687153582;
        bh=0vEito5akZJOuzpb8hZG5t8lVKuIt6IDUGos6zSFFw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DZL38GxCYCzFubP+6WAh5a37Pzhs2ByykikeF8n8QC2+ILbEQM18qoPd/1tnLQDt
         JwzWIjffq9dpvfCROnnJbpAe1A1SBFzZ/u1lJCmu//hM3MHWm7h02za4/gzEPWUipU
         ApYTIYYenF6Gc6LZ1IC5u9f++7J9+MlDwUH7sEpw=
Date:   Mon, 19 Jun 2023 07:46:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anne Macedo <retpolanne@posteo.net>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: xhci: parameterize Renesas delay/retry
Message-ID: <2023061951-taekwondo-unsoiled-faf2@gregkh>
References: <20230618224656.2476-2-retpolanne@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618224656.2476-2-retpolanne@posteo.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 10:46:57PM +0000, Anne Macedo wrote:
> Cards based on Renesas uPD720202 have their firmware downloaded during
> boot by xhci-pci. At this step, the status of the firmware is read and
> it takes a while for this read to happen (up to a few seconds). The
> macros RENESAS_RETRY and RENESAS_DELAY are used to retry reading this
> status byte from PCI a few times. If it can't read the status byte in
> RENESAS_RETRY tries, it times out.
> 
> However, since this may vary from card to card, these retry and delay
> values need to be tweaked. In order to avoid having to patch the code to
> change these values, CONFIG_USB_XHCI_PCI_RENESAS_RETRY and
> CONFIG_USB_XHCI_PCI_RENESAS_DELAY are introduced.

No, a build-time option that affects all devices controlled by this
driver is not how you handle this, sorry.

Make this a dynamic value, either determined automatically by the device
itself (as you know what device is being controlled), or worst case, a
sysfs attribute that you can modify if things are not working properly.

But a build-time option will never work, as it will never be changed,
and it would not allow for multiple devices in the system that are
different.

thanks,

greg k-h
