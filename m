Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3511174763C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjGDQOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGDQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:14:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99006DC;
        Tue,  4 Jul 2023 09:14:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-766fb2213f3so64728585a.1;
        Tue, 04 Jul 2023 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688487283; x=1691079283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T63vv7+1NxTr4s2sWM7fL8hh1V9Gn3Leuqcn+6bgKsY=;
        b=BMb718vHwyMN6MBuFNP60YzyrP+fTctzIyNIBsd2q3ChJALvpkTxJ574Z6oCH7yekB
         pltHKmOYxHMTNHkQ3FknVwVWhOvDF5zO5ZPPvliC9p57tekWY6VHiD5JGyLnn2SLd7DJ
         w6q19uvLs/qgC7iidE4/46kwGo/rq0NabXX1/rq6wdQMP7jZN/ygdgBvfwW8agQnurk6
         ZLbh5D6MBMWd1pDaksdoNj23GhTKao4aNj0A6kddyjWVqajpKYNnP6d4kbWeYzry+cna
         LbfWSXPc4jzX726H7AfYG1GYHcEMu5s8e5UPaqgFonfMp7eeRlA60kkCwtC+U6RezevN
         mGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487283; x=1691079283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T63vv7+1NxTr4s2sWM7fL8hh1V9Gn3Leuqcn+6bgKsY=;
        b=FtUp9cGFqtipW38j0AiGHNlIjuc+vXe4lRDr7pW1IbQxQEezHvBGkydTpWU+7n59N1
         TDaqkZ1tUUJ6ARaLsYyU/hjOdY+ed/YGcXgJiir8c3QjJlqbZ93W/JZwDM+FBOsvjfWw
         SC8YDzjAjhcbzMkshfTJZYhN+0/dXlt82O27OyFTYe9J/JkO8x+apKOzloe+4izD9svt
         VyFbnoNtjwzESVrQQMueCuFs1WE9gu/G8s9z3DdPIxcDk+iMgR4CpxJg4RB3/5nnCRQt
         DW8E3q5lPjF+341M9OjL5PxZvOHIT6/RHP1nDvjV74jzcTWonUavR5tnz+TfDYb7FJk7
         Pc3w==
X-Gm-Message-State: AC+VfDyScj3LEj3+9To07x/LkJOFdv8p0ulh+v1T6+rGHfJB2V9aqDJc
        C2gNu6lhE6Xey5Mkp5qvRIxhYf9wchqUmWW1ayw=
X-Google-Smtp-Source: ACHHUZ73/hB4Vz36V4ohxX2Dsb7RQkVIJ3k/+v5O6FzFzOGc5QwhUR9nFuE895wFMxku5EF51/o0q6TVRWrVCBqkpIs=
X-Received: by 2002:a05:620a:2687:b0:765:97b7:cfb5 with SMTP id
 c7-20020a05620a268700b0076597b7cfb5mr16726860qkp.6.1688487282999; Tue, 04 Jul
 2023 09:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230630024748.1035993-1-islituo@gmail.com>
In-Reply-To: <20230630024748.1035993-1-islituo@gmail.com>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Tue, 4 Jul 2023 09:14:32 -0700
Message-ID: <CABPRKS8_bGqfE3x8abj0p1CTVcLk8EtVn8gjbWd15CaC42_Oew@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
To:     Tuo Li <islituo@gmail.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>,
        Justin Tee <justin.tee@broadcom.com>
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

Hi Tuo,

Looks good.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Thanks,
Justin

On Thu, Jun 29, 2023 at 8:03=E2=80=AFPM Tuo Li <islituo@gmail.com> wrote:
>
> The variable phba->fcf.fcf_flag is often protected by the lock
> phba->hbalock() when is accessed. Here is an example in
> lpfc_unregister_fcf_rescan():
>
>   spin_lock_irq(&phba->hbalock);
>   phba->fcf.fcf_flag |=3D FCF_INIT_DISC;
>   spin_unlock_irq(&phba->hbalock);
>
> However, in the same function, phba->fcf.fcf_flag is assigned with 0
> without holding the lock, and thus can cause a data race:
>
>   phba->fcf.fcf_flag =3D 0;
>
> To fix this possible data race, a lock and unlock pair is added when
> accessing the variable phba->fcf.fcf_flag.
>
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc_hbadisc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hb=
adisc.c
> index 5ba3a9ad9501..9d2feb69cae7 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -6961,7 +6961,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
>         if (rc)
>                 return;
>         /* Reset HBA FCF states after successful unregister FCF */
> +       spin_lock_irq(&phba->hbalock);
>         phba->fcf.fcf_flag =3D 0;
> +       spin_unlock_irq(&phba->hbalock);
>         phba->fcf.current_rec.flag =3D 0;
>
>         /*
> --
> 2.34.1
>
