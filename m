Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931FB6D830F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjDEQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjDEQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:07:48 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B815FCF;
        Wed,  5 Apr 2023 09:07:46 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j7so43177074ybg.4;
        Wed, 05 Apr 2023 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680710865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THmN70ARi7g7nOYqZGnyM9XC7McNixSrT5VySL2L1XY=;
        b=Ynq4GiK2SqmRrZlnbjGWooOzINuQI2kyGH0oZTjLcYpR8Rs6aNftMp8N3eW+t/dze4
         OxZTEFcOklqlcLYKx79sZyHbFMBtgONxh5NkuXQGiHsY0F2DwOWWGZn0pboZLEEq8Aa4
         83BKvuSCI+wDcqh4EjP63C5Li9q0E5JBjd8x0ZQxdYo8ZmEnqN15nKu8R+ZinzrwDgUL
         xxcv7QVQWIA2qOlmPYwm+CX/InDQKN/fACdhJMxkNbkfhdYF3eJGIdLNFcfb6+2zEypL
         ATdyu90rsv42mRDJ7Bd2xr2bb4rRJK677foENmhz467SujK7zqTYyxZUp2FyqtEagX0w
         LNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THmN70ARi7g7nOYqZGnyM9XC7McNixSrT5VySL2L1XY=;
        b=aOQgwbPvqS5yKqtA6jfCMvGfgxiP4M37QpMBrEUFAogusBQsfCt02p09xxq7eGciOP
         dRAvTO5iEH0PQW1/nzeRpvwyIN2z3qbwWoAnpFgxPHg481dxO+2qrB9c7dHIupBB6yif
         TZVXdIaVPj28q0IhMq5I4mc//rov0HeO38sdlp1n3RHIGypzUYpkri1cGC4v0jI+OGuY
         98CknoU34cwDvE/cToIwLnEsHCn81YmKnKYtUEmB1a7I8m+Q7ksfPonzfrBA4fmNhe1D
         k+mkKFbV+3z733GDNCEhrR7OmatOYUgoI7XX6pDPrLB9bb7X6Mb5+F78My+W89ASHD8p
         LMNw==
X-Gm-Message-State: AAQBX9cZWIV0qNrY8SAl1/6wClqc7J6o3S5Jqwz3wzfpugk97MFLaSBP
        uZWxgYmyOZEy5TqMjh9mGKxnOLrjhaVsDT4GgHjkJBRgP4g=
X-Google-Smtp-Source: AKy350br5ntxgbSUHc424ssdCh8Ae26wHN0Kzb3Z0nBg8xN62+VacIWHvdlWqbfWl6gLgodcuHdyG3i46Pp7y5mcPDY=
X-Received: by 2002:a25:c401:0:b0:b76:ae61:b68b with SMTP id
 u1-20020a25c401000000b00b76ae61b68bmr3849390ybf.5.1680710865451; Wed, 05 Apr
 2023 09:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230404072133.1022-1-lishuchang@hust.edu.cn>
In-Reply-To: <20230404072133.1022-1-lishuchang@hust.edu.cn>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Wed, 5 Apr 2023 09:07:34 -0700
Message-ID: <CABPRKS9FDRyVwvO-sixFJ0uT64ua1s3r9UDNV_raD9bw+WN6HQ@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: lpfc: fix ioremap issues in 'lpfc_sli4_pci_mem_setup'
To:     lishuchang@hust.edu.cn
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks okay.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Thanks,
Justin

On Tue, Apr 4, 2023 at 12:24=E2=80=AFAM <lishuchang@hust.edu.cn> wrote:
>
> From: Shuchang Li <lishuchang@hust.edu.cn>
>
> When if_type equals to zero and pci_resource_start(pdev, PCI_64BIT_BAR4)
> returns false, drbl_regs_memmap_p is not remapped.This passes a NULL
> pointer to iounmap(), which can trigger a WARN() on certain arches.
>
> When if_type equals to six and pci_resource_start(pdev, PCI_64BIT_BAR4)
> returns true, drbl_regs_memmap_p may has been remapped and
> ctrl_regs_memmap_p is not remapped. This is a resource leak and passes
> a NULL pointer to iounmap().
>
> To fix these issues, we need to add null checks before iounmap(), and
> change some goto lables.
>
> Fixes: 1351e69fc6db ("scsi: lpfc: Add push-to-adapter support to sli4")
> Signed-off-by: Shuchang Li <lishuchang@hust.edu.cn>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.=
c
> index 4f7485958c49..ed75230b0209 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -12026,7 +12026,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
>                                 goto out_iounmap_all;
>                 } else {
>                         error =3D -ENOMEM;
> -                       goto out_iounmap_all;
> +                       goto out_iounmap_ctrl;
>                 }
>         }
>
> @@ -12044,7 +12044,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
>                         dev_err(&pdev->dev,
>                            "ioremap failed for SLI4 HBA dpp registers.\n"=
);
>                         error =3D -ENOMEM;
> -                       goto out_iounmap_ctrl;
> +                       goto out_iounmap_all;
>                 }
>                 phba->pci_bar4_memmap_p =3D phba->sli4_hba.dpp_regs_memma=
p_p;
>         }
> @@ -12069,9 +12069,11 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
>         return 0;
>
>  out_iounmap_all:
> -       iounmap(phba->sli4_hba.drbl_regs_memmap_p);
> +       if (phba->sli4_hba.drbl_regs_memmap_p)
> +               iounmap(phba->sli4_hba.drbl_regs_memmap_p);
>  out_iounmap_ctrl:
> -       iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
> +       if (phba->sli4_hba.ctrl_regs_memmap_p)
> +               iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
>  out_iounmap_conf:
>         iounmap(phba->sli4_hba.conf_regs_memmap_p);
>
> --
> 2.25.1
>
