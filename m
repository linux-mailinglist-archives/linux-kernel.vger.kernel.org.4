Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC66D4B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjDCPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjDCPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D9191D0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0679D61F94
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CD2C433D2;
        Mon,  3 Apr 2023 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680534409;
        bh=iPsLfUOydlyRBM14W+1Y54Vdkd9NzvvPvuL3Akt7gro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRsYPWkYCNmwTCjgnX9A4Fgng8HytyNJLrHJG55zROJd+xwUXCaIB/Z+2HKftDsVD
         9BX4RxhBRVkrv1zrwAYZHDE/xXlYxYwBMr91VbEny7S0WD01sXo6VptG4e00uf8yZa
         5HXaNt5WArUs+4nVo+FmDU+KxudutNURsPf/YvB8flUdvsIeq23eeOv4qVRgqsYw8o
         PydEPYPhpFxousptAc465o/Qjvtcu9JBlxgegUDLYeuHsPMvwozW9BohIBKiJnhiF9
         QtvLyGcu2VzvHj+MpqHzUwRUnmLG3YfKH3ntCjrt+RDEUsXYfG5oFdS4BdkbIn8qos
         CvUrnMlh7drUg==
Date:   Mon, 3 Apr 2023 20:36:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v9 1/2] phy: core: add debugfs files
Message-ID: <ZCrrhZzj98WdWkd3@matsya>
References: <20230316071452.9161-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316071452.9161-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-23, 15:14, Chunfeng Yun wrote:
> Add a debugfs root for phy class, and create a debugfs directory under
> the root when create phy, then phy drivers can add debugfs files.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v9: create a 'phy' debugfs root, add a debugfs entry in struct phy suggested by Vinod;
> 
> No v8 sent out;
> 
> v2~v7: no changes
> ---
>  drivers/phy/phy-core.c  | 14 ++++++++++++++
>  include/linux/phy/phy.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 9951efc03eaa..05715352881e 100644
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
> @@ -20,6 +21,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  static struct class *phy_class;
> +static struct dentry *phy_debugfs_root;
>  static DEFINE_MUTEX(phy_provider_mutex);
>  static LIST_HEAD(phy_provider_list);
>  static LIST_HEAD(phys);
> @@ -996,6 +998,8 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
>  		pm_runtime_no_callbacks(&phy->dev);
>  	}
>  
> +	phy->debugfs = debugfs_create_dir(dev_name(&phy->dev), phy_debugfs_root);
> +
>  	return phy;
>  
>  put_dev:
> @@ -1226,6 +1230,7 @@ static void phy_release(struct device *dev)
>  
>  	phy = to_phy(dev);
>  	dev_vdbg(dev, "releasing '%s'\n", dev_name(dev));
> +	debugfs_remove_recursive(phy->debugfs);
>  	regulator_put(phy->pwr);
>  	ida_simple_remove(&phy_ida, phy->id);
>  	kfree(phy);
> @@ -1242,6 +1247,15 @@ static int __init phy_core_init(void)
>  
>  	phy_class->dev_release = phy_release;
>  
> +	phy_debugfs_root = debugfs_create_dir("phy", NULL);
> +
>  	return 0;
>  }
>  device_initcall(phy_core_init);
> +
> +static void __exit phy_core_exit(void)
> +{
> +	debugfs_remove_recursive(phy_debugfs_root);

This should be moved to phy_release() we want the debugfs to be cleaned
first

> +	class_destroy(phy_class);

hmmm we are missing this already, that might be an issue!

> +}
> +module_exit(phy_core_exit);
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 3a570bc59fc7..f6d607ef0e80 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -148,6 +148,7 @@ struct phy_attrs {
>   * @power_count: used to protect when the PHY is used by multiple consumers
>   * @attrs: used to specify PHY specific attributes
>   * @pwr: power regulator associated with the phy
> + * @debugfs: debugfs directory
>   */
>  struct phy {
>  	struct device		dev;
> @@ -158,6 +159,7 @@ struct phy {
>  	int			power_count;
>  	struct phy_attrs	attrs;
>  	struct regulator	*pwr;
> +	struct dentry		*debugfs;
>  };
>  
>  /**
> -- 
> 2.18.0

-- 
~Vinod
