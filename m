Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AC7168C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjE3QJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjE3QJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:09:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF6198;
        Tue, 30 May 2023 09:09:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30ae69ef78aso2004396f8f.1;
        Tue, 30 May 2023 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462949; x=1688054949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi0/JSrKBypgCtjQEoow24NFxZocncTUaEgKTBeFpRQ=;
        b=hVGRu0prW/3S+Zg8ZJ1Tz6XPV24/xDsOnyP8dFoMgmQfP0JUFuGqzGAcHbka3yAuPQ
         SugcRLOkP9/VXsMnyb5id8VqYhISd6rVqpv+IzZhHwEnPh8gK+cOM9uUUlpuuRsgjaK8
         DDZcZj56JHwrW2bTx31CI2+JAgYVbAo+zEklLQJSU8zRs/rUOUlaJyCRPdHZCMYUuS03
         MzBB6AKo150s/58E822BDtV6WS0NMm+H2VhSceuzQ2kmLspIPTfBrfoJT0Nur10k+2+o
         Jun10e6ds2y8NxmwzAY3mvh31Jc268Dw06p+PXjB9BUe0/Hdk7foKMlXbEm7xzvMo/jo
         9mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462949; x=1688054949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oi0/JSrKBypgCtjQEoow24NFxZocncTUaEgKTBeFpRQ=;
        b=bd6JHjHl3ofOJAdWsEtxo022n+aeViLaSsx290UwP1xraMrmUwS4SOjnQPNJYdi6Gw
         07Kv5KEywYU6gqh7wCR9OMPVK5XdNmHk1GNMtfvjvlSIOkWHutR4NlyhVS7fj5/phL6c
         Wn8VtBt5IgXAfTU0j6vbZKGO6tjleDtvxdzsf+HvmD84hFyN9uYrREMjYq6rkS9Gpzio
         Ug+0OxrwemzWFVeNycr0P7oiLMmsGbUFRRiTP+cIY30fWAjYZqklQeE/urjO0Rt/EUTZ
         mNAohebvK2Hpr85gRxJwpp+ht0Z7dzCUaA5poI38NfTrTiM0x3DdSXdFTclGue+jzmP9
         jrsA==
X-Gm-Message-State: AC+VfDwPe4ZAFKCU1KUXsvVo72JmH6K3PJpDEe9BNLkAFgZ4Tp4Fldgb
        93QdyzD489SUZp4GU/pf5Smm7GIEKJWYr7lW45Q=
X-Google-Smtp-Source: ACHHUZ6aXodoM2hGVPxieUQ1l1WXdJrNDTm1QeHOWlvIwTAqEarAHbF9cm8DW7PE6ssRdnEeq4SfiQDwReqkPJLAiTQ=
X-Received: by 2002:adf:f812:0:b0:2f6:661:c03c with SMTP id
 s18-20020adff812000000b002f60661c03cmr2525443wrp.28.1685462948658; Tue, 30
 May 2023 09:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230530160033.411441-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230530160033.411441-1-azeemshaikh38@gmail.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Tue, 30 May 2023 12:08:57 -0400
Message-ID: <CADmuW3Vgraciy__V24wHF0fBstT8odmMm6t1bUxZLeyFi9P6fQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate of https://lore.kernel.org/all/20230523021425.2406309-1-azeemshai=
kh38@gmail.com/.
Sorry about that.

On Tue, May 30, 2023 at 12:00=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.=
com> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/soc/fsl/qe/qe.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index b3c226eb5292..58746e570d14 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -524,7 +524,7 @@ int qe_upload_firmware(const struct qe_firmware *firm=
ware)
>          * saved microcode information and put in the new.
>          */
>         memset(&qe_firmware_info, 0, sizeof(qe_firmware_info));
> -       strlcpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_inf=
o.id));
> +       strscpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_inf=
o.id));
>         qe_firmware_info.extended_modes =3D be64_to_cpu(firmware->extende=
d_modes);
>         memcpy(qe_firmware_info.vtraps, firmware->vtraps,
>                 sizeof(firmware->vtraps));
> @@ -599,7 +599,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
>         /* Copy the data into qe_firmware_info*/
>         sprop =3D of_get_property(fw, "id", NULL);
>         if (sprop)
> -               strlcpy(qe_firmware_info.id, sprop,
> +               strscpy(qe_firmware_info.id, sprop,
>                         sizeof(qe_firmware_info.id));
>
>         of_property_read_u64(fw, "extended-modes",
>
