Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693966722B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjARQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjARQMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:12:44 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 61D6C53E7F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:07:29 -0800 (PST)
Received: (qmail 212028 invoked by uid 1000); 18 Jan 2023 11:07:28 -0500
Date:   Wed, 18 Jan 2023 11:07:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-omap: avoid unused-variable warning
Message-ID: <Y8gZQPmdpY+jCXC2@rowland.harvard.edu>
References: <20230118082746.391542-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118082746.391542-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> The patch that caused the issue is in the boardfile-removal branch
> of the soc tree. I would just add the patch there.
