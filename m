Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F5366733E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjALNes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjALNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:34:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4187BB08
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:34:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D42A661AA2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366CBC433D2;
        Thu, 12 Jan 2023 13:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673530484;
        bh=j0YIDz5bHF2dFE2r4pGCMvZWfbTDEfD2sZPAljVVdPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVh35eywb5oK7iIixDKPwxnygS6i9OfZxaRlgXZVZSaUI2xBUtrtHDIUB350VJI1c
         JK8EQ9nzK1wAVVCzb5Au21M7c+h9dTyP23XudUduDXGrppEhSIDJp/WGoB5uLyFd9W
         57K2iAQni9rcMi60meEtbkPnvxgIczX1aXRmp7I7L2GZAbLGkkAETYSDwJLFDmBIjC
         nfTIUiC9euE0vKEvft7Mu4mgCqgqDxlTvI6Pa7kXTCZ0RGOgRlpOVXJprKzRaChlzJ
         DgfIdidyjphtq0P40ueCY+WmQXLY4xRo9s0zzepVrezR5J69gSc8mIIWqX0BAx3aHE
         5rfJGq222ZZGQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFxjG-0001vA-Mi; Thu, 12 Jan 2023 14:34:51 +0100
Date:   Thu, 12 Jan 2023 14:34:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] genirq/irqdomain/msi: Add
 irq_domain_alloc_irqs_affinity() wrapper
Message-ID: <Y8AMejEy59W87YC5@hovoldconsulting.com>
References: <20221213140844.15470-1-johan+linaro@kernel.org>
 <20221213140844.15470-3-johan+linaro@kernel.org>
 <87358ggayt.ffs@tglx>
 <Y8AKKVs9vAFR+F6H@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8AKKVs9vAFR+F6H@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:24:58PM +0100, Johan Hovold wrote:
> On Wed, Jan 11, 2023 at 07:52:42PM +0100, Thomas Gleixner wrote:
> > On Tue, Dec 13 2022 at 15:08, Johan Hovold wrote:
> > > The full __irq_domain_alloc_irqs() interface was initially only intended
> > > for some legacy (x86) use cases while most callers should use the
> > > irq_domain_alloc_irqs() wrapper.
> > >
> > > Add a matching irq_domain_alloc_irqs_affinity() wrapper that can be used
> > > when an affinity hint needs to be provided and use it for MSI
> > > allocations.
> > 
> > I definitely like the irqchip cleanup, but this one is core code and
> > having the extra wrapper is not really buying us much.
> 
> Fair enough. If you don't expect there to be any further users then
> perhaps it's not worth it even if it arguably makes the call site a bit
> more readable (e.g. by dropping the base and realloc arguments).

And having this wrapper would also limit the use of the full (internal)
helper to places that actually need the realloc parameter (e.g. making
those stand out more).

Johan
