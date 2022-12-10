Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2F64904B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 19:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLJS51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 13:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLJS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:57:26 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2918B13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:57:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p24so8158154plw.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4UKuanvtTc6pBLj1c77ibxcLn9BN426eXwMqHxuibjo=;
        b=ML1M5s5VvtzDIyDfN8hlW/dV9W+VN3zq55D8NbPMCZvLDHYaE9eruPUoVovKhEX67w
         U/7cfOxj4e5mm6JW/wTPFU7bDkV4DgN13BD7HoyPH/wDN8vhveOXxkiDBPDNghrRqIBx
         7FqXmcJPPQaNFs4EEM55OerBTTB1pYhkoJ5fK0VG1j4JOXCb25YXZvWOd77VOmbEHk0N
         LhTWAwEVXVmX+T+4GZUG1dPO3ZOwSsp5vkO4Z2ScwU2jnX0dxCpA8/ulQuyBN1o9vqQ/
         fwl19hgltCr+s2FDEldowkc87qMYsRXnaT/sjKrHOiNSwfhltd3y7Ab/YNcDKalNFq8Y
         i7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UKuanvtTc6pBLj1c77ibxcLn9BN426eXwMqHxuibjo=;
        b=p3dsZCniDjbvTl9spn0S/Ea4Bh0oTVf6cPQbCTbKhxgQwvPw22STNuZSlfeIIf6RWX
         eo9ylaf5l1pvttTCYK7tPsKJJjnDrRLTJeAEmYqSTpmm/dgIEi090NtsS0Jbg4SWNj5N
         nGE4RPv9B/c16QfTn2mqERzLPjsCKQwzt5y7bGkp+1RYDlVHoZC1YV516gJ/gQrmqQsl
         ZtQHAK2Rl/kQc+kqFE1e4FT4HMZnz3FE+AwErRmrOlZMD/mI8fMOheYmgtZDc2Q3Qpii
         veMojcVhagTI5NnQO9wKumIuwclzKQd4Jo3i3vgp8KFiSueCx0DIzDkx+v5ouG8FGcIX
         W3yw==
X-Gm-Message-State: ANoB5pld6dt+NGbD8E+tlggtfoUKWbABdDPFr3YLaT+PV2b6RjQJUy4C
        Odb4krNCQMED1qDVs9+B3X+9BMAhzpeh7o9muypnaA==
X-Google-Smtp-Source: AA0mqf6hO4sWp/7QbotW9HzI2iOoThlF77BPGyuN2XOTa5xcCAo9KsvSFj04C1EqjRoLU/FbZHGs+RCTQ95LfH4qFUI=
X-Received: by 2002:a17:90a:df8f:b0:219:20ed:101e with SMTP id
 p15-20020a17090adf8f00b0021920ed101emr60787165pjv.215.1670698644221; Sat, 10
 Dec 2022 10:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20221210061626.948426-1-badhri@google.com> <0e516c19-31f9-c2a7-97da-7c61e5d1d3f0@roeck-us.net>
