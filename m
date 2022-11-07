Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9561EF3F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiKGJjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiKGJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:39:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B0E18359
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:39:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0EE560FA0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A71FC433C1;
        Mon,  7 Nov 2022 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667813972;
        bh=spbjsj6d/mh2WdTsuolIPPVMJv8lUrjlgNBp9SHvitw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwhSIempCsTnTfOAjRtrMqCpwbJYRsZSqdIClAKuLcKMRIl2vDWN6wbHbIGwULGcz
         gvpw1zLBYsvR8paBpSu7IKnRtBc7DtCkJH9kwzU8DzETj1eAPhkEZbvcDHF+HWLF4b
         6gWMgap0xH3JQMqx//YixgOSLEkUrF4HWBxnrW7W9Jl0a1SKg3AvXYw7XsqE7bZ0ni
         QbnH52a3fe4rDOTZnKnTysN2udMnK5BiIEQBD4NopVZFeN7Lb7sSHkH3JnvVixhOeI
         oIGXvSoUVOI3qSXUPG8ZJ8lh8wAQuWfoQ90yg882VNLsI9UETJwyRcq4Z4KaFI/ASI
         tOviXTILlHrbw==
Date:   Mon, 7 Nov 2022 09:39:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Do not sleep in the power off handler
Message-ID: <Y2jSTotJgjUx1tHV@google.com>
References: <20221105212909.6526-1-samuel@sholland.org>
 <a3488b0c-dbc7-0109-8ba7-9f319f018e22@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3488b0c-dbc7-0109-8ba7-9f319f018e22@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Nov 2022, Dmitry Osipenko wrote:

> On 11/6/22 00:29, Samuel Holland wrote:
> > Since commit 856c288b0039 ("ARM: Use do_kernel_power_off()"), the
> > function axp20x_power_off() now runs inside a RCU read-side critical
> > section, so it is not allowed to call msleep(). Use mdelay() instead.
> > 
> > Fixes: 856c288b0039 ("ARM: Use do_kernel_power_off()")
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> >  drivers/mfd/axp20x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index 88a212a8168c..880c41fa7021 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -842,7 +842,7 @@ static void axp20x_power_off(void)
> >  		     AXP20X_OFF);
> >  
> >  	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
> > -	msleep(500);
> > +	mdelay(500);
> >  }
> >  
> >  int axp20x_match_device(struct axp20x_dev *axp20x)
> 
> ARM was doing local_irq_disable() on power-off before
> do_kernel_power_off() was introduced, so this should've been incorrect
> for a couple years at least. If I'm not missing anything.

Is that a review?  Care to provide a tag?

-- 
Lee Jones [李琼斯]
