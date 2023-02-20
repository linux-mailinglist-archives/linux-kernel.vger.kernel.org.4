Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6001469C7BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjBTJc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBTJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:32:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1589166DF;
        Mon, 20 Feb 2023 01:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1934F60D38;
        Mon, 20 Feb 2023 09:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BB1C4339B;
        Mon, 20 Feb 2023 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676885538;
        bh=WP/C8hKVpvdrRvMRdROd3OdMlXuM01497fljMlMi13o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ne24zRzA9QCyMRSpjrif2y6f5rLPcC0ETThe1iYNjjAPHbITeX6qnCpTIr2gRpBkn
         naztHHw2oEfx4t2zDq3yhKTbnS0Sg37tjoNdzIdlxq4jD39qyFFkH5z3alt1AO6paw
         yTGE9rnUoKgvZ6swolAIHfOSiUV2kDoGxVkmESi4aqJt7EwX6xXguI1aAI1TdS66jK
         seazaUZJ6ZHubyphkZ5IqmH3qhiinYEdlbPADku+RKCMy8yUjJAsPofF7dxPkfOJ5h
         Px4s8Xh+WmsO3wo8T6F3qBcZ8BKpC4hJxE4K9EC9gxVZG9rBt5q1mC5veXVbW5+/Wh
         VJjXz/e91+JSQ==
Date:   Mon, 20 Feb 2023 15:02:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     jejb@linux.ibm.com, artin.petersen@oracle.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        beanhuo@micron.com, bvanassche@acm.org, avri.altman@wdc.com,
        yoshihiro.shimoda.uh@renesas.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, zhangshida@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] scsi: ufs: Add select to CONFIG_PM in Kconfig
Message-ID: <20230220093210.GA27366@thinkpad>
References: <20230220083256.997470-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230220083256.997470-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 04:32:56PM +0800, Stephen Zhang wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> In a configuration with CONFIG_SCSI_UFS_MEDIATEK set to 'm' and
> CONFIG_PM set to 'n', errors occur at compile time:
> 
> ====
> ../drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_suspend’:
> ../drivers/ufs/host/ufs-mediatek.c:1621:8: error: implicit declaration of function ‘ufshcd_runtime_suspend’; did you mean ‘ufs_mtk_runtime_suspend’? [-Werror=implicit-function-declaration]
> ../drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_resume’:
> ../drivers/ufs/host/ufs-mediatek.c:1636:9: error: implicit declaration of function ‘ufshcd_runtime_resume’; did you mean ‘ufs_mtk_runtime_resume’? [-Werror=implicit-function-declaration]
> ====
> 
> This patch fixes these by selecting CONFIG_PM from CONFIG_SCSI_UFS_MEDIATEK.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  drivers/ufs/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
> index 4cc2dbd79ed0..f9786f085b54 100644
> --- a/drivers/ufs/host/Kconfig
> +++ b/drivers/ufs/host/Kconfig
> @@ -71,6 +71,7 @@ config SCSI_UFS_QCOM
>  config SCSI_UFS_MEDIATEK
>  	tristate "Mediatek specific hooks to UFS controller platform driver"
>  	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
> +	select PM

Forcing a dependency is only valid if the driver won't work without it. PM is
an optional feature, so it shouldn't be forced. Moreover, in your case the
drivers were not used but instead erroring out because their definitions exist.

Here you should guard the ufs_mtk_runtime_suspend and ufs_mtk_runtime_resume
functions with CONFIG_PM instead.

Thanks,
Mani

>  	select PHY_MTK_UFS
>  	select RESET_TI_SYSCON
>  	help
> -- 
> 2.27.0
> 

-- 
மணிவண்ணன் சதாசிவம்
