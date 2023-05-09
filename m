Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D896FC1B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjEII0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjEIIZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:25:50 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343118A67;
        Tue,  9 May 2023 01:25:49 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-528dd896165so3913031a12.2;
        Tue, 09 May 2023 01:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620748; x=1686212748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERXKU7Iam0RWQoLv2yoyLcRLH7baQ0ZdyyRRjxqfMWs=;
        b=Tg6DMIhez8FDhVEzoOaePA5i/wgyJigDk9g8TaVK8WcEX2jX1lXaGoH4IzZDJ21x8y
         U/ho59rNCnfSAtFVnZFlWES8d86/4b2UB7e4Sf5ydNUZDHNyTfkZakBKcnGim1eXKshm
         F7ccjcQGsgx4s5me9Acl44f5eCuI+6KdLvbLvDPV8tNaYUieJziN6GpUrTaOuuyd/YNU
         vvWlk+OvJaQ3gcGsb7fBr/tXF9xFgoUG8CiX51oZlKN6QZqwDwtBDFtbSmAjYXhwDy4w
         I3bkYru91T+bxDnxaRhqRAJql7HyHccCbDCwYbtFeze8X/I76UuwoW+Cj/EQpXOpxEGs
         0dng==
X-Gm-Message-State: AC+VfDw6ygOy5B4h/myy98MjNrZF0e4sEUbABEJ1niuPCrv/R4syq+VM
        ePOh1x3sTj/U7JkNIAo0nGt7wpyR4EgXz0mrn0g=
X-Google-Smtp-Source: ACHHUZ6AbeApD+lWtzuPxiPpr1RbbZxz2HJ1p7sIWMRDiK9gNYpoQk4D4GVSFvqbhjpT4crBlQHwoJ7LpHBdVBB6bFg=
X-Received: by 2002:a17:90a:de91:b0:24b:2f85:13eb with SMTP id
 n17-20020a17090ade9100b0024b2f8513ebmr13457528pjv.30.1683620748590; Tue, 09
 May 2023 01:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230504154414.1864615-1-frank.jungclaus@esd.eu>
 <20230504154414.1864615-3-frank.jungclaus@esd.eu> <CAMZ6RqKgJs-yJaaqREmN1SkUzE1EkGtjBzXiATKx5WL+=J48dQ@mail.gmail.com>
 <ff1374d58d98a42d5f78a2685c748730b26926b9.camel@esd.eu> <CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com>
 <20230509-smirk-viewing-5e13ea0abfeb-mkl@pengutronix.de>
In-Reply-To: <20230509-smirk-viewing-5e13ea0abfeb-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 May 2023 17:25:37 +0900
Message-ID: <CAMZ6RqKPbv+mMY0W4P9YR-HoiRAMg7VZgSrs2emnAOrBQyoWxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] can: esd_usb: Add support for esd CAN-USB/3
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Frank Jungclaus <Frank.Jungclaus@esd.eu>,
        =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 9 May 2023 at 16:12, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 09.05.2023 10:28:13, Vincent MAILHOL wrote:
> > > > And because hdr.len is initially 3, hdr.len becomes 5. Right? Shouldn't it be 8?
> > >
> > > It might be a little confusing, but I think it's fine.
> > > hdr.len is given in units of longwords (4 bytes each)! Therefore we
> > > have 12 bytes (the initial 3 longwords) for struct tx_msg before
> > > tx_msg.data[].
> > > Than (8 + 3)/4=2 gives us 2 additional longwords for the 8 data bytes.
> > > So that 3+2=5 (equal to 20 bytes) should be ok.
>
> I think the term longword is more commonly used in non-Unix operating
> systems :)
>
> > OK. So you want to round up the length to the next sizeof(long) multiple, right?
> >
> > First, sizeof(long) being platform specific, you need to declare a
> > macro to make your intent explicit.
> >
> > /* Size of a long int on esd devices */
> > #define USB_ESD_SIZEOF_LONG 4
> >
> > Please test, but for what I understand, below line is an equivalent
> > and a more readable way to achieve your goal:
> >
> >           msg->hdr.len = DIV_ROUND_UP(cf->len, USB_ESD_SIZEOF_LONG);
>
> use "sizeof(u32)"

Marc is right, forget about USB_ESD_SIZEOF_LONG. sizeof(u32) does the
job better.
