Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365736A7776
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjCAXBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:01:31 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773A51F9A;
        Wed,  1 Mar 2023 15:01:30 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v101so1967197ybi.2;
        Wed, 01 Mar 2023 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677711689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE+oDtpGbT+gAQYEDgK6kIQbWVaBpPAhxc78Hy6giGs=;
        b=YN3Xwwm6qjB0IPrk36jtIOHeHiJOXJAG5Ntq1ZQ27BSpqPzaV1aBKDIp4ded1fT6jT
         x2JFMZQgfsy1VcXp/rpN44zJ9bQD8kpE3l5/XJz4U/5gPehsAtBJX+DjTMWAfQxQQlbN
         LsRAfRwPKa/jK6dOxq8SuCfaqUjzbOhM0Ef2VEaKdQ1akV3gt2NnZ3F/u0gIAT2xpli3
         Fr9UgnjlrG2n17rKTfjBF02K/iGUIEke+Um94U/rELnZLrEDYxZUBF+2dLZ7QH+DRBJ0
         rxeEuGiGgv/xrq8ttT/I/PBboTMPQL9t7ytYSQKfxM3mAwm1z1Wl96nq5aogteWwH+Qy
         f5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677711689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE+oDtpGbT+gAQYEDgK6kIQbWVaBpPAhxc78Hy6giGs=;
        b=rFwU1brYYrAxYdL+35fNrYjG8/dDH9GtghMYX6906II0AVDC+atNSMSmjcpAmtrqxi
         DYkgsz7DZR1pOXLE6wCbAO0/TSUc5I/VuY+m03VqHXyvC2CJrJipc2iEpFIbauzUKyp9
         rrMA+YjNL2gfTlHIpRWmaKCJ74QKlwe39MzGKtI597733AxxsJjqPw7bnFCUyLhQyzm8
         Yd14EUPigDWZH+WoOnHKu8OY/ZzMkL7x9w9Co3L3UmTXXVhDitsA1ncYzoH/udSGqRBd
         6MlbwIIYge+IHtYYORjXPmXXx6YLsdNB58xS5PZhwMJhNEGz1v52BrOu6t2wphYa2WGi
         ewAQ==
X-Gm-Message-State: AO0yUKVW3xgtKWD3WnMafhTf/RBjxXQTE7ERZIioBDSNEA0nnOT4N6tH
        6yucTvDyfwVVEoPlt1LG5pEIwRn5AdkmiUM2dEU=
X-Google-Smtp-Source: AK7set8ZYQR4OKKo4Fi/bkDgdO8v7guksvEtRubnGTad9wxIIjYX/6yzveg0PFMZoi/GQdAo0qa3CmciT+MNz+2jEs0=
X-Received: by 2002:a5b:792:0:b0:a03:da3f:3e68 with SMTP id
 b18-20020a5b0792000000b00a03da3f3e68mr4380243ybq.12.1677711689421; Wed, 01
 Mar 2023 15:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20230301-scsi-lpfc-avoid-list-iterator-after-loop-v1-1-325578ae7561@gmail.com>
In-Reply-To: <20230301-scsi-lpfc-avoid-list-iterator-after-loop-v1-1-325578ae7561@gmail.com>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Wed, 1 Mar 2023 15:01:18 -0800
Message-ID: <CABPRKS_NjBM_fW++PD5Az=9vEuhn=0-mtBg+a37P4i8HyVXcOg@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: avoid usage of list iterator variable after loop
To:     Jakob Koschel <jkl820.git@gmail.com>, linux-scsi@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Justin Tee <justin.tee@broadcom.com>
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

On Wed, Mar 1, 2023 at 9:30=E2=80=AFAM Jakob Koschel <jkl820.git@gmail.com>=
 wrote:
>
> If the &epd_pool->list is empty when executing
> lpfc_get_io_buf_from_expedite_pool() the function would return an
> invalid pointer. Even in the case if the list is guaranteed to be
> populated, the iterator variable should not be used after the loop to be
> more robust for future changes.
>
> Linus proposed to avoid any use of the list iterator variable after the
> loop, in the attempt to move the list iterator variable declaration into
> the marcro to avoid any potential misuse after the loop [1].
>
> Link: https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXP=
wr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc_sli.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index edbd81c3b643..5d06bf6d4f39 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -21899,20 +21899,20 @@ lpfc_get_io_buf_from_private_pool(struct lpfc_h=
ba *phba,
>  static struct lpfc_io_buf *
>  lpfc_get_io_buf_from_expedite_pool(struct lpfc_hba *phba)
>  {
> -       struct lpfc_io_buf *lpfc_ncmd;
> +       struct lpfc_io_buf *lpfc_ncmd =3D NULL, *iter;
>         struct lpfc_io_buf *lpfc_ncmd_next;
>         unsigned long iflag;
>         struct lpfc_epd_pool *epd_pool;
>
>         epd_pool =3D &phba->epd_pool;
> -       lpfc_ncmd =3D NULL;
>
>         spin_lock_irqsave(&epd_pool->lock, iflag);
>         if (epd_pool->count > 0) {
> -               list_for_each_entry_safe(lpfc_ncmd, lpfc_ncmd_next,
> +               list_for_each_entry_safe(iter, lpfc_ncmd_next,
>                                          &epd_pool->list, list) {
> -                       list_del(&lpfc_ncmd->list);
> +                       list_del(&iter->list);
>                         epd_pool->count--;
> +                       lpfc_ncmd =3D iter;
>                         break;
>                 }
>         }
>
> ---
> base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
> change-id: 20230301-scsi-lpfc-avoid-list-iterator-after-loop-7b7d5c3a8efc
>
> Best regards,
> --
> Jakob Koschel <jkl820.git@gmail.com>
>

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Thanks looks fine.

Regards,
Justin
