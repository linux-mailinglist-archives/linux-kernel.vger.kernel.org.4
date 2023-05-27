Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D1713200
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjE0CnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjE0CnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:43:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E963D1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:43:17 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53469299319so921148a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685155396; x=1687747396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7t86+KZaIhok7zkq05CYQswh4oNWKMJp210pgQMbDQ=;
        b=rBtjrI34P7Ts9lQzTMArATNf1Q1jKN9beYK5JX9IoK4N+6L2izn24P56ZjXSWXxIih
         YN/u1lfSKxK7y5Kss27GMXgIeGfWnQgkrFfRqRqe4kv3Zq0c3LalNKW7FF19lnW5ijdb
         cD9sNGGNYYDwzwS5ADxrR+YbdIf7pz7hlHgkA9fsv/qCbE5PeDQdHovShqhyth1CY8bt
         hK2hILzoJ0RFbry105r3BexfXXVrSoF/oUtoLqTjd91xTI0USrbuomUUvGXPROFHZe83
         IldrcINhnmabG5lvAKwE4Re0yP+IW1wC+DmgtLMYzW97KrUZ6O7lzMlJLBa8zWiiG0Np
         dr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685155396; x=1687747396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7t86+KZaIhok7zkq05CYQswh4oNWKMJp210pgQMbDQ=;
        b=F7LLwOLRNTen89gDiIbDXKBg//oxN+K1wzw49TxBu3cAIIcPLJpVvfCr2OL459QW/U
         aG44dvcndTK9uvZfX8xTYp7G0M7yp7b2vySByO/hwOYTfKkQ5bNyUGvm08ugUrhpiYHr
         YgJvLekTHyZtilDmVTAyeqIGs7brT2bK1CYVoiePLvODgXlnV8Hlg0GPk+Nvax57oKYU
         VKAhPhaFFJ8DHcvAa78m9j+bA4otWFY5hzB3Rd/MrVLldiYw14s+UMVz1iQjkcDaD2m9
         ukbExuoldzKeOCjq92tOx9I6p+rlpJZAi7+QsLKngUHh+z2MJ/Ji6tHhyAWvkcTmEemK
         5tZw==
X-Gm-Message-State: AC+VfDx4/K7V/u0wYiv16ziqHl7jxoPkuM5oT8ilyXDdE+FjFeKfrl14
        HYWrvPsIVLNtl/uS+esN2+womdq6cs7ywyZ4xzAj8g==
X-Google-Smtp-Source: ACHHUZ6rLES7QC5pmtpL+vkpqiBfoNYMccC4XU0KTyNIW9eB4U0dfLoN6pEvN6FznZivzbkPhitN7+LhM4rJL0XQNEE=
X-Received: by 2002:a17:902:d2ca:b0:1a6:abac:9cc with SMTP id
 n10-20020a170902d2ca00b001a6abac09ccmr5386435plc.66.1685155396173; Fri, 26
 May 2023 19:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230519043041.1593578-1-badhri@google.com> <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
 <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
 <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com>
 <a2305ca6-d343-473d-b220-556a2c2e7833@rowland.harvard.edu>
 <CAPTae5Lke+DE3WzGuBxkMMZ=qbbux=avdDTgrxEc1A5SrCFevg@mail.gmail.com> <547ecbb2-921d-4714-82b7-066202ccf292@rowland.harvard.edu>
In-Reply-To: <547ecbb2-921d-4714-82b7-066202ccf292@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 26 May 2023 19:42:39 -0700
Message-ID: <CAPTae5J=VGeHNio0XAj=trrwqXWgGCiwcSaKsxQ4H_9j2mCVXA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        francesco@dolcini.it, alistair@alistair23.me, stephan@gerhold.net,
        bagasdotme@gmail.com, luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again Alan !