In-Reply-To: <0e516c19-31f9-c2a7-97da-7c61e5d1d3f0@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Sat, 10 Dec 2022 10:56:47 -0800
Message-ID: <CAPTae5LVSsfVdyMyGSpDJJmf=VjKqUY2LMTj1qrPu=gTRZWpXw@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] usb: typec: tcpm: Add callbacks to mitigate
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 1:58 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/9/22 22:16, Badhri Jagan Sridharan wrote:
> > On some of the TCPC implementations, when the Type-C port is exposed
> > to contaminants, such as water, TCPC stops toggling while reporting OPEN
> > either by the time TCPM reads CC pin status or during CC debounce
> > window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
> > to restart toggling, the behavior recurs causing redundant CPU wakeups
> > till the USB-C port is free of contaminant.
> >
> > [206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > [206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > [206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> >
> > (or)
> >
> > [ 7853.867577] Start toggling
> > [ 7853.889921] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > [ 7855.698765] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
> > [ 7855.698790] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> > [ 7855.698826] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> > [ 7855.703559] CC1: 0 -> 0, CC2: 5 -> 5 [state SNK_ATTACH_WAIT, polarity 0, connected]
> > [ 7855.856555] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_ATTACH_WAIT, polarity 0, disconnected]
> > [ 7855.856581] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> > [ 7855.856613] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 170 ms [rev3 NONE_AMS]
> > [ 7856.027744] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 170 ms]
> > [ 7856.181949] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > [ 7856.187896] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > [ 7857.645630] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > [ 7857.647291] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
> > [ 7857.647298] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> > [ 7857.647310] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> > [ 7857.808106] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_ATTACH_WAIT, polarity 0, disconnected]
> > [ 7857.808123] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> > [ 7857.808150] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 170 ms [rev3 NONE_AMS]
> > [ 7857.978727] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 170 ms]
> >
> > To mitigate redundant TCPM wakeups, TCPCs which do have the needed hardware
> > can implement the check_contaminant callback which is invoked by TCPM
> > to evaluate for presence of contaminant. Lower level TCPC driver can
> > restart toggling through TCPM_PORT_CLEAN event when the driver detects
> > that USB-C port is free of contaminant. check_contaminant callback also passes
> > the disconnect_while_debounce flag which when true denotes that the CC pins
> > transitioned to OPEN state during the CC debounce window.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > Changes since v7:
> > * None. Skipped versions by mistake.
> > Changes since v6:
> > * folded the debounce logic into tcpm state machine and removed tcpm
> > * state export.
> > * Added a helper to determine whether the port is in toggling state.
> > * Excluded CHECK_CONTAMINANT from tcpm_log.
> > Changes since v5:
> > * Updated commit message. Removed change id.
> > Changes since v4:
> > * None
> > Changes since v3:
> > * None
> > Changes since V2:
> > * Offloaded tcpm from maintaining disconnect_while_debouncing logic
> > * to lower level maxim tcpc driver based on feedback.
> > ---
> >   drivers/usb/typec/tcpm/tcpm.c | 51 ++++++++++++++++++++++++++++++++++-
> >   include/linux/usb/tcpm.h      |  8 ++++++
> >   2 files changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 904c7b4ce2f0..5f514e5e6e2a 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -36,6 +36,7 @@
> >   #define FOREACH_STATE(S)                    \
> >       S(INVALID_STATE),                       \
> >       S(TOGGLING),                    \
> > +     S(CHECK_CONTAMINANT),                   \
> >       S(SRC_UNATTACHED),                      \
> >       S(SRC_ATTACH_WAIT),                     \
> >       S(SRC_ATTACHED),                        \
> > @@ -249,6 +250,7 @@ enum frs_typec_current {
> >   #define TCPM_RESET_EVENT    BIT(2)
> >   #define TCPM_FRS_EVENT              BIT(3)
> >   #define TCPM_SOURCING_VBUS  BIT(4)
> > +#define TCPM_PORT_CLEAN              BIT(5)
> >
> >   #define LOG_BUFFER_ENTRIES  1024
> >   #define LOG_BUFFER_ENTRY_SIZE       128
> > @@ -483,6 +485,13 @@ struct tcpm_port {
> >        * SNK_READY for non-pd link.
> >        */
> >       bool slow_charger_loop;
> > +
> > +     /*
> > +      * When true indicates that the lower level drivers indicate potential presence
> > +      * of contaminant in the connector pins based on the tcpm state machine
> > +      * transitions.
> > +      */
> > +     bool potential_contaminant;
> >   #ifdef CONFIG_DEBUG_FS
> >       struct dentry *dentry;
> >       struct mutex logbuffer_lock;    /* log buffer access lock */
> > @@ -647,7 +656,7 @@ static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
> >       /* Do not log while disconnected and unattached */
> >       if (tcpm_port_is_disconnected(port) &&
> >           (port->state == SRC_UNATTACHED || port->state == SNK_UNATTACHED ||
> > -          port->state == TOGGLING))
> > +          port->state == TOGGLING || port->state == CHECK_CONTAMINANT))
> >               return;
> >
> >       va_start(args, fmt);
> > @@ -3904,15 +3913,28 @@ static void run_state_machine(struct tcpm_port *port)
> >       unsigned int msecs;
> >       enum tcpm_state upcoming_state;
> >
> > +     if (port->tcpc->check_contaminant && port->state != CHECK_CONTAMINANT)
> > +             port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
> > +                                             port->state == SRC_UNATTACHED) ||
> > +                                            (port->enter_state == SNK_ATTACH_WAIT &&
> > +                                             port->state == SNK_UNATTACHED));
> > +
> >       port->enter_state = port->state;
> >       switch (port->state) {
> >       case TOGGLING:
> >               break;
> > +     case CHECK_CONTAMINANT:
> > +             port->tcpc->check_contaminant(port->tcpc);
> > +             break;
> >       /* SRC states */
> >       case SRC_UNATTACHED:
> >               if (!port->non_pd_role_swap)
> >                       tcpm_swap_complete(port, -ENOTCONN);
> >               tcpm_src_detach(port);
> > +             if (port->potential_contaminant) {
> > +                     tcpm_set_state(port, CHECK_CONTAMINANT, 0);
> > +                     break;
> > +             }
> >               if (tcpm_start_toggling(port, tcpm_rp_cc(port))) {
> >                       tcpm_set_state(port, TOGGLING, 0);
> >                       break;
> > @@ -4150,6 +4172,10 @@ static void run_state_machine(struct tcpm_port *port)
> >                       tcpm_swap_complete(port, -ENOTCONN);
> >               tcpm_pps_complete(port, -ENOTCONN);
> >               tcpm_snk_detach(port);
> > +             if (port->potential_contaminant) {
> > +                     tcpm_set_state(port, CHECK_CONTAMINANT, 0);
> > +                     break;
> > +             }
> >               if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
> >                       tcpm_set_state(port, TOGGLING, 0);
> >                       break;
> > @@ -4926,6 +4952,9 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
> >               else if (tcpm_port_is_sink(port))
> >                       tcpm_set_state(port, SNK_ATTACH_WAIT, 0);
> >               break;
> > +     case CHECK_CONTAMINANT:
> > +             /* Wait for Toggling to be resumed */
> > +             break;
> >       case SRC_UNATTACHED:
> >       case ACC_UNATTACHED:
> >               if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
> > @@ -5425,6 +5454,11 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
> >                       port->vbus_source = true;
> >                       _tcpm_pd_vbus_on(port);
> >               }
> > +             if (events & TCPM_PORT_CLEAN) {
> > +                     tcpm_log(port, "port clean");
> > +                     if (port->state == CHECK_CONTAMINANT)
> > +                             tcpm_set_state(port, TOGGLING, 0);
> > +             }
> >
>
> I just realized: This never calls tcpm_start_toggling(), meaning the
> start_toggling() callback will never be called. Worse, if the callback
> doesn't exist the state machine may be stuck. How does the state machine
> ever really start toggling in this situation ?

Good points ! Fixed both the problems in v10.
a) Only if the lower level callback exists, TCPM will transition into
CHECK_CONTAMINANT state.
port->potential_contaminant only set when
port->tcpc->check_contaminant is installed. I have fixed this in the
tcpci.c driver as well in v10.

