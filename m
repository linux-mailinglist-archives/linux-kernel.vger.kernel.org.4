Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9406A523D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjB1EMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1EMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:12:34 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D124C87;
        Mon, 27 Feb 2023 20:12:33 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536bbe5f888so237004347b3.8;
        Mon, 27 Feb 2023 20:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuF33KH98sGFgLOo+Da/Vtltg0Ots7b1XnFG+EYO+/Y=;
        b=A/conDcyLaaFSvmSMmdUYGpUQgnyNWcA0NcM2sQ4I9/OM230X9v6Q+ubRARWvcj9kR
         rwPLfct2gi1YwS+/Oq4r06lR/zd4uuuBCX2ft4hVGcloy01icyyV9KKEHy0+vfcxFWyz
         NINnpRdjB0pkyV8kzRG7PpSwLJPf8zCeUY7ttEGYM4lEA7Q1J5QB/F0pK91A83+fRjDB
         aoraiRg4WikwI03GnWEZNJ/9jR4QMJZj/Zd0tOjPhT6GJyg2OpWZ/izQimV2B5nFZtiy
         5SHnh0pQbVnuxuSzMx/HgZbKpYkmTCd40/YxwBjDXHyR5MH2S2A08yreMuGg1j6Bsgk3
         pYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuF33KH98sGFgLOo+Da/Vtltg0Ots7b1XnFG+EYO+/Y=;
        b=AvD/mOhEbuvHZcEsTJnLB764UMa4tFhCCLUbzZsYf4q2UjsshKvLI8Qa0SIOSZ31Wg
         V5srX8d4TB1iSIIePh3tz7e5Au2/AH6Yd8gqlyk6QcSYuAEWbkh4vyJFKrlr+ybsrRz8
         QIFJgJByYe3CBAlmHkDdu6zc/p97D+VK7lQYtcQc97sHQT9SvOMT9Xqiw1yPIQvdVWRO
         n8IzQqTJ1YXn49LdNdYLt/h3eaNqN9s7TeH5g1W9R1ar1A8Gh39HCcwb+3k3/hWpFfFy
         +uwP5+E38YtSoVswDrldDJL6UzIzwUzzTrd8SqB1pPUcxLgRBEoTfjI3eTkUILMVPSkx
         RbMQ==
X-Gm-Message-State: AO0yUKVoKt72jZA5v5PVhGeyt0WjYaebXll//l5cDdKkfsOqX7sass5R
        MPPQiLvp15dSjRWB/dHgD+3hCZmccUdLM3wxyPE=
X-Google-Smtp-Source: AK7set+PEdxsUbSO9J3q0yThjG5gMX6voXImg8S6bL5r1Dz7gKzVPesisjj633vKWxDc4V9G8hv0v3jUti0TTcHefXc=
X-Received: by 2002:a05:690c:c1a:b0:533:9d13:a067 with SMTP id
 cl26-20020a05690c0c1a00b005339d13a067mr10119576ywb.3.1677557552280; Mon, 27
 Feb 2023 20:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20230226102338.3362585-1-void0red@gmail.com>
In-Reply-To: <20230226102338.3362585-1-void0red@gmail.com>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Mon, 27 Feb 2023 20:12:21 -0800
Message-ID: <CABPRKS84yaatW-PD19aH4SdB5hfmZEUFYXqj8fX+QTUgLmy43w@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: add null check of kzalloc in lpfc_sli4_cgn_params_read
To:     Kang Chen <void0red@gmail.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kang,

Thanks for reporting this.

Technically, the lpfc_read_object routine already NULL checks pdata,
and if it was NULL would return -ENODEV.  Then, else if (ret < 0)
would evaluate to true and we'd goto rd_obj_err.

However, we like the suggestion to return -ENOMEM instead.  I will
post a v2 of this patch to address both concerns.

Thanks,
Justin

On Sun, Feb 26, 2023 at 2:48=E2=80=AFAM Kang Chen <void0red@gmail.com> wrot=
e:
>
> kzalloc may fails, pdata might be null and it may cause
> null pointer dereference later.
>
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.=
c
> index 6eb4085a3..54134d782 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -7291,6 +7291,8 @@ lpfc_sli4_cgn_params_read(struct lpfc_hba *phba)
>         /* Find out if the FW has a new set of congestion parameters. */
>         len =3D sizeof(struct lpfc_cgn_param);
>         pdata =3D kzalloc(len, GFP_KERNEL);
> +       if (!pdata)
> +               return -ENOMEM;
>         ret =3D lpfc_read_object(phba, (char *)LPFC_PORT_CFG_NAME,
>                                pdata, len);
>
> --
> 2.34.1
>
