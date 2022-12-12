Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1B64A413
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiLLPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLLPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:23:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F4DF6F;
        Mon, 12 Dec 2022 07:23:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d20so13407889edn.0;
        Mon, 12 Dec 2022 07:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ChHITi8TFnxzMUCCvh0ICYLsFw/8Il2tsX12Z2NSXOo=;
        b=PSDAmMe+hWxRzmwceoDRF6ubxXRO1ox1EuLxysgOKbWBdQr9gaSeKoosyuP4EOl95S
         Mg2iou5kEt/OXY3m3ZQWr16AX/TDzcXd2GDbVlW8CKXbCNpMjRWWYwOC+Ey3lEmvEFcK
         gRtDYbm+gp+59Kwn1zmR1KQ0fsQXTDUboM0ZwcnOci0zOgIx57VgLtvIxjrgqLa+wT9b
         LY3tef4KLMGfj3kkCmZkdGPz1eqxF4rXsMXJ7687Djhs69adb7zKT1FYoOCZbuwou4dM
         1t/9j7PTzVqWZru1XM8UZe968tEpKbSfVH6YDsLNRSQGviMbeG2rYJul3dFIJgcroIfo
         x28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChHITi8TFnxzMUCCvh0ICYLsFw/8Il2tsX12Z2NSXOo=;
        b=bHbJxfkFNyPY7VukKNfKuXvy5JUjqKjm78m8vC0XJP2hyYj5+CSS2wUKrl3Q9mlr7g
         tBtPHn85ClD9jEi8zmVvPdjKfMcwTiVq8iyMEhgbjDkS9QoyEGrW4fONzsK94ZiOgDP/
         6FJSARAaqhGwoajfieepRO4mMZr6qn04ypYNVXYRFZIqYP9vmdKjrkmWOKh/hi/IgTW+
         UI+U0mxEzL38eJIW2QkXQKNrszrutWZeNPbeq/hE0zY+MvliPMxu/nwtZn2jYYGUveet
         wtovXYuQpGtrWWBRg4h1DnoYb60rzEqdGaVh892wDf4M18apBy2nu4KFf0EVUwWMM7ZM
         ACHw==
X-Gm-Message-State: ANoB5pm4ovn2UqJwHMC2QIL6Rhqvmie0Gt/r4dMfttvex1/X97bULFoJ
        pM7bfTxukkIslEEzIhGRAWY76RG6oxg9rCAytZRjPmu9k/4=
X-Google-Smtp-Source: AA0mqf5P7C8N2DcUDQeXuyNiXnMsH4ADDboDkylr8vx9skN4uB2SpAZ43Rrc0sB5PdkBcHMdWpuOxrSuuInEB73/wBk=
X-Received: by 2002:a05:6402:35d6:b0:46d:e6b2:1ebd with SMTP id
 z22-20020a05640235d600b0046de6b21ebdmr968810edc.179.1670858631850; Mon, 12
 Dec 2022 07:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20221205210354.11846-1-andrew.smirnov@gmail.com> <20221205210354.11846-2-andrew.smirnov@gmail.com>
In-Reply-To: <20221205210354.11846-2-andrew.smirnov@gmail.com>
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Mon, 12 Dec 2022 16:23:40 +0100
Message-ID: <CADyDSO6EBuKNZFTvuuhS9VM+dy8t8HOcHyodiQR8o_uXd8gXww@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] HID: uhid: Don't send the report ID if it's zero
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
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

Hi

On Mon, 5 Dec 2022 at 22:04, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Report ID of zero is a special case handling ID-less reports and in
> that case we should omit report ID from the payload being sent to the
> backend.
>
> Without this change UHID_DEV_NUMBERED_{FEATURE,OUTPUT}_REPORTS doesn't
> represent a semantical difference.
>
> Cc: David Rheinsberg <david.rheinsberg@gmail.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/hid/uhid.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 2a918aeb0af1..7551120215e8 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -273,11 +273,11 @@ static int uhid_hid_get_report(struct hid_device *hid, unsigned char rnum,
>  }
>
>  static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
> -                              const u8 *buf, size_t count, u8 rtype)
> +                              u8 *buf, size_t count, u8 rtype)
>  {
>         struct uhid_device *uhid = hid->driver_data;
>         struct uhid_event *ev;
> -       int ret;
> +       int ret, skipped_report_id = 0;
>
>         if (!READ_ONCE(uhid->running) || count > UHID_DATA_MAX)
>                 return -EIO;
> @@ -286,6 +286,15 @@ static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
>         if (!ev)
>                 return -ENOMEM;
>
> +       /* Byte 0 is the report number. Report data starts at byte 1.*/
> +       buf[0] = rnum;
> +       if (buf[0] == 0x0) {
> +               /* Don't send the Report ID */
> +               buf++;
> +               count--;
> +               skipped_report_id = 1;
> +       }
> +

In HID core, the buffer is filled by a call to hid_output_report() in
__hid_request(). And hid_output_report() only writes the ID if it is
non-zero. So your patch looks like it is duplicating this logic? In
which scenario is the report-ID not skipped exactly?

Regardless, if you want to mess with the buffer, you should do that
after the memcpy(). I don't see why we should mess with the buffer
from HID core, when we have our own, anyway.

David