On Mon, May 22, 2023 at 8:55=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Mon, May 22, 2023 at 12:48:39AM -0700, Badhri Jagan Sridharan wrote:
> > Hi Alan,
> >
> > Thanks for taking the time out to share more details !
> > +1 on your comment: " A big problem with the USB gadget
> > framework is that it does not clearly state which routines have to run
> > in process context and which have to run in interrupt/atomic context."
> >
> >
> > I started to work on allow_connect and other suggestions that you had m=
ade.
> > In one of the previous comments you had mentioned that the
> > connect_lock should be a spinlock and not a mutex.
>
> Yeah, I changed my mind about that.
>
> > Right now there are four conditions that seem to be deciding whether
> > pullup needs to be enabled or disabled through gadget->ops->pullup().
> > 1. Gadget not deactivated through usb_gadget_deactivate()
> > 2. Gadget has to be started through usb_gadget_udc_start().
> > soft_connect_store() can start/stop gadget.
> > 3. usb_gadget has been connected through usb_gadget_connect(). This is
> > assuming we are getting rid of usb_udc_vbus_handler.
> > 4. allow_connect is true
> >
> > I have so far identified two constraints here:
> > a. gadget->ops->pullup() can sleep in some implementations.
> > For instance:
> > BUG: scheduling while atomic: init/1/0x00000002
> > ..
> > [   26.990631][    T1] Call trace:
> > [   26.993759][    T1]  dump_backtrace+0x104/0x128
> > [   26.998281][    T1]  show_stack+0x20/0x30
> > [   27.002279][    T1]  dump_stack_lvl+0x6c/0x9c
> > [   27.006627][    T1]  __schedule_bug+0x84/0xb4
> > [   27.010973][    T1]  __schedule+0x6f0/0xaec
> > [   27.015147][    T1]  schedule+0xc8/0x134
> > [   27.019059][    T1]  schedule_timeout+0x98/0x134
> > [   27.023666][    T1]  msleep+0x34/0x4c
> > [   27.027317][    T1]  dwc3_core_soft_reset+0xf0/0x354
> > [   27.032273][    T1]  dwc3_gadget_pullup+0xec/0x1d8
> > [   27.037055][    T1]  usb_gadget_pullup_update_locked+0xa0/0x1e0
> > [   27.042967][    T1]  udc_bind_to_driver+0x1e4/0x30c
> > [   27.047835][    T1]  usb_gadget_probe_driver+0xd0/0x178
> > [   27.053051][    T1]  gadget_dev_desc_UDC_store+0xf0/0x13c
> > [   27.058442][    T1]  configfs_write_iter+0x100/0x178
> > [   27.063399][    T1]  vfs_write+0x278/0x3c4
> > [   27.067483][    T1]  ksys_write+0x80/0xf4
>
> What kernel was this trace made with?  I don't see udc_bind_to_driver
> appearing anywhere in 6.4-rc3.


