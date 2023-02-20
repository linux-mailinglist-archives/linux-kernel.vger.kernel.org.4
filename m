Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B456069CE75
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjBTN7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjBTN7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:59:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005991EFEC;
        Mon, 20 Feb 2023 05:58:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CF246602149;
        Mon, 20 Feb 2023 13:58:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676901511;
        bh=SsOeXt+P4iwbX9REZy4GabzaEzha82/twxsj56mbnP0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ApwaLqnSxqZSACmOYBRcautqtgPCym4zXwmdQy3gJ8+JNxQGjJZz79agFwnCkU8qO
         68q3OZBddtmNffxG7S29M9BYVR13x5iZcc8tBQ/uqzbg4s4vsceyZyI5gLMFlCBnXK
         Q5uo2o3jWuosSwCatSLGMt981Q9+dHxZqEFBCJH3HuH2XJsLum95myMvAcU9hn7+vV
         RNo6NQOwouOekReWXxCnO12RdNJZNvtBuxA+jantW3I2fsKKMgeAQnz8j4QdcIinBj
         BDJLh9wQ19ZPmHBmDpghBon1bzqvglddr95ejGgiWlWhJmPg3G6E9nTuGFBkI2BcyT
         fFjQdUfgJb0tA==
Message-ID: <c6058eb2-0cb5-4cbd-e7d9-5ae5975be86f@collabora.com>
Date:   Mon, 20 Feb 2023 14:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] scsi: ufs: Add select to CONFIG_PM in Kconfig
Content-Language: en-US
To:     Stephen Zhang <starzhangzsd@gmail.com>, jejb@linux.ibm.com,
        artin.petersen@oracle.com, matthias.bgg@gmail.com,
        beanhuo@micron.com, bvanassche@acm.org, avri.altman@wdc.com,
        yoshihiro.shimoda.uh@renesas.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, zhangshida@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
References: <20230220083256.997470-1-zhangshida@kylinos.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220083256.997470-1-zhangshida@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/02/23 09:32, Stephen Zhang ha scritto:
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

That's wrong. This driver should be made to compile for both !CONFIG_PM
and CONFIG_PM.

Regards,
Angelo

> This patch fixes these by selecting CONFIG_PM from CONFIG_SCSI_UFS_MEDIATEK.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>   drivers/ufs/host/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
> index 4cc2dbd79ed0..f9786f085b54 100644
> --- a/drivers/ufs/host/Kconfig
> +++ b/drivers/ufs/host/Kconfig
> @@ -71,6 +71,7 @@ config SCSI_UFS_QCOM
>   config SCSI_UFS_MEDIATEK
>   	tristate "Mediatek specific hooks to UFS controller platform driver"
>   	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
> +	select PM
>   	select PHY_MTK_UFS
>   	select RESET_TI_SYSCON
>   	help


