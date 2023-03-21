Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD746C346A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCUOiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCUOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:38:15 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E682CCA02
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:38:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t9so18048741qtx.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679409493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DVlCgRoSZ9XdR+Dy6Lh3PgMM9vzKokhgsg4QRxt5Aw=;
        b=Ii9vwY2OjmyAvNnxf+T08UQB+cF+jbbCZtE+3u0iN3aU/0+jauV4ZjMJebbSFttUPK
         hUYsjvQ0kbH3NJZhESF3Tr2JFGUWH80Hd9GG9kJSplusYknJKi2MeLejFpoZG4Fws6j7
         aYnqUk750Lm2vq5fA/R+jrxF8qvilvSThOZGCz/dsmgHeLlax1X4TErUYAbb5gK8Eexq
         lC/ZHY1ZIvfZRi7wpzKm0MIMuKGlgcJUiVXuvKLMhGgi+jWlT40mrIl6Zj6B1XoLBuyF
         aWBUOoty+Rxmw9HWXoMmA731Vj07RBjHP4lhxsZP/fxvbEr8xjH+MO4HXIzjTa0HSSMd
         015g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DVlCgRoSZ9XdR+Dy6Lh3PgMM9vzKokhgsg4QRxt5Aw=;
        b=uZhPvaDbyUSBl+Wlz4SeT/GYlz7tevbfpuzbW3C+NsGtFrPsDpCQDDPkP2+4F3mccR
         2OT46TluaYgyXQwnIkJXRkYehIEE8TDj32UlZfY11iCU9nTgwVIGvtaGC0Q0ND9+dhSw
         82J78HYIk7ReFl3QZyUbJIFiCHuDVSpCxMA4SDU4zM9q8NF8fvgYGVSj0qe7rQxJ0Dua
         lxy5ZBtS8b0swmZvPQlkVaMNAv6kPwarqAKe7N7pJblWwelfvm93hhS93UvldP5vW1Xw
         eDfJkwOwTKteTB8MH5iEuDB8MmcKac753Z2YA+zYDbkEbaMjkS+RWsVJyvUE9+e9udWS
         ZxdQ==
X-Gm-Message-State: AO0yUKW0+GtoyX8sMXkCEg45K0Sxq/NHySKMeCia5l/i4MYy06Htgqjg
        wXFZ3U5c7m/EER4tWZj8Jn8eUw==
X-Google-Smtp-Source: AK7set+5mApLIf05UV9lI1WrSUTLqjn2u3xMtQ0MG3GtGOXeh/M+a5iOeRv/Y1L8h+HxYiW3FbYnTQ==
X-Received: by 2002:ac8:7d15:0:b0:3dc:ce21:6f87 with SMTP id g21-20020ac87d15000000b003dcce216f87mr191326qtb.11.1679409493048;
        Tue, 21 Mar 2023 07:38:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id z9-20020a376509000000b0074283b87a4esm2198697qkb.90.2023.03.21.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:38:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ped7r-000VWi-TM;
        Tue, 21 Mar 2023 11:38:11 -0300
Date:   Tue, 21 Mar 2023 11:38:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Message-ID: <ZBnBU9OU4iV6CV0W@ziepe.ca>
References: <20230315164152.333251-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315164152.333251-1-steven.price@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 04:41:52PM +0000, Steven Price wrote:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal).
> 
> Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> This fixes a splat I was seeing on a Firefly-RK3288, more details here:
> https://lore.kernel.org/all/26a5d1b8-40b3-b1e4-bc85-740409c26838@arm.com/

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Do you know what state the iommu is left in after
rk_iommu_detach_device()? Ie is it blocking DMA or doing identity or
something else?

Jason
