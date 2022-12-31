Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1765A4AB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiLaNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLaNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:35:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459F8FC9;
        Sat, 31 Dec 2022 05:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F77C60B8F;
        Sat, 31 Dec 2022 13:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23F6C433EF;
        Sat, 31 Dec 2022 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672493703;
        bh=dUnijUHbgerYaBzn9Rg23kVSkLXe70+EE1pNnR1zUuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHSEUqYKnvGPlARWi/AMAcNkhRPToDn/GslN7uuW7RCqWuaQYIkinrbZS7FQZnSNg
         KJvdsv/d106SjzhUn94GO+7gkl7XeUUKYTbOzvZSPF06l6vyeVVFrjnUB83YnlxbJ7
         0QgKMIrjv9W/IgRGE3h6V1Jica9hfh4tquR+7iH092UQEBdqprp1cLxtc6mJiqmx7B
         pnauiV8ZT94c4SdYOgdZs4EMBN22OtSuiFEOOdWKOetoRrL3sQxGQ9h44j+WSwvjAk
         muZa1FADl9+FohPmFi2kYrMf9QUU0BVWMJFaVdq3WeHi2Vz0CBtbKcFOdgExKpe6jP
         AhHJtzDcCQ4IA==
Date:   Sat, 31 Dec 2022 21:34:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 1/2] arm64: dts: ls1028a: declare cache-coherent page
 table walk feature for IOMMU
Message-ID: <20221231133454.GF6112@T480>
References: <20221215135636.3684026-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215135636.3684026-1-vladimir.oltean@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 03:56:35PM +0200, Vladimir Oltean wrote:
> The SMMUv2 driver for MMU-500 reads the ARM_SMMU_GR0_ID0 register at
> probe time and tries to determine based on the CTTW (Coherent
> Translation Table Walk) bit whether this feature is supported.
> 
> Unfortunately, it looks like the SMMU integration in the NXP LS1028A has
> wrongly tied the cfg_cttw signal to 0, even though the SoC documentation
> specifies that "The SMMU supports cache coherency for page table walks
> and DVM transactions for page table cache maintenance operations."
> 
> Device tree provides the option of overriding the ID register via the
> dma-coherent property since commit bae2c2d421cd ("iommu/arm-smmu: Sort
> out coherency"), and that's what we do here.
> 
> Telling struct io_pgtable_cfg that the SMMU page table walks are
> coherent with the CPU caches brings performance benefits, because it
> avoids certain operations such as __arm_lpae_sync_pte() for PTE updates.
> 
> Link: https://lore.kernel.org/linux-iommu/3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com/
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied both, thanks!
