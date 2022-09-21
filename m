Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A115BFE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIUMvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiIUMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:50:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0298CBB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:49:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so2428422wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lEb4/vNRwZCzTxI/+P3qnCbawhg15sfGPXUaXIOqYpI=;
        b=PoHyJCavEEfGvzK5zXf9rbMdn7G6Upl1QJOu7Zm5YdjfK763Nm3aSmlNChHxB4ZJzv
         2dgQnb/ZNZThkfQNTXl3cIsti7gm0Q9eLUrRhlu5OBi06LbUGd8q0rocOYzn/A1Jnixy
         KyA7KT9j9oNQGs3Vt6HVR6q0U86dqPBKwjXCrKbCUVvBmPQ3ttxCspFJIl+GXj+9JJ2n
         dWPE+7gSrIa7otYJiWekHk9vWPGSW49dyeGZxn4GaJZ+MFcKlMc6Wwm4WnkWC/qcBacr
         h9l0mfGXGgPB+gcfMSzBd4sOwQYnDFlr9imeQBdGW6h1H0xnpZ2UCeq0KA2gQy+w8mMR
         gcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lEb4/vNRwZCzTxI/+P3qnCbawhg15sfGPXUaXIOqYpI=;
        b=Yc5sfXS21hXAgX5qxjlugyeEZtMwzcZjv0qCf/6t8mYLP/kqUuf9sxDhz9jVKsmdZq
         1WtJ3tBp76EYW1mW1ERGA1C828bbClfPCmhAqx7Rnsd869m9P4kVFYsb5E1pXFtZeTX1
         6YS2UHw51fIizsDvwv9ahOMSaHFM0kn4yCTiBVTgjk7Ldd/VnhKG4T35lmP4Z1sN4OkV
         DDtiRQhWckLZ1XrdnanITUr0NOjuqF9/VwqpUNImpNrzYktWUW9x9MsGBdiQselGdm52
         Zyk20KNcJSyk8q5K8Fd+6dup99BcJrRTdGo6nv8b41l8/dfxfgNqHaa5iQ++ERnn3Fdu
         T5uQ==
X-Gm-Message-State: ACrzQf31ejYp+T69GEpNqpdbQ2tWJ/EOSBTmjq0Vcs3E8AvYZl/SCGid
        cz7HL19HAniwUJ+KTk9g35pNtdfgFU3olcAySAY3MKgmWsM=
X-Google-Smtp-Source: AMsMyM7RicGBmKbhHlBZWqTSEaQjpWc7j9DhvdwmmAme+poXKTCBPcEBxEu/631ZA5y8bw4T04rLJ0cER2Icgi83Pmc=
X-Received: by 2002:a05:600c:524d:b0:3b4:91ee:933c with SMTP id
 fc13-20020a05600c524d00b003b491ee933cmr5562117wmb.100.1663764543062; Wed, 21
 Sep 2022 05:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220914063702.20283-1-wenchao.chen666@gmail.com>
In-Reply-To: <20220914063702.20283-1-wenchao.chen666@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:48:26 +0200
Message-ID: <CAPDyKFptoSosJG-LGk6QFbU43f-NUnLHafMyXG7CfoWO-D5zLA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix the limitation of div
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     adrian.hunter@intel.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sept 2022 at 08:37, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> From: Wenchao Chen <wenchao.chen@unisoc.com>
>
> Because the bit field size of the divider coefficient register is 1023, it is
> limited before returning the value.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index f33e9349e4e6..46c55ab4884c 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -205,14 +205,14 @@ static inline u32 sdhci_sprd_calc_div(u32 base_clk, u32 clk)
>         if ((base_clk / div) > (clk * 2))
>                 div++;
>
> -       if (div > SDHCI_SPRD_CLK_MAX_DIV)
> -               div = SDHCI_SPRD_CLK_MAX_DIV;
> -
>         if (div % 2)
>                 div = (div + 1) / 2;
>         else
>                 div = div / 2;
>
> +       if (div > SDHCI_SPRD_CLK_MAX_DIV)
> +               div = SDHCI_SPRD_CLK_MAX_DIV;
> +
>         return div;
>  }
>
> --
> 2.17.1
>
