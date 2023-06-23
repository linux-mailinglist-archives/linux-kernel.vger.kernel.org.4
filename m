Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AE573B216
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjFWHuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjFWHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10A170E;
        Fri, 23 Jun 2023 00:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5D9861986;
        Fri, 23 Jun 2023 07:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45B8C433C8;
        Fri, 23 Jun 2023 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687506612;
        bh=WtcyzaTUSv/WReXeRZyEpOtCLJ2gt5RNzIT8R9bpWl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKt/RBDcZswrLCHI1MAX8yJ/6y/JYOEGW4aWCvlOW3cn1EkERNHhazn9btlt20mWW
         SdtAQujujGAsZgWZ04kgW7pS4YPc0d4OTzS29oLIsSG2dAbsPEYeBSACrScHLNJeAF
         cubQlRI1Lll/kYMBaVXTd9yFCE80eMZbUstdRtbw=
Date:   Fri, 23 Jun 2023 09:50:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: Set port->pd before adding device for
 typec_port
Message-ID: <2023062330-unwoven-sizable-e17a@gregkh>
References: <20230622150423.3726894-1-kyletso@google.com>
 <20230622150423.3726894-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622150423.3726894-2-kyletso@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:04:21PM +0800, Kyle Tso wrote:
> When calling device_add in the registration of typec_port, it will do
> the NULL check on usb_power_delivery handle in typec_port for the
> visibility of the device attributes. It is always NULL because port->pd
> is set in typec_port_set_usb_power_delivery which is later than the
> device_add call.
> 
> Set port->pd before device_add and only link the device after that.
> 
> Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Shouldn't all of these also have a cc: stable@ line in them as well?

thanks,

greg k-h
