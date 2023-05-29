Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D971525E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjE2XkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2XkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:40:20 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191FBE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:40:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51b33c72686so2311822a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685403618; x=1687995618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWnaHwPWA/fVIjR4XbDr4c75QOgze1714R6hzX3CW1Q=;
        b=VDMCHpjOT9MCIGpbEJufDNmHq5mMqKe5Qw/U1YvTqSS/S4/k40H8Zg2LJa8+LrzdmD
         d9JksXRdGmTxo33Cw/gSyKu2BFMvJDcOxBsJe34HhNOel1wadfYJztQtr9pv58fK/dqi
         f/jPRDX5ZedEc5gvnEWtoq3dGL2tl2KlM29igzdBK46ewHdjd8sRhZp4/GEMSAZR/d54
         UPAof0Ve8wwhsvghI7jkae3tLsx5N981y+5v9h+yH3c2bvNn4/SZnH+Tnwar4rhy8Nhm
         8FsOG2oLN9vYuKQ2ZEvBBYQhCsolt5s6bJwPamYkrIbsqmWJ52FiLcsqrOr8Gqs4N9Ar
         YN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685403618; x=1687995618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWnaHwPWA/fVIjR4XbDr4c75QOgze1714R6hzX3CW1Q=;
        b=DtFae9Uhtwr/wcCCjFQ7CERbGaz5Momt0T9r0jENk+2tcxZnSDrV0pfPKi5Ffe8zvT
         I7+i25yKtqwTdofJGJp6hjFVfbeInQvxkr2T6bTbdNkmI2OO0Q5uv4sm1drRwrkA2gQ5
         odj7DYNbgGiUxi2fhObJNOwRFjZYopA5kssVTppHGb+AR1pb7VFGIWJ1D/o5tE+WEiOa
         OI2wKLT1qPsDoDOH+6lbAHE6QbA1Bj/KhQhQH6tOwpnYCjrl4D4j85bKt/fbwJpfLZ58
         EoeTZqaBOnp+OrLJhucJUlmKnpcGwBEOdYriidl2cg+iztZPnnGw+hwLcONNAwA9z2se
         Kb7g==
X-Gm-Message-State: AC+VfDzYi50gCb/yWRGt/6CsEioeXahJ/z8zuRTdtkuuuyGEHeJMadzd
        qkdx6g7SRIf1G2x+g6grVtbzLEFV8VJDXzU5GxNmmNVkW1GNSPuTR30=
X-Google-Smtp-Source: ACHHUZ7izGJeZ7ZU5XC6q3WnaXtJdiVRLkjI6/s9NLYWhle7FePXdFQUwPMx9tKme49dKkvOrvJNTYOyMigbSGHw5CU=
X-Received: by 2002:a17:902:d485:b0:1ae:7421:82b5 with SMTP id
 c5-20020a170902d48500b001ae742182b5mr604989plg.45.1685403617399; Mon, 29 May
 2023 16:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230529233700.3706661-1-badhri@google.com> <20230529233700.3706661-3-badhri@google.com>
In-Reply-To: <20230529233700.3706661-3-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 29 May 2023 16:39:40 -0700
Message-ID: <CAPTae5+XJ6s7MMS9jYxkK-JvRLkBHVV=VdTVqunFkQ7uQM0qcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] usb: gadget: udc: core: Offload
 usb_udc_vbus_handler processing
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard v3 as I missed a minor cleanup. Sending v4.

Thanks,
Badhri

