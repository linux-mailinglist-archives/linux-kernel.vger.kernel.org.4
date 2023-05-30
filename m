Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77C716D44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjE3TQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjE3TQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:16:26 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A31F7;
        Tue, 30 May 2023 12:16:25 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba849c9e769so720457276.1;
        Tue, 30 May 2023 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685474184; x=1688066184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReF3huZIX5MctcfmMwDZUJKJfR+aqdvurL3+etSGPTE=;
        b=eX75pXiciwV/nPpOs0cNYiWqohYG7dS/oJdv84zYd60x7tsg0skrvDTgTACmmG/nW7
         NftcHo7jZiGXqGHTCMqelg3PoyQa+gIlCuLk25vwXUHg/KgoavIB80kuil7ODR00NCRC
         Tw6jll+NN2TSm0Y9Q+DDOVvsHCczp49nOJjh/mYUfncelDFoXLJvbm7iuq20tYWltWxp
         oBNfeqihCPhl+XDHiYCPbeaLHj0CWjlvpSflv3CmpQ9B94aEeNiDdEbH/3O6n0EHSmWf
         QByVctJMof4P3L8NGej/AoSobqnpKF4yRgpLAf8AXaVXUbthYpWLP83jjmSfSJx4oY5l
         jFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685474184; x=1688066184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReF3huZIX5MctcfmMwDZUJKJfR+aqdvurL3+etSGPTE=;
        b=WY8g4metQIlxwKfvXU57BDMouBOHmtwSX63HkIxBrG46YLmkX1xfiBImhpK6cc8CEL
         tfwXtKAfKQeZhlkJNkuGzWJ2EwwNLaoyTGV8RfJ5pmgwH357jxGrkaWKoqxTgdiAYT76
         XCffiJKcGAbKfDx8QNuuR79AcCghlJR6n6M2Gt13rBNohNfFgMHLWgRhwuRN4mlGpv0f
         NlT2hKA7n1Xt487BM9H+sy3gihzXdUoyy5onNo/uVEjQbEzhsAxIY+t9xVKi9TxqJdwG
         uneeox2brhoSi7ewtNjyftfyOY5NDu4O3h+orrCWcp+vLS5sProbce1+N8JVO1DB+DH+
         i99Q==
X-Gm-Message-State: AC+VfDzv3tdNZY2Bhu3aoeEXebjDnq2zoVWrVyb19bGtjkffB7prMTVK
        oM30iw0gS/Hl6x9oNWik7pkkHPf78ZN8sYG8Su4=
X-Google-Smtp-Source: ACHHUZ5KF5sP458BAcc4MOaFQx+ppx14Rr714fryU4Pc0VR6ggbBG74ErZ8JzB+32dZEQBBzsN8PE9WmIWTSyjqnO48=
X-Received: by 2002:a81:1a05:0:b0:565:be47:55d9 with SMTP id
 a5-20020a811a05000000b00565be4755d9mr277679ywa.1.1685474184541; Tue, 30 May
 2023 12:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230530155745.343032-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230530155745.343032-1-azeemshaikh38@gmail.com>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Tue, 30 May 2023 12:16:13 -0700
Message-ID: <CABPRKS8Gx8kaSXXbyV2Ms=mPTvuR1grAcxbXROCVq3WFr3KL5Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Replace all non-returning strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
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

Hi Azeem,

Looks good.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Thanks,
Justin

On Tue, May 30, 2023 at 8:59=E2=80=AFAM Azeem Shaikh <azeemshaikh38@gmail.c=
om> wrote:
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
>  drivers/scsi/lpfc/lpfc_hbadisc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hb=
adisc.c
> index 5ba3a9ad9501..239a6537b987 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -4835,7 +4835,7 @@ lpfc_nlp_state_name(char *buffer, size_t size, int =
state)
>         };
>
>         if (state < NLP_STE_MAX_STATE && states[state])
> -               strlcpy(buffer, states[state], size);
> +               strscpy(buffer, states[state], size);
>         else
>                 snprintf(buffer, size, "unknown (%d)", state);
>         return buffer;
>
