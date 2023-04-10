Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC16DC4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDJJK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjDJJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:10:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E25B8D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:09:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id px4so1417458pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681117760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSW/vLoGfD75WpzekdO7JWqn1GghjgWEvwLppmMteTI=;
        b=hYpqE1ZnAfLf6ql6mbixsFRaOTytoxhHlG/IsRi5piozB6GCHadHVgkZHi/MWHh1aw
         JVZf+dpnRkRF/M8rbjRjC9v9b6QTnZdSdDtusilobMO7TqA2ns+hrIoiQIDNPBcsjoFt
         PqztvrL9TfYl5YuK0T9qQXfv+q2skU3ahXXRKf0WArDmqayzGFaNzi371nrTOFF2zWgx
         yzAF/ylMrdZnt/pcul37mfXEMrYSd1144oFe7Z7xWshy/jKQBpPiAEMCkmlUcmpCiW54
         Tg9s8U1VYySj0+GadUqKcGLJINTVok1/o4o2OS/oRHUjq61blM8RWMkaCQSNq6l0BoTd
         dDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSW/vLoGfD75WpzekdO7JWqn1GghjgWEvwLppmMteTI=;
        b=QqGob6XlHfEhoopUhMqWfE9bWhYB3yjTm7oEzMrMh087sYa9o84VnnpE5CqXjgQ2tx
         wFOXLnjdeQZYFmPkcw7MUbit2M5JAwqj5BiiEX3ZrE+y+ueWre35Ck7JjxhMlyqGmr70
         JcEq/e88avtFqLaP4c6UwHReUTZ3LNMuQFoie0sTHm//RfEiBTYYc0FEMKw5vSWQhHpJ
         VzO2Df93XD6xU9/d0weopy+/nJA2UNK/z8MWZzMlhaoxcEpRoyCdoLxbVge9YRQ4jvq7
         N419T0UszvgbTHlcx8+BP+buCSWJoHSBpiTJGwDm21y6nEOTOnNaZIjdtuq6mIUcd6wC
         oEdg==
X-Gm-Message-State: AAQBX9csLWH+48ADoAH/fa5lcK/tj7tRbCTNgcFRVFFWeOmuG4ch8H4J
        jXw88H1o1kWpwxzV5YWFXVDa4Xb665Q973Bxa2ssEQ==
X-Google-Smtp-Source: AKy350biADeY+M5/Yg8USOFpSbfHD8ZyNkf/ReCOiCJkyuLjXuc/G86xunOsXPSMpawrgRbsqihHuSWzaGiv7+cbql8=
X-Received: by 2002:a17:903:48b:b0:19a:e3d4:216e with SMTP id
 jj11-20020a170903048b00b0019ae3d4216emr3383113plb.7.1681117760123; Mon, 10
 Apr 2023 02:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230410073134.488762-1-badhri@google.com> <2023041028-irritate-starless-a42f@gregkh>
 <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com>
 <2023041004-antarctic-hardiness-524e@gregkh> <CAPTae5JFC8WUzjrMeiyw7tYfWpsZUQThrrvG_etx7Fb2KP6y6A@mail.gmail.com>
In-Reply-To: <CAPTae5JFC8WUzjrMeiyw7tYfWpsZUQThrrvG_etx7Fb2KP6y6A@mail.gmail.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 10 Apr 2023 02:08:43 -0700
Message-ID: <CAPTae5JfPzmTkzM79Mi8x1qy8PfVMCe_83v9oOU=baRowsrPeA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around
 tcpm logs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 2:00=E2=80=AFAM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> On Mon, Apr 10, 2023 at 1:27=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Mon, Apr 10, 2023 at 01:08:55AM -0700, Badhri Jagan Sridharan wrote:
> > > On Mon, Apr 10, 2023 at 12:45=E2=80=AFAM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > >
> > > > On Mon, Apr 10, 2023 at 07:31:34AM +0000, Badhri Jagan Sridharan wr=
ote:
> > > > > This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allows=
 the
> > > > > logs to be wrapped around. Additionally, when set, does not clear
> > > > > the TCPM logs when dumped.
> > > > >
> > > > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > > > ---
> > > > >  drivers/usb/typec/tcpm/Kconfig | 6 ++++++
> > > > >  drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
> > > > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/t=
cpm/Kconfig
> > > > > index e6b88ca4a4b9..4dd2b594dfc9 100644
> > > > > --- a/drivers/usb/typec/tcpm/Kconfig
> > > > > +++ b/drivers/usb/typec/tcpm/Kconfig
> > > > > @@ -18,6 +18,12 @@ config TYPEC_TCPCI
> > > > >       help
> > > > >         Type-C Port Controller driver for TCPCI-compliant control=
ler.
> > > > >
> > > > > +config TCPM_LOG_WRAPAROUND
> > > > > +     bool "Enable TCPM log wraparound"
> > > > > +     help
> > > > > +       When set, wraps around TCPM logs and does not clear the l=
ogs when dumped. TCPM logs by
> > > > > +       default gets cleared when dumped and does not wraparound =
when full.
> > > >
> > > > Kconfig help text needs to be wrapped at the properly width.
> > >
> > > I assumed that the width is 100 characters, but it looks like it is
> > > 80. Will fix it in the next version.
> > > >
> > > > And you do not provide any hint here as to why this is not the defa=
ult
> > > > option, or why someone would want this.
> > >
> > > "TCPM logs by default gets cleared when dumped and does not wraparoun=
d
> > > when full." was intended
> > > to convey why someone would want to set this. Perhaps it's not effect=
ive.
> > >
> > > Does the below look better:
> > > "TCPM logs by default gets cleared when dumped and does not wraparoun=
d
> > > when full. This can be overridden by setting this config.
> > > When the config is set, TCPM wraps around logs and does not clear the
> > > logs when dumped."
> > >
> > > Also, I could make this default if that's OK with Guenter.
> > >
> > > >
> > > > So, why is this not just the default operation anyway?  Why would y=
ou
> > > > ever want the logs cleared?
> > >
> > > I remember Guenter mentioning that he was finding it useful to not
> > > wrap around the logs to fix problems
> > > during tcpm_register_port (init sequence). IMHO wrapping around the
> > > logs helps to triage interoperability
> > > issues uncovered during testing. So both approaches have their own ad=
vantages.
> >
> > But as this is a build-time option, what would cause someone to choose
> > one over the other, and then when the system is running, they can't
> > change them?
>
> During initial phases of bringup, it makes sense to not wrap around
> the logs, but, once bringup is done its most effective to wraparound
> so that interop issues reported by the end users can be triaged where
> TCPM logs are very effective.
> Also, without wrapping around, the logbuffer logs are completely stale
> after the user goes through a few USB connect and disconnect cycles
> till the system is rebooted.
> If we don't want to pursue the Kconfig option, we should atleast make
> TCPM default to wrapping the logs around when full so we could
> maximise the use of the logbuffer contents.
>

The other option that I could think of is to expose another debugfs node
that can be used to control wrapping around the logs in runtime.

Thanks,
Badhri

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