b) tcpm now invokes tcpm_start_toggling() before transitioning into
TOGGLING from CHECK_CONTAMINANT state

Thanks,
Badhri

>
> Thanks,
> Guenter
>
> >               spin_lock(&port->pd_event_lock);
> >       }
> > @@ -5477,6 +5511,21 @@ void tcpm_sourcing_vbus(struct tcpm_port *port)
> >   }
> >   EXPORT_SYMBOL_GPL(tcpm_sourcing_vbus);
> >
> > +void tcpm_port_clean(struct tcpm_port *port)
> > +{
> > +     spin_lock(&port->pd_event_lock);
> > +     port->pd_events |= TCPM_PORT_CLEAN;
> > +     spin_unlock(&port->pd_event_lock);
> > +     kthread_queue_work(port->wq, &port->event_work);
> > +}
> > +EXPORT_SYMBOL_GPL(tcpm_port_clean);
> > +
> > +bool tcpm_port_is_toggling(struct tcpm_port *port)
> > +{
> > +     return port->port_type == TYPEC_PORT_DRP && port->state == TOGGLING;
> > +}
> > +EXPORT_SYMBOL_GPL(tcpm_port_is_toggling);
> > +
> >   static void tcpm_enable_frs_work(struct kthread_work *work)
> >   {
> >       struct tcpm_port *port = container_of(work, struct tcpm_port, enable_frs);
> > diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> > index bffc8d3e14ad..ab7ca872950b 100644
> > --- a/include/linux/usb/tcpm.h
> > +++ b/include/linux/usb/tcpm.h
> > @@ -114,6 +114,11 @@ enum tcpm_transmit_type {
> >    *              Optional; The USB Communications Capable bit indicates if port
> >    *              partner is capable of communication over the USB data lines
> >    *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
> > + * @check_contaminant:
> > + *           Optional; The callback is called when CC pins report open status
> > + *           at the end of the deboumce period or when the port is still
> > + *           toggling. Chip level drivers are expected to check for contaminant
> > + *           and call tcpm_clean_port when the port is clean.
> >    */
> >   struct tcpc_dev {
> >       struct fwnode_handle *fwnode;
> > @@ -148,6 +153,7 @@ struct tcpc_dev {
> >                                                bool pps_active, u32 requested_vbus_voltage);
> >       bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
> >       void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
> > +     void (*check_contaminant)(struct tcpc_dev *dev);
> >   };
> >
> >   struct tcpm_port;
> > @@ -165,5 +171,7 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
> >                              enum tcpm_transmit_status status);
> >   void tcpm_pd_hard_reset(struct tcpm_port *port);
> >   void tcpm_tcpc_reset(struct tcpm_port *port);
> > +void tcpm_port_clean(struct tcpm_port *port);
> > +bool tcpm_port_is_toggling(struct tcpm_port *port);
> >
> >   #endif /* __LINUX_USB_TCPM_H */
> >
> > base-commit: 1524ceb14dd5ebd6f724d993c5ec1a9a8d445d8e
>
