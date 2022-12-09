Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFF64839C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLIOSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLIOSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:18:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00CB28
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:18:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6737D62267
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE01BC433EF;
        Fri,  9 Dec 2022 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670595496;
        bh=k3lReZsB9ujrUbztvY5qcuTZbP31euMRI/x+bqTAoo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSO53tSWdADEz5EAUd/an2dSBqGUFwXffbLVUPBh3fcgpsD3JgiS/RNHDs6mKd6jZ
         wNJz8pcougnyVeNgLQ4uUKLU27/4d8WtrfWgW1F+strtXqp7GL4+p2U0kL3d+JSLPU
         yIxBJDhGVC6+wG/Tn6YP/vdQ6t7DbwxnqmVAaOSSOAwmvOMgMGDCZ/hDRSjSaOW0Rr
         CFP/RbkdnHWptrKJTmM8KEYDMv0+/L0OxG8RU8+6SwGaAoSIjPmpNd6kPUBXRNAZd4
         vjWy62LbhHqYn5PMQf9L+sOGQyV2wl/wI2r74IC0dYAGEa42NXbB3AWUWSLpvvZAQG
         Lz8WHwrXiVmsw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p3eCv-0000dl-Gt; Fri, 09 Dec 2022 15:18:33 +0100
Date:   Fri, 9 Dec 2022 15:18:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 2/4] irqdomain: Fix mapping-creation race
Message-ID: <Y5NDuV+xb3FZRHAr@hovoldconsulting.com>
References: <20220901142816.13731-1-johan+linaro@kernel.org>
 <20220901142816.13731-3-johan+linaro@kernel.org>
 <87v8ppkofy.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8ppkofy.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Sep 15, 2022 at 09:54:25AM +0100, Marc Zyngier wrote:
> Johan,
> 
> On Thu, 01 Sep 2022 15:28:14 +0100,
> Johan Hovold <johan+linaro@kernel.org> wrote:
> > 
> > Parallel probing (e.g. due to asynchronous probing) of devices that share
> > interrupts can currently result in two mappings for the same hardware
> > interrupt to be created.
> > 
> > Add a serialising mapping mutex so that looking for an existing mapping
> > before creating a new one is done atomically.
> > 
> > Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
> > Fixes: b62b2cf5759b ("irqdomain: Fix handling of type settings for existing mappings")
> > Cc: Dmitry Torokhov <dtor@chromium.org>
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Link: https://lore.kernel.org/r/YuJXMHoT4ijUxnRb@hovoldconsulting.com
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> I must confess I have a hard time figuring out the semantic difference
> between map_mutex and revmap_mutex. or rather, what is the use of
> revmap_mutex once map_mutex is taken. They fundamentally overlap, and
> I have the feeling one should eventually replace the other.
> 
> If anything, you should absolutely define/document how these two locks
> interact.

Sorry about the late follow-up on this. I meant to revisit this much
sooner, but couldn't seem to find the time until this week.

I just sent you a v3 which reworks the irqdomain locking and fixes the
race in the process. In the end the irq_domain_mutex is only used for
managing the irq_domain_list, while domain operations use per-domain
(hierarchy) locking.

Johan
