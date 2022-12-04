Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1277F641BAD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 09:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLDIrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 03:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLDIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 03:47:16 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4141611C1E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 00:47:16 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 124so8732961pfy.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QutOAL+nMDB4Cb3AtDiIQ2iv82OlmswSDdCAvRLXxpo=;
        b=jEUgJbFkejprgcotd3OgshHJzjqLYMr1//21XcDrGTPmwsKzQs67SalriJk5yogCZD
         naMHk25OwpidKgNZsfrNIfa+8KIHp+Fed3d1ByUN8hbyMCMKMsCsW/xCpWzbn22gYWdX
         gcktV1BGgq9UA1HLNUsUqCB3LAlewBtqotoqkhBdreR0e6SusnF/Y15UoSeGNjAAtcsU
         gQ0PXxwqX9Vfq0U48pbgEl04VdmQB3jvH4XBD10Ms61v25i7z2Jd2LNKLSIaHIFJws6O
         uKyOiJRhKT5mzT+GA22MIVTOPd5gU5+wXdjlmyotkLAE2HNhkykDA0OjmWt+VAHOYiFF
         oynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QutOAL+nMDB4Cb3AtDiIQ2iv82OlmswSDdCAvRLXxpo=;
        b=Hw2Sv/3b2gOdND6bPrUaldzohOnv373BCzhgrvcnEWl5HrbT0hhhAI71RpeCs5hG5n
         o/zBmp+YCaQ3HI4Fp8ZouenVR5uiPCijirLEU/FsFOZpCEqNNnW7Zefg39rL3+UM4wvc
         DRI4gTz6Z7lgXfMIxQrK9arW+VhxOvp1J/Ve7nbz/lQ4dZEQvajQ3fT0o4FtdumCcRo/
         8yU7WF1A7lGbfFMvYZfe6F4a2zImVQZDGtszZtbkMnST2sOVt2whDtbX3rhs85v4EDMO
         p592SuaBUwEjA+s1KVWWQYmbXaKHR6zerdj/C+5c6F5tWnaKD2evJ8m0N0aqsGL8yjjM
         KOfw==
X-Gm-Message-State: ANoB5pkXk8D8qJlkcuDmOuHjUp6YYaoPWDXwJy8rVldB4noJ2e35DE5e
        cV+TPDwKIiC5Fiv/RZDKrkEXAXtxr11yXRo0arZpwUS9Kief1Jt0
X-Google-Smtp-Source: AA0mqf6R+Tp4dvP/ZzQ9B2oqndBCvDq8NSf+W9/couiaPGS+SwR5sgWtCCN8VoBu0aTxsUBc4fXXJx7mHHcJ94WiuWQ=
X-Received: by 2002:a63:eb01:0:b0:477:5a8f:8037 with SMTP id
 t1-20020a63eb01000000b004775a8f8037mr51393130pgh.227.1670143635576; Sun, 04
 Dec 2022 00:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20220831001555.285081-1-badhri@google.com> <Yw90JmdIxg/YdUYH@kuha.fi.intel.com>
 <7bf33aaa-11d3-2ff2-8c32-70e11340a3a9@roeck-us.net>
In-Reply-To: <7bf33aaa-11d3-2ff2-8c32-70e11340a3a9@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Sun, 4 Dec 2022 00:46:38 -0800
Message-ID: <CAPTae5JmtEGyDV0ZUn3x_yOmRu8bWE6zuZ5vqSFqGFJOdHHzoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usb: typec: tcpm: Add callbacks to mitigate
 wakeups due to contaminant
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking the time out to review !
Circling back to address  the feedback here in Version 3 of the patchset.

I was able to move the logic around  disconnect_while_debounce to the
lower level maxim tcpc driver.
However, I couldn't incorporate a callback as generic as run_state_machine.
Instead I have added a callback, is_potential_contaminant, which calls
the lower tcpc driver for every state transition in the TCPM state
machine.
This is somewhat similar to what Heikki had suggested but instead of
calling it at the end, had to call the is_potential_contaminant at the
beginning.
is_potential_contaminant would allow the lower level tcpc driver to
determine presence of potential contaminant.
The CHECK_CONTAMINANT state in TCPM had to be retained as TCPM should
not be reacting to changes in the system while the lower level tcpc
driver is waiting for the port to be clean.

Sending out the Version 3 of the patchset.

Thanks,
Badhri


On Wed, Aug 31, 2022 at 10:51 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/31/22 07:45, Heikki Krogerus wrote:
> > Hi Badhri,
> >
> > On Tue, Aug 30, 2022 at 05:15:53PM -0700, Badhri Jagan Sridharan wrote:
> >> On some of the TCPC implementations, when the Type-C port is exposed
> >> to contaminants, such as water, TCPC stops toggling while reporting OPEN
> >> either by the time TCPM reads CC pin status or during CC debounce
> >> window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
> >> to restart toggling, the behavior recurs causing redundant CPU wakeups
> >> till the USB-C port is free of contaminant.
> >>
> >> [206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> >> [206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> >> [206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> >> ...
> >>
> >> To mitigate redundant TCPM wakeups, TCPCs which do have the needed hardware
> >> can implement the check_contaminant callback which is invoked by TCPM
> >> to evaluate for presence of contaminant. Lower level TCPC driver can
> >> restart toggling through TCPM_PORT_CLEAN event when the driver detects
> >> that USB-C port is free of contaminant. check_contaminant callback also passes
> >> the disconnect_while_debounce flag which when true denotes that the CC pins
> >> transitioned to OPEN state during the CC debounce window.
> >
> > I'm a little bit concerned about the size of the state machine. I
> > think this is a special case that at least in the beginning only the
> > Maxim port controller can support, but it's still mixed into the
> > "generic" state machine.
> >
> > How about if we just add "run_state_machine" callback for the port
> > controller drivers so they can handle this kind of special cases on
> > their own - they can then also add custom states?
> >
>
> Same concern here. I would very much prefer an approach as suggested below,
> especially since the changes around the added disconnect_while_debounce flag
> are extensive and difficult to verify.
>
> Thanks,
> Guenter
>
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 904c7b4ce2f0c..91c22945ba258 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -4858,9 +4858,11 @@ static void run_state_machine(struct tcpm_port *port)
> >                  tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ? SRC_READY : SNK_READY, 0);
> >                  break;
> >          default:
> > -               WARN(1, "Unexpected port state %d\n", port->state);
> >                  break;
> >          }
> > +
> > +       if (port->tcpc->run_state_machine)
> > +               port->tcpc->run_state_machine(port->tcpc);
> >   }
> >
> >   static void tcpm_state_machine_work(struct kthread_work *work)
> >
> > thanks,
> >
>
