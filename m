Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BCE6874F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjBBFRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBFRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:17:36 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA171658
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 21:17:34 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bk15so2724106ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 21:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVud7XdiUX0mKjIJrqc89ENI7FRKLDkmwIWqY2bzco8=;
        b=l58F0GO2FyMkZeXQvm38EG21sZ5U7UDTGNVRaDds+w6pRCA/vkEKF4d8Jo5cIWyEAn
         cRohcnGbsyag+nW0dnn6J4YwE/hx1BrMH9rQGjunMVxW8UJE5YgOHYwDkYHAd4PMrt40
         dwpSwJqBDI/NNx/Zhgyo5RuYRbKfqukQFgGZY54QYwPit3mPb24F2KFd9tzjp1Mqo0fT
         0cXixDEMX/rOE3Omvl+rZTriMytoePe8rClb7WEONsqeCWB2Rfag55PF3j13JHPb5pOS
         tBT6K3M57hl8clLAc85BtO/7BODnpVJAtlWa1mkiR2reZh+kCiG/1yEjl/ExLirDJ6Ao
         Kn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVud7XdiUX0mKjIJrqc89ENI7FRKLDkmwIWqY2bzco8=;
        b=EhxyyKwB975126Xi5d6I5cPwibxqHOZ1/U6AjGkzNfPeFYb5HsIpmcqJ2dTarg9cOb
         853/cKY5le5Bjn/EQmv+waC3wBs2IFbSNRhzlFcrVhAXY230W7qiYhXlJ+cHoSkooBfP
         1dzGkX5TLwLp9AurDyZv39KaQcVzlSvxY8vewT6Z9tNeAyDOrFKMIMmRuw5wxSTR0sAn
         Y/XBoaGYqQFS8XwihrFRZ5ZiUoq7+6DKxdn9c3n9ycf/aphKsl/BK2Ewm0jljemNkPov
         Bdj32HTqfyDRbSmYTBz4w1YCKgqWGWvdHsYNws5pTNw5FXYm0/CARirpZavOwlRADTq/
         oEQg==
X-Gm-Message-State: AO0yUKUODIg6dS6ZXTC0c+5H1EDIBK/NjYkbH6synjobnGXjYmG43hBZ
        DjzIunIJYMfLGzSmDe+wpRn5UVYVWFNlUfT4mvqYE/lQ
X-Google-Smtp-Source: AK7set9Q+DCC8VdFnx7Ahq+cEBa/GidcwaOGd4QFWUmnaR7brGZqIyAa0s8MoQ35cRyIeTbr5VDyQuEwFGV+rdeOqN8=
X-Received: by 2002:a17:907:1008:b0:887:ca34:5e69 with SMTP id
 ox8-20020a170907100800b00887ca345e69mr1259204ejb.90.1675315053064; Wed, 01
 Feb 2023 21:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20221228034617.58386-1-zh.nvgt@gmail.com> <CAO2zrtZjDj5U4CCwVWQcWfbXJa0hwRjjNRE7jtHshrEb-nEwEg@mail.gmail.com>
In-Reply-To: <CAO2zrtZjDj5U4CCwVWQcWfbXJa0hwRjjNRE7jtHshrEb-nEwEg@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 1 Feb 2023 23:17:21 -0600
Message-ID: <CABb+yY3VtTYiyu0s470+Z0bQAPycec7gj+EF5kt=-zhufdutrQ@mail.gmail.com>
Subject: Re: [PATCH] mailbox: mailbox-test: fix potential use-after-free issues
To:     Hang Zhang <zh.nvgt@gmail.com>
Cc:     linux-kernel@vger.kernel.org
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

On Wed, Feb 1, 2023 at 10:25 PM Hang Zhang <zh.nvgt@gmail.com> wrote:
>
> On Tue, Dec 27, 2022 at 10:46 PM Hang Zhang <zh.nvgt@gmail.com> wrote:
> >
> > mbox_test_message_write() is the .write handler of the message
> > debugfs interface, it operates on global pointers "tdev->signal"
> > and "tdev->message" (e.g., allocation, dereference, free and
> > nullification). However, these operations are not protected by any
> > locks, making use-after-free possible in the concurrent setting.
> > E.g., one invocation of the handler may have freed "tdev->signal"
> > but being preempted before nullifying the pointer, then another
> > invocation of the handler may dereference the now dangling pointer,
> > causing use-after-free. Similarly, "tdev->message", as a shared
> > pointer, may be manipulated by multiple invocations concurrently,
> > resulting in unexpected issues such as use-after-free.
> >
> > Fix these potential issues by protecting the above operations with
> > the spinlock "tdev->lock", which has already been deployed in other
> > handlers of the debugfs interface (e.g., .read). This patch introduces
> > the same lock to the .write handler.
> >
> > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> > ---
> >  drivers/mailbox/mailbox-test.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
> > index 4555d678fadd..b2315261644a 100644
> > --- a/drivers/mailbox/mailbox-test.c
> > +++ b/drivers/mailbox/mailbox-test.c
> > @@ -97,6 +97,7 @@ static ssize_t mbox_test_message_write(struct file *filp,
> >         struct mbox_test_device *tdev = filp->private_data;
> >         void *data;
> >         int ret;
> > +       unsigned long flags;
> >
> >         if (!tdev->tx_channel) {
> >                 dev_err(tdev->dev, "Channel cannot do Tx\n");
> > @@ -110,9 +111,12 @@ static ssize_t mbox_test_message_write(struct file *filp,
> >                 return -EINVAL;
> >         }
> >
> > +       spin_lock_irqsave(&tdev->lock, flags);
> >         tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
>
This is bad.  atomic context should not do things like alloc.
Also, please look up MAINTAINERS and cc authors.

thanks.
