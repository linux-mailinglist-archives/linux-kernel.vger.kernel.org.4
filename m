Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5E70D145
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjEWCcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjEWCcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:32:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938CDE9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:32:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3094871953bso3529490f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684809136; x=1687401136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy1fEYOjdw9GRZ4W/gqIzqsxA2jpxKh6oxmTgbjHp2I=;
        b=0JwIPCtNAGkP0yFDPIEz1ckdt4yootZqk+wiYVLMTjGXcSl7O01SdXUNiNRVnm42mD
         MvUv9J8KbP5KnILjvIa2C3gwHjEucdg5PlJmFblioKxv1GXe1/g5eRtOPvgkd1TBz8tx
         ckrXkabrcYQ6KAHhuCEDq22K00yKcM0ADcdmsLvt+aEETGkBAGF9hFMd2EGs0hRCxe07
         HesiRJhSRJZOVsa0Z4CBTHNuiZNNpw5es5B/ePOn63VfQpbAEuIqvd+oSLcvh029lxW7
         lhJZpBtLPKb5r4m5o4Bm1sU+VlDfvX0d/oZv71v77a9vTzMS1sSHnOpbLyTBVrMtaGtW
         bCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684809136; x=1687401136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy1fEYOjdw9GRZ4W/gqIzqsxA2jpxKh6oxmTgbjHp2I=;
        b=mEPE7G8rRlwmydC53RBS0yYBuFFTKOt3n9UdUfFlWaMCpvIq2phlHjcAzkMTXyGi4D
         ID+i9MDTTVDIgxFGvz+z2bP1wd1Im5tleEx3+3mIbM4x+oabhc5UcMaczwiMutv9cIGd
         mJo1nvVxGYA7fo+BsZmepomST6qxWFxXxYdbRb6tHuIoWS2U2KmV4+p8edxZ4KOJeSd1
         F/eFscTJSUgbXsyaCa1lGnG/lDfcYT1bi8I010S/aBZWYL528eqjQfDkhtHLQ2cymar2
         8hr8skYnH5Fvtvrbm69hw3a1ixOqltqw7BHJPQ3gep7qSZXfDwmzn0oTTMbe3GfayTii
         Mx4Q==
X-Gm-Message-State: AC+VfDz5ut4f7RMaJX447UXcy3J/gUQdUszXn5Hbeak+MfqM/cZJbk5u
        +37MTfRWEDcifk1a7dzbWEYHM9zLoQ4Gks/nNkUIiEaDEXXanVagSgc=
X-Google-Smtp-Source: ACHHUZ7P5cOtJ5G1n3f/+I3nC83p/qIPzpIoOw6MEvl2GQi+Sl82dBsdIOXmtafJDiaOi4usXg3TH7IrlGlVsxGBbqY=
X-Received: by 2002:a5d:5448:0:b0:307:83a4:3d3b with SMTP id
 w8-20020a5d5448000000b0030783a43d3bmr7054212wrv.54.1684809136467; Mon, 22 May
 2023 19:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Mon, 22 May 2023 19:32:05 -0700
Message-ID: <CAB=BE-TQsa+D9WZ01Zi_ByAjaLMcHGZBXAuGzmRSEdgeio7UJA@mail.gmail.com>
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are enabled
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 2:21=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> As Sandeep shown [1], high priority RT per-cpu kthreads are
> typically helpful for Android scenarios to minimize the scheduling
> latencies.
>
> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
> EROFS_FS_PCPU_KTHREAD.
>
> Also clean up unneeded sched_set_normal().
>
> [1] https://lore.kernel.org/r/CAB=3DBE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8Gb=
O6wyUqFneQ@mail.gmail.com
> Cc: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/Kconfig | 1 +
>  fs/erofs/zdata.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 704fb59577e0..f259d92c9720 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
>  config EROFS_FS_PCPU_KTHREAD_HIPRI
>         bool "EROFS high priority per-CPU kthread workers"
>         depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
> +       default y
>         help
>           This permits EROFS to configure per-CPU kthread workers to run
>           at higher priority.
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 92f3a01262cf..3ba505434f03 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -367,8 +367,6 @@ static struct kthread_worker *erofs_init_percpu_worke=
r(int cpu)
>                 return worker;
>         if (IS_ENABLED(CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI))
>                 sched_set_fifo_low(worker->task);
> -       else
> -               sched_set_normal(worker->task, 0);
>         return worker;
>  }
>
> --
> 2.24.4
>
Looks good!

Reviewed-by: Sandeep Dhavale <dhavale@google.com>
