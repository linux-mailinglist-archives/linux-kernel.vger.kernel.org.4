Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0516D53C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDCVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjDCVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:42:59 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDEA4690;
        Mon,  3 Apr 2023 14:42:36 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id f14so9309339oiw.10;
        Mon, 03 Apr 2023 14:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680558096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LeHLbpF/fq/v7HgIjULXU12w98TZp0k1/TVoIaCi/Q=;
        b=zt7YobaqdX+pdDCa3htRBLExSaTUStQQa40MNZdtek3l4ts513J7UnePK8hW0eAPl4
         GBZKCRWdxCGPdJ8ciqfX7lAFD8RgtwCH10+yxaYYe3lnq2UNGiB8nBV1DcKipXKAxtVy
         kKAhLHj1MWsJo0a8JdYDEyUo4aNK9Ka0fP36LgeBgUIkbsXI3L/0asSZ5V3qaQ2lfs/4
         dDFUJsKinSmdLFoNwuH86sa1cjngWwdiRSeCXRQZUQGwi417IYS9LtF3p7NEGZPkWGfS
         afFgHfCbYeV1dBzj0QYLRU/dYYHiI30G65hAee74ZfstAS6qDDrDch85Zq5Eytaq4K+A
         oTrQ==
X-Gm-Message-State: AAQBX9dlo8h/NuZram0RUXVXyQG1QK9IvkAcw7s4h+X7iwMmlwEvSOQS
        xk+E3AdKIiQTwY8mkuk6jA==
X-Google-Smtp-Source: AKy350a2F8xmoADBsJlISa26dZ7R6j/FmNhkywKUdlNRmCRgb7Q43nYdyUnk3XPxfhHB8nsze14+Ow==
X-Received: by 2002:aca:ef42:0:b0:38b:de4:e3c5 with SMTP id n63-20020acaef42000000b0038b0de4e3c5mr382108oih.43.1680558095945;
        Mon, 03 Apr 2023 14:41:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n6-20020a4a4006000000b0052a77e38722sm4558873ooa.26.2023.04.03.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:41:35 -0700 (PDT)
Received: (nullmailer pid 1922535 invoked by uid 1000);
        Mon, 03 Apr 2023 21:41:35 -0000
Date:   Mon, 3 Apr 2023 16:41:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] of: address: Fix documented return value of
 of_pci_range_to_resource()
Message-ID: <168055809427.1922483.3557288422319217276.robh@kernel.org>
References: <cover.1680248888.git.geert+renesas@glider.be>
 <bcdaa9332e9c6dfa27af68d79fda121eac2975dc.1680248888.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcdaa9332e9c6dfa27af68d79fda121eac2975dc.1680248888.git.geert+renesas@glider.be>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 Mar 2023 09:52:29 +0200, Geert Uytterhoeven wrote:
> of_pci_range_to_resource() returns a negative instead of a positive
> error code.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/address.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

