Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE27673967
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjASNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjASNEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:04:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4670B7E6A5;
        Thu, 19 Jan 2023 05:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D087160ED9;
        Thu, 19 Jan 2023 13:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8570C433D2;
        Thu, 19 Jan 2023 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674133380;
        bh=4fpRwxBDEvKhdeNvpW0jXDdE0yZhmx+fqvJjKU6UQ8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxzWnwrIOK3O/jYLSAqMZPG5FXGQqLLw1cHUt7kw3BLgocy1ioIoytm80AedZHoMO
         mtbNusCHvs3V0zPrfLPLj+gCAJ+jVAKbLB/m2iNDLAX4nWrUD6vCjYE4qWFQxtfOKI
         +4j88CsxiWONiAV+Ubv20xf/nuI0MILqna0DufCw=
Date:   Thu, 19 Jan 2023 14:02:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-omap: avoid unused-variable warning
Message-ID: <Y8k/gXy8YQd0/oyr@kroah.com>
References: <20230118082746.391542-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118082746.391542-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:27:34AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The dead code removal has led to 'need_transceiver' not being
> used at all when OTG support is disabled:
> 
> drivers/usb/host/ohci-omap.c: In function 'ohci_omap_reset':
> drivers/usb/host/ohci-omap.c:99:33: error: unused variable 'need_transceiver' [-Werror=unused-variable]
>    99 |         int                     need_transceiver = (config->otg != 0);
> 
> Change the #ifdef check into an IS_ENABLED() check to make the
> code more readable and let the compiler see where it is used.
> 
> Fixes: 8825acd7cc8a ("ARM: omap1: remove dead code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The patch that caused the issue is in the boardfile-removal branch
> of the soc tree. I would just add the patch there.


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
