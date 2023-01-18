Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB066718C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjARKPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjARKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:13:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD905955F;
        Wed, 18 Jan 2023 01:22:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE18616ED;
        Wed, 18 Jan 2023 09:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6099C433F2;
        Wed, 18 Jan 2023 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674033723;
        bh=DZS895Z+3sptXir0tPzxTsJKKkNp6DzwiYVTcI+Nxas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQ7ipcJnCrbNJpn/1LWq84GZ6TR5qt3+KUz1dTKkr0XakM13mE2CdJADXrQLKwcR6
         /Y3Z9lMY/yyTr/h9ZUnaD8+HXWyOE5ECHRk5Ms4N/Ok8HHvwCpTGqhjRA0VIalsHhM
         Me7LShijNUwJaJ0wWn8jIkIIhcRWdLmHJ1kRfvMXLLv6X71hv3leQfEbYu6u3h9QRe
         CgT19EWFPvSX+s3slPUT+xSyveq5YOLXegUVs4z8Ti9TPBsI0yH1Rys/JCC1QfWt8t
         ughKXZz3GlLkly1qj6aT0KSqaw88dFUiVD4evJ91gGUyuExYpTAmMoCAcYMW+RlnUq
         AdP1+leZLv+ng==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI4eI-0001cJ-FS; Wed, 18 Jan 2023 10:22:27 +0100
Date:   Wed, 18 Jan 2023 10:22:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 06/19] irqdomain: Drop revmap mutex
Message-ID: <Y8e6Us0Qgt0p5S4R@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-7-johan+linaro@kernel.org>
 <871qnslut3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qnslut3.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:23:20PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> > The global irq_domain_mutex is now held in all paths that update the
> > revmap structures so there is no longer any need for the revmap mutex.
> 
> This can also go after the 3rd race fix, but ...
> 
> >  static void irq_domain_clear_mapping(struct irq_domain *domain,
> >  				     irq_hw_number_t hwirq)
> >  {
> > +	lockdep_assert_held(&irq_domain_mutex);
> 
> these lockdep asserts want to be part of the [dis]association race
> fixes. They are completely unrelated to the removal of the revmap_mutex.

No, they are very much related to the removal of the revmap_mutex. These
functions deal with the revmap structures which before this patch were
clearly only modified with the revmap_mutex held.

The lockdep assert is here to guarantee that my claim that all current
(and future) paths that end up modifying these structures do so under
the irq_domain_mutex instead.

> Your race fixes change the locking and you want to ensure that all
> callers comply right there, no?

I want to make sure that all callers of these function comply, yes.
That's why the asserts belong in this patch.

Johan
