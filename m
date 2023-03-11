Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A136B5CA0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCKOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCKOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B040F1691
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678543833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rI9UkkY/zqKs0y6gyqXwPg+4g7Xn+4IOJ0Nvb47KScw=;
        b=Ah5Rhur6v+GdvOTmJum6soXvTEaJZhRK59+Qx4TDjtnMyk96vbYTILvah5Tkg9WfpJxUJT
        UHEWGbFrM+cFiG5gCAgeDhFLA9tGcX/R8Rmax+/32g879Vey0YSGbyxzoNdSNbGyjn2uMM
        FvQydjyYzcvq9haQLuYLDzfWgKnijak=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-mHcqbzw-NRmnyQD9bFQxlw-1; Sat, 11 Mar 2023 09:10:32 -0500
X-MC-Unique: mHcqbzw-NRmnyQD9bFQxlw-1
Received: by mail-vs1-f69.google.com with SMTP id f11-20020a67ea8b000000b0042210bcecc9so2649623vso.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rI9UkkY/zqKs0y6gyqXwPg+4g7Xn+4IOJ0Nvb47KScw=;
        b=g8vRunbeGR4FnSeOxV8JClYNfC3fJP9yPSLciGnwYtA5ysGgl/QsiowTj+/BVdsAPk
         xaILpfvcJ1QiXs40LcTPng2Hrzn2gsVq3yGrDphsS4vBkbVW2Uycr1L9WwhKU+WGHYS8
         +qYxttR6ZwDebvLY6d/2GMy9vbqIZbSJ+v3RdbdVhyTt/4gfI3UW3BeJU7Hu++yV+XQu
         Y4daBXm/FHgh93EGwu4uNeKyArgizbFjHjfu8bOdLL9qfxP3E67FZroHko2JesZvr5vM
         FGWRqBTMszAxtecfCRAqGnMoGbOQKZidI5L3OUdB7smQzNEtC/gfjmdVHiQciD99IoN4
         WQLw==
X-Gm-Message-State: AO0yUKVcYmeh9frZlEmgWBUMIj4FnBQLoYBzvt5ns7BG0o8dWgomZc9n
        vCtXqXMbhEWtV8xLS8RI3DlgLidTlMymZcf0+zB1UAxhKxde0zNgWLwQ8cZXtYRrWSFje0wL19j
        iYL0zfygw6T2sO7JXOsgczwJEdd+CRbw12XaXWXWT
X-Received: by 2002:a9f:3001:0:b0:68b:817b:eec8 with SMTP id h1-20020a9f3001000000b0068b817beec8mr18498513uab.0.1678543831516;
        Sat, 11 Mar 2023 06:10:31 -0800 (PST)
X-Google-Smtp-Source: AK7set8tL22Z64GFZQlBETeAIXfNC/NFYd/MWg33mB4oH3lVXRGgxR03Dz5LsWIgpcSED5a84XZH6Ovr3dXVwTdKMzQ=
X-Received: by 2002:a9f:3001:0:b0:68b:817b:eec8 with SMTP id
 h1-20020a9f3001000000b0068b817beec8mr18498509uab.0.1678543831274; Sat, 11 Mar
 2023 06:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20230311133453.63246-1-sven@svenpeter.dev>
In-Reply-To: <20230311133453.63246-1-sven@svenpeter.dev>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sat, 11 Mar 2023 14:10:15 +0000
Message-ID: <CAOgh=FydD7Or4KBCHaQ-SyRFKx3rBeft1abVjMUMBxvuQbHMjg@mail.gmail.com>
Subject: Re: [PATCH] PCI: apple: Initialize pcie->nvecs before using it
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 at 13:41, Sven Peter <sven@svenpeter.dev> wrote:
>
> apple_pcie_setup_port computes ilog2(pcie->nvecs) to setup the number of
> MSIs available for each port. It is however called before apple_msi_init
> which actually initializes pcie->nvecs.
> Luckily, pcie->nvecs is part of kzalloc-ed structure and thus
> initialized as zero. ilog2(0) happens to be 0xffffffff which then just
> configures more MSIs in hardware than we actually have. This doesn't
> break anything because we never hand out those vectors.
> Let's swap the order of the two calls so that we use the correctly
> initialized value.
>
> Fixes: 476c41ed4597 ("PCI: apple: Implement MSI support")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/pci/controller/pcie-apple.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 66f37e403a09..8b7b084cf287 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -783,6 +783,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>         cfg->priv = pcie;
>         INIT_LIST_HEAD(&pcie->ports);
>
> +       ret = apple_msi_init(pcie);
> +       if (ret)
> +               return ret;
> +
>         for_each_child_of_node(dev->of_node, of_port) {
>                 ret = apple_pcie_setup_port(pcie, of_port);
>                 if (ret) {
> @@ -792,7 +796,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>                 }
>         }
>
> -       return apple_msi_init(pcie);
> +       return 0;
>  }
>
>  static int apple_pcie_probe(struct platform_device *pdev)
> --
> 2.25.1
>
>

