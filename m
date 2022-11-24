Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012F9637E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKXRjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKXRjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:39:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CE1369FE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 101F0B8289F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E806C433D6;
        Thu, 24 Nov 2022 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669311557;
        bh=tyzmNAgwRMboqPDBUM9cWs8DieS+1c/Ts/cUfeW/wlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuhKSYQIHJWfV+VTYQmilf/wk4qAFbnygigDtZyDzcFUeTFcZpnmSkwABw4PN4moQ
         o6asFh7VVVAisaw7o1n4+G4wdnrvLQUsk7BK9llkHePNn8zoWQ/NFfh0LxRL0l1EMY
         /mM5UVWCCA3IkUJrNFCPfb85PbSebLNaF8f2SjTX4ikcNjnjkbH/sAMtCfKrukooHF
         Vedz4ShSw/V+S7+Y10p0fnqkleBdF9+GcgEmxazUbf4p+GSqIerWN06PbvLg85whdf
         YvlhaJNup91qkxIVZB5lo/pR+j7+2GyHxZJEtZIqoZPC754v6V1zWYIcd1DpHSbqYP
         9FqUuOsArzeMQ==
Date:   Thu, 24 Nov 2022 23:09:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v4 2/3] phy: core: add debugfs root
Message-ID: <Y3+sQewHEpCU0xu9@matsya>
References: <20221110132716.12294-1-chunfeng.yun@mediatek.com>
 <20221110132716.12294-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110132716.12294-2-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-22, 21:27, Chunfeng Yun wrote:
> Add a debugfs root for phy class, then phy drivers can add debugfs files
> under this folder.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v4: no changes
> ---
>  drivers/phy/phy-core.c  | 6 ++++++
>  include/linux/phy/phy.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index d93ddf1262c5..2f9f69190519 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/err.h>
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> @@ -1204,6 +1205,9 @@ void devm_of_phy_provider_unregister(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);
>  
> +struct dentry *phy_debug_root;
> +EXPORT_SYMBOL_GPL(phy_debug_root);

Why expose this to whole world? Alternate approach would be to add this
in struct phy

> +
>  /**
>   * phy_release() - release the phy
>   * @dev: the dev member within phy
> @@ -1233,6 +1237,8 @@ static int __init phy_core_init(void)
>  
>  	phy_class->dev_release = phy_release;
>  
> +	phy_debug_root = debugfs_create_dir("phy", NULL);
> +
>  	return 0;
>  }
>  device_initcall(phy_core_init);
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index b1413757fcc3..c398749d49b9 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -205,6 +205,8 @@ struct phy_lookup {
>  #define devm_of_phy_provider_register_full(dev, children, xlate) \
>  	__devm_of_phy_provider_register(dev, children, THIS_MODULE, xlate)
>  
> +extern struct dentry *phy_debug_root;
> +
>  static inline void phy_set_drvdata(struct phy *phy, void *data)
>  {
>  	dev_set_drvdata(&phy->dev, data);
> -- 
> 2.18.0

-- 
~Vinod
