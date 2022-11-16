Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562A962C25C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiKPPVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiKPPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:21:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262B27932
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:21:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so2609287pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8OvGtAqRoTQELMczmQoHKstBKe+hWZtT69Hm+pj822g=;
        b=BkOM7+3oyrZLB50a7ooVuiZCyXmDm528HyGCCWA2DWwPN/y7hl6ST/jCgSP9DZYmqd
         AEhEe+Ze1hMpDERr1icN/DOsLk0VU4+amJJ7ugq9morEwfu3wNb9JeWcmjZtgurIe+rt
         U0hO2hfm3fiyiIRs0sxFBgSDA4tSTMReIFgI32kT9E9ftISGtGlM+PEj6h2hMquhGCl5
         fZrz895lM2BtV5fchkJPYy3N4VDooCegRy4i+d6k0i7WCKspRhF88r21NFSeqm/zn+qC
         nWP83HRHRBFqc+HxWDW6/PpCn4pR8mt/z525IisYtnmrFJHoZTi9xAX3GHEjgoky46kG
         r2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OvGtAqRoTQELMczmQoHKstBKe+hWZtT69Hm+pj822g=;
        b=Z7vMQzJrJdF5XFPN7iWPjnrvvHkLsL6WTGMDN0k4I8mPgtxhiiG3FwSe7UBs6wiETX
         ilqIxO3CT8bPuwCI/SNHID7IphSKt/Ktp5oyuASw14gvOl0RSe8sM9yXEcEhkfZiRYjb
         BkeTmAZcDoOpWw2jlQGnTR+YPSde7ygE49n0vNK+Q0UVauzS3ugu90NcYp2zWu2Ol7Ih
         y6Lqy5BTN2FRHbfwo1NMINGteraMSAlA+U9NZjaE4C3rp8U4KFh6GVDdETEZckFpKMC/
         mqdsoPu813th/HPZtwenDljlkkb8stOboWsb9nw86OmB+ZScIUkpMov5HEj0a8Oow697
         PogA==
X-Gm-Message-State: ANoB5plmTilEPBKSHVXQhrBruSaicta0MZdQcFgevuClmDd00H3AebUK
        Kfje1UYIKTSRHFaVGC9/RteWQlhREdCKuzWEVaCVog==
X-Google-Smtp-Source: AA0mqf4GwQYIelvsRq8vdudWPLdb8BqPtPml7BZT0L2Yx3B0wfRoHUumYE8+2T9/CzGG9Y8x3hT5DosOf6BTcwrh6zM=
X-Received: by 2002:a17:90a:7804:b0:211:2d90:321 with SMTP id
 w4-20020a17090a780400b002112d900321mr4280330pjk.84.1668612088110; Wed, 16 Nov
 2022 07:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20221111084214.14822-1-wenchao.chen666@gmail.com> <20221111084214.14822-2-wenchao.chen666@gmail.com>
In-Reply-To: <20221111084214.14822-2-wenchao.chen666@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 16:20:51 +0100
Message-ID: <CAPDyKFqvbFLeVFHrd12Q1VdNy3TFmpRaNyuk4AJjNukPzNpT5w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci: Fixed too many logs being printed during tuning
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 at 09:42, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> From: Wenchao Chen <wenchao.chen@unisoc.com>
>
> During the HS200 tuning process, too many tuning errors are printed in
> the log.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fef03de85b99..a503b54305eb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3401,6 +3401,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>                 if (host->pending_reset)
>                         return;
>
> +               command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> +               if (command == MMC_SEND_TUNING_BLOCK || command == MMC_SEND_TUNING_BLOCK_HS200)
> +                       return;
> +

Please use mmc_op_tuning() instead of open-coding this. I also need an
ack from Adrian to apply this.

>                 pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
>                        mmc_hostname(host->mmc), (unsigned)intmask);
>                 sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
> --
> 2.17.1
>

Kind regards
Uffe