On Mon, May 29, 2023 at 4:37=E2=80=AFPM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handler
> processing.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> 640-rc1-000-devel-00005-gcda3c69ebc14 #1 Not tainted
> -------------------------------------------
>
> CPU0
> ----
> lock(&udc->connect_lock);
> lock(&udc->connect_lock);
>
>  DEADLOCK
>
> stack backtrace:
>   CPU: 1 PID: 566 Comm: echo Not tainted 640-rc1-000-devel-00005-gcda3c69=
ebc14 #1
>   Hardware name: Freescale iMX7 Dual (Device Tree)
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x70/0xb0
>   dump_stack_lvl from __lock_acquire+0x924/0x22c4
>   __lock_acquire from lock_acquire+0x100/0x370
>   lock_acquire from __mutex_lock+0xa8/0xfb4
>   __mutex_lock from mutex_lock_nested+0x1c/0x24
>   mutex_lock_nested from usb_udc_vbus_handler+0x1c/0x60
>   usb_udc_vbus_handler from ci_udc_start+0x74/0x9c
>   ci_udc_start from gadget_bind_driver+0x130/0x230
>   gadget_bind_driver from really_probe+0xd8/0x3fc
>   really_probe from __driver_probe_device+0x94/0x1f0
>   __driver_probe_device from driver_probe_device+0x2c/0xc4
>   driver_probe_device from __driver_attach+0x114/0x1cc
>   __driver_attach from bus_for_each_dev+0x7c/0xcc
>   bus_for_each_dev from bus_add_driver+0xd4/0x200
>   bus_add_driver from driver_register+0x7c/0x114
>   driver_register from usb_gadget_register_driver_owner+0x40/0xe0
>   usb_gadget_register_driver_owner from gadget_dev_desc_UDC_store+0xd4/0x=
110
>   gadget_dev_desc_UDC_store from configfs_write_iter+0xac/0x118
>   configfs_write_iter from vfs_write+0x1b4/0x40c
>   vfs_write from ksys_write+0x70/0xf8
>   ksys_write from ret_fast_syscall+0x0/0x1c
>
> Fixes: 0db213ea8eed ("Revert "Revert "usb: gadget: udc: core: Prevent red=
undant calls to pullup""")
> Cc: stable@vger.kernel.org
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Closes: https://lore.kernel.org/all/ZF4bMptC3Lf2Hnee@gerhold.net/
> Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Closes: https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.tor=
adex.com/
> Reported-by: Alistair <alistair@alistair23.me>
> Closes: https://lore.kernel.org/lkml/0cf8c588b701d7cf25ffe1a9217b81716e6a=
5c51.camel@alistair23.me/
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Address Alan Stern's comment on usb_udc_vbus_handler invocation from
>   atomic context:
> * vbus_events_lock is now a spinlock and allocations in
> * usb_udc_vbus_handler are atomic now.
>
> Changes since v2:
> - Addressing Alan Stern's comments:
> ** connect_lock is now held by callers of
> * usb_gadget_pullup_update_locked() and gadget_(un)bind_driver() does
> * notdirectly hold the lock.
>
> ** Both usb_gadget_(dis)connect() and usb_udc_vbus_handler() would
> * set/clear udc->vbus and invoke usb_gadget_pullup_update_locked.
>
> ** Add "unbinding" to prevent new connections after the gadget is being
> * unbound.
> ---
>  drivers/usb/gadget/udc/core.c | 269 ++++++++++++++++------------------
>  1 file changed, 124 insertions(+), 145 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.=
c
> index 4641153e9706..2aa914a0a195 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -38,9 +38,10 @@ static const struct bus_type gadget_bus_type;
>   * for udcs who do not care about vbus status, this value is always true
>   * @started: the UDC's started state. True if the UDC had started.
>   * @connect_lock: protects udc->vbus, udc->started, gadget->connect, gad=
get->deactivate related
> - * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
> - * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadg=
et_udc_stop_locked are
> - * called with this lock held.
> + * functions. usb_gadget_pullup_update_locked called with this lock held=
.
> + * @vbus_events: list head for processing vbus updates on usb_udc_vbus_h=
andler.
> + * @vbus_events_lock: protects vbus_events list
> + * @vbus_work: work item that invokes usb_gadget_pullup_update_locked.
>   *
>   * This represents the internal data structure which is used by the UDC-=
class
>   * to hold information about udc driver and gadget together.
> @@ -53,6 +54,20 @@ struct usb_udc {
>         bool                            vbus;
>         bool                            started;
>         struct mutex                    connect_lock;
> +       struct list_head                vbus_events;
> +       spinlock_t                      vbus_events_lock;
> +       struct work_struct              vbus_work;
> +       bool                            unbinding;
> +};
> +
> +/**
> + * struct vbus_event - used to notify vbus updates posted through usb_ud=
c_vbus_handler.
> + * @vbus_on: true when vbus is on. false other wise.
> + * @node: list node for maintaining a list of pending updates to be proc=
essed.
> + */
> +struct vbus_event {
> +       bool vbus_on;
> +       struct list_head node;
>  };
>
>  static struct class *udc_class;
> @@ -693,40 +708,46 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *g=
adget)
>  EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
>
>  /* Internal version of usb_gadget_connect needs to be called with connec=
t_lock held. */
> -static int usb_gadget_connect_locked(struct usb_gadget *gadget)
> +static int usb_gadget_pullup_update_locked(struct usb_gadget *gadget)
>         __must_hold(&gadget->udc->connect_lock)
>  {
>         int ret =3D 0;
> +       bool connect =3D !gadget->deactivated && gadget->udc->started && =
gadget->udc->vbus &&
> +                      !gadget->udc->unbinding;
>
>         if (!gadget->ops->pullup) {
>                 ret =3D -EOPNOTSUPP;
>                 goto out;
>         }
>
> -       if (gadget->connected)
> -               goto out;
> -
> -       if (gadget->deactivated || !gadget->udc->started) {
> -               /*
> -                * If gadget is deactivated we only save new state.
> -                * Gadget will be connected automatically after activatio=
n.
> -                *
> -                * udc first needs to be started before gadget can be pul=
led up.
> -                */
> -               gadget->connected =3D true;
> -               goto out;
> +       if (connect !=3D gadget->connected) {
> +               ret =3D gadget->ops->pullup(gadget, connect);
> +               if (!ret)
> +                       gadget->connected =3D connect;
> +               mutex_lock(&udc_lock);
> +               if (!connect)
> +                       gadget->udc->driver->disconnect(gadget);
> +               mutex_unlock(&udc_lock);
>         }
>
> -       ret =3D gadget->ops->pullup(gadget, 1);
> -       if (!ret)
> -               gadget->connected =3D 1;
> -
>  out:
>         trace_usb_gadget_connect(gadget, ret);
>
>         return ret;
>  }
>
> +static int usb_gadget_set_vbus(struct usb_gadget *gadget, bool vbus)
> +{
> +       int ret;
> +
> +       mutex_lock(&gadget->udc->connect_lock);
> +       gadget->udc->vbus =3D vbus;
> +       ret =3D usb_gadget_pullup_update_locked(gadget);
> +       mutex_unlock(&gadget->udc->connect_lock);
> +
> +       return ret;
> +}
> +
>  /**
>   * usb_gadget_connect - software-controlled connect to USB host
>   * @gadget:the peripheral being connected
> @@ -739,56 +760,10 @@ static int usb_gadget_connect_locked(struct usb_gad=
get *gadget)
>   */
>  int usb_gadget_connect(struct usb_gadget *gadget)
>  {
> -       int ret;
> -
> -       mutex_lock(&gadget->udc->connect_lock);
> -       ret =3D usb_gadget_connect_locked(gadget);
> -       mutex_unlock(&gadget->udc->connect_lock);
> -
> -       return ret;
> +       return usb_gadget_set_vbus(gadget, true);
>  }
>  EXPORT_SYMBOL_GPL(usb_gadget_connect);
>
> -/* Internal version of usb_gadget_disconnect needs to be called with con=
nect_lock held. */
> -static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
> -       __must_hold(&gadget->udc->connect_lock)
> -{
> -       int ret =3D 0;
> -
> -       if (!gadget->ops->pullup) {
> -               ret =3D -EOPNOTSUPP;
> -               goto out;
> -       }
> -
> -       if (!gadget->connected)
> -               goto out;
> -
> -       if (gadget->deactivated || !gadget->udc->started) {
> -               /*
> -                * If gadget is deactivated we only save new state.
> -                * Gadget will stay disconnected after activation.
> -                *
> -                * udc should have been started before gadget being pulle=
d down.
> -                */
> -               gadget->connected =3D false;
> -               goto out;
> -       }
> -
> -       ret =3D gadget->ops->pullup(gadget, 0);
> -       if (!ret)
> -               gadget->connected =3D 0;
> -
> -       mutex_lock(&udc_lock);
> -       if (gadget->udc->driver)
> -               gadget->udc->driver->disconnect(gadget);
> -       mutex_unlock(&udc_lock);
> -
> -out:
> -       trace_usb_gadget_disconnect(gadget, ret);
> -
> -       return ret;
> -}
> -
>  /**
>   * usb_gadget_disconnect - software-controlled disconnect from USB host
>   * @gadget:the peripheral being disconnected
> @@ -803,16 +778,22 @@ static int usb_gadget_disconnect_locked(struct usb_=
gadget *gadget)
>   * Returns zero on success, else negative errno.
>   */
>  int usb_gadget_disconnect(struct usb_gadget *gadget)
> +{
> +       return usb_gadget_set_vbus(gadget, false);
> +}
> +EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
> +
> +static int usb_gadget_set_deactivate(struct usb_gadget *gadget, bool dea=
ctivate)
>  {
>         int ret;
>
>         mutex_lock(&gadget->udc->connect_lock);
> -       ret =3D usb_gadget_disconnect_locked(gadget);
> +       gadget->deactivated =3D deactivate;
> +       ret =3D usb_gadget_pullup_update_locked(gadget);
>         mutex_unlock(&gadget->udc->connect_lock);
>
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
>
>  /**
>   * usb_gadget_deactivate - deactivate function which is not ready to wor=
k
> @@ -829,26 +810,7 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
>  {
>         int ret =3D 0;
>
> -       if (gadget->deactivated)
> -               goto out;
> -
> -       mutex_lock(&gadget->udc->connect_lock);
> -       if (gadget->connected) {
> -               ret =3D usb_gadget_disconnect_locked(gadget);
> -               if (ret)
> -                       goto unlock;
> -
> -               /*
> -                * If gadget was being connected before deactivation, we =
want
> -                * to reconnect it in usb_gadget_activate().
> -                */
> -               gadget->connected =3D true;
> -       }
> -       gadget->deactivated =3D true;
> -
> -unlock:
> -       mutex_unlock(&gadget->udc->connect_lock);
> -out:
> +       ret =3D usb_gadget_set_deactivate(gadget, true);
>         trace_usb_gadget_deactivate(gadget, ret);
>
>         return ret;
> @@ -868,21 +830,7 @@ int usb_gadget_activate(struct usb_gadget *gadget)
>  {
>         int ret =3D 0;
>
> -       if (!gadget->deactivated)
> -               goto out;
> -
> -       mutex_lock(&gadget->udc->connect_lock);
> -       gadget->deactivated =3D false;
> -
> -       /*
> -        * If gadget has been connected before deactivation, or became co=
nnected
> -        * while it was being deactivated, we call usb_gadget_connect().
> -        */
> -       if (gadget->connected)
> -               ret =3D usb_gadget_connect_locked(gadget);
> -       mutex_unlock(&gadget->udc->connect_lock);
> -
> -out:
> +       ret =3D usb_gadget_set_deactivate(gadget, false);
>         trace_usb_gadget_activate(gadget, ret);
>
>         return ret;
> @@ -1121,13 +1069,28 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
>
>  /* ---------------------------------------------------------------------=
---- */
>
> -/* Acquire connect_lock before calling this function. */
> -static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_h=
old(&udc->connect_lock)
> +static void vbus_event_work(struct work_struct *work)
>  {
> -       if (udc->vbus && udc->started)
> -               usb_gadget_connect_locked(udc->gadget);
> -       else
> -               usb_gadget_disconnect_locked(udc->gadget);
> +       struct vbus_event *event, *n;
> +       struct usb_udc *udc =3D container_of(work, struct usb_udc, vbus_w=
ork);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&udc->vbus_events_lock, flags);
> +       list_for_each_entry_safe(event, n, &udc->vbus_events, node) {
> +               list_del(&event->node);
> +               /* OK to drop the lock here as it suffice to syncrhronize=
 udc->vbus_events node
> +                * retrieval and deletion against usb_udc_vbus_handler. u=
sb_udc_vbus_handler does
> +                * list_add_tail so n would be the same even if the lock =
is dropped.
> +                */
> +               spin_unlock_irqrestore(&udc->vbus_events_lock, flags);
> +               mutex_lock(&udc->connect_lock);
> +               udc->vbus =3D event->vbus_on;
> +               usb_gadget_pullup_update_locked(udc->gadget);
> +               kfree(event);
> +               mutex_unlock(&udc->connect_lock);
> +               spin_lock_irqsave(&udc->vbus_events_lock, flags);
> +       }
> +       spin_unlock_irqrestore(&udc->vbus_events_lock, flags);
>  }
>
>  /**
> @@ -1141,14 +1104,26 @@ static void usb_udc_connect_control_locked(struct=
 usb_udc *udc) __must_hold(&udc
>   */
>  void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
>  {
> -       struct usb_udc *udc =3D gadget->udc;
> +       struct usb_udc *udc;
> +       struct vbus_event *vbus_event;
> +       unsigned long flags;
>
> -       mutex_lock(&udc->connect_lock);
> -       if (udc) {
> -               udc->vbus =3D status;
> -               usb_udc_connect_control_locked(udc);
> +       //mutex_lock(&udc_lock);
> +       if (!gadget || !gadget->udc) {
> +               //mutex_unlock(&udc_lock);
> +               return;
>         }
> -       mutex_unlock(&udc->connect_lock);
> +       udc =3D gadget->udc;
> +
> +       vbus_event =3D kzalloc(sizeof(*vbus_event), GFP_ATOMIC);
> +       if (!vbus_event)
> +               return;
> +
> +       spin_lock_irqsave(&udc->vbus_events_lock, flags);
> +       vbus_event->vbus_on =3D status;
> +       list_add_tail(&vbus_event->node, &udc->vbus_events);
> +       spin_unlock_irqrestore(&udc->vbus_events_lock, flags);
> +       schedule_work(&udc->vbus_work);
>  }
>  EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
>
> @@ -1170,7 +1145,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadget=
,
>  EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
>
>  /**
> - * usb_gadget_udc_start_locked - tells usb device controller to start up
> + * usb_gadget_udc_start - tells usb device controller to start up
>   * @udc: The UDC to be started
>   *
>   * This call is issued by the UDC Class driver when it's about
> @@ -1181,11 +1156,8 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
>   * necessary to have it powered on.
>   *
>   * Returns zero on success, else negative errno.
> - *
> - * Caller should acquire connect_lock before invoking this function.
>   */
> -static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
> -       __must_hold(&udc->connect_lock)
> +static inline int usb_gadget_udc_start(struct usb_udc *udc)
>  {
>         int ret;
>
> @@ -1194,15 +1166,17 @@ static inline int usb_gadget_udc_start_locked(str=
uct usb_udc *udc)
>                 return -EBUSY;
>         }
>
> +       mutex_lock(&udc->connect_lock);
>         ret =3D udc->gadget->ops->udc_start(udc->gadget, udc->driver);
>         if (!ret)
>                 udc->started =3D true;
> +       mutex_unlock(&udc->connect_lock);
>
>         return ret;
>  }
>
>  /**
> - * usb_gadget_udc_stop_locked - tells usb device controller we don't nee=
d it anymore
> + * usb_gadget_udc_stop - tells usb device controller we don't need it an=
ymore
>   * @udc: The UDC to be stopped
>   *
>   * This call is issued by the UDC Class driver after calling
> @@ -1211,19 +1185,18 @@ static inline int usb_gadget_udc_start_locked(str=
uct usb_udc *udc)
>   * The details are implementation specific, but it can go as
>   * far as powering off UDC completely and disable its data
>   * line pullups.
> - *
> - * Caller should acquire connect lock before invoking this function.
>   */
> -static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
> -       __must_hold(&udc->connect_lock)
> +static inline void usb_gadget_udc_stop(struct usb_udc *udc)
>  {
>         if (!udc->started) {
>                 dev_err(&udc->dev, "UDC had already stopped\n");
>                 return;
>         }
>
> +       mutex_lock(&udc->connect_lock);
>         udc->gadget->ops->udc_stop(udc->gadget);
>         udc->started =3D false;
> +       mutex_unlock(&udc->connect_lock);
>  }
>
>  /**
> @@ -1362,6 +1335,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
>         if (!udc)
>                 goto error;
>
> +       udc->unbinding =3D true;
>         device_initialize(&udc->dev);
>         udc->dev.release =3D usb_udc_release;
>         udc->dev.class =3D udc_class;
> @@ -1375,6 +1349,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
>         udc->gadget =3D gadget;
>         gadget->udc =3D udc;
>         mutex_init(&udc->connect_lock);
> +       INIT_LIST_HEAD(&udc->vbus_events);
> +       spin_lock_init(&udc->vbus_events_lock);
> +       INIT_WORK(&udc->vbus_work, vbus_event_work);
>
>         udc->started =3D false;
>
> @@ -1474,6 +1451,17 @@ char *usb_get_gadget_udc_name(void)
>  }
>  EXPORT_SYMBOL_GPL(usb_get_gadget_udc_name);
>
> +static int usb_gadget_set_unbinding(struct usb_udc *udc, bool status)
> +{
> +       int ret;
> +
> +       mutex_lock(&udc->connect_lock);
> +       udc->unbinding =3D status;
> +       ret =3D usb_gadget_pullup_update_locked(udc->gadget);
> +       mutex_unlock(&udc->connect_lock);
> +
> +       return ret;
> +}
>  /**
>   * usb_add_gadget_udc - adds a new gadget to the udc class driver list
>   * @parent: the parent device to this udc. Usually the controller
> @@ -1576,15 +1564,11 @@ static int gadget_bind_driver(struct device *dev)
>         if (ret)
>                 goto err_bind;
>
> -       mutex_lock(&udc->connect_lock);
> -       ret =3D usb_gadget_udc_start_locked(udc);
> -       if (ret) {
> -               mutex_unlock(&udc->connect_lock);
> +       ret =3D usb_gadget_udc_start(udc);
> +       if (ret)
>                 goto err_start;
> -       }
>         usb_gadget_enable_async_callbacks(udc);
> -       usb_udc_connect_control_locked(udc);
> -       mutex_unlock(&udc->connect_lock);
> +       usb_gadget_set_unbinding(udc, false);
>
>         kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>         return 0;
> @@ -1615,14 +1599,13 @@ static void gadget_unbind_driver(struct device *d=
ev)
>
>         kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>
> -       mutex_lock(&udc->connect_lock);
> -       usb_gadget_disconnect_locked(gadget);
> +       usb_gadget_set_unbinding(udc, true);
> +       cancel_work_sync(&udc->vbus_work);
>         usb_gadget_disable_async_callbacks(udc);
>         if (gadget->irq)
>                 synchronize_irq(gadget->irq);
>         udc->driver->unbind(gadget);
> -       usb_gadget_udc_stop_locked(udc);
> -       mutex_unlock(&udc->connect_lock);
> +       usb_gadget_udc_stop(udc);
>
>         mutex_lock(&udc_lock);
>         driver->is_bound =3D false;
> @@ -1708,15 +1691,11 @@ static ssize_t soft_connect_store(struct device *=
dev,
>         }
>
>         if (sysfs_streq(buf, "connect")) {
> -               mutex_lock(&udc->connect_lock);
> -               usb_gadget_udc_start_locked(udc);
> -               usb_gadget_connect_locked(udc->gadget);
> -               mutex_unlock(&udc->connect_lock);
> +               usb_gadget_udc_start(udc);
> +               usb_udc_vbus_handler(udc->gadget, true);
>         } else if (sysfs_streq(buf, "disconnect")) {
> -               mutex_lock(&udc->connect_lock);
> -               usb_gadget_disconnect_locked(udc->gadget);
> -               usb_gadget_udc_stop_locked(udc);
> -               mutex_unlock(&udc->connect_lock);
> +               usb_udc_vbus_handler(udc->gadget, false);
> +               usb_gadget_udc_stop(udc);
>         } else {
>                 dev_err(dev, "unsupported command '%s'\n", buf);
>                 ret =3D -EINVAL;
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