Sorry, I was switching between devices running different kernel
versions, with the latest one running 6.1, and posted trace from an
older one by mistake.
>
>
> > b. gadget->ops->udc_start can also sleep in some implementations.
> > For example:
> > [   28.024255][    T1] BUG: scheduling while atomic: init/1/0x00000002
> > ....
> > [   28.324996][    T1] Call trace:
> > [   28.328126][    T1]  dump_backtrace+0x104/0x128
> > [   28.332647][    T1]  show_stack+0x20/0x30
> > [   28.336645][    T1]  dump_stack_lvl+0x6c/0x9c
> > [   28.340993][    T1]  __schedule_bug+0x84/0xb4
> > [   28.345340][    T1]  __schedule+0x6f0/0xaec
> > [   28.349513][    T1]  schedule+0xc8/0x134
> > [   28.353425][    T1]  schedule_timeout+0x4c/0x134
> > [   28.358033][    T1]  wait_for_common+0xac/0x13c
> > [   28.362554][    T1]  wait_for_completion_killable+0x20/0x3c
> > [   28.368118][    T1]  __kthread_create_on_node+0xe4/0x1ec
> > [   28.373422][    T1]  kthread_create_on_node+0x54/0x80
> > [   28.378464][    T1]  setup_irq_thread+0x50/0x108
> > [   28.383072][    T1]  __setup_irq+0x90/0x87c
> > [   28.387245][    T1]  request_threaded_irq+0x144/0x180
> > [   28.392287][    T1]  dwc3_gadget_start+0x50/0xac
> > [   28.396866][    T1]  udc_bind_to_driver+0x14c/0x31c
> > [   28.401763][    T1]  usb_gadget_probe_driver+0xd0/0x178
> > [   28.406980][    T1]  gadget_dev_desc_UDC_store+0xf0/0x13c
> > [   28.412370][    T1]  configfs_write_iter+0x100/0x178
> > [   28.417325][    T1]  vfs_write+0x278/0x3c4
> > [   28.421411][    T1]  ksys_write+0x80/0xf4
> >
> > static int dwc3_gadget_start(struct usb_gadget *g,
> >                 struct usb_gadget_driver *driver)
> > {
> >         struct dwc3             *dwc =3D gadget_to_dwc(g);
> > ...
> >         irq =3D dwc->irq_gadget;
> >         ret =3D request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_i=
nterrupt,
> >                         IRQF_SHARED, "dwc3", dwc->ev_buf);
> >
> > Given that "1016fc0c096c USB: gadget: Fix obscure lockdep violation
> > for udc_mutex" has been there for a while and no one has reported
> > issues so far, perhaps ->disconnect() callback is no longer being
> > invoked in atomic context and the documentation is what that needs to
> > be updated ?
>
> That's part of what I'm trying to figure out.  However, some UDC drivers
> call ->disconnect() directly when they detect loss of VBUS power,
> instead of going through the core.  So disconnect handlers will have
> remain capable of running in interrupt context until those UDC drivers
> are changed.
>
> Getting back to your first point, it looks like we need to assume any
> routine that needs to communicate with the UDC hardware (such as the
> ->pullup callback used in usb_gadget_{dis}connect()) must always be
> called in process context.  This means that usb_udc_connect_control()
> always has to run in process context, since it will do either a connect
> or a disconnect.
>
> On the other hand, some routines -- in particular,
> usb_udc_vbus_handler() -- may be called by a UDC driver's interrupt
> handler and therefore may run in interrupt context.  (This fact should
> be noted in that routine's kerneldoc, by the way.)
>
> So here's the problem: usb_udc_vbus_handler() running in interrupt
> context calls usb_udc_connect_control(), which has to run in process
> context.  And this is not just a simple issue caused by the
> ->disconnect() callback or use of mutexes; it's more fundamental.
>
> I'm led to conclude that you were right to offload part of
> usb_udc_vbus_handler()'s job to a workqueue.  It's an awkward thing to
> do, because you have to make sure to cancel the work item at times when
> it's no longer needed.  But there doesn't seem to be any other choice.
>
> Here's two related problems for you to think about:
>
>     1.  Once gadget_unbind_driver() has called usb_gadget_disconnect(),
>         we don't want a VBUS change to cause usb_udc_vbus_handler()'s
>         work routine to turn the pullup back on.  How can we prevent
>         this?
>
>     2.  More generally, suppose usb_udc_vbus_handler() gets called at
>         exactly the same time that some other pathway (either
>         gadget_bind_driver() or soft_connect_store()) tries to do a
>         connect or disconnect.  What should happen then?


I believe I can solve the above races by protecting the flags set by
each of them with connect_lock and not pulling up unless all of them
are true.
The caller will hold connect_lock, update the respective flag and
invoke the below usb_gadget_pullup_update_locked function(shown
below).

Code stub:
/* Internal version of usb_gadget_connect needs to be called with
connect_lock held. */
static int usb_gadget_pullup_update_locked(struct usb_gadget *gadget)
        __must_hold(&gadget->udc->connect_lock)
{
        int ret =3D 0;
        bool connect =3D !gadget->deactivated && gadget->udc->started &&
gadget->udc->vbus &&
                             gadget->udc->allow_connect;

        if (!gadget->ops->pullup) {
                ret =3D -EOPNOTSUPP;
                goto out;
        }

        if (connect !=3D gadget->connected) {
                ret =3D gadget->ops->pullup(gadget, connect);
                if (!ret)
                        gadget->connected =3D connect;
                if (!connect) {
                        mutex_lock(&udc_lock);
                        if (gadget->udc->driver)
                                gadget->udc->driver->disconnect(gadget);
                        mutex_unlock(&udc_lock);
        }

out:
        trace_usb_gadget_connect(gadget, ret);

        return ret;
}

However, while auditing the code again, I noticed another potential
race as well:
Looks like usb_del_gadget() can potentially race against
usb_udc_vbus_handler() and call device_unregister.
This implies usb_udc can be freed while usb_udc_vbus_handler() or the
work item is executing.

void usb_del_gadget(struct usb_gadget *gadget)
{
        struct usb_udc *udc =3D gadget->udc;

..
...
        device_unregister(&udc->dev);
}
EXPORT_SYMBOL_GPL(usb_del_gadget);

Does this look like a valid concern to you or am I misunderstanding this ?
If so, I am afraid that the only way to solve this is by synchronizing
usb_udc_vbus_handler() against usb_del_gadget() through a mutex as
device_unregister() can sleep.
So offloading usb_udc_vbus_handler() cannot work either.

usb_udc_vbus_hander() seems to be invoked from the following drivers:

1. drivers/usb/chipidea/udc.c:
usb_udc_vbus_hander()  is called from a non-atomic context.

2. drivers/usb/gadget/udc/max3420_udc.c
usb_udc_vbus_hander()  is called from the interrupt handler.
However, all the events are processed from max3420_thread kthread.
So I am thinking of making them threaded irq handlers instead.

3. drivers/usb/gadget/udc/renesas_usbf.c
This one looks more invasive. However, still attempting to move them
to threaded irq handlers.

As always, I'm looking forward to your feedback !

Thanks,
Badhri

>
> Alan Stern
