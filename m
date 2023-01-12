Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073866731C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjALNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjALNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:24:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC27543A39
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 689B8B81E5A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E64C433D2;
        Thu, 12 Jan 2023 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673529891;
        bh=0zSlVdYnPlbeNYKtpgCs0o57tBG0cbE87Ki1QmaP4YM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Waya4oOTGc/ruH/oPImj1IC6j6yg1CShhpqNMoexocftc7u43r/3dnDLXBYzw52p5
         q/8Sf1poFhpD36FOwMnfSb0I/thmR/cgN5bLo72F9k14o0wY/SLvyjB/n+KgH+1Nhv
         XbyJb0xONCyr+Ah/iSpkMaTGlceoCXaP/w86xG9aWzlUlfVyIYAnfqh8SVF/EiqlfF
         oamFvinesWSFSamkc2Hu79ua827T0ZKcABEyx+2i7/IYeLNNDpntxOztWfdfXDxG/Q
         aBJETlWkC9h++bhC+vvVvEWLLSfPF5+ekBRVbmGad8Z5KsLzBNRoRQzyThMJjbJOkR
         EeTIiH4GrgRmw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFxZh-0001fB-IY; Thu, 12 Jan 2023 14:24:58 +0100
Date:   Thu, 12 Jan 2023 14:24:57 +0100
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
Message-ID: <Y8AKKVs9vAFR+F6H@hovoldconsulting.com>
References: <20221213140844.15470-1-johan+linaro@kernel.org>
 <20221213140844.15470-3-johan+linaro@kernel.org>
 <87358ggayt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87358ggayt.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 07:52:42PM +0100, Thomas Gleixner wrote:
> On Tue, Dec 13 2022 at 15:08, Johan Hovold wrote:
> > The full __irq_domain_alloc_irqs() interface was initially only intended
> > for some legacy (x86) use cases while most callers should use the
> > irq_domain_alloc_irqs() wrapper.
> >
> > Add a matching irq_domain_alloc_irqs_affinity() wrapper that can be used
> > when an affinity hint needs to be provided and use it for MSI
> > allocations.
> 
> I definitely like the irqchip cleanup, but this one is core code and
> having the extra wrapper is not really buying us much.

Fair enough. If you don't expect there to be any further users then
perhaps it's not worth it even if it arguably makes the call site a bit
more readable (e.g. by dropping the base and realloc arguments).

Johan
