Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661FE74BA7D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGHAM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjGHAM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:12:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D9219B7;
        Fri,  7 Jul 2023 17:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F19B61ACF;
        Sat,  8 Jul 2023 00:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566CBC433C8;
        Sat,  8 Jul 2023 00:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688775146;
        bh=ijIPQ+hptm0DWZFgQRUdBDKFLI/pxNjT4o8gTe1nWV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VejCWVV9U7psKJ3JrtNUdWwyjWoiPvzKVme9p7gPfbfghJgkdEX8kpkGiL6F7yYRq
         r+oHGPOjOOtEgsSRr+bxii5/WgIRCwYDC+KZAQ6KasAjQnW4km/WeHSN0SS2oAFOfi
         Jb/QD3EWha/3zssviaP/GAXjJgmyrYVZXUx0Jy3nzs/a0VKB/DBZGBPvPI+X2pHby9
         wTXv07i+YK1VlXHk+N0sz2Zu51eiYvC0XuNpcG5PkG8QpfpF+zvHbSyLT8YN7kleIy
         sPLoJG/Nle4Wwh+3OTtbo+SYbpJuMSd3UIKlvQAmVj9QwYr5LrLYdsg+d3VGfgG6lo
         +QyOFXkmKXmQg==
Date:   Fri, 7 Jul 2023 17:12:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        hayeswang@realtek.com, jflf_kernel@gmx.com, bjorn@mork.no,
        svenva@chromium.org, linux-kernel@vger.kernel.org,
        eniac-xw.zhang@hp.com, stable@vger.kernel.org
Subject: Re: [PATCH] r8152: Suspend USB device before shutdown when WoL is
 enabled
Message-ID: <20230707171225.3cb6e354@kernel.org>
In-Reply-To: <20230706182858.761311-1-alexandru.gagniuc@hp.com>
References: <20230706182858.761311-1-alexandru.gagniuc@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jul 2023 18:28:58 +0000 Alexandru Gagniuc wrote:
> For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
> in U3 state. If it is not, and the host "disappears", the chip will
> no longer respond to WoL triggers.
>  
> To resolve this, add a notifier block and register it as a reboot
> notifier. When WoL is enabled, work through the usb_device struct to
> get to the suspend function. Calling this function puts the link in
> the correct state for WoL to function.

Would be good to hear from USB experts on this one, to an outside seems
like something that the bus should be doing, possibly based on some
driver opt-in..

> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>

Please add a Fixes tag - I'm guessing it dates back to

Fixes: 21ff2e8976b1 ("r8152: support WOL")

?
-- 
pw-bot: cr
