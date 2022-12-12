Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B666764A34C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiLLO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiLLO3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:29:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921DC12D06;
        Mon, 12 Dec 2022 06:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AA6EB80D8B;
        Mon, 12 Dec 2022 14:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C71C433D2;
        Mon, 12 Dec 2022 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670855352;
        bh=Rus4CdOiiPn7zFAosG9gmqEHn/vU+rdHuj+PuYGnEXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAmAzWWkhYpob2WNGn5P3l87YkLVt2J+gDnA5q/PAfUReD/3Y5Vfjmc1YYMg6jC9P
         5XtNdReR5EbdW6ySCZZALPLA1rfxWksQNIIcp6tLuWJXyuK205G5KrEtlT6nN8WRmL
         JdoDFb8bS1qXi/eVjlTIjt0TnPGii1Zmrn9bH053ZbO4EGWlr7XlUKZOmb3zHQHht8
         gxZr0BfBNHuYM5dQw82FJTt+qXG47m1khF+auqnwwvKOYdM3gOGN1BZ1aohHFWsLc0
         0x2BdSUFsBoekH48ZIviTY0edLXP/AUtlUgaYTOFA+KQ93wsoNIyEoo/84u2kkIeRX
         fPWG7s6x4m6JQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p4joF-0007Mc-B7; Mon, 12 Dec 2022 15:29:36 +0100
Date:   Mon, 12 Dec 2022 15:29:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/19] irqdomain: Switch to per-domain locking
Message-ID: <Y5c6z3t+sV/kIMjF@hovoldconsulting.com>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-20-johan+linaro@kernel.org>
 <87mt7sbtf9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt7sbtf9.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 03:14:34PM +0100, Thomas Gleixner wrote:
> On Fri, Dec 09 2022 at 15:01, Johan Hovold wrote:
> > The IRQ domain structures are currently protected by the global
> > irq_domain_mutex. Switch to using more fine-grained per-domain locking,
> > which may potentially speed up parallel probing somewhat.
> >
> > Note that the domain lock of the root domain (innermost domain) must be
> > used for hierarchical domains. For non-hierarchical domain (as for root
> > domains), the new root pointer is set to the domain itself so that
> > domain->root->mutex can be used in shared code paths.
> >
> > Also note that hierarchical domains should be constructed using
> > irq_domain_create_hierarchy() (or irq_domain_add_hierarchy()) to avoid
> > poking at irqdomain internals.
> 
> While I agree in principle, this change really makes me nervous.
> 
> Any fail in setting up domain->root correctly, e.g. by not using
> irq_domain_create_hierarchy(), cannot be detected and creates nasty to
> debug race conditions.
> 
> So we need some debug mechanism which allows to validate that
> domain->root is set up correctly when domain->parent != NULL.

Lockdep will catch that due to the

	lockdep_assert_held(&domain->root->mutex);

I added to irq_domain_set_mapping() and which is is called for each
(inner) domain in a hierarchy when allocating an IRQ.

Johan
