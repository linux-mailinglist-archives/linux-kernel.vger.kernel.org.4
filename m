Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC926CA7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjC0OmP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjC0OmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:42:09 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6A13588;
        Mon, 27 Mar 2023 07:42:07 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id ew6so37124529edb.7;
        Mon, 27 Mar 2023 07:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679928126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qyUn7aDL5USf6ipYjZT6BGcEOmvQqh6mMOQLhE45Pc=;
        b=xq7KW4IRn+/a/wwNLgTwqPd7M/iKlkQwGHjsOpXyQtZOJwumxQRgMO4GL9nZJpVAn3
         /gV0wX4rwvRUL9ie6YRgyyQYUlNDFT+24Xr6rQlRwMrbanqogagK7FlNBvS/UpdnqFf8
         N8oEXeBmieZ7GrybYyCRLtyMwRiu9R+HPI1f8MZMGSwXvBE8Y7e2Mfg4KPtt5JF6TJ9x
         mONFcpAkDhITg4sEd1cr5MJdmY3Q1peBGFHdUxQLLI3HlwiZe6EJ2jAODa9hBQf/7eeg
         a1lbMshKLCWxokwyVAXd7bGBpIVUFGys8H9khx0xljNsaue0fLI3i/SaZBxvFovZ3N5q
         rJ/A==
X-Gm-Message-State: AAQBX9fINsCN6E9U+Rfx/L7JqGERO3elG4js+V/eWbHZ8V64BgPx116r
        Qnx4llUoXC3AZKmFeLv7QFheuZ2W4QPwJtmqPZrR8KjFERc=
X-Google-Smtp-Source: AKy350aEvB9afQy3KKQhuj1VPBUTsm/ADOwJ93yrIEqjbOLr2IJP7Np8TI21O6znpYNUBZ64f7bdQoO1++ZoFLM6ps8=
X-Received: by 2002:a17:906:9f0b:b0:8b1:38d6:9853 with SMTP id
 fy11-20020a1709069f0b00b008b138d69853mr5349619ejc.2.1679928125940; Mon, 27
 Mar 2023 07:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <5687037.DvuYhMxLoT@kreacher> <11fab8f24f976112aa4d025d03f0f322.squirrel@mail.panix.com>
 <CAJZ5v0gAyGNAT-t=pQ9wEbNAqzixEfm5dKZuRJVv-YQ=1=LbFw@mail.gmail.com> <bd57500b3900e5cce3f1a65de59959bc.squirrel@mail.panix.com>
In-Reply-To: <bd57500b3900e5cce3f1a65de59959bc.squirrel@mail.panix.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 16:41:54 +0200
Message-ID: <CAJZ5v0go3E9tTo-=FY88jd-ca0XVSzuhifje8vrE7rbdtXX+uw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: bus: Rework system-level device notification handling
To:     Pierre Asselin <pa@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?VXdlIEtsZWluZS1Lw4PCtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 3:33 PM Pierre Asselin <pa@panix.com> wrote:
>
> > On Fri, Mar 24, 2023 at 4:54 PM Pierre Asselin <pa@panix.com> wrote:
> >>
> >> Rafael, the patch is good for 6.3-rc1 (boots to early userspace).
> >> I'll try a full install now.
> >
> > I'm wondering if this has succeeded?
>
> Yes.  I've been running 6.3-rc1 + Rafael's patch for a few days now
> and all is well.

Great!

> (Okay, the simple framebuffer has psychedelic color effects but that too
> has a workaround.  One bug at a time.)
>
> Are these emails getting through ?  I see them on patchwork but not
> on linux-acpi or regressions.

Yes, they are.  See
https://lore.kernel.org/linux-acpi/bd57500b3900e5cce3f1a65de59959bc.squirrel@mail.panix.com
for example.

I'll queue up this patch as a fix for 6.3-rc5.

I'll add a Tested-by: tag from you to it, unless you don't want me to
do that, in which case please let me know.

Thanks!
