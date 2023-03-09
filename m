Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A246B2D16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCISq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCISqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:46:22 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87116F9EDE;
        Thu,  9 Mar 2023 10:46:21 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso2816837pjs.3;
        Thu, 09 Mar 2023 10:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678387581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QQXhhWy/WX7t9a+HyBFcajzfrIYmYwyOCh7SSy3BNE=;
        b=bVNyOQ89k5/Ns185lY+/SXtVZL2LquT42XxUewY3ZLyK290zFcDxcFgSHod0xWu/7j
         g3S5IyQpLYtkd1UTYF9XSBjaggAci+SKLYHFNR8+5KbfsEMKWUs7mur13EDh57yzAWdX
         ZpRATm+RZUbYFhI4yEa1DuMscwCUGQtwSqhBQr3aAEMcfD1MBOYP/ppdKCHnx9O1AinH
         fVNPvw8croW4y+Xln7CMjZQUfDsOHp9At+WAh/Qd0gpGeH0PIJ/qOyf0ILMKyUvNXXLL
         QL5TiZyE3Y/dMLWYosDgClubfGKhBvgGTgmw2x5y79jxeQb2K4blImtjGN1QEEu9DB7g
         2BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678387581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QQXhhWy/WX7t9a+HyBFcajzfrIYmYwyOCh7SSy3BNE=;
        b=dLpdL8LG303OdSJrwtBXnrY0B72BQF9b9mwWNgP70WpSVSqEkw1HGaOjOvX1bujqNC
         6A6EsnXC0d+55UIx7yEJ51k1QNmnpkz5R2JxSg89s41apbHyCx7htpEeUHPn90V199Bc
         3KUEe++8fJAKRkzlpDaFeuklwUXxkrM99DVvJHHkg7QuWW7TAaH7R+xgH/9pLStwATQC
         VkdiImrHQl3c6y1k+lpvegG/zv/vU2lqfq9imU3SGIyqWttf2i3aNhhJgWCpoj3oYVoA
         3agu9JVBjkq1V29ufJ/BK9zdqO26vzgWKaz+QfTV4wmuzzOsn26fbv7OFjwAwxkGXeWQ
         Qm7A==
X-Gm-Message-State: AO0yUKUUJ1HiVG6iRMTtmgCnvpc7K4AN4vxQpS9aCdUXOKtpeY/R6Cb4
        FlWu1mMiRS0IxWMJ3YvLtQ/Ugl31R1s+KwZWPRY=
X-Google-Smtp-Source: AK7set9Yd4KF1cKAXgU/qKkoIyWdYbYFyUt+1wTvRd2DJvggJ+jYl6d7heMCgT1M7TO94/bmDhILkSpuplZh/gFnt9c=
X-Received: by 2002:a17:902:cf46:b0:19e:f660:81d0 with SMTP id
 e6-20020a170902cf4600b0019ef66081d0mr2744589plg.12.1678387580889; Thu, 09 Mar
 2023 10:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20230309183812.299349-1-zyytlz.wz@163.com>
In-Reply-To: <20230309183812.299349-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 10 Mar 2023 02:46:09 +0800
Message-ID: <CAJedcCy-b5aCi33FV84WtOSQXOf3YrEGheOAKdBSzBHdv4bG4w@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla4xxx: Fix use after free bug in
 da9150_charger_remove due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
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

Sorry about the fix. This is a false positive which should be ignored.
The work will be posted on ha->dpc_thread. In qla4xxx_remove_adapter,
it will call destroy_workqueue(ha->dpc_thread);

Regards,
Zheng

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8810=E6=97=A5=
=E5=91=A8=E4=BA=94 02:38=E5=86=99=E9=81=93=EF=BC=9A
>
> In qla4xxx_probe_adapter, &ha->dpc_work is bound with
> qla4xxx_do_dpc. qla4xxx_post_aen_work may be called
> to start the work.
>
> If we remove the module which will call qla4xxx_remove_adapter
>   to make cleanup, there may be a unfinished work. The possible
>   sequence is as follows:
>
> Fix it by canceling the work before cleanup in qla4xxx_remove_adapter
>
> CPU0                  CPUc1
>
>                     |qla4xxx_do_dpc
> qla4xxx_remove_adapter|
> scsi_remove_host        |
> kfree(ha->host)         |
>                     |
>                     |   iscsi_host_for_each_session
>                     |   //use ha->host
> Fixes: afaf5a2d341d ("[SCSI] Initial Commit of qla4xxx")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.=
c
> index 005502125b27..d530cc853f43 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -9001,6 +9001,7 @@ static void qla4xxx_remove_adapter(struct pci_dev *=
pdev)
>         if (!pci_is_enabled(pdev))
>                 return;
>
> +       cancel_work_sync(&ha->dpc_work);
>         ha =3D pci_get_drvdata(pdev);
>
>         if (is_qla40XX(ha))
> --
> 2.25.1
>
