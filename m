Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AE96BCCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCPKhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCPKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:37:00 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049CF62FFD;
        Thu, 16 Mar 2023 03:36:53 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h11so698500ild.11;
        Thu, 16 Mar 2023 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678963012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2KwWFmzvZ2djH3TgZVwyQ57NzJvl1Pp4QAiCezPP9s=;
        b=q7nen8m4MrzYxoSraaaLgFF/LeGnpIMcuEzwCVtItw1YT6TBImobq/JQPtQmmrmibP
         941k8PkJhfwkMc14EomNcFFX8mnn2JpLBEF5TuHI8STOKnD2FkWgYCkEioqCzRXpNmbN
         nH9rz+BergZ3rHPNOKtsC71xkboD3N/jb5Sl8wkGZPDDgUEEaEIxhtOtDtFU5pxixwSK
         crY8NJJk7BrqXrOL/BkzFaepKWNblJYXLPNq8GCJBhiCbFjbk6HcK3UFIQZUwpQAuruy
         18z6F11MsOUibF+XIR3ThyLq5IDY2cUOKqxIG0ffECgkPrdDOgcH9hJnSl11gozIcFjM
         k9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678963012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2KwWFmzvZ2djH3TgZVwyQ57NzJvl1Pp4QAiCezPP9s=;
        b=gWCrAKtRcn3dlDb1Ks4OWOdgwF/oujf/58DoNtG4ay/ki4B90yqgoewW8veYxZWutM
         67w64OdjY9gO0TrenEvEJi4eDpcj2l+S6ZexkFNrWoxh1Hf92v5SNdEgvWdhtfP1j4DT
         nRVNlWgI/nIrMFAITD6sVGB3bYTNwrZpZdLPDN+10R1pPV39MlqEj67AJEclcI/yfddu
         2SBj6XH9IjoQzb4LKH2J/Klz9qfb8757gJGt2iaDljO3142jR1JESqTbYK+JL2n9Gw6R
         w5oGO+NgT6OGpDlfI0sysnY4scS9rHJjoovUUGAIi3CSnbrWt1BBaa8hlnlveWBkjTpk
         /3QQ==
X-Gm-Message-State: AO0yUKVZx4sEHPxUxhIhGvg51XpuV8T7z/WaW7hzOO2CY5zN0Z2QEryH
        5KQqxkoGD898uq9xTSrTZ3rdFLElQulFkuSDp/8=
X-Google-Smtp-Source: AK7set+I41DgNxZUiTGjCAooKOqPDj7fDsAESCcsdjclnfa3Zv10wR6onWDT/9rS5Enbie/3JSVTDeSO+jBqV7OmTD0=
X-Received: by 2002:a92:c14b:0:b0:316:f0d7:8db with SMTP id
 b11-20020a92c14b000000b00316f0d708dbmr4439270ilh.5.1678963012299; Thu, 16 Mar
 2023 03:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230313154522.52684-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230313154522.52684-1-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>
Date:   Thu, 16 Mar 2023 11:36:41 +0100
Message-ID: <CAMUOyH1BFnGzODgCZP+Whde=Kbmq_5rPN02GrfSp8z2_PVPpEQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: gadget: Use correct endianness of the wLength
 field for WebUSB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 4:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> WebUSB code uses wLength directly without proper endianness conversion.
> Update it to use already prepared temporary variable w_length instead.

Excellent catch! Thank you very much for finding this. This could have
been a very hard to find issue in a big endian system.

I tested this on my local setup and it (unsurprisingly) works like a charm.

> Fixes: 93c473948c58 ("usb: gadget: add WebUSB landing page support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-By: J=C3=B3 =C3=81gila Bitsch <jgilab@gmail.com>

> ---
>  drivers/usb/gadget/composite.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composit=
e.c
> index fa7dd6cf014d..5377d873c08e 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -2079,10 +2079,9 @@ composite_setup(struct usb_gadget *gadget, const s=
truct usb_ctrlrequest *ctrl)
>                                 sizeof(url_descriptor->URL)
>                                 - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + l=
anding_page_offset);
>
> -                       if (ctrl->wLength < WEBUSB_URL_DESCRIPTOR_HEADER_=
LENGTH
> -                                           + landing_page_length)
> -                               landing_page_length =3D ctrl->wLength
> -                                       - WEBUSB_URL_DESCRIPTOR_HEADER_LE=
NGTH + landing_page_offset;
> +                       if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGT=
H + landing_page_length)
> +                               landing_page_length =3D w_length
> +                               - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + l=
anding_page_offset;
>
>                         memcpy(url_descriptor->URL,
>                                 cdev->landing_page + landing_page_offset,
> --
> 2.39.2
>
