Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A23627B68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiKNLDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiKNLDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:03:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAFB1EAE3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:03:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 385B9B80DE9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB47C433D6;
        Mon, 14 Nov 2022 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668423789;
        bh=We0tNznk6pD1EsYDV5SF5sB9KstEhBcQ5VVI9l4wVjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZnL7S0RSLGTUOgQ+xI675KTj8CHtInFBWJ6ZmcJJlq6pC4fbmhuoIwiXJafRZEN2
         j1auOba7pk/CQM5dYeCxvawq8db4ZmHhLZf1XtyLsd46tPxzZ0KqXEyoSeiR1aDAyt
         ew1xMjuGZERQpUfmCQsbRvOhLQ2l/g6KMet1v46j/uLQvOD4pe5zAZeD57q3GGQATM
         D6ePOh7LTncRVz0rzDcMX2FBO+6Wr7R5ZyUz9IOBuc0oCNr92FUvSQ6h0TSbCezwAx
         izoY7/BO6H17+EO/OH9B3KsSc2HFmZeWrH5WCBdjietkxLGbkKCMjEZGsvecO7jgGO
         ZgFxkvFx9BptQ==
Date:   Mon, 14 Nov 2022 11:03:05 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Do not sleep in the power off handler
Message-ID: <Y3IgaSWb46QjljfP@google.com>
References: <20221105212909.6526-1-samuel@sholland.org>
 <a3488b0c-dbc7-0109-8ba7-9f319f018e22@collabora.com>
 <Y2jSTotJgjUx1tHV@google.com>
 <ac5063a0-f03d-44ba-63a5-f55e9f2fd2de@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5063a0-f03d-44ba-63a5-f55e9f2fd2de@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Nov 2022, Dmitry Osipenko wrote:

> On 11/7/22 12:39, Lee Jones wrote:
> > On Mon, 07 Nov 2022, Dmitry Osipenko wrote:
> > 
> >> On 11/6/22 00:29, Samuel Holland wrote:
> >>> Since commit 856c288b0039 ("ARM: Use do_kernel_power_off()"), the
> >>> function axp20x_power_off() now runs inside a RCU read-side critical
> >>> section, so it is not allowed to call msleep(). Use mdelay() instead.
> >>>
> >>> Fixes: 856c288b0039 ("ARM: Use do_kernel_power_off()")
> >>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >>> ---
> >>>
> >>>  drivers/mfd/axp20x.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> >>> index 88a212a8168c..880c41fa7021 100644
> >>> --- a/drivers/mfd/axp20x.c
> >>> +++ b/drivers/mfd/axp20x.c
> >>> @@ -842,7 +842,7 @@ static void axp20x_power_off(void)
> >>>  		     AXP20X_OFF);
> >>>  
> >>>  	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
> >>> -	msleep(500);
> >>> +	mdelay(500);
> >>>  }
> >>>  
> >>>  int axp20x_match_device(struct axp20x_dev *axp20x)
> >>
> >> ARM was doing local_irq_disable() on power-off before
> >> do_kernel_power_off() was introduced, so this should've been incorrect
> >> for a couple years at least. If I'm not missing anything.
> > 
> > Is that a review?  Care to provide a tag?
> 
> It's a review and my point was that the "Fixes" tag in this patch
> doesn't look correct. But this is minor comment, otherwise patch looks
> okay. Hope that the relevant I2C controller driver supports atomic
> transfer that are required for power-off to work.
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thanks.

-- 
Lee Jones [李琼斯]
