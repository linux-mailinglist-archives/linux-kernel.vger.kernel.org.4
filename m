Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DABE5BBD6D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIRK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIRK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:29:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF05255A4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 847BCB80CA2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DD2C433D6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663496956;
        bh=72guKqCsIfZJ8cVgibwrY4byAvvWT+yvv6Sk3dPWw2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jbk2NbYP7PhaVKcAwgQNQP54q6HdbPf2tyK8onehCmqEbeoeTnEBTcvoCu5IKn/WY
         HIUscHaAcOFYefH17tMh6KSond3thAZoYg843SJplP5c9W3vh/Nn4bxBJU4Lf9zvGy
         TcDm0yDR46h82Hsq5YPQt4ccrSFICWG5u/BCY8gv15TJ/iqQz0J+G7TQa8jAsJ1ZZJ
         vIrLJVXsveEP9gSdxSI9wU99aGS+Gq4AtJh2O7xqM95lYQ30poshuHjTJsH6e3+5AM
         QnC+IF9hoXRebu4Vf6ihE69EeoPcCjG82pOBjTLKTEnrf9jlo3egItl14Sc5/KSfV5
         274OfvMBapXBw==
Received: by mail-io1-f45.google.com with SMTP id b23so20653705iof.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:29:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf0z5GTQGYvRqSqG7PxYbu2iqLa63Ud+Yl1aocK7wK86zKlJuTBM
        MbfZO1+gtkwh9kZOaAhVjkIBs08YiaG0IFYFSC4=
X-Google-Smtp-Source: AMsMyM4Mfpf+Z37FkGukYAtjRoUrS44dZRamXkAP2J3ud4sOgMmrwb413qOkf02l0Mf3+73p7sS7KDWExf0SiNQrIms=
X-Received: by 2002:a05:6638:16cf:b0:35a:576b:6e33 with SMTP id
 g15-20020a05663816cf00b0035a576b6e33mr5781351jat.159.1663496955410; Sun, 18
 Sep 2022 03:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220913030714.974259-1-yangyingliang@huawei.com>
In-Reply-To: <20220913030714.974259-1-yangyingliang@huawei.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 18 Sep 2022 13:28:48 +0300
X-Gmail-Original-Message-ID: <CAFCwf12hQqWjVr==31hM4MjhVd35KwjQdRYY_qnzBNcV1PbQjA@mail.gmail.com>
Message-ID: <CAFCwf12hQqWjVr==31hM4MjhVd35KwjQdRYY_qnzBNcV1PbQjA@mail.gmail.com>
Subject: Re: [PATCH -next v2] habanalabs/gaudi2: fix free irq in error path in gaudi2_enable_msix()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 6:00 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Add two variables to store completion irq and event queue irq. And add
> a new lable to free event queue irq in error path in gaudi2_enable_msix().
I'm sorry, I already pushed a fix to the bug (I didn't get any reply
from you for more than a week so I didn't know if you are going to fix
it).
Oded

>
> Fixes: d7bb1ac89b2f ("habanalabs: add gaudi2 asic-specific code")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   print correct irq in error prints.
> ---
>  drivers/misc/habanalabs/gaudi2/gaudi2.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> index 98336a1a84b0..8f521d8a1aa1 100644
> --- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
> +++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> @@ -3518,6 +3518,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>         struct asic_fixed_properties *prop = &hdev->asic_prop;
>         struct gaudi2_device *gaudi2 = hdev->asic_specific;
>         int rc, irq, i, j, user_irq_init_cnt;
> +       int completion_irq, event_queue_irq;
>         irq_handler_t irq_handler;
>         struct hl_cq *cq;
>
> @@ -3532,26 +3533,28 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>                 return rc;
>         }
>
> -       irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
> +       completion_irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
>         cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_CS_COMPLETION];
> -       rc = request_irq(irq, hl_irq_handler_cq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
> +       rc = request_irq(completion_irq, hl_irq_handler_cq, 0,
> +                        gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
>         if (rc) {
> -               dev_err(hdev->dev, "Failed to request IRQ %d", irq);
> +               dev_err(hdev->dev, "Failed to request IRQ %d", completion_irq);
>                 goto free_irq_vectors;
>         }
>
> -       irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
> -       rc = request_irq(irq, hl_irq_handler_eq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_EVENT_QUEUE),
> -                       &hdev->event_queue);
> +       event_queue_irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
> +       rc = request_irq(event_queue_irq, hl_irq_handler_eq, 0,
> +                        gaudi2_irq_name(GAUDI2_IRQ_NUM_EVENT_QUEUE),
> +                        &hdev->event_queue);
>         if (rc) {
> -               dev_err(hdev->dev, "Failed to request IRQ %d", irq);
> +               dev_err(hdev->dev, "Failed to request IRQ %d", event_queue_irq);
>                 goto free_completion_irq;
>         }
>
>         rc = gaudi2_dec_enable_msix(hdev);
>         if (rc) {
>                 dev_err(hdev->dev, "Failed to enable decoder IRQ");
> -               goto free_completion_irq;
> +               goto free_event_queue_irq;
>         }
>
>         for (i = GAUDI2_IRQ_NUM_USER_FIRST, j = prop->user_dec_intr_count, user_irq_init_cnt = 0;
> @@ -3582,9 +3585,11 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>
>         gaudi2_dec_disable_msix(hdev, GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM + 1);
>
> +free_event_queue_irq:
> +       free_irq(event_queue_irq, &hdev->event_queue);
> +
>  free_completion_irq:
> -       irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
> -       free_irq(irq, cq);
> +       free_irq(completion_irq, cq);
>
>  free_irq_vectors:
>         pci_free_irq_vectors(hdev->pdev);
> --
> 2.25.1
>
