Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B8611EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJ2ANI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2ANG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:13:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C2A101E6;
        Fri, 28 Oct 2022 17:12:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bp15so10685696lfb.13;
        Fri, 28 Oct 2022 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=byQ111eujx+eXWvPavx0Kng5Y9HdyCkzb9o7x0jd+5M=;
        b=OL1A0Ff6iaIu5eGmS8ZnJunVAoNFycUftrNojA3wKuX3NIbNPqk/Z7umwm5XjDtrFX
         17p5387re66kqjxj93O+pQQc70XPrEHg/x8J50RZfWZol9ItMXBKFcw/VY1euIvDd8l4
         +OBqMmsaFq9clWGguGeLi3BhWmCiWB/0zpKyAuvGLw6A4VzojMVQWA0z6qY4HWw/BdXG
         4V1TF+DuGckOFCCjC7nwhv1DnOezvxZsep1mZGpjyQHcI4n8m8mz6pVIHWVJoXA5UK6i
         HQXOPTi/vG+CoTPxohaVm+YjOyvj7O9j1/v0KsmzCsKxBleRNqx6WugKMpd6EeP4db6r
         fNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byQ111eujx+eXWvPavx0Kng5Y9HdyCkzb9o7x0jd+5M=;
        b=XJbd0wnnmW3PfLCtgUr5BwKy7mh3ztvnPpsGxu9QSf8BdS8t7FZEFZp+rjOBRLfZys
         rmaM5gXW6c7XoM8DWAr8zIuOzP3JltcCbdZ6JA4D0Hs2RwvIJGQMqS/3NwbizsWs7+vg
         ZYubJCfC2VSfFFUXafNz3M/VSkp9G6SKWOYPClw2VhDfEAz1A9jmk6xU59qn0KFUXRQ1
         fTNbTKJJdLtMGke99AlmYPjXm3XpMIHmFCRH2zf66zT58AJArgTnMvGY1FEFgDwxiys6
         KILHwkIqS1uAYfdex24RddApUDy66BDOUB142XFfiHOLinNtJGmGgUgXkohSXu3ph5B/
         6VFQ==
X-Gm-Message-State: ACrzQf2tqcJk7Mws3vU5MtZqwwq5hgWd7er5DamTeD3wyqfUvdRzPfBE
        FY/rPlF9EoanNv1rqxmaHOh/897+QG43uiyT1ck=
X-Google-Smtp-Source: AMsMyM44Vk/bgOmKUCKb1lenjbSK9+iUWlb64IJT7CG6QU52E8yOwChO6v5SqBQRiyFSV3Ww0TQtPve88NozKHMiq90=
X-Received: by 2002:a05:6512:3f2a:b0:4ae:612b:f47b with SMTP id
 y42-20020a0565123f2a00b004ae612bf47bmr674863lfa.106.1667002375575; Fri, 28
 Oct 2022 17:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org> <20221027150926.587581591@goodmis.org>
In-Reply-To: <20221027150926.587581591@goodmis.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Oct 2022 17:12:44 -0700
Message-ID: <CABBYNZKurkYyv0XAeEnEwzRQ3Fc+-_NJREEv=7YU2+8tGdjXQw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 08/31] timers: Bluetooth: Use del_timer_shutdown()
 before freeing timer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, Oct 27, 2022 at 8:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Before a timer is freed, del_timer_shutdown() must be called.
>
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Btw, we do seem to have similar problems with the likes of
cancel_delayed_work/cancel_delayed_work_sync so wonder if it wouldn't
be the case to introduce something like shutdown_delayed_work before
freeing the struct/object containing it?

> ---
>  drivers/bluetooth/hci_bcsp.c | 2 +-
>  drivers/bluetooth/hci_h5.c   | 2 +-
>  drivers/bluetooth/hci_qca.c  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index cf4a56095817..69caaff37141 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -737,7 +737,7 @@ static int bcsp_close(struct hci_uart *hu)
>  {
>         struct bcsp_struct *bcsp = hu->priv;
>
> -       del_timer_sync(&bcsp->tbcsp);
> +       del_timer_shutdown(&bcsp->tbcsp);
>
>         hu->priv = NULL;
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index c5a0409ef84f..08a36ea9eea9 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -253,7 +253,7 @@ static int h5_close(struct hci_uart *hu)
>  {
>         struct h5 *h5 = hu->priv;
>
> -       del_timer_sync(&h5->timer);
> +       del_timer_shutdown(&h5->timer);
>
>         skb_queue_purge(&h5->unack);
>         skb_queue_purge(&h5->rel);
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 8df11016fd51..1796166ba35d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -697,8 +697,8 @@ static int qca_close(struct hci_uart *hu)
>         skb_queue_purge(&qca->txq);
>         skb_queue_purge(&qca->rx_memdump_q);
>         destroy_workqueue(qca->workqueue);
> -       del_timer_sync(&qca->tx_idle_timer);
> -       del_timer_sync(&qca->wake_retrans_timer);
> +       del_timer_shutdown(&qca->tx_idle_timer);
> +       del_timer_shutdown(&qca->wake_retrans_timer);
>         qca->hu = NULL;
>
>         kfree_skb(qca->rx_skb);
> --
> 2.35.1



-- 
Luiz Augusto von Dentz
