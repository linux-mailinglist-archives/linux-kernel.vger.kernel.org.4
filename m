Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D2C742AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjF2QeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjF2QeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:34:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8181830DF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:34:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313f1085ac2so878654f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688056442; x=1690648442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LqHUnlso1hdG3VJ+pTodHLUrLXzUMRTfH8n86mBkWGM=;
        b=saB8+ZA/oTbFO22dlhNSOJr/pdy2C0eJ7wQf/+uf2obs9efHuHzrvZpqTi3DGfHlXl
         VQ//6jSxIUjflGsQ0rUwQwp9cLVWKhU7QC4C7eRaMPUiCY9zWAgAoAdLTLF2vEG5kFIt
         TAbyonrAC/vbfB2cICF3ivWy89e/CnJzt2Xy2VOwbPYDVqk7lzLOWcJbUtwdtZdtqAvU
         Y2grNnXuaH1qlKeRMIq3SfTl4whEaENe0k71GLGfVgxoEDk0W59mBfN6ckeY281FZgRz
         t3bdJ0o0T+ZcVKTZoGLlzGTrwhTK1mKX6jOMNuIEpmkQDCOSprERyKEnmAcTzpi8lt4E
         Mwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056442; x=1690648442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqHUnlso1hdG3VJ+pTodHLUrLXzUMRTfH8n86mBkWGM=;
        b=Bk2rEFm2veUeBSfXTqUGPtNg60T9fbRCM4m3PVcLYJeyuvAw/7bfzw8ez78odn9HfN
         TZiA6WblACQjx2yE30ESficOLFZZjpXhym1dfM5AnWQ8484HzegqHNEfQSXOcw1uiUx9
         YJ23P3eqpSUDW7VcZabJURldgWDrYKBQw3ajhOBmdi5N0mh97Q0tIKXUj49uc78GtXfA
         +LQLLcps4gRVCsJ9l5udFNd4XdjZE0E70oGJFvqIKVhQ0+WzJbNpoaZT3SUHBWu4qWEz
         fmsz/FMcTZ0l9rE1wPtWYHvbwjaWaq4JRKEiJPvn+8vb8m2wRjeEIvzMh9BVHAQBF2hL
         GJhA==
X-Gm-Message-State: ABy/qLbJF8AC7fytB3rwQeCGy+BHf6/Pq9JpFBnrppzsfEg5hM93Aof8
        Nsvp5GC0t0AeRHB59W+B1bswbD2Jfk/bqlYMA5izTQ==
X-Google-Smtp-Source: APBJJlH/H/FYY6FeQt1Oek53lXyD6oByP8yaDCmrg1kMkO65pcFhmlQTa2fqTCAXe9fMg23H4mNeE7N6tPZ6UxLbdbk=
X-Received: by 2002:adf:ef0c:0:b0:314:1de3:f9e0 with SMTP id
 e12-20020adfef0c000000b003141de3f9e0mr122057wro.12.1688056441962; Thu, 29 Jun
 2023 09:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230629093327.3376308-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230629093327.3376308-1-peng.fan@oss.nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 29 Jun 2023 10:33:51 -0600
Message-ID: <CANLsYkzek+hb6_eRb-wN3qQfV+WCDqVHd3q_H03VR+k7NRkF1Q@mail.gmail.com>
Subject: Re: [PATCH V3] remoteproc: imx_rproc: iterate all notifiyids in rx callback
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        daniel.baluta@nxp.com, iuliana.prodan@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 03:28, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The current code only supports one vdev and a single callback,
> but there are cases need more vdevs. So iterate all notifyids to
> support more vdevs with the single callback.
>

Much better - I'll pick this up when rc2 comes out.

Thanks,
Mathieu

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V3:
>  Drop debug message in callback
>
> V2:
>  Update commit log
>
>  drivers/remoteproc/imx_rproc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index f9874fc5a80f..986d3db81596 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -725,13 +725,22 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>         return 0;
>  }
>
> +static int imx_rproc_notified_idr_cb(int id, void *ptr, void *data)
> +{
> +       struct rproc *rproc = data;
> +
> +       rproc_vq_interrupt(rproc, id);
> +
> +       return 0;
> +}
> +
>  static void imx_rproc_vq_work(struct work_struct *work)
>  {
>         struct imx_rproc *priv = container_of(work, struct imx_rproc,
>                                               rproc_work);
> +       struct rproc *rproc = priv->rproc;
>
> -       rproc_vq_interrupt(priv->rproc, 0);
> -       rproc_vq_interrupt(priv->rproc, 1);
> +       idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
>  }
>
>  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
> --
> 2.37.1
>
