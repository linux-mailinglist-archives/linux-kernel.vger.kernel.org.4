Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2259270EDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbjEXGfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEXGfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:35:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC3A3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:35:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510e419d701so1418061a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684910103; x=1687502103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1wUIJMfAo0/AosKYM4CFvgerfUFkbb5h7skbboxjNk=;
        b=bYgXzpU/awJ0+ETrxbiLpTzWHBhjQqTGv8/32UVjV48zHtUevfBFi6SMmToo/vpamV
         GznXbYsUrHbqI+m5fVEli++e5vwnW0Zpb6teIHTh/r1UcImdfq97TsG7JvJVpGARTDpA
         qC1kCZ3/WzTdfqoUEUh8rLCspfY25g8luc8B6eG0lSyo8AeiarRssa7jlPCEfbM02o6y
         qjSNX9qi1qkoAGcn4Omywm/i3Zdr8xsRNAiG8TfeUqvg0epmymaVkaFrqskllY7Y59j4
         /YAvjfhh4Q9kgTHHLpbBssnW2A7MrISl73zhTrLwa2E63hyYvTHRdLzZf46PIPgkJWlJ
         3zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910103; x=1687502103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1wUIJMfAo0/AosKYM4CFvgerfUFkbb5h7skbboxjNk=;
        b=QsvyxsEDuH7xDi3sYjmYHH/itPpOOIMspC9bOh61kFQulpE1PNF+F4NATKFATRdWD6
         1MY6zQhK5nbbsFGNKhctI/wENVALRfsFxep/Ov5SaM+qGgbe4DdfZPehS4Ohw7TU1Obo
         MZZ0OHleI3Zx38vF0VT/EAQpDRqyyLtkaMDS9E8i5QeA9SEbcassDfkdy3v0cDcYouOO
         E5aAYot111lQ2bunTRC9nP8NH48dA89N+P2aWdwYii36zjViAMvG6tkDsu3MWTfLhyyS
         /eeNwbzE8tRwWgcSdVyQdFypSJMutIneegUIkiQvODel7WrqvUfihB/4faOwIAO9zJ+t
         DMtA==
X-Gm-Message-State: AC+VfDwFoxMKceU4oIwP9Cnd9KA7Vs5AGRHkga7sonvFGE5lyulSlS5d
        ZQi64ExCCuAu3Cslvwh5gsf4jkLvKr9okJE41c/QLg==
X-Google-Smtp-Source: ACHHUZ5Vt7DbqCG5icK+LBKYsRYQ7t53nm7nT80Zqm+kcEebiw5nDR0OjvWoVsnbVufGuAdQuciNJ9K2GX4dBEPqwA4=
X-Received: by 2002:a17:907:6d9d:b0:96f:cb23:daf6 with SMTP id
 sb29-20020a1709076d9d00b0096fcb23daf6mr11031279ejc.40.1684910103457; Tue, 23
 May 2023 23:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230523214127.4006891-1-pranavpp@google.com> <20230523214127.4006891-2-pranavpp@google.com>
In-Reply-To: <20230523214127.4006891-2-pranavpp@google.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 May 2023 08:34:52 +0200
Message-ID: <CAMGffE=mf_9ik6Sc19rQu_cC6rTacF6-Bd1xFYbgumoXnZsgVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: pm80xx: Add fatal error check for pm8001_phy_control()
To:     Pranav Prasad <pranavpp@google.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:41=E2=80=AFPM Pranav Prasad <pranavpp@google.com=
> wrote:
>
> From: Changyuan Lyu <changyuanl@google.com>
>
> This patch adds a fatal error check for the pm8001_phy_control() function=
.
>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm800=
1_sas.c
> index e5673c774f66..b153f0966e5d 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -167,6 +167,16 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, =
enum phy_func func,
>         pm8001_ha =3D sas_phy->ha->lldd_ha;
>         phy =3D &pm8001_ha->phy[phy_id];
>         pm8001_ha->phy[phy_id].enable_completion =3D &completion;
> +
> +       if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
> +               /* If the controller is in fatal error state,
> +                *  we will not get a response from the controller
> +                */
> +               pm8001_dbg(pm8001_ha, FAIL,
> +                               "Phy control failed due to fatal errors\n=
");
> +               return -EFAULT;
> +       }
> +
>         switch (func) {
>         case PHY_FUNC_SET_LINK_RATE:
>                 rates =3D funcdata;
> --
> 2.40.1.698.g37aff9b760-goog
>
