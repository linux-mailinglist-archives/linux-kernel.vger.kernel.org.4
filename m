Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAF06E0A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDMJvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjDMJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:51:27 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA71976E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:51:16 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 71441243D2F;
        Thu, 13 Apr 2023 11:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1681379475;
        bh=hfCTNO7CbDHuy5gEZDfgwcU5fyZr8N4+slArZivW3lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ID/i916x2CZalvNc5f/R6aW8D4x6NJ8nK+/pvuDo6z1OQ6IfGBLDQE3J3V4qprtBi
         Mo0C6jKS5Mx4BzBtIVmjw6rkQ46iZhO2tzfPr1yzXIG4d1/WC3RF9L1XHCBnXuv5JJ
         aeNuF50dxQtO7RTIALOV6sH3HPrq7tuMvIV8ujFECRQroYCmCrrF5jrT/i7IEnZqcB
         XfqUvoT6LWLR2ip/W2NtFTnaLjoI6zxSAmU2V4OjcTyceHTxicIoVYoEuxoRJFSv6d
         oUvh00qZWZi23XMtaLWojo/ceFIfrLvMl3ElVMG6hSvWq2wqlt6z2xTz7+SBbkWpIN
         /2mVr58koQU/w==
Date:   Thu, 13 Apr 2023 11:51:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        John Keeping <john@metanate.com>
Subject: Re: [PATCH v4] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Message-ID: <ZDfQkmiPaNalNx2W@8bytes.org>
References: <20230331095154.2671129-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331095154.2671129-1-steven.price@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 10:51:54AM +0100, Steven Price wrote:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal). But also the use of a NULL domain is confusing.
> 
> Rework the code to add support for IOMMU_DOMAIN_IDENTITY and a singleton
> rk_identity_domain which is assigned to domain when using an identity
> mapping rather than "detaching". This makes the code easier to reason about.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v3[1]:
> 
>  * Added a dummy free callback to rk_identity_ops.
> 
> [1] https://lore.kernel.org/r/20230330144604.2431436-1-steven.price%40arm.com
> 
>  drivers/iommu/rockchip-iommu.c | 61 ++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 14 deletions(-)

Applied, thanks.
