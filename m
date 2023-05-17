Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94C706584
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjEQKmN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 06:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEQKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:42:09 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459D420B;
        Wed, 17 May 2023 03:41:52 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-94a342f4c8eso13719866b.0;
        Wed, 17 May 2023 03:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320111; x=1686912111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnrYckLOMdeQP/cDiOa38SdJDj0LdQRatYnbgv9Ep9A=;
        b=hSlDZfxrVyV8JDvFe1ZdZm2NT2WU+K2lvAFWXVBuxvrPzV/94cPu79Ab8Q6PYoqOta
         OhYpQqqztzz080gQhCkfQtEJ+yn6jDU/17B9BLMe5IeyVVke8ViJok8MsaOOkNYg+y2S
         ip8btiob7Lq1xRA5GmQDR5agjaTCwNSugY6p5CW9zAL3OGlWrjjAMj6iunR5rWkpBPse
         Rrl/Z+vxJKPKLuAm6F0xmnmIsmeeCjBl8GRQWLybuY4VOybNMG4y+cEXSIWToEfvvfkI
         f1heZtOUwgLBSEFj9T/SMGhVyM8R1tLi2Ei+rDdB5kWw6eWpXxt+UsPFBK/GoBx0ZG2i
         BrbA==
X-Gm-Message-State: AC+VfDxK633w+VW1ruENsy1YvXCVkKtCNzIxt6PCGaZ8T2xFjqUMgOLc
        kLdd2X0Z06SS959uR78PAmwswaezR3QZj6gkYXo=
X-Google-Smtp-Source: ACHHUZ737VKfyM+JUSu6Rg5k5YwzOHwe6va5akiHl2b//bC8+5GIrD3s8T3PhzLz0sXmr0MWCsqp3+06juZ3/Vbh1uo=
X-Received: by 2002:a17:906:51c4:b0:965:c518:4681 with SMTP id
 v4-20020a17090651c400b00965c5184681mr1637401ejk.7.1684320110524; Wed, 17 May
 2023 03:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <2023051610-stove-condense-9a77@gregkh>
In-Reply-To: <2023051610-stove-condense-9a77@gregkh>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 May 2023 12:41:38 +0200
Message-ID: <CAJZ5v0h-jjoS7evdVS5HkO0A0v5mFwPnEQgoA4X+pmoeopRc=w@mail.gmail.com>
Subject: Re: [PATCH] driver core: class: properly reference count class_dev_iter()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 9:20 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When class_dev_iter is initialized, the reference count for the subsys
> private structure is incremented, but never decremented, causing a
> memory leak over time.  To resolve this, save off a pointer to the
> internal structure into the class_dev_iter structure and then when the
> iterator is finished, drop the reference count.
>
> Reported-and-tested-by: syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/class.c         | 2 ++
>  include/linux/device/class.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index ac1808d1a2e8..05d9df90f621 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -320,6 +320,7 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
>                 start_knode = &start->p->knode_class;
>         klist_iter_init_node(&sp->klist_devices, &iter->ki, start_knode);
>         iter->type = type;
> +       iter->sp = sp;
>  }
>  EXPORT_SYMBOL_GPL(class_dev_iter_init);
>
> @@ -361,6 +362,7 @@ EXPORT_SYMBOL_GPL(class_dev_iter_next);
>  void class_dev_iter_exit(struct class_dev_iter *iter)
>  {
>         klist_iter_exit(&iter->ki);
> +       subsys_put(iter->sp);
>  }
>  EXPORT_SYMBOL_GPL(class_dev_iter_exit);
>
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index 9deeaeb457bb..abf3d3bfb6fe 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -74,6 +74,7 @@ struct class {
>  struct class_dev_iter {
>         struct klist_iter               ki;
>         const struct device_type        *type;
> +       struct subsys_private           *sp;
>  };
>
>  int __must_check class_register(const struct class *class);
> --
> 2.40.1
>
