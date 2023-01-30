Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC210680D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjA3M3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjA3M3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:29:21 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7872685F;
        Mon, 30 Jan 2023 04:29:20 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id m8so1545843edd.10;
        Mon, 30 Jan 2023 04:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCbcC/SCqrKNfyxz02Ndo4K5PjoPuepHRt3ZEc19gvc=;
        b=mui2O7j4uHgWgkBmChAoCKPfjSyXWyG5poF7LeHVS347QRwVgQyEPGNtMunTV00+y6
         r6ZJ7jEbJYs3Q4bkQT/PRz2XM7riPY1BlrN2JGmSzHOk83ogbcFDTTB19nDD0oO7E6q0
         PNeLnkLmo0+GdLvnaQs13fI4DLl+7wVOfkCubc48U25wXdfGSzw/bWwGzQMGAVcY4H+K
         Xj/RAl/fDa/hqzapRwJTX256d0xcOu4pXmVCQP3pdeMTGw6jpkY7tYtqqIq0xC5uzkTd
         AyUYM03D81/p1i7cYQpOMXaoX68oFlEYsg9gD4k0/6T8aMGDy8YyWEdBv9FLB68fGS/e
         4uiA==
X-Gm-Message-State: AO0yUKXPYFtIkFZ1MFA1c1c14KAvkSVPK0lUit8b3dsWuiVZEfLuUIOb
        VGZpG8MKyBj2DCwWB2UimtHXZVYqE5rlt0icTbA=
X-Google-Smtp-Source: AK7set+I7yl7/pgKbZGIlh6IPE69HDCVB3m1cGgNYMwHGcwBhRzt5XFl7PuIsnxrSPwcYYiSM6RRp9wRkvnfo6FX4L4=
X-Received: by 2002:a05:6402:845:b0:4a2:56e7:178 with SMTP id
 b5-20020a056402084500b004a256e70178mr460794edz.58.1675081758611; Mon, 30 Jan
 2023 04:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20230119142115.38260-1-W_Armin@gmx.de> <8e3ddde5-87aa-a72a-dcfa-5a6041377b15@gmx.de>
In-Reply-To: <8e3ddde5-87aa-a72a-dcfa-5a6041377b15@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 13:29:02 +0100
Message-ID: <CAJZ5v0jkN_Qi+DNmQvbk+bRKfGkgZOvwLmYEujpn9d47TMSrng@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ACPI: battery: Fix various string handling issues
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jan 30, 2023 at 10:14 AM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 19.01.23 um 15:21 schrieb Armin Wolf:
>
> > On my Dell Inspiron 3505, the battery model name was displayed
> > differently than when running Windows. While i first suspected an
> > ACPI issue, it turned out that the real reason was the ACPI battery
> > driver failing to handle strings larger than 32 bytes.
> >
> > This caused the model name of the battery (35 bytes long, hex string)
> > to miss proper NUL-termination, resulting in a buffer overread later.
> > Luckily, a valid string was stored right after the now invalid string,
> > appending only the battery serial number to the original model name.
> >
> > The first patch fixes a potential buffer overread then handling buffers,
> > while the second patch finally increases the maximum string length to
> > avoid truncating such larger strings.
> >
> > The patch series was tested on a Dell Inspiron 3505 and appears
> > to work properly.
>
> Are there any outstanding issues with the patch series which need
> to be fixed for mainline inclusion?

I'll have a look shortly and let you know.

Thanks!

> > ---
> > Changes in v2:
> > - Drop first patch since it was already applied
> > - combine the second and third patch
> > - do not replace 0 with '\0'
> > - spell ACPI in capitals
> > - rework the buffer length hdanling
> >
> > Armin Wolf (2):
> >    ACPI: battery: Fix buffer overread if not NUL-terminated
> >    ACPI: battery: Increase maximum string length
> >
> >   drivers/acpi/battery.c | 35 +++++++++++++++++++++++------------
> >   1 file changed, 23 insertions(+), 12 deletions(-)
> >
> > --
