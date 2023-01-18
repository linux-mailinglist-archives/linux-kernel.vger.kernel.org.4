Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7767198A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjARKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjARKpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:45:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23447A507;
        Wed, 18 Jan 2023 01:51:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92924B81BA0;
        Wed, 18 Jan 2023 09:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ACBC433D2;
        Wed, 18 Jan 2023 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674035479;
        bh=j/7pxZs99cf2pf1Bco/XMbeVzyp9qS8qcECcckzCgwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqmZoVeGBkzKKbVdNOT1zBosOWrD2+vFykeBgMmnJT82zWMD/Zf1AK1d39A2ygvdk
         yLmefoW/XOjQndPkjz5vYkpLE9hG0BY4L7JWF9DhYKWZhBH8sZsXzrJjTBiia6f9tk
         xJAwe/5LlE0JknRYXhNmGPWkj0m4cR/BAHbxXOlo0ncfuMtB1jSS3FavGrZmt2RoKS
         0ZotIc9qe4fvw+qMe6SA2B+uTVlakxtncNHvvJ0LNRxEW9hQC5uFHt2ttZDZKmcERi
         SnBt3eIrIFF/g4w480CdSN0DDwh2oEYIxmWwbT2c6IwdYBoQd2uGbXXDnRK1/iZyFE
         LSGUPX8TnDi+w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI56d-00021s-KC; Wed, 18 Jan 2023 10:51:43 +0100
Date:   Wed, 18 Jan 2023 10:51:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 19/19] irqdomain: Switch to per-domain locking
Message-ID: <Y8fBL+h2l5Wsiq2Z@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-20-johan+linaro@kernel.org>
 <87mt6gkez4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt6gkez4.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:50:39PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> > The IRQ domain structures are currently protected by the global
> > irq_domain_mutex. Switch to using more fine-grained per-domain locking,
> > which may potentially speed up parallel probing somewhat.
> 
> Does it or not?
> 
> If not then why adding all this churn for no real value?

It probably doesn't make much difference, but Marc wanted per-domain
locking:

    > I'd really like to avoid a global mutex. At the very least this should
    > be a per-domain mutex, otherwise this will serialise a lot more than
    > what is needed.
    
    Yeah, I considered that too, but wanted to get your comments on this
    first.
    
    Also note that the likewise global irq_domain_mutex (and
    sparse_irq_lock) are taken in some of these paths so perhaps using finer
    locking won't actually matter that much as this is mostly for parallel
    probing.

    https://lore.kernel.org/lkml/YuKHiZuNvN+K9NCc@hovoldconsulting.com/

As part of fixing the races, this series has now replaced the per-domain
revmap mutexes with the global irq_domain_mutex, which could possibly be
perceived as a step in the wrong direction in this respect.

This patch restores per-domain locking for non-hierarchical domains and
extends it to hierarchical domains. This leaves the irq_domain_mutex to
only be used for things that actually need a global lock such as the
domain list.

I consider this mostly a clean up, and I did intentionally place it last
in order to not have the fixes depend on it.

Johan
