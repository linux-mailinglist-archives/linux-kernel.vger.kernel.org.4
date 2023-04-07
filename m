Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83F86DA7E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 05:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbjDGDKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 23:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjDGDKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 23:10:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15516A6B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 20:10:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n14so23220277plc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 20:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680837041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok6PZ07lUeDE4ZLf3XMSAQ3r1Qo4OzJ2tCJNS6+X510=;
        b=FCYB97d1cfV3x69FnLu9i8NigTJLFdhnGHsbL3TKTgydjebVZ5qQuATKZyMJaOprEf
         VFGHIr8dV7eQclNqiTo3pp21q6wQp0C3yk4iTN85ec+1ijvDkiSsn0+5fZgMLrd6c3+z
         az3d4xK4B6G4sbCJjAp1YbZXYgqJFXHHeNfZetLsIPZEQ9xZW5/4wRdG72v3suyhz3o8
         FUcn0LlnZxJUjz9KXFVI/Hs6DHAuLU7o6uAGqkFXdjZ6Jxoze1Rg4SKwiEQK4pazU4WE
         Oq+gpfwZbSBU6b0OFOirR9cVWf2TUp+kZLbGfwe0GcXWI76Jptq3Uj6lGWvyt6qcWL8a
         FOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680837041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok6PZ07lUeDE4ZLf3XMSAQ3r1Qo4OzJ2tCJNS6+X510=;
        b=Fs5gKATxz6r9q0HR4UhHx/T1geowrFb2g3vrDZyNNyiHlZfOEqpPZgdzYCLcIgMlZS
         SkYFGz5YWNXhFaJqSkLRH44kMsacBiknCM4wYgP4GDYJbMAw5CQr1kzMq9DeY2UN9CA7
         AKVuWdpbeCSDRRZkSJvBpJEdrHpcJa/BWJZFqLpFrDdIjnDqDpOvSkaTdKxAMACfDlzL
         Kt63s2vqvp5TcYKTCxCpV90/5Bqs8tfeMQHszSpXz6SqexhbHyQBNoFtBKd5IWp4JIKJ
         dvHuJ+38W+HC74DMDMjmu0z4GT+jjoE3EE4gU5O7HIuEOFsm/YdoGPE1by2lNk6GHy30
         FJaA==
X-Gm-Message-State: AAQBX9dYGhBYqSf6UpCEtPRrhldKuA1MtYmbDg6GkIuDkfruAfhinn2+
        0lTSRxHkFtn1c67n4NgtYNA2gcmgm+p7LjKIbsbb6A==
X-Google-Smtp-Source: AKy350bcoUNpaA/bpl6jgqmhvY9HQLYykmSrD9t8qkOSngbFtDC6dQuDHtzmsp3EjBJNS2Ff3GWNBGRcx1TNiw0FJVk=
X-Received: by 2002:a17:902:b688:b0:1a1:8f72:e9b with SMTP id
 c8-20020a170902b68800b001a18f720e9bmr424790pls.7.1680837041146; Thu, 06 Apr
 2023 20:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230406062549.2461917-1-badhri@google.com> <2023040639-lair-risotto-4693@gregkh>
In-Reply-To: <2023040639-lair-risotto-4693@gregkh>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 6 Apr 2023 20:10:04 -0700
Message-ID: <CAPTae5LEswD6A34YK3Zkj3AaG0DK-92tCmg40mBZx6EmkWOJMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: gadget: udc: core: Invoke usb_gadget_connect
 only when started
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Wed, Apr 5, 2023 at 11:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Apr 06, 2023 at 06:25:48AM +0000, Badhri Jagan Sridharan wrote:
> > usb_udc_connect_control does not check to see if the udc has already
> > been started. This causes gadget->ops->pullup to be called through
> > usb_gadget_connect when invoked from usb_udc_vbus_handler even before
> > usb_gadget_udc_start is called. Guard this by checking for udc->started
> > in usb_udc_connect_control before invoking usb_gadget_connect.
> >
> > Guarding udc->vbus, udc->started, gadget->connect, gadget->deactivate
> > related functions with connect_lock. usb_gadget_connect_locked,
> > usb_gadget_disconnect_locked, usb_udc_connect_control_locked,
> > usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are called with
> > this lock held as they can be simulataneously invoked from different co=
de
> > paths.
> >
> > Adding an additional check to make sure udc is started(udc->started)
> > before pullup callback is invoked.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > * Fixed commit message comments.
> > * Renamed udc_connect_control_lock to connect_lock and made it per
> > device.
> > * udc->vbus, udc->started, gadget->connect, gadget->deactivate are all
> > now guarded by connect_lock.
> > * Code now checks for udc->started to be set before invoking pullup
> > callback.
> > ---
> >  drivers/usb/gadget/udc/core.c | 140 +++++++++++++++++++++++-----------
> >  1 file changed, 96 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/cor=
e.c
> > index 3dcbba739db6..41d3a1998cff 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -37,6 +37,10 @@ static struct bus_type gadget_bus_type;
> >   * @vbus: for udcs who care about vbus status, this value is real vbus=
 status;
> >   * for udcs who do not care about vbus status, this value is always tr=
ue
> >   * @started: the UDC's started state. True if the UDC had started.
> > + * @connect_lock: protects udc->vbus, udc->started, gadget->connect, g=
adget->deactivate related
> > + * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
> > + * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_ga=
dget_udc_stop_locked are
> > + * called with this lock held.
> >   *
> >   * This represents the internal data structure which is used by the UD=
C-class
> >   * to hold information about udc driver and gadget together.
> > @@ -48,6 +52,7 @@ struct usb_udc {
> >       struct list_head                list;
> >       bool                            vbus;
> >       bool                            started;
> > +     struct mutex                    connect_lock;
> >  };
> >
> >  static struct class *udc_class;
> > @@ -687,17 +692,8 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *=
gadget)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
> >
> > -/**
> > - * usb_gadget_connect - software-controlled connect to USB host
> > - * @gadget:the peripheral being connected
> > - *
> > - * Enables the D+ (or potentially D-) pullup.  The host will start
> > - * enumerating this gadget when the pullup is active and a VBUS sessio=
n
> > - * is active (the link is powered).
> > - *
> > - * Returns zero on success, else negative errno.
> > - */
> > -int usb_gadget_connect(struct usb_gadget *gadget)
> > +/* Internal version of usb_gadget_connect needs to be called with udc_=
connect_control_lock held. */
>
> Shouldn't you just use the __must_hold() marking here to document this
> so that the tools can properly check and validate it as well?

Sure  ! Have fixed it in v3.
I also made these functions static in v4.

Thanks,
Badhri

>
> thanks,
>
> greg k-h
