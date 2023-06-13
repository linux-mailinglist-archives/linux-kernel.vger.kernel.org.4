Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF52D72E5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242828AbjFMOZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbjFMOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:25:51 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B4AE7A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:25:47 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bd5f59fb71dso311885276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686666347; x=1689258347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X94bKUv1M/Inu/XN1ifqHmKL/+Q4WPqhv8WNjOapxf0=;
        b=OwBzeUYJFPZNoWS/K7NNXfa4wHYGTeLHpzbYzACsXX411U6MsVaA2d+USzjcPRrD+U
         nVeUiqgWgIvGA116XqyHDaVy+rnUnER20hUpmqxg2X3/cMBlogilvT5NQ3OF3qr2IGg0
         m2K9yi0mvoEsQ9ddAhQH6ESEUNYBtYY8ztVKBxmlp7E3tS7qNb39Wl8bauBrrAojY3i9
         6d4J+WtIsYGh+mxxH2/TSSMgexlpZk+f2BrkSXVOX/Febwk10dd1gi1CDRSZGy+59wh6
         kjvsaBYzpGfSP9quYmnmvQ+vxO2lKWiRLh8iM7be5bSZZvsVhIonPRjM3Y4sqihwYG1n
         hbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666347; x=1689258347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X94bKUv1M/Inu/XN1ifqHmKL/+Q4WPqhv8WNjOapxf0=;
        b=IlI3yKJZS+/PDundpnn8RE+i++tPtrxiix1G+kA3+ZpkYlAqgPhtZzKmTB15B+AKB4
         11KGQ/uApoR2KBe2i1UrIh2U80ouH068fSpRT+FhDgnm6xYtwdfGroLTTqNDbvPc57i/
         14oPZK1pwSWNUyyzQVyTNiuylU6f4P6oDUmN9n61KKBRojOC9GiMXTghFvg0ry8oMoHy
         Kr7tNlagazbKmS8tHhZalx3j1bW1Zr9Amnj4QzV2KWgfsbdRP5xHe7I949Fc0RVXOH5E
         mbNQVQ2bUfpcdqP97swqgg7whEefHbjeWHpVaQ0b5kRQO6qplV9hbVlyNupJBc63ZBP8
         LsWA==
X-Gm-Message-State: AC+VfDzLGywL/IMX2sOyYP/VY3zNccEx1PGDfDo/PyqIeLhmsZL6viC5
        9gNHOocYbFl5p+ygTj+zwgOTsZNWUoCaTxgcmUKaQg==
X-Google-Smtp-Source: ACHHUZ4nfn5fXKPLkVPdIFaBTff3OnOuc93W0l6Vm+OqbL1rQradCBXVg8Ejhu4aWla7TnbyV+pim/v5TGSRCEP8xuA=
X-Received: by 2002:a25:8305:0:b0:b99:9335:87f6 with SMTP id
 s5-20020a258305000000b00b99933587f6mr1830093ybk.27.1686666346927; Tue, 13 Jun
 2023 07:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org>
In-Reply-To: <20230329202148.71107-1-dennis@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 16:25:11 +0200
Message-ID: <CAPDyKFoKmWAC0V_t7WL-5OauxS-iiLxW+KhqC6RzJXD_szjPCA@mail.gmail.com>
Subject: Re: [PATCH] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 at 22:21, Dennis Zhou <dennis@kernel.org> wrote:
>
> When using dm-verity with a data partition on an emmc device, dm-verity
> races with the discovery of attached emmc devices. This is because mmc's
> probing code sets up the host data structure then a work item is
> scheduled to do discovery afterwards. To prevent this race on init,
> let's inline the first call to detection, __mm_scan(), and let
> subsequent detect calls be handled via the workqueue.
>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Along with the patch for the mmci driver, this one applied too, for
next, thanks!

Note also that I took the liberty to clarify the commit message a bit.

Moreover, if we want this to be applied for stable kernels, we need to
manage that separately, as then the mmci patch is needed too. Please
ping if you need some pointers in regards to this.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f10405e13..c0fdc438c882 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
>  }
>  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
>
> -void mmc_rescan(struct work_struct *work)
> +void __mmc_rescan(struct mmc_host *host)
>  {
> -       struct mmc_host *host =
> -               container_of(work, struct mmc_host, detect.work);
>         int i;
>
>         if (host->rescan_disable)
> @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
>                 mmc_schedule_delayed_work(&host->detect, HZ);
>  }
>
> +void mmc_rescan(struct work_struct *work)
> +{
> +       struct mmc_host *host =
> +               container_of(work, struct mmc_host, detect.work);
> +
> +       __mmc_rescan(host);
> +}
> +
>  void mmc_start_host(struct mmc_host *host)
>  {
>         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
>         }
>
>         mmc_gpiod_request_cd_irq(host);
> -       _mmc_detect_change(host, 0, false);
> +       host->detect_change = 1;
> +       __mmc_rescan(host);
>  }
>
>  void __mmc_stop_host(struct mmc_host *host)
> --
> 2.40.0
>
