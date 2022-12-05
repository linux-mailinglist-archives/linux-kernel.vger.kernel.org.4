Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286DB64395B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiLEXQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiLEXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:16:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520AB1C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:16:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27B61B81202
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 23:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4896C433C1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670282173;
        bh=tTj6xlqwZkkawn6eAfGzgzhH58kjDBepMPSTaEkO1+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZY/GeL7d56Z67JgEQuUyLY6Vqk/2mg/lRDQfmu9taP+IPjTF2dez5CemaGs4DPpYL
         CgyKfBXI+PqKJRC83bS6qkJfpHd/OzMbTBFn3+l80OxFvLe0BK1sPfEeZUifZZyEdE
         rvpR/Kt12dVHkYg+waOl98VivJ0ehO/vGyL6mU09EoTvIIemI5onOJFhyncIVpU1i2
         JtoJ5GkzOVP26LCAAfv3dEFLvoxqkzmuJek6SYtu6LGcP6cvJ9AYBdKzaMobtt98b4
         sfY87Zjv0psr4D33dFMKY8U9uGj8l5ivstsDoDLky8TPELLx6Nf2RynaYJE/JXrZeD
         PQTjYxbdOYcWg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so15370240fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:16:13 -0800 (PST)
X-Gm-Message-State: ANoB5pl+jApMxs/ibd5sdcvYPP6Ch/5eYFyboU/oCdYetQ7eMfqqff+F
        Bxk/Z4PKEHjkCrmHj79B1qjYYMwTxkjKf4kg4g==
X-Google-Smtp-Source: AA0mqf7VhWuGDHZgIsW7euFPqGB81veoXwRhbmr7m/MxNUsi4J+BsvBrNEz7hgNDnExfLJ6wGZ3fogI8TRhYee8qtkQ=
X-Received: by 2002:a05:6870:b00f:b0:13a:f4fd:7d81 with SMTP id
 y15-20020a056870b00f00b0013af4fd7d81mr39025319oae.139.1670282172886; Mon, 05
 Dec 2022 15:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20221125-mtk-mailbox-v3-0-c4b635052b65@chromium.org>
In-Reply-To: <20221125-mtk-mailbox-v3-0-c4b635052b65@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 6 Dec 2022 07:16:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY__8uYdjFHGTrtq-ZTqvt7gaXeEKv9T3X0e=v4iZ52EE9g@mail.gmail.com>
Message-ID: <CAAOTY__8uYdjFHGTrtq-ZTqvt7gaXeEKv9T3X0e=v4iZ52EE9g@mail.gmail.com>
Subject: Re: [PATCH v3] mailbox: mtk-cmdq: Do not request irq until we are ready
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Ribalda <ribalda@chromium.org> =E6=96=BC 2022=E5=B9=B411=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A8:59=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> If the system comes from kexec() the peripheral might trigger an IRQ
> befoe we are ready for it. Triggering a crash due to an access to
> invalid memory.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> To: Jassi Brar <jassisinghbrar@gmail.com>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> ---
> Changes in v3:
> - Rebase on top of https://patchwork.kernel.org/project/linux-mediatek/pa=
tch/20221102100736.37815-1-angelogioacchino.delregno@collabora.com/
> - Link to v2: https://lore.kernel.org/r/20221125-mtk-mailbox-v2-0-886f70c=
7173c@chromium.org
>
> Changes in v2:
> - I have managed to repro a different panic. Moving the irq enabling to t=
he very end of probe.
> - Link to v1: https://lore.kernel.org/r/20221125-mtk-mailbox-v1-0-2e3ee12=
0850c@chromium.org
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index a460ee26eb11..b18d47ea13a0 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -569,12 +569,6 @@ static int cmdq_probe(struct platform_device *pdev)
>         }
>
>         cmdq->irq_mask =3D GENMASK(cmdq->pdata->thread_nr - 1, 0);
> -       err =3D devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_S=
HARED,
> -                              "mtk_cmdq", cmdq);
> -       if (err < 0) {
> -               dev_err(dev, "failed to register ISR (%d)\n", err);
> -               return err;
> -       }
>
>         dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
>                 dev, cmdq->base, cmdq->irq);
> @@ -641,6 +635,13 @@ static int cmdq_probe(struct platform_device *pdev)
>
>         cmdq_init(cmdq);
>
> +       err =3D devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_S=
HARED,
> +                              "mtk_cmdq", cmdq);
> +       if (err < 0) {
> +               dev_err(dev, "failed to register ISR (%d)\n", err);
> +               return err;
> +       }
> +
>         return 0;
>  }
>
>
> ---
> base-commit: 1642107db81361b4339643eb90af4839e2cf229f
> change-id: 20221125-mtk-mailbox-ba6cbd1d91b6
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>
