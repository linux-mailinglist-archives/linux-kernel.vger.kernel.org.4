Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8A56F0BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbjD0R45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbjD0R4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:56:52 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01083C15;
        Thu, 27 Apr 2023 10:56:51 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-32e74139877so2791955ab.0;
        Thu, 27 Apr 2023 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682618211; x=1685210211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyyJxrKprj6gNIC+QO8e9T92EW/T6FSHwvzLTsvXaHM=;
        b=DSI8J5PYEq8QOWMZPUwhKy6PV1gQSw8JmV7AoobI6FD1KhBIHOBTYDgZoiOaT8zmLk
         mexLObUoy3kXHyG6wl0Pbdd8tEPdWsLNwEsiuVvyXMwAU9Bd+TXDNoxyVe/3PAPGNqby
         b1+R6TVZkBDfLoQCk+w7jp5INj4l0LoNLxFpXAG2VQbmt+pteNcKuC+vKNu8JM5d0XwE
         YcOv+RDUtS0sM9YjQl9kMjcmerrzBfYCvAdDOODP4IIEEwPr6IkyDG9fdHfsjEsVTcQT
         QHBINd9QK4cXa6q0ilC4LwiEHPVfCpS+vHsqVYGaeEsQfpy7i10CMfqzAlaXBG+VFfQP
         Ab+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682618211; x=1685210211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyyJxrKprj6gNIC+QO8e9T92EW/T6FSHwvzLTsvXaHM=;
        b=MLVclo31CWbI3s+Cx8VRlSSn4TmiNDy2ss8ts57pfWwKL9Ck2givP0rYpMgrNwDLzM
         s5dYM8tkO21uOYyTvJU49MHFB96ZBn+Yg7IonwFy09DYcIPk7YX+7mxa7FY+sg8RbDtT
         wTQ6TFvnMFagkf+dfGSF82/cM6N1m0/WWtg9k1avsuzmrufuaJkyYNTcsKa+iyoPqmXG
         6xvT6sU9Y9hHAX2mF939i3XY0Ucf/Mz5VSyc1JvoMd4gWKOJwtND/28YJUwKwB9gg/gM
         CIiFenQf0A9DjFw1glSnctvzJk0Njh+TfdYKNdyeTD1u7MSsi5DlBRb6VQojIeNrhHVJ
         SvNg==
X-Gm-Message-State: AC+VfDx6xrD6yc5aq4XWSBlrU0wSOTal6Fl75+/zpGgRoBD39qCJE46+
        eNXIqgS4NCBxpm8HIy5U9hGRcp4gz6hpQHV5NzZKni8eUDE=
X-Google-Smtp-Source: ACHHUZ4FdYwY34u3N3Zwc++BIkVuYDUs9eBVQJ9sWiasZHatNI9NhUlJbQZaeahlrkmL4ZX5L1ZDIMjUWhLwKJuK29Y=
X-Received: by 2002:a05:6e02:972:b0:32a:eacb:c5d4 with SMTP id
 q18-20020a056e02097200b0032aeacbc5d4mr1206144ilt.0.1682618211012; Thu, 27 Apr
 2023 10:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230427114745.53136-1-arefev@swemel.ru>
In-Reply-To: <20230427114745.53136-1-arefev@swemel.ru>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Thu, 27 Apr 2023 10:56:40 -0700
Message-ID: <CAF8JNh+ps2F=vCr6GwpB7NAj8-graAw1-oCV2DonJWw8YA8p9g@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Added error check
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 5:07=E2=80=AFAM Denis Arefev <arefev@swemel.ru> wro=
te:
>
>    Added a variable check and
>    transition in case of an error
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Thank you Denis for working on the patch! The patch LGTM.

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

> ---
>  drivers/hid/wacom_sys.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index fb538a6c4add..aff4a21a46b6 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2417,8 +2417,13 @@ static int wacom_parse_and_register(struct wacom *=
wacom, bool wireless)
>                 goto fail_quirks;
>         }
>
> -       if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
> +       if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
>                 error =3D hid_hw_open(hdev);
> +               if (error) {
> +                       hid_err(hdev, "hw open failed\n");
> +                       goto fail_quirks;
> +               }
> +       }
>
>         wacom_set_shared_values(wacom_wac);
>         devres_close_group(&hdev->dev, wacom);
> --
> 2.25.1
>
