Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD566DC449
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDJI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJI1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF27C30C8;
        Mon, 10 Apr 2023 01:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8876560C7F;
        Mon, 10 Apr 2023 08:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ED2C433D2;
        Mon, 10 Apr 2023 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681115221;
        bh=wdrP0v6vCirsnZnScA2c36yAoABoqtZx/h3x+Po66Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEACWwOemFrAUM+fsTXmC46Xz1a+AwRk6AJYzc6Hljf3dRc/QwS0JEP5yYgJTZsjT
         8JU2cp509ahyUh9BrJgX2EcLR7FX/yLhQrUSFeGRDipEqgq7wR/olUDdW3dfH+laLd
         8PIsyixh4sX+b8equqeE8bV7eeYg6XcfiUtaK1uI=
Date:   Mon, 10 Apr 2023 10:26:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around
 tcpm logs
Message-ID: <2023041004-antarctic-hardiness-524e@gregkh>
References: <20230410073134.488762-1-badhri@google.com>
 <2023041028-irritate-starless-a42f@gregkh>
 <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 01:08:55AM -0700, Badhri Jagan Sridharan wrote:
> On Mon, Apr 10, 2023 at 12:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 10, 2023 at 07:31:34AM +0000, Badhri Jagan Sridharan wrote:
> > > This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allows the
> > > logs to be wrapped around. Additionally, when set, does not clear
> > > the TCPM logs when dumped.
> > >
> > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > ---
> > >  drivers/usb/typec/tcpm/Kconfig | 6 ++++++
> > >  drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> > > index e6b88ca4a4b9..4dd2b594dfc9 100644
> > > --- a/drivers/usb/typec/tcpm/Kconfig
> > > +++ b/drivers/usb/typec/tcpm/Kconfig
> > > @@ -18,6 +18,12 @@ config TYPEC_TCPCI
> > >       help
> > >         Type-C Port Controller driver for TCPCI-compliant controller.
> > >
> > > +config TCPM_LOG_WRAPAROUND
> > > +     bool "Enable TCPM log wraparound"
> > > +     help
> > > +       When set, wraps around TCPM logs and does not clear the logs when dumped. TCPM logs by
> > > +       default gets cleared when dumped and does not wraparound when full.
> >
> > Kconfig help text needs to be wrapped at the properly width.
> 
> I assumed that the width is 100 characters, but it looks like it is
> 80. Will fix it in the next version.
> >
> > And you do not provide any hint here as to why this is not the default
> > option, or why someone would want this.
> 
> "TCPM logs by default gets cleared when dumped and does not wraparound
> when full." was intended
> to convey why someone would want to set this. Perhaps it's not effective.
> 
> Does the below look better:
> "TCPM logs by default gets cleared when dumped and does not wraparound
> when full. This can be overridden by setting this config.
> When the config is set, TCPM wraps around logs and does not clear the
> logs when dumped."
> 
> Also, I could make this default if that's OK with Guenter.
> 
> >
> > So, why is this not just the default operation anyway?  Why would you
> > ever want the logs cleared?
> 
> I remember Guenter mentioning that he was finding it useful to not
> wrap around the logs to fix problems
> during tcpm_register_port (init sequence). IMHO wrapping around the
> logs helps to triage interoperability
> issues uncovered during testing. So both approaches have their own advantages.

But as this is a build-time option, what would cause someone to choose
one over the other, and then when the system is running, they can't
change them?

That does not seem good at all.

Why not just use tracing instead of this odd custom log buffer?  That's
a better solution overall, right?

thanks,

greg k-h
