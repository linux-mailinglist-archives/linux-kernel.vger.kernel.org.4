Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D56D9148
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbjDFINs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbjDFINl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:13:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA105242
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:13:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t10so147192984edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680768815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu1ZIi7tBRHWfqxhCGVkyOO/jfdqs/J/p+pYOITBDkU=;
        b=ZsSbhJJ3pKekXGH3l1kAv86u9/s8jGrtjbPMAcs/BEyLEXHZMzE0rtLj9YohhlHY5Z
         F53XyvF8tiFcmLhi5c82QMmvn7AhGiLh/LmvM4vR4JgeQs+i4e8kXDvQp/pjelPyTCGL
         R70lzADyRmjduvx89W327EjXOudBurv1gy/tDrijgDZEu+FqpyIpUUODwkbv9jKt/PHG
         SXhWEL6+1j+oCOtoWHgkhFlK+LHW5ot53HB5b+M/APYoChQ8vuKAzeyrL0gelsOyeoxj
         8QfsrhzA8EdQGWh6gXZzkKnpJ8UB4VsBvQupIzu+h8a0JsmYT8dAlfTdXMhXBCGD8GrN
         G+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu1ZIi7tBRHWfqxhCGVkyOO/jfdqs/J/p+pYOITBDkU=;
        b=tHqXH8gTEaNxTHfIsrtzm3upzpSC6mapslBCB6W8M/UPONIyr6MUaSci07Zoht5ZLB
         qa+fvmdam31lTkzkrRMKYkPOOM6xtGXjWu3qXP0mZZmlnh2Fi/ho+ziysurscYcbz3t4
         Vc/m9zzf8sFAJ3+Hvz8ClNkR0KMLZUEdoQOI0Fodb159JXfhlYfy5a563UW79gnZUy0K
         aAlePvOjd6mNdZ37CvFdo7sjFl9juaQMlG67EGgQ2n/j0RMLhBFOXuMI3I8q69StKJ3p
         Z0zEguTS27m8AooUy3JFJcbTFnwbN1k8Tizqs1l0UUMDgmBChHEguNfWzWbsLFju+7lX
         NbiQ==
X-Gm-Message-State: AAQBX9dpmpk44SE+mT93siYVOYR6Krbdj+5tkAhJG+IPCpL1NN4zZoMR
        LLQeYI2lmVJzJwmvjTOgn2wm8Hu6wAZFmE5lzAHTQH73gSI=
X-Google-Smtp-Source: AKy350blbuwNZejN6L/nUpeEwCHeQxxdE8X6OS0Ll1ser07oYVVQatoB0SiGSLUgyWopUY6f6TUg0bPKIo9QxXrzPI8=
X-Received: by 2002:a17:906:1619:b0:878:4a24:1a5c with SMTP id
 m25-20020a170906161900b008784a241a5cmr2824172ejd.6.1680768814664; Thu, 06 Apr
 2023 01:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230329123420.34641-1-tomas.krcka@gmail.com>
In-Reply-To: <20230329123420.34641-1-tomas.krcka@gmail.com>
From:   Tomas Krcka <tomas.krcka@gmail.com>
Date:   Thu, 6 Apr 2023 10:13:23 +0200
Message-ID: <CAOtnYZPfy3AuB-B2O_VCFy9Amt18PRCg+7f2tvKKYMrwZThtdg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Acknowledge pri/event queue overflow
 if any
To:     will@kernel.org
Cc:     Tomas Krcka <krckatom@amazon.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 29. M=C3=A4rz 2023 um 14:34 Uhr schrieb <tomas.krcka@gmail.com>:
>
> From: Tomas Krcka <krckatom@amazon.de>
>
> When an overflow occurs in the PRI queue, the SMMU toggles the overflow
> flag in the PROD register. To exit the overflow condition, the PRI thread
> is supposed to acknowledge it by toggling this flag in the CONS register.
> Unacknowledged overflow causes the queue to stop adding anything new.
>
> Currently, the priq thread always writes the CONS register back to the
> SMMU after clearing the queue.
>
> The writeback is not necessary if the OVFLG in the PROD register has not
> been changed, no overflow has occured.
>
> This commit checks the difference of the overflow flag between CONS and
> PROD register. If it's different, toggles the OVACKFLG flag in the CONS
> register and write it to the SMMU.
>
> The situation is similar for the event queue.
> The acknowledge register is also toggled after clearing the event
> queue but never propagated to the hardware. This would only be done the
> next time when executing evtq thread.
>
> Unacknowledged event queue overflow doesn't affect the event
> queue, because the SMMU still adds elements to that queue when the
> overflow condition is active.
> But it feel nicer to keep SMMU in sync when possible, so use the same
> way here as well.
>
> Signed-off-by: Tomas Krcka <krckatom@amazon.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index f2425b0f0cd6..7614739ea2c1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -152,6 +152,18 @@ static void queue_inc_cons(struct arm_smmu_ll_queue =
*q)
>         q->cons =3D Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
>  }
>
> +static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
> +{
> +       struct arm_smmu_ll_queue *llq =3D &q->llq;
> +
> +       if (likely(Q_OVF(llq->prod) =3D=3D Q_OVF(llq->cons)))
> +               return;
> +
> +       llq->cons =3D Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
> +                     Q_IDX(llq, llq->cons);
> +       queue_sync_cons_out(q);
> +}
> +
>  static int queue_sync_prod_in(struct arm_smmu_queue *q)
>  {
>         u32 prod;
> @@ -1577,8 +1589,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, vo=
id *dev)
>         } while (!queue_empty(llq));
>
>         /* Sync our overflow flag, as we believe we're up to speed */
> -       llq->cons =3D Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
> -                   Q_IDX(llq, llq->cons);
> +       queue_sync_cons_ovf(q);
>         return IRQ_HANDLED;
>  }
>
> @@ -1636,9 +1647,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, vo=
id *dev)
>         } while (!queue_empty(llq));
>
>         /* Sync our overflow flag, as we believe we're up to speed */
> -       llq->cons =3D Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
> -                     Q_IDX(llq, llq->cons);
> -       queue_sync_cons_out(q);
> +       queue_sync_cons_ovf(q);
>         return IRQ_HANDLED;
>  }
>
> --
> 2.39.2
>

ping for this patch ...
