Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6236B282E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjCIPF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjCIPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:04:48 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5532CEDB4D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:02:52 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id d6so1228832pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpG+8TjRKU1Xq1b7ChN1vz1PZS008U/FxhApKNmqYlY=;
        b=ELYbTvyRDRvOH8dgBQ/Fwx17+m9R3aqgz5pT7V7fAkZJsA+oV5WiXFMZLcOenBBcbo
         Iomz7JdnKuw/g52XHENDsg9hzunSk4MHravqG2QuI/iiHrQirjr8y73m7ZbBXY/o7vLg
         qvwNTEDQsWU9Of4q0G3fEWJe30V6onvW2a3+JTt/V7Y4xmemTnj3zMSH2yh0yqy6v2Cj
         a/57s24pd09PXcbhcLZVSXqhgklg7hVV+a1VfUTBgAPlfhwUzkjH5KHMImC7zUxFSqTO
         FQHaGZXufx854DG2kV0GcvrLGNTYFThFRHLCUDrtkIwO46cukE2cBALux/qu3ME/ggcP
         lUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpG+8TjRKU1Xq1b7ChN1vz1PZS008U/FxhApKNmqYlY=;
        b=uK1Hj0Ovb9ssVvUQnyM2onHGnK6crttmnb80exqFwwYILpm+J56LE/cVmGwK08DcqW
         A6lxHwmIVqyKXPFthBIgHPugdcnKjSAJLwMks1l294rGX6hixcR/LFjFcgJPGFuU9HRx
         6YNZYx3r7mJwen0g6h0/IsiKTdAo7GbHl8QTz4kKTWXotGzBrEINeH9I9NxSET7ZAVHu
         OfRU2z7oEXE9OxOCWa6uPGRtYQaqdJluh7LA919mibUR0g7Qcv51+mrorgjcc5MZna4w
         oufbD8yEa9R1SwiabkJMJVBiSI+Za3I+kCknUP42s9w/Ws94BjLE8viaM5aH02f7rySZ
         g9cQ==
X-Gm-Message-State: AO0yUKV99LzqijBMKKVslQc4wotPKwvzphGe+YqpLwsq8iw8Sw0vaQxS
        B7O0ucaxllU65jPYMG+STJqgeb26R72/xPnzzl6YLA==
X-Google-Smtp-Source: AK7set/Pu4XGzKcyUzu0ET/xIBNGm/Mc7zvqzaKEVvMGZxTLOsJ3vWQd5u10L1Z/1FJ77TF3nXXUVY+1mwvJkbrIn10=
X-Received: by 2002:a63:bc02:0:b0:4fb:d6b9:abea with SMTP id
 q2-20020a63bc02000000b004fbd6b9abeamr7692841pge.5.1678374171737; Thu, 09 Mar
 2023 07:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20230307024646.10216-1-william.qiu@starfivetech.com> <20230307024646.10216-3-william.qiu@starfivetech.com>
In-Reply-To: <20230307024646.10216-3-william.qiu@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 16:02:15 +0100
Message-ID: <CAPDyKFp204LOmo9rD7DS5hE=s2jHuFfgsaj05MRzdTKNrscWWQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mmc: starfive: Add initialization of prev_err
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 03:46, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Add a incremental updates to fix a bug that prev_err is uninitialized.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reported-by: Dan Carpenter <error27@gmail.com>

I took the liberty of updating the commit message a bit, to try to
further clarify things. Moreover, future wise, let's use the prefix,
"mmc: dw_mmc-starfive" for the commit message header, to be consistent
with the other dw_mmc drivers.

So, applied for fixes and by adding a fixes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-starfive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
> index 40f5969b07a6..dab1508bf83c 100644
> --- a/drivers/mmc/host/dw_mmc-starfive.c
> +++ b/drivers/mmc/host/dw_mmc-starfive.c
> @@ -51,7 +51,7 @@ static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>         struct dw_mci *host = slot->host;
>         struct starfive_priv *priv = host->priv;
>         int rise_point = -1, fall_point = -1;
> -       int err, prev_err;
> +       int err, prev_err = 0;
>         int i;
>         bool found = 0;
>         u32 regval;
> --
> 2.34.1
>
