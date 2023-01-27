Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE1867EDA5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjA0SiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjA0SiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:38:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757812065;
        Fri, 27 Jan 2023 10:37:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71378B821AD;
        Fri, 27 Jan 2023 18:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A8DC433D2;
        Fri, 27 Jan 2023 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674844668;
        bh=YgzAgrGIiQbrNkCPBVg/eVCkPUVFz8isVF148X4pZ5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MvblgqK3yBTgTnIkOZ5pQ1kols/MPSyP5k75Dv+d5/jVMj/hC/0fmsoyz/X4z/ZSn
         rWt4fDxxHKvGTCve5LgYKbsaeQLpU1lpUlIt3Bi94pTij8jNUsI1gKsa/+gmzPS2zB
         XRJv+lLJQ4iyAWr+YyB/6VYpB3lIRPtoxZOPJVMNFNk7ld2w2VNtakzZijUKL6SdrV
         vFr4sRyRaqL2VZvqA/O1nBYhQWfSwoRANNgOa2WzKne6gLM41e2oQ4+/YFJyIUYUy7
         SnIKn6Hvw4WjChd6MzjoUH0YpfHdObf5DFC+LOD5uLS+n4+0janj20PO05yYlqscXF
         mG1sBq6WF2oGQ==
Received: by mail-vs1-f53.google.com with SMTP id h19so4452245vsv.13;
        Fri, 27 Jan 2023 10:37:47 -0800 (PST)
X-Gm-Message-State: AFqh2krvU5Whf3zQdaSinNy3CxO6blK5PrJtNVxzkbHLTPRrERdO9KZL
        6ao6P2cYT9sT5hJ4PmlwdEcIK/KBj8Itl9LKEQ==
X-Google-Smtp-Source: AMrXdXvqGmerRXrDh993paK7OoB3shg4+PA6c/HIVQgKWAhDWC2iTcY9bl/WHU+bdjFEh40ZdyHGZKaPw0bXtwzqNWk=
X-Received: by 2002:a67:f506:0:b0:3d3:c767:4570 with SMTP id
 u6-20020a67f506000000b003d3c7674570mr6235736vsn.85.1674844666952; Fri, 27 Jan
 2023 10:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20230126-synquacer-boot-v1-1-94ed0eb1011f@kernel.org>
In-Reply-To: <20230126-synquacer-boot-v1-1-94ed0eb1011f@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Jan 2023 12:37:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPUKS2+8-sShADSYxAgxjP3mh=TcZPszFeYbMTiPvjYQ@mail.gmail.com>
Message-ID: <CAL_JsqLPUKS2+8-sShADSYxAgxjP3mh=TcZPszFeYbMTiPvjYQ@mail.gmail.com>
Subject: Re: [PATCH] of/address: Return an error when no valid dma-ranges are found
To:     Mark Brown <broonie@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luca Di Stefano <luca.distefano@linaro.org>,
        993612@bugs.debian.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:27 AM Mark Brown <broonie@kernel.org> wrote:
>
> Commit 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
> converted the parsing of dma-range properties to use code shared with the
> PCI range parser. The intent was to introduce no functional changes however
> in the case where we fail to translate the first resource instead of
> returning -EINVAL the new code we return 0. Restore the previous behaviour
> by returning an error if we find no valid ranges, the original code only
> handled the first range but subsequently support for parsing all supplied
> ranges was added.
>
> This avoids confusing code using the parsed ranges which doesn't expect to
> successfully parse ranges but have only a list terminator returned, this
> fixes breakage with so far as I can tell all DMA for on SoC devices on the
> Socionext Synquacer platform which has a firmware supplied DT. A bisect
> identified the original conversion as triggering the issues there.

Looks like maybe it was fixed by Colin in commit f49c7faf776f
("of/address: check for invalid range.cpu_addr") as that commit refers
to Synquacer. But then was it possibly reintroduced by commit
e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting
dma_pfn_offset")?

> Fixes: 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Luca Di Stefano <luca.distefano@linaro.org>
> Cc: 993612@bugs.debian.org
> Cc: stable@kernel.org
> ---
>  drivers/of/address.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index c34ac33b7338..21342223b8e5 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -975,10 +975,12 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>         }
>
>         /*
> -        * Record all info in the generic DMA ranges array for struct device.
> +        * Record all info in the generic DMA ranges array for struct device,
> +        * returning an error if we don't find any parsable ranges.
>          */
>         *map = r;
>         of_dma_range_parser_init(&parser, node);
> +       ret = -EINVAL;

Looks to me like we are leaking 'r' with this change.

Wouldn't this change work:

diff --git a/drivers/of/address.c b/drivers/of/address.c
index c34ac33b7338..f43311f01c32 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -968,6 +968,11 @@ int of_dma_get_range(struct device_node *np,
const struct bus_dma_region **map)
        for_each_of_range(&parser, &range)
                num_ranges++;

+       if (!num_ranges) {
+               ret = -EINVAL;
+               goto out;
+       }
+
        r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
        if (!r) {
                ret = -ENOMEM;
