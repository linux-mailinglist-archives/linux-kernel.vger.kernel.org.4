Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6960366BD9B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAPMRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjAPMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:17:26 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4451E28A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:17:13 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 78so19531146pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6O6s+/Jt2HoabvH6cuHS9xSwRe0NVzIqCZ/LeG/LHY=;
        b=pGYFC/99nJry9sCOIIEhVPMiFJI2cPOyFjxJ+CQredOPjfvSiLV/gFUzpcP5iemlFV
         VU7uweWcbuErhIP5Q2+eJIVUyc2AiAKNOqFKNasT6LF0fbulicGAEFrG/8eYuDebb/wR
         v0LSXKCNkynVx37AqCZnEFCtfiF4H5eG44hmFBkiNrMPWnlNUdr+3BP9lRQe09smS7LP
         0gf28va4QB9FcMfnh898iYbLkW/4dhFIdwwU3cs98WcHGNOEURwIC9Kq9ej8CTC9ZJPr
         TC9vXSyjtJnS3iUPJgqeA/aPh8fpyYaK/jo+r1tS0IsGbQPbVtjLjFwnkC65bdZ67Qmx
         3cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6O6s+/Jt2HoabvH6cuHS9xSwRe0NVzIqCZ/LeG/LHY=;
        b=SRFNXaDIZqHrYFqL8yzmrovdfyHD7C5FYaSPOIndoUBH9AHj2KWTqzycZN3pZDlSho
         CgivReKXWa4bry2wd24UfEMVPxMTYn53TEYBSQPWKlxSG+nIis2mxkwOjkylaWIx5CKf
         sEmBRvaNBXWoqt8etUc58miZhNsp6Ad3LGT5NemIAO/UqMIwAfyf3eRSh4n8s4sMj8tF
         ixk2dqh3wtPbkxlbxvCaiK5opkAb3Mz8Cne829br6kPs2qv4ZvqX1zToy9bclA9R0CkE
         nNO7zCWkBsPPy1MVS+QP9hw3ODwkobMbsv5xfcWVUTdaZXLNjIsQsSYqjmrKezuIKt8u
         dF4Q==
X-Gm-Message-State: AFqh2kqk+N76K+ORVjxLFY5zfFpwMrh27CwrmqMQHa2IxnZS7o9Uqtky
        EqpntNt7A1Cmdhr6XbjACC4QkLQ2WhN8HHpmkyZMqg==
X-Google-Smtp-Source: AMrXdXv42heKSjxH9IbMlW2WEJ0jJ2oxbDDcd/9dL4HfNDG3mX+fT4ukYrCn9Kuo4Szve/3TM1B13jKJi/moHSsz+II=
X-Received: by 2002:a63:104f:0:b0:4ac:d14e:2d01 with SMTP id
 15-20020a63104f000000b004acd14e2d01mr2089863pgq.595.1673871433402; Mon, 16
 Jan 2023 04:17:13 -0800 (PST)
MIME-Version: 1.0
References: <990885f566c32ac8e6888ad6b434fb70d1a5d7af.1673460632.git.limings@nvidia.com>
In-Reply-To: <990885f566c32ac8e6888ad6b434fb70d1a5d7af.1673460632.git.limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:37 +0100
Message-ID: <CAPDyKFrzxCKa__v_GFQg2p9cvYKaGaN4kWCEuTM9zvL_tOOAsQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: enable host V4 support for
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 11 Jan 2023 at 19:15, Liming Sun <limings@nvidia.com> wrote:
>
> This commit enables SDHCI Host V4 support on Bluefield-3 SoC to be
> consistent with the default setting in firmware(UEFI).
>
> Reviewed-by: David Woods <davwoods@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a7343d4bc50e..49338670c89f 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -528,6 +528,11 @@ static int dwcmshc_probe(struct platform_device *pdev)
>                         goto err_clk;
>         }
>
> +#ifdef CONFIG_ACPI
> +       if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
> +               sdhci_enable_v4_mode(host);
> +#endif
> +
>         host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>
>         err = sdhci_setup_host(host);
> --
> 2.30.1
>
