Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB017672075
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjARPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjARPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:02:48 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F645F71;
        Wed, 18 Jan 2023 07:01:05 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id v6so40895256ejg.6;
        Wed, 18 Jan 2023 07:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp/Qb8JE/S2uY67GV9cLrf5ynIgddgJKDaz9VISPXI4=;
        b=PDgTo38KhpT4sT8dIlz4noEcc0j1vfwCu4YRN5qmh1yjSmytMy5aYt/q+3jcZYI8ZK
         6eNHjnRPkwxzpwkpwFPvmzIw4JI9OPnSydHYGLrPbjqm+u/ERuApdXnhba6jTHaX4KXL
         FlxW9fQjKqwUDZJe1jUQ6NIfwL/xWY4dqUvmPTo11Hljr/gYLRnhGJhj1cmmjy4GgRTQ
         jAXS79JYW2ap5TOWEzxvFJYN9H+X1nTCZz6BdN3JUQYOysAVAP27fhCOvGCDSs9/oOeJ
         a6ZT8+A/qglgTNlpjPYzCzs2B5Su3TRq/4UWYPE2tpHFs+Nu9Fxnp3/6n6aeTh6r1m0b
         NYcA==
X-Gm-Message-State: AFqh2krIxgvdx6LFyGiTZUnnejD4SvOFVwhTRVnsyA/AmYR3zybtZJJK
        HPLzlSfMPd7KL+08t/bUNRn9GWwFnDI9sTVoMSVGX9ZJ
X-Google-Smtp-Source: AMrXdXt8NBqxcCTr2yLkNnvYWOQKVnshNJLbITioXBv/1HPIYfYQleekZegNpLwhF4bZAvTKfDmzvptZ+JVtAg+z0iY=
X-Received: by 2002:a17:906:a20c:b0:7c1:5ff0:6cc2 with SMTP id
 r12-20020a170906a20c00b007c15ff06cc2mr589851ejy.246.1674054064313; Wed, 18
 Jan 2023 07:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20230114085053.72059-1-W_Armin@gmx.de> <20230114085053.72059-3-W_Armin@gmx.de>
 <CAJZ5v0h2vTAUovMoEoWVX2gJQiJS6C9PSYzMqQMtxPusgdHBMQ@mail.gmail.com> <90f1270d-3c37-088b-98ac-a08caba685e8@gmx.de>
In-Reply-To: <90f1270d-3c37-088b-98ac-a08caba685e8@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jan 2023 16:00:53 +0100
Message-ID: <CAJZ5v0hKaet9sB6Xr8J5Ke848nF1T=T8k9H0Uyfm5J0MLNHD-w@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: battery: Fix buffer overread if not NUL-terminated
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:01 PM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 17.01.23 um 15:42 schrieb Rafael J. Wysocki:
>
> > On Sat, Jan 14, 2023 at 9:51 AM Armin Wolf <W_Armin@gmx.de> wrote:
> >> If the buffer containing string data is not NUL-terminated
> >> (which is perfectly legal according to the ACPI specification),
> >> the acpi battery driver might not honor its length.
> > Note that this is about extracting package entries of type ACPI_TYPE_BUFFER.
> >
> > And please spell ACPI in capitals.
> >
> >> Fix this by limiting the amount of data to be copied to
> >> the buffer length while also using strscpy() to make sure
> >> that the resulting string is always NUL-terminated.
> > OK
> >
> >> Also use '\0' instead of a plain 0.
> > Why?  It's a u8, not a char.
> >
> >> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >> ---
> >>   drivers/acpi/battery.c | 23 ++++++++++++++++-------
> >>   1 file changed, 16 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> >> index fb64bd217d82..9f6daa9f2010 100644
> >> --- a/drivers/acpi/battery.c
> >> +++ b/drivers/acpi/battery.c
> >> @@ -438,15 +438,24 @@ static int extract_package(struct acpi_battery *battery,
> >>                  if (offsets[i].mode) {
> >>                          u8 *ptr = (u8 *)battery + offsets[i].offset;
> > I would add
> >
> > u32 len = 32;
> >
> >> -                       if (element->type == ACPI_TYPE_STRING ||
> >> -                           element->type == ACPI_TYPE_BUFFER)
> >> +                       switch (element->type) {
> > And here I would do
> >
> > case ACPI_TYPE_BUFFER:
> >          if (len > element->buffer.length + 1)
> >                  len = element->buffer.length + 1;
> >
> >          fallthrough;
> > case ACPI_TYPE_STRING:
> >          strscpy(ptr, element->buffer.pointer, len);
> >          break;
> > case ACPI_TYPE_INTEGER:
> >
> > and so on.
>
> But wouldn't this cause the ACPI string object to be accessed the wrong way
> (buffer.pointer instead of string.pointer)?

I meant string.pointer, like in the original code, but this doesn't
matter really, because the value of the pointer is the same.
