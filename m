Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B336B4ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjCJP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjCJP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:26:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC08133A71
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:16:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u5so5898598plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678461322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5g8vR07GTWTUVecdpjiYPq809ToUsFQgWiHCdhz5c0E=;
        b=BLqIw4BvC1iedATySI8RkLDa1iN8lrVN6q1548MCHtVfgY2S/U32LS+zave6+iOdRu
         1A9dK8ybmVg7cJNQRULvAn8JkIy87BLMpScULmgPl/SNXLG5juTSDWTYmfJcXrqFU0cd
         uYqbOUZLjS2frQNKhTC+6q/LZqHCRdkXHV5knmV7mjwTGdwV8WgDNl8Jr/GnljBptjHi
         Ah8UQosX11dX80119KvSos53T/Gc9K6BuaTkInYWzNZydxg9Cv9f79DDURj8dOFFbJGQ
         PgsRhUb+5lFwKAUURicL/xJiQ4LgjaoIGM45XJoD+jfT6qf5PEqm1QwCPdp0IyToOpE3
         SRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5g8vR07GTWTUVecdpjiYPq809ToUsFQgWiHCdhz5c0E=;
        b=xPLmB54bBUWHBA5duhZbTDHMo8atYMqZSVskLqu7jEfSymYCC02N6uS2VET6HWF3pB
         nj7330H3aY7ZkzWi4Kjl7B4r0hg307R3+iUtlbL8n0a6AqsCNVs5eY6rVm4AwNy5tlJ1
         j8oDxLdlioVM2xORNw+JBo2NlFXXaxjSpYK+fIlO03gsvSdPF0I0/W8szpxflR6q7dE5
         q398zgXv8ewK3Hv1HpcEHNdIshHyTfW4FhW4fASAyhN0+mFwY8uqaJXBL3a2EBz862Kx
         kML+zrwxILFB9PFPWGxKqNz4RohJ5LdZWvT41nMnZFqEGn+1KjU54joAz/Ru1VVqhRRj
         PaBg==
X-Gm-Message-State: AO0yUKXXVxMgZp2Zf3yHKQqI9vVjSgMJdQodZRmzerQwCZImfIJsp6iS
        c64oGxD1nCWFjsV37NCVHYxjbDEKitn62n7fSdeQQA==
X-Google-Smtp-Source: AK7set8XfEUKPvF0aeKfAH+x0DFIfMT8p/xVEeTgibM3QZAdqTaiEh0H9ZQj/m69mh73RyFH8CKsu2Px8LEpKmL50Ro=
X-Received: by 2002:a17:903:2c1:b0:19b:f946:e57d with SMTP id
 s1-20020a17090302c100b0019bf946e57dmr9890237plk.11.1678461322689; Fri, 10 Mar
 2023 07:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20230310144714.1543767-1-robh@kernel.org>
In-Reply-To: <20230310144714.1543767-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Mar 2023 16:14:46 +0100
Message-ID: <CAPDyKFr84WTrA8Gw7Jfq9tZGQJ8SXbg1E0gYvQJ9TBx3Qn7fdA@mail.gmail.com>
Subject: Re: [PATCH] mmc: arasan: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 at 15:47, Rob Herring <robh@kernel.org> wrote:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 89c431a34c43..415f44bf5ee6 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1434,7 +1434,7 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
>  {
>         struct device_node *np = dev->of_node;
>
> -       if (!of_find_property(np, "#clock-cells", NULL))
> +       if (!of_property_present(np, "#clock-cells"))
>                 return;
>
>         of_clk_del_provider(dev->of_node);
> --
> 2.39.2
>
