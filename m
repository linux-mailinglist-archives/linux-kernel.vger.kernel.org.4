Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF766718EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjARK0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjARKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:25:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02666EEA;
        Wed, 18 Jan 2023 01:30:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C1FEB81C13;
        Wed, 18 Jan 2023 09:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C573EC433D2;
        Wed, 18 Jan 2023 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674034205;
        bh=3XyBFQNLnTyo9L+X0vrC5knpbLQfzzDd/EREfX7SuV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiOTsPzfhCtG5D2uMQmCk52l/VOS8fqxJvZPWk57KOq8xyLCHSOgS6UY4qI+N7kPI
         /JOk6EDQXbDnhyqJuIDv8wP9EfKfmhNa5WIaVYIF05q1YvJOEcOyYUjNYFEBrCDH9Y
         ItuJ+LdqkqD39zPRSoLHzSyaHNXURNNkWUZsGJs2erhOqDliW7SGP8I4WeeFLT1Y7R
         7y3XZQHlKo4yxIgYBWQcFXtoigA0dKA0ioeiG7D4zLHgLO6HQPGL1GLnnfYDoLC7Ut
         AfrVDOuoOVdg+pGi/Cbi8sE+qokWA6U2JBzMGzMgLhpvlP0PSczfsxmiV2U4bp3GPN
         chX0f98MBfIEA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI4m6-0001jE-0W; Wed, 18 Jan 2023 10:30:30 +0100
Date:   Wed, 18 Jan 2023 10:30:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 08/19] irqdomain: Refactor __irq_domain_alloc_irqs()
Message-ID: <Y8e8Nm2lu1jFE6Mx@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-9-johan+linaro@kernel.org>
 <87v8l4kfpr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8l4kfpr.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:34:40PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:

> > -int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
> > -			    unsigned int nr_irqs, int node, void *arg,
> > -			    bool realloc, const struct irq_affinity_desc *affinity)
> > +static int ___irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
> > +				    unsigned int nr_irqs, int node, void *arg,
> > +				    bool realloc, const struct irq_affinity_desc *affinity)
> 
> __ vs. ___ is almost undistinguishable.
> 
> irq_domain_alloc_irqs_locked() nicely explains what this is about, no?

Yeah, wasn't too happy about those three underscores either, but with
the exported function unfortunately already having a double underscore
prefix... I'll try switching to a 'locked' suffix instead.

Johan
