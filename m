Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91877715BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjE3K2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjE3K1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AED1715;
        Tue, 30 May 2023 03:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0F8B617FE;
        Tue, 30 May 2023 10:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA57C433D2;
        Tue, 30 May 2023 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685442356;
        bh=pY34Pb2areloIwOCiXV2hlSOd2QQ82VfjCkgmbChUDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8EgoMHmK/HHfo1Xv3pxKSQRqKHmc782ZzkCMWd+Dw5mkKvkUC3tJwe+lk4Owt06C
         8ImUYkftGpz/2VQxbVgLkl0JIb6BdL1nS+C+EYtwMfpCVDtGw45gQ0Z6ikv+fUfWzt
         6jpfPF7/ZKYRBPDQ9lda/ItNEgYeMrh7L5k6Vwm8=
Date:   Tue, 30 May 2023 11:25:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 7/9] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <2023053058-onlooker-fondue-8c24@gregkh>
References: <20230529140711.896830-1-hugo@hugovil.com>
 <20230529140711.896830-8-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529140711.896830-8-hugo@hugovil.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 10:07:09AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> changed the function of the GPIOs pins to act as modem control
> lines without any possibility of selecting GPIO function.
> 
> As a consequence, applications that depends on GPIO lines configured
> by default as GPIO pins no longer work as expected.
> 
> Also, the change to select modem control lines function was done only
> for channel A of dual UART variants (752/762). This was not documented
> in the log message.
> 
> Allow to specify GPIO or modem control line function in the device
> tree, and for each of the ports (A or B).
> 
> Do so by using the new device-tree property named
> "modem-control-line-ports" (property added in separate patch).
> 
> When registering GPIO chip controller, mask-out GPIO pins declared as
> modem control lines according to this new "modem-control-line-ports"
> DT property.
> 
> Boards that need to have GPIOS configured as modem control lines
> should add that property to their device tree. Here is a list of
> boards using the sc16is7xx driver in their device tree and that may
> need to be modified:
>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>     mips/boot/dts/ingenic/cu1830-neo.dts
>     mips/boot/dts/ingenic/cu1000-neo.dts
> 
> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")

So you are marking this as a "bugfix" and yet, it is at the end of a
much larger series of patches.  Does this fix require all of them?  If
so, it's not really relevant for stable kernels, right?  Or is it?

I'm confused, what should I, as a maintainer, do here?  Take just this
one fix for 6.4-final, and the rest for 6.5-rc1?  And add a proper cc:
stable@ tag?  Or queue them all up for 6.4-final?  Or all for 6.5-rc1?
Or something else?

What would you want to see if you were in my position here to help make
your life easier?

thanks,

greg k-h
