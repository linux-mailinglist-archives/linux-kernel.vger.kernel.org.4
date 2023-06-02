Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A74371F78A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjFBBKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjFBBKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:10:49 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE8E4;
        Thu,  1 Jun 2023 18:10:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b10a3d91dfso77611a34.0;
        Thu, 01 Jun 2023 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685668248; x=1688260248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH98QIvRTr6UanreAyKHqgM4BGZBSV4Xr4LOowmlmGk=;
        b=Ttry9yv4yGffZ8+5YY7QOR5UGwV3VAzvywcudKmI3R1O8C2JeTzwqd4rh81lKYhgxt
         1mOw9aZ9R2D5e2BcpBux2/DN8bdZhcimrgZm/WO7Xdvmy1BjCAtBmmVIm5lk9rEnl6GB
         C4UZS90gRXrBx7dq7mTILSRxNBI/Jv3L856YbU5gHV90dfpP3Qvz0QZ8VcdNFDQtmwXa
         2aZ1J/l3viG5lbVx88WF0a9WSagGnltXene62GwcSO38LwuZD2REoBED1TnIjbtrdB3m
         U2QhcNsG2zEy4Q61JrMY6RQOPbC1vS8pXpmobb4zltkUlvRHlCGd8gt24Pv/W9yFz9EZ
         pZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668248; x=1688260248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH98QIvRTr6UanreAyKHqgM4BGZBSV4Xr4LOowmlmGk=;
        b=lPGgqJfIh1UaeLIoz735pj2ffcT4hrquZcFRJ82Jyjuh5thN0tDLWje8uODSTKqa7l
         qINzLt94cpY+1FEZ/I7x+5IjlQl6j7zrR2AskYez1Uf/C2JGF704dzAfsBw8ZJvzDCde
         ut5XqA4ehIoAV5LEc7jLrw/Pi5prZ2vgASQelgGoVjOr6V6NlZ1745YVcpmRK6pz+v71
         6LDIzX1ZLoAmbnXFCJvI7pVsbsvUlSrgb3tvgR8AJw7y1tLubO+hE5VdswlJuE/lk3s9
         nkknRh0+HzES9jxxG29++wm2sBc7Qm/FYOsqJP4t0DoyELNfquVmmVx442wNuY04tuqb
         Og8Q==
X-Gm-Message-State: AC+VfDyLWG4X+u9AhFwZ8GQQSvwHXqlNRzfXAs3+2EvtT16tV6hwImS+
        GCZyzpFJ2QiBpRg2/tJgLwxuJ20t5YGuSkQeATQ=
X-Google-Smtp-Source: ACHHUZ4XPuz4c9rrooO5lzthn7ewEGiToh11VcZSPY2ZDm7z6XPwg9tBLrptzSglD5xyAvjUJgt1RfQTN0DOsuX7HE8=
X-Received: by 2002:aca:a8c1:0:b0:385:d91:ee30 with SMTP id
 r184-20020acaa8c1000000b003850d91ee30mr4236678oie.3.1685668247712; Thu, 01
 Jun 2023 18:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <ZHkseX6TiFahvxJA@work>
In-Reply-To: <ZHkseX6TiFahvxJA@work>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Thu, 1 Jun 2023 18:10:36 -0700
Message-ID: <CABPRKS_FD=oeJGAEk2kpiwxSP-eDRXmm0iMhDfOW0CLV4qcS3Q@mail.gmail.com>
Subject: Re: [PATCH v2][next] scsi: lpfc: Avoid -Wstringop-overflow warning
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Justin Tee <justin.tee@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

Thanks Gustavo and Kees.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

On Thu, Jun 1, 2023 at 4:43=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Prevent any potential integer wrapping issue, and avoid a
> -Wstringop-overflow warning by using the check_mul_overflow() helper.
>
> drivers/scsi/lpfc/lpfc.h:
> 837:#define LPFC_RAS_MIN_BUFF_POST_SIZE (256 * 1024)
>
> drivers/scsi/lpfc/lpfc_debugfs.c:
> 2266 size =3D LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;
>
> this can wrap to negative if cfg_ras_fwlog_buffsize is large
> enough. And even when in practice this is not possible (due to
> phba->cfg_ras_fwlog_buffsize never being larger than 4[1]), the
> compiler is legitimately warning us about potentially buggy code.
>
> Fix the following warning seen under GCC-13:
> In function =E2=80=98lpfc_debugfs_ras_log_data=E2=80=99,
>     inlined from =E2=80=98lpfc_debugfs_ras_log_open=E2=80=99 at drivers/s=
csi/lpfc/lpfc_debugfs.c:2271:15:
> drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: =E2=80=98memcpy=E2=80=
=99 specified bound between 18446744071562067968 and 18446744073709551615 e=
xceeds maximum object size 9223372036854775807 [-Wstringop-overflow=3D]
>  2210 |                         memcpy(buffer + copied, dmabuf->virt,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  2211 |                                size - copied - 1);
>       |                                ~~~~~~~~~~~~~~~~~~
>
> Link: https://github.com/KSPP/linux/issues/305
> Link: https://lore.kernel.org/linux-hardening/CABPRKS8zyzrbsWt4B5fp7kMowA=
ZFiMLKg5kW26uELpg1cDKY3A@mail.gmail.com/ [1]
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use check_mul_overflow() helper (Kees).
>
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZHZq7AV9Q2WG1xRB@work/
>
>  drivers/scsi/lpfc/lpfc_debugfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_de=
bugfs.c
> index bdf34af4ef36..7f9b221e7c34 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.c
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.c
> @@ -2259,11 +2259,15 @@ lpfc_debugfs_ras_log_open(struct inode *inode, st=
ruct file *file)
>                 goto out;
>         }
>         spin_unlock_irq(&phba->hbalock);
> -       debug =3D kmalloc(sizeof(*debug), GFP_KERNEL);
> +
> +       if (check_mul_overflow(LPFC_RAS_MIN_BUFF_POST_SIZE,
> +                              phba->cfg_ras_fwlog_buffsize, &size))
> +               goto out;
> +
> +       debug =3D kzalloc(sizeof(*debug), GFP_KERNEL);
>         if (!debug)
>                 goto out;
>
> -       size =3D LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsi=
ze;
>         debug->buffer =3D vmalloc(size);
>         if (!debug->buffer)
>                 goto free_debug;
> --
> 2.34.1
>
