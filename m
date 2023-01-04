Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3265CDEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjADH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjADH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:56:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268A1868D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:56:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bn26so12661178wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 23:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p4bk2kR6vfthPpFenTn22PKehFzpsgiENf7r1MoqglY=;
        b=s5jnMX0uA8FPSLTajRXu62P9RH6GQ6kALDIa3h+e4iFtnWVfIZARIgwiRGD5YYlyeL
         rSlrr7Uz6WTN/unB7/nK7Ng/d9AmawVfxCXzLjCT06EOj08OLgB5y3GaIrgjwuEFIgJw
         7Qk54atfu+ZuT61oCG2SGJYGCUGf4ie7FjOkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4bk2kR6vfthPpFenTn22PKehFzpsgiENf7r1MoqglY=;
        b=mS4Wf30qmeoxaZuF9/xRI72RNKx20L3oyc77AqZE0lWr7PrUdsivrhgqpTaKTUf+K9
         UhZBCOleZhGOFPHVoSW0J9Mh5fxQYiKC2EKgYs5RijGMSbydzOOf86F9ssjtgyxFil8E
         etS6Lhwpsfx8OiU6JfYVEB8nN17UxFJ0ZnQAGdBC5SqkB/Sm133KNlL3wc9WQttM4mw5
         jU3nw2bA/CDGChf9Y2psj57IcYlW6YAvFln5ugXZtw6Qu4MyNmFMN6S+Mu6kzXZT00x9
         VrdymckcNdq1w4i+n3WizXyM/m89bc8P7Ax7xQPg9CjUBJN+5uaSmRglhaQOBfHeACMI
         Z/qA==
X-Gm-Message-State: AFqh2koIrBp39G2bLYIrWle6BCJKKqKKYnmNy620gvHnJW7fw45rLlOL
        /0IG9wFwbB7qSG9U0HETAw8EGyhpgUoJHHwcN7rACCUhwP7eqqEB
X-Google-Smtp-Source: AMrXdXtUwJsl1Fi3dt6BuaSO3cxTNTbm//DvwUr+CVpUft9ZmbTqQ3YgfLXLWe+9rvr3yaLr3gElg7UDQ/U6343H2Gg=
X-Received: by 2002:adf:e3cf:0:b0:29d:7fe4:b70c with SMTP id
 k15-20020adfe3cf000000b0029d7fe4b70cmr155058wrm.704.1672819009785; Tue, 03
 Jan 2023 23:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20221215165728.2062984-1-arnd@kernel.org> <CACRpkda3V2Fv9aOxxcuQ5NKv3sWic9-skQU_z7=0S692h_WhnQ@mail.gmail.com>
 <CAFr9PXmVXqAX73VUzAt_M2yPN93in9Y_LHyYcEA1Dfj_m_4ZHA@mail.gmail.com> <CACRpkdZBs0RTwnEjTu81ih0Pyar-e0mb-9-zo9rS6fB9OAHWog@mail.gmail.com>
In-Reply-To: <CACRpkdZBs0RTwnEjTu81ih0Pyar-e0mb-9-zo9rS6fB9OAHWog@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 4 Jan 2023 16:56:38 +0900
Message-ID: <CAFr9PXm3iCkf0ATnjdYXN28mRPkToJpE-5_sAy6w2XVoqX5NVQ@mail.gmail.com>
Subject: Re: [PATCH] usb: fotg210: fix OTG-only build
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, 4 Jan 2023 at 09:14, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jan 2, 2023 at 7:10 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> > Maybe a little unrelated to this patch but this IP is also used on the
> > MStar/SigmaStar chips
>
> I actually think Arnd Bergmann at one point sent me a device with
> this line of chips in it. I suppose you will be upstreaming this
> support?

We've got some of it upstreamed already.
We actually have most of these chips working now but the progress is
slow because it's a hobby/spare time thing..

> The first patch in this series differentiates between
> FOTG200 and FOTG210, do you mean to say there is
> rather FUSBH200 as well?

Ah this is real confusing. There is an FUSBH200 that I thought was the
FOTG210 without the device (OTG) registers.
I think they all are probably fairly close though.

Here's the series that added the FUSBH200 to the kernel:
https://lore.kernel.org/all/1366969040-28892-1-git-send-email-yhchen@faraday-tech.com/

> > I'm not sure how using the common EHCI driver works with the OTG part
> > but if it's possible to make that work maybe my way is a better
> > solution than trying to maintain this driver?
>
> That's a good point, do you have a pointer to your EHCI
> quirk patch so I can take a look?

I don't have a clean series but here are some links to the patches I
needed to get something that worked with UVC cameras and ethernet
dongles.
There are some bits of platform garbage and working out mixed in. I
can clean it up into a proper series if it's worth doing.

https://github.com/linux-chenxing/linux/commit/cafda0a6588c125d93a513b3a86f26f287c68fa3
https://github.com/linux-chenxing/linux/commit/f628cc1e915b4c7beb37a33e1a255e88cc90e609
https://github.com/linux-chenxing/linux/commit/a03f6312e4cba20ae5058822ae57e94ba989475d
https://github.com/linux-chenxing/linux/commit/f4f10314c23370376f2bcffa653709535775bcd8
https://github.com/linux-chenxing/linux/commit/fc8e4548b89d5c984284f5c085046be37889bc88
https://github.com/linux-chenxing/linux/commit/2a6ef17ad41a7228a13756d50ac1449862857b64

Cheers,

Daniel
