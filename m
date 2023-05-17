Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0AF706791
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjEQMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjEQMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:07:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98E5BAA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:04:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5304d0d1eddso341252a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684325096; x=1686917096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+LzPosmBO0/0G26DyRhqrYRo8ZugUnTZ6niByyzzL0=;
        b=SGU2Ta9EWk8MktvH66sfWQhpYLv3u2quJkl5m1VPwSMPAwZmURfyJm4lAxN0AygaJO
         Sh2GKFK8grX4ltUU2X+87Dpl1WRLyIWTf2YC35TNPFQ8tiMQRVgPOmETZNfj/C+GidU4
         agQMqOdIeqfICdJ4j6oidizaXin9wUCaWRzeYis8sabANJLNtvtIMnnuHAB8chClDQtk
         d5rg7Ptm1p/t1UK0YXCpiWTcsuYGdLBNb5iqh8ZpZI/NjEjMJDn2tC/zozMVeo2+LR8+
         0EqylPJS2/CcGj9xJrsVpX4vCeqsXi2JqPd8y4pefY1E9PThRBjuyl6xjTFccHqE9u1x
         aCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684325096; x=1686917096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+LzPosmBO0/0G26DyRhqrYRo8ZugUnTZ6niByyzzL0=;
        b=epKFT8P2OG16xenfd8+2eSk6RHORrUPtXeXPV9nv35JS7vRm4Nfy1ZPjVFU5J9HUtQ
         WWhF29toY/HhYxuCp+s5M4rXxc0XLK1uIgtrQ8CV59IrOUb7TQUchog0UJxFDO4f50/7
         m3kyRtmfZsUYfQWTsgezpYo2qgHxH6Lu3niHlJLEG8eXL+7ZY8DREztzaaezZcSvZvPx
         U3MF82XlwWi3fG/jDE8abqqZWrjho0c1xlhlO8UgeXYF6Mgs74qAeffFTof0+JHZQx2x
         Cery6okc4tiVjRlkyWfOERw3pmGGOxyz6lRhYnIPx5w48ynnrLRFtuAXrVv90mwCRueB
         HUnQ==
X-Gm-Message-State: AC+VfDxqOB5UnYU9gBXW2kRqBiUMgr+dMAcN17MWveoEspPn2JHY3TWT
        DYLTGsjRYIC4w+nPQeC1ZRxBq0ABmgA0PhE0/mf3fQ==
X-Google-Smtp-Source: ACHHUZ6m5uYqeu3FV452t2l/kzLQlU1CR0oyBGk8+ALoiU/ie5AyCvXPOSfnRmfcNMucnogFzSQw7U6IDxPyOfawp+w=
X-Received: by 2002:a17:90a:d24f:b0:24e:4a1a:39a4 with SMTP id
 o15-20020a17090ad24f00b0024e4a1a39a4mr41986211pjw.17.1684325095709; Wed, 17
 May 2023 05:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230517115955.1078339-1-badhri@google.com>
In-Reply-To: <20230517115955.1078339-1-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 17 May 2023 05:04:19 -0700
Message-ID: <CAPTae5+UapO9kJngkwMGxVwzgR1cxk3=RKa5se9mK4g=g2cQOg@mail.gmail.com>
Subject: Re: [PATCH v1] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco, Alistair, Stephan, Bagas, Lucas,

Thanks for sharing the stack traces !
Requesting your help on validating the patch as I dont have the same
hardware with me which reproduces the issue.
Let me know if you are still seeing the crash.

Thanks,
Badhri

On Wed, May 17, 2023 at 5:00=E2=80=AFAM Badhri Jagan Sridharan
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
> Fixes: 0db213ea8eed ("usb: gadget: udc: core: Invoke usb_gadget_connect o=
nly when started")
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
>  drivers/usb/gadget/udc/core.c | 55 +++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.=
c
> index 69041cca5d24..bbcfab50f657 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -41,6 +41,9 @@ static const struct bus_type gadget_bus_type;
>   * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
>   * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadg=
et_udc_stop_locked are
>   * called with this lock held.
> + * @vbus_events: list head for processing vbus updates on usb_udc_vbus_h=
andler.
> + * @vbus_events_lock: protects vbus_events list
> + * @vbus_work: work item that invokes usb_udc_connect_control_locked.
>   *
>   * This represents the internal data structure which is used by the UDC-=
class
>   * to hold information about udc driver and gadget together.
> @@ -53,6 +56,19 @@ struct usb_udc {
>         bool                            vbus;
>         bool                            started;
>         struct mutex                    connect_lock;
> +       struct list_head                vbus_events;
> +       struct mutex                    vbus_events_lock;
> +       struct work_struct              vbus_work;
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
> @@ -1134,6 +1150,23 @@ static int usb_udc_connect_control_locked(struct u=
sb_udc *udc) __must_hold(&udc-
>         return ret;
>  }
>
> +static void vbus_event_work(struct work_struct *work)
> +{
> +       struct vbus_event *event, *n;
> +       struct usb_udc *udc =3D container_of(work, struct usb_udc, vbus_w=
ork);
> +
> +       mutex_lock(&udc->vbus_events_lock);
> +       list_for_each_entry_safe(event, n, &udc->vbus_events, node) {
> +               mutex_lock(&udc->connect_lock);
> +               udc->vbus =3D event->vbus_on;
> +               usb_udc_connect_control_locked(udc);
> +               list_del(&event->node);
> +               kfree(event);
> +               mutex_unlock(&udc->connect_lock);
> +       }
> +       mutex_unlock(&udc->vbus_events_lock);
> +}
> +
>  /**
>   * usb_udc_vbus_handler - updates the udc core vbus status, and try to
>   * connect or disconnect gadget
> @@ -1146,13 +1179,20 @@ static int usb_udc_connect_control_locked(struct =
usb_udc *udc) __must_hold(&udc-
>  void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
>  {
>         struct usb_udc *udc =3D gadget->udc;
> +       struct vbus_event *vbus_event;
>
> -       mutex_lock(&udc->connect_lock);
> -       if (udc) {
> -               udc->vbus =3D status;
> -               usb_udc_connect_control_locked(udc);
> -       }
> -       mutex_unlock(&udc->connect_lock);
> +       if (!udc)
> +               return;
> +
> +       vbus_event =3D kzalloc(sizeof(*vbus_event), GFP_KERNEL);
> +       if (!vbus_event)
> +               return;
> +
> +       mutex_lock(&udc->vbus_events_lock);
> +       vbus_event->vbus_on =3D status;
> +       list_add_tail(&vbus_event->node, &udc->vbus_events);
> +       mutex_unlock(&udc->vbus_events_lock);
> +       schedule_work(&udc->vbus_work);
>  }
>  EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
>
> @@ -1379,6 +1419,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
>         udc->gadget =3D gadget;
>         gadget->udc =3D udc;
>         mutex_init(&udc->connect_lock);
> +       INIT_LIST_HEAD(&udc->vbus_events);
> +       mutex_init(&udc->vbus_events_lock);
> +       INIT_WORK(&udc->vbus_work, vbus_event_work);
>
>         udc->started =3D false;
>
>
> base-commit: 6bae03b0484b54f699d69339fbec5658e885c224
> --
> 2.40.1.606.ga4b1b128d6-goog
>
