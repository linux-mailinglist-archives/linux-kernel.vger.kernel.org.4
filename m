Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C75FED4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJNLpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJNLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93DD21815
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665747897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+SaMoWTI1va/GeQPVZGv1GV3k10aJeG+I3b8tcuOi4k=;
        b=PTGVZGBAZ1EO7Sg2NP6lB6ZPMFHAFigWiPppJ8yz27ZUGjqo+ikoQQgc1vQu9Rzxv6XK/+
        vvfMZNAe4mf3lGzJUBlcO8l1t76gKc0QduyDNZ7E77hzh2lCvwYv6rwhf4PPT57PHRJlzL
        gnQPA5b1/L5etwa0w6mZacfXwNN8B98=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-NhSNpbLKNsikGRPwcIYLdw-1; Fri, 14 Oct 2022 07:44:56 -0400
X-MC-Unique: NhSNpbLKNsikGRPwcIYLdw-1
Received: by mail-io1-f72.google.com with SMTP id t15-20020a5d81cf000000b006bc1ca3ae00so2944004iol.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SaMoWTI1va/GeQPVZGv1GV3k10aJeG+I3b8tcuOi4k=;
        b=lBUsAjCUsvvRTYFHyUECIqcZZc1U0JStMxV5Ovz254Bbj8RN+2mJANndLkQSoQP1ZC
         AzrD5dp8D2BQqmZvbD8TGgmTDTsLaP85hrWFe8bhMSpxe2lxbqXvqdLrkI5PRX/HhBhk
         k7kBEokfGETSo5knkf15oU6a4qRUu0jxEPeZuKd58GIsqyvvD0vsuSp+kHHaPS1o+cOC
         +zsjYz9OCWP2pzu2kGZ8cLcNHT3Bf1OlRFR0cCIHEdk6WiDyr703KLg7wULN7NwNGfY9
         3jv02O/vjZAtceDFC4FS5z5sejKnn64CKByPZ/o5umo85frwFjdV6r7ihZZ36ZgYGuNY
         xBsw==
X-Gm-Message-State: ACrzQf1d5yMU770Dijt1CGuXDK0nGvnLx/TeUpcNUUAcfOINEOinG85e
        4wdXVIAyg5gL1CeuXXbkygrGqxbACw7+iYIgV/YXVSvkJ7me6kwUvxbji+vAcyXIoK2ps9l9kHZ
        H2pNfc6OoK7CdOTEcWH4zFT3ZCOJKTOZC267klSke
X-Received: by 2002:a05:6e02:1ba3:b0:2fa:3547:477a with SMTP id n3-20020a056e021ba300b002fa3547477amr2333626ili.34.1665747895139;
        Fri, 14 Oct 2022 04:44:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6bwkw/YLVKENVtQ5QSSOSYDV5uyqFVv+l7NGeCxPr7b/ll4YvLxvKADWuES9vE93ktW2TZnt4eeMdL4zO9Gmg=
X-Received: by 2002:a05:6e02:1ba3:b0:2fa:3547:477a with SMTP id
 n3-20020a056e021ba300b002fa3547477amr2333619ili.34.1665747894973; Fri, 14 Oct
 2022 04:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221009182747.90730-1-jose.exposito89@gmail.com>
In-Reply-To: <20221009182747.90730-1-jose.exposito89@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 14 Oct 2022 13:44:43 +0200
Message-ID: <CAO-hwJKJ8SROR5WVyogAAh=L3jyuHuJwLi6B1C9wGD=14PjYGA@mail.gmail.com>
Subject: Re: [PATCH] HID: magicmouse: Do not set BTN_MOUSE on double report
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nulo <git@nulo.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 9, 2022 at 8:28 PM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gma=
il.com> wrote:
>
> Under certain conditions the Magic Trackpad can group 2 reports in a
> single packet. The packet is split and the raw event function is
> invoked recursively for each part.
>
> However, after processing each part, the BTN_MOUSE status is updated,
> sending multiple click events. [1]
>
> Return after processing double reports to avoid this issue.
>
> Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/811  # [1=
]
> Fixes: a462230e16ac ("HID: magicmouse: enable Magic Trackpad support")
> Reported-by: Nulo <git@nulo.in>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> ---

Applied to for-6.1/upstream-fixes, thanks for spotting that old bug :)

Cheers,
Benjamin

>  drivers/hid/hid-magicmouse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 664a624a363d..c9c968d4b36a 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -480,7 +480,7 @@ static int magicmouse_raw_event(struct hid_device *hd=
ev,
>                 magicmouse_raw_event(hdev, report, data + 2, data[1]);
>                 magicmouse_raw_event(hdev, report, data + 2 + data[1],
>                         size - 2 - data[1]);
> -               break;
> +               return 0;
>         default:
>                 return 0;
>         }
> --
> 2.25.1
>

