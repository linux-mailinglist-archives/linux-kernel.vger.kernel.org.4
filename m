Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7BE6DC9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjDJRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:00:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B81BF0;
        Mon, 10 Apr 2023 10:00:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-514156b4976so594660a12.3;
        Mon, 10 Apr 2023 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681146025; x=1683738025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDMIxIlzLe6OoM/naJz5POkNQuDzrQhBtMQcvFk0KY8=;
        b=RU4JTfE+2r2I/O3lhOHpLJLUNeiNQumTqneN4FMDHyOHkaCNYKnfdy25EpHrHEjP2a
         MtHpMjqQ7sO9a1Wf/pnJ//nhyDR9+P+GQPeSwRSAX8Km3a7alSCA32fXVe+B3VgkDMbE
         capCRVmRWK52w5/GdMijjLlKvlU5nICMrB+SB6mHpX9xArmOFJENG+zY5BVF9ZLWOOo3
         OFzAGKtrQ7gI6toY1qQ+91NdBTMElQyK+hN+s+Cu2pLzehyTlvgyWLhR9c67TiwgezRh
         npZ7V9lNjsNxxXq6gWhhkAUm0zerDjhiChFEyCnd7Fh+rCFAcbiolmcTPlGGjOgrtsni
         ENbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146025; x=1683738025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDMIxIlzLe6OoM/naJz5POkNQuDzrQhBtMQcvFk0KY8=;
        b=nRpGHdunFZpFrbKNpD3w2gDaFDQUv5NnlM85ZIWcD+y4JOz0UbY5VHJFWylthIMKIx
         3fGjbOv3F4JbSGDgMZfxP0gJH3Efw/qOAqLdw400HLZkMNziAAjWMIKRL+oOOy/IM0YF
         E/gNMg1njIvbdX1h+TQuwPiI6UEa2tYC/1yHz52gXNsxKWYGF/RHXHNvcxmP8bFjIKib
         AXJOGZpVzsVd6ffdIF+tuPSXph5pjSUdJidcsRQjsBK9z2B+lc7u0ZKt/sqMU6NGqHQB
         zL/hFK7Nfl/aI/lI0r3eYg5DIOGv6A5DtAm6Dec6+UmgXRaIi8nfExpHafrdjFW6T9AY
         wivw==
X-Gm-Message-State: AAQBX9dimcQjPUtZx1pRSlm6/qtRFYlHHijp7mUknOYRrC1+73KB2CDk
        Ky45kShdo6zYw0jOZt8oZFM=
X-Google-Smtp-Source: AKy350ZczkXuAUfkRgDblFH05pj0TflbxQPGzLKhhFHBI1V7r2z1V7Pho0DaSQZJUsx31wvrbe8Epw==
X-Received: by 2002:aa7:95b1:0:b0:62d:dd8b:f42a with SMTP id a17-20020aa795b1000000b0062ddd8bf42amr11990296pfk.25.1681146024387;
        Mon, 10 Apr 2023 10:00:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b0062d859a33d1sm8056827pfn.84.2023.04.10.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:00:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 Apr 2023 10:00:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around
 tcpm logs
Message-ID: <b1ac0ab9-e6f3-4301-a231-519752e4a735@roeck-us.net>
References: <20230410073134.488762-1-badhri@google.com>
 <2023041028-irritate-starless-a42f@gregkh>
 <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com>
 <2023041004-antarctic-hardiness-524e@gregkh>
 <CAPTae5JFC8WUzjrMeiyw7tYfWpsZUQThrrvG_etx7Fb2KP6y6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5JFC8WUzjrMeiyw7tYfWpsZUQThrrvG_etx7Fb2KP6y6A@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 02:00:08AM -0700, Badhri Jagan Sridharan wrote:
> On Mon, Apr 10, 2023 at 1:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 10, 2023 at 01:08:55AM -0700, Badhri Jagan Sridharan wrote:
> > > On Mon, Apr 10, 2023 at 12:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Apr 10, 2023 at 07:31:34AM +0000, Badhri Jagan Sridharan wrote:
> > > > > This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allows the
> > > > > logs to be wrapped around. Additionally, when set, does not clear
> > > > > the TCPM logs when dumped.
> > > > >
> > > > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > > > ---
> > > > >  drivers/usb/typec/tcpm/Kconfig | 6 ++++++
> > > > >  drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
> > > > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> > > > > index e6b88ca4a4b9..4dd2b594dfc9 100644
> > > > > --- a/drivers/usb/typec/tcpm/Kconfig
> > > > > +++ b/drivers/usb/typec/tcpm/Kconfig
> > > > > @@ -18,6 +18,12 @@ config TYPEC_TCPCI
> > > > >       help
> > > > >         Type-C Port Controller driver for TCPCI-compliant controller.
> > > > >
> > > > > +config TCPM_LOG_WRAPAROUND
> > > > > +     bool "Enable TCPM log wraparound"
> > > > > +     help
> > > > > +       When set, wraps around TCPM logs and does not clear the logs when dumped. TCPM logs by
> > > > > +       default gets cleared when dumped and does not wraparound when full.
> > > >
> > > > Kconfig help text needs to be wrapped at the properly width.
> > >
> > > I assumed that the width is 100 characters, but it looks like it is
> > > 80. Will fix it in the next version.
> > > >
> > > > And you do not provide any hint here as to why this is not the default
> > > > option, or why someone would want this.
> > >
> > > "TCPM logs by default gets cleared when dumped and does not wraparound
> > > when full." was intended
> > > to convey why someone would want to set this. Perhaps it's not effective.
> > >
> > > Does the below look better:
> > > "TCPM logs by default gets cleared when dumped and does not wraparound
> > > when full. This can be overridden by setting this config.
> > > When the config is set, TCPM wraps around logs and does not clear the
> > > logs when dumped."
> > >
> > > Also, I could make this default if that's OK with Guenter.
> > >
> > > >
> > > > So, why is this not just the default operation anyway?  Why would you
> > > > ever want the logs cleared?
> > >
> > > I remember Guenter mentioning that he was finding it useful to not
> > > wrap around the logs to fix problems
> > > during tcpm_register_port (init sequence). IMHO wrapping around the
> > > logs helps to triage interoperability
> > > issues uncovered during testing. So both approaches have their own advantages.
> >
> > But as this is a build-time option, what would cause someone to choose
> > one over the other, and then when the system is running, they can't
> > change them?
> 
> During initial phases of bringup, it makes sense to not wrap around
> the logs, but, once bringup is done its most effective to wraparound
> so that interop issues reported by the end users can be triaged where
> TCPM logs are very effective.

Not really, because the problem tends to be the remote device
(or at least it used to be), not a driver under development.

> Also, without wrapping around, the logbuffer logs are completely stale
> after the user goes through a few USB connect and disconnect cycles
> till the system is rebooted.

Unless they are cleared.

Again, the premise is wrong here. The idea was to ensure that the
beginning of a problem is caught and available in the log, not its tail.
This includes "beginning" as the behavior immediately after boot regarding
an already connected device, and the behavior observed when inserting
a device into the running system. Again, in both cases it was most
important to catch the beginning of a problem, not its tail.

> If we don't want to pursue the Kconfig option, we should atleast make
> TCPM default to wrapping the logs around when full so we could
> maximise the use of the logbuffer contents.
> 

I don't really agree, but then I am not in a position to argue either.
Maybe the premise and reasons have changed since I wrote the driver.

Guenter

> >
> > That does not seem good at all.
> >
> > Why not just use tracing instead of this odd custom log buffer?  That's
> > a better solution overall, right?
> 
> Tracing is not enabled by default in most systems. End users don't
> want to retry and reproduce the failure to collect traces even if they
> could reproduce it consistently.
> So tracing was not proving handy here.
> 
> Thanks,
> Badhri
> 
> >
> > thanks,
> >
> > greg k-h
