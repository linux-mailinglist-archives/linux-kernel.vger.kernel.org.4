Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8FD5F49E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJDTwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJDTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:52:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3B76B153
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:51:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a13so20307839edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7dAFZ0Dv74viOjab/o6SdVduwwf4JhWfgRlUOHBIw8s=;
        b=p1Rf07UZ6nQSCG9E2dB1vRGVLdfDE6pwCDbvEiwzmXiNm8hJsNPkwiXVEXblsgcTMO
         VD7elVi7Im7+BdHJKgOrYhC1xTHRHa6v75jV+Cj5KYkTaf2vqtTXohDgNbX5xUavrV0+
         oR+j5h3G4GJaGr+QCRnFqEuAr95AIRhOWnhGhQH3PG3JdXHqZ6uUcn0icJxqTCJ8TWSN
         W2NrDXPLKkw+1VBcphQbF2Q9Esii2ytqFi+A1ZJ8qPHSczRAp2pkyS3+7nRmsbflYICs
         DKyBZrrJfVWF6hfc0ESiJYhiqC3TGVY99zj+NP/9rudqbBJeXwvQ8/mLhg+Zr6/c9SFU
         Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7dAFZ0Dv74viOjab/o6SdVduwwf4JhWfgRlUOHBIw8s=;
        b=VGDQuP2uV2wAhGoUGpDbvMrWSWbFyqukCm9L+dVlne0UatxCaILLSmDL6+VUE0y2KY
         hzEnNSilFNy04LIOytTZ5Ei9Q+sqZfmAzsKgkZCZZQLvdQuaulaSJZh5+eoUjz9t98bD
         XTbmVkiLbIjS3hF/U8v8I2JRJKI/mCl5rd2mSMO62Gy6MrZR4lRnkWW+Dt5BMkj7Tku7
         +2lmNWq6OXZqNE0bszh0luXoResOxFiHpsFzaR9fS6D17qKa84ZXB+2xSDB4n4P9rrZk
         nIMKytMMuTSck6SOrxI81qVQmT8PvPKdl/QnP+bqhlGI2ydeoTVfDjwLxf2OzI3LIbNO
         8F3Q==
X-Gm-Message-State: ACrzQf0L2XLIEaV9LWKcXCpzgIVNUjtEdggIA5dVOPGWSs+UGwCDODES
        adrQRGkXBCuGAAW4uwhsQuhHuSZW+BklYbvgwX+czw==
X-Google-Smtp-Source: AMsMyM7tp161kPhb3d8RhOwSScAFsLy++rlzF6dUMDcpt01r082kRDSLrp9nYObjuNioSwTIh1BPKNN1kU8tq6QyjKY=
X-Received: by 2002:a05:6402:40d1:b0:44f:e974:f981 with SMTP id
 z17-20020a05640240d100b0044fe974f981mr25889439edb.222.1664913115282; Tue, 04
 Oct 2022 12:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221004174018.3319712-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20221004174018.3319712-1-arnaud.pouliquen@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 4 Oct 2022 13:51:44 -0600
Message-ID: <CANLsYkw357ajx8BnbykKiVD+BVv21VwAaYjvFDwqbvEw7cBDHQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: virtio: Fix warning on bindings by removing
 the of_match_table
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 at 11:40, Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> The checkpatch tool complains that "virtio,rproc" is not documented.
> But it is not possible to probe the device "rproc-virtio" by declaring
> it in the device tree. So documenting it in the bindings does not make
> sense.
> This commit solves the checkpatch warning by suppressing the useless
> of_match_table.
>
> Fix-suggested-by: Rob Herring <robh@kernel.org>

I'll change that for "Suggested-by:"

> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index a29e3b8ff69c..26a7d8c498bc 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -593,17 +593,11 @@ static int rproc_virtio_remove(struct platform_device *pdev)
>  }
>
>  /* Platform driver */
> -static const struct of_device_id rproc_virtio_match[] = {
> -       { .compatible = "virtio,rproc" },
> -       {},
> -};
> -
>  static struct platform_driver rproc_virtio_driver = {
>         .probe          = rproc_virtio_probe,
>         .remove         = rproc_virtio_remove,
>         .driver         = {
>                 .name   = "rproc-virtio",
> -               .of_match_table = rproc_virtio_match,

Yes, this is quite simple and slick.  Rob - is this what you meant earlier on?

>         },
>  };
>  builtin_platform_driver(rproc_virtio_driver);
> --
> 2.24.3
>
