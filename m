Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D56C671A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjARLSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjARLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:16:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F8C5DC18;
        Wed, 18 Jan 2023 02:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCBB7B81BA1;
        Wed, 18 Jan 2023 10:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDABC433EF;
        Wed, 18 Jan 2023 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674037854;
        bh=JESyVLEBRskcOn6pGiXUzE4QX0hziwBDIa4wVXsbNCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fY97SJidlILMLeB4sgj157aP8uuTuwfnJ3d/HtvwBkbPYiHgwlpuWmXx90N3of1h0
         uf/voAEVr0UlP89b+slzMHrEM3XCslwpk0/biuUMzwoanBCTAOQUPeXd9/WfBVWZa8
         k3h1ra/S5PeiMKl1OXx5HGZ3eL7LOGliaqOEJ7StKCLQAFIsRQWog4pde6EJ+dR+m9
         mCgBFSqMYTnfwqV6d2dMby9YBTewhHELGuF3S0e6O2wTeES1ytGvt7wqiDbbm079wV
         geSf3eNhTn6PXkvUFhO+BZT5QDyymNrapcgQpPj7UpoUB4STS42103uJdzpS5Vh+7W
         ylg9EEo9ickfg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI5iw-000300-OB; Wed, 18 Jan 2023 11:31:18 +0100
Date:   Wed, 18 Jan 2023 11:31:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 11/19] x86/ioapic: Use irq_domain_create_hierarchy()
Message-ID: <Y8fKdl/kJJ/3Uymn@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-12-johan+linaro@kernel.org>
 <87pmbckfe7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmbckfe7.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:41:36PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> >  
> > -	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
> > -						 (void *)(long)ioapic);
> > -
> > +	ip->irqdomain = irq_domain_create_hierarchy(parent, 0, hwirqs, fn,
> > +						    cfg->ops,
> > +						    (void *)(long)ioapic);
> 
> The 80 character limit has been lifted quite some time ago. Please use
> the 100 which are now the norm.

Not everyone agrees, including coding-style.rst:

	The preferred limit on the length of a single line is 80 columns.

	Statements longer than 80 columns should be broken into sensible
	chunks, unless exceeding 80 columns significantly increases
	readability and does not hide information.

I go above 80 chars when it improves readability, but it's still a soft
limit for many of us.

I'll change the above, but not sure trying too hard to fit everything in
one line really improves things in cases like:

-       uv_domain = irq_domain_create_hierarchy(x86_vector_domain, 0, 0, fn,
-                                               &uv_domain_ops, NULL);
+       uv_domain = irq_domain_create_hierarchy(x86_vector_domain, 0, 0, fn, &uv_domain_ops, NULL);

Johan
