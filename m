Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BA5F12D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiI3TjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiI3TjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:39:06 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3400166F17;
        Fri, 30 Sep 2022 12:39:03 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id s125so5769929oie.4;
        Fri, 30 Sep 2022 12:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gc+2YWt2oU07e+y1ije3UAQx/39QdPNvIwaD0iRcu70=;
        b=Oh7rTew0Xcb1sb1H8y5Ew1UC0LvhqLChynFh8gM8KBHn4dA++TmLmB/KMmZiKrHLmG
         oJa+At9XVlSn6gwl+pFHqpxqCvC37EsHlc9bYlX/bhwzcGs0FhRkvizOWNZEaXmQq0yc
         tYUk8xGZHfZigEEv/E+pVUSdQ2ZthpG9yws8qv/YNVacwhp6XgKnWEXYRTc/D9zQYjRW
         2DZZbFCOjq+0KNzdnCMesW+UIHxAQ5ZpjtTKGia9Yf4zh1kn1XNgk5qvJKLZdU/Dr2bO
         gxM+xuECUkbl2UH8FRMYLZVjr0VWOV6AFyODZo57+BwFChuGa4+IcqJzthaPspHLyZeE
         XFYA==
X-Gm-Message-State: ACrzQf3iaToZZ6lo+8Cw5Hi5FvwLMGN/WX/HtpTP9iKZboIVqC+ZkeSN
        sX2JPhc8gOjLeNzt2Tt9Tw==
X-Google-Smtp-Source: AMsMyM60F1bWPyOC9w2iMswWma5K08XI6rdnhlwn8dgfOcWkAp/B4KS6XLJl05bYntsiDarhy42jDw==
X-Received: by 2002:a05:6808:198e:b0:34f:f114:8921 with SMTP id bj14-20020a056808198e00b0034ff1148921mr4509289oib.1.1664566742974;
        Fri, 30 Sep 2022 12:39:02 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i21-20020a4a8d95000000b0044b24273f55sm632858ook.6.2022.09.30.12.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:39:02 -0700 (PDT)
Received: (nullmailer pid 759675 invoked by uid 1000);
        Fri, 30 Sep 2022 19:39:01 -0000
Date:   Fri, 30 Sep 2022 14:39:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2] of: Fix "dma-ranges" handling for bus controllers
Message-ID: <166456654423.756056.16732005186500514187.robh@kernel.org>
References: <112e8f3d3e7c054ecf5e12b5ac0aa5596ec00681.1664455433.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112e8f3d3e7c054ecf5e12b5ac0aa5596ec00681.1664455433.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 13:48:38 +0100, Robin Murphy wrote:
> Commit 951d48855d86 ("of: Make of_dma_get_range() work on bus nodes")
> relaxed the handling of "dma-ranges" for any leaf node on the assumption
> that it would still represent a usage error for the property to be
> present on a non-bus leaf node. However there turns out to be a fiddly
> case where a bus also represents a DMA-capable device in its own right,
> such as a PCIe root complex with an integrated DMA engine on its
> platform side. In such cases, "dma-ranges" translation is entirely valid
> for devices discovered behind the bus, but should not be erroneously
> applied to the bus controller device itself which operates in its
> parent's address space. Fix this by restoring the previous behaviour for
> the specific case where a device is configured via its own OF node,
> since it is logical to assume that a device should never represent its
> own parent bus.
> 
> Reported-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Fix !HAS_DMA build error
> 
>  drivers/of/address.c    | 4 +++-
>  drivers/of/device.c     | 9 ++++++++-
>  drivers/of/of_private.h | 5 +++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 

Applied, thanks!

I assume this was not tagged with Fixes or stable because there is not 
yet a user that needs it? I didn't add it either because I'm a bit 
worried about regressions and applying this just before the merge 
window. So send it to stable later if anyone cares.

Rob
