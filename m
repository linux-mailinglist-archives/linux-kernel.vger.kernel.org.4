Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2069E1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjBUNxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjBUNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:53:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4536D10CE;
        Tue, 21 Feb 2023 05:53:36 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B192766021C8;
        Tue, 21 Feb 2023 13:53:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676987614;
        bh=tkbb/5D+yMva8uwQqyx5oDFbgQMJg9RVa+b/TFHaoGY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Cjf3TtcqodsxvzJWpUGFRv+A66jtjxGhsgfawxM5DO+WOM8nWlX5oQmrAm3gJ/3JJ
         4eo6bmequtFesURcX+Mam//hyDyqR3y8Is/Q0mnJ2OsdLcsC1Wh2+69H6bvxCQsvUa
         +QZkmdq0T2v+AaZTpdOqU5J6GksolJtmERNiQvJhqX8QQYZBsnIs+c/9G80kUJei4g
         Rb00ikBCWacxY0Xm51mcdpahBVTMRNbqagctStKLc8zXwgmvN6H5gZ9Kiwh/HNwffO
         66sDMQnPNDEoRdDn1+qsWbehc3oCYjh3onEQFidPS/pKRRB01DVb5m95lLY+c5AV9Y
         tdGoZm3lTIUWA==
Message-ID: <00c5a33b-7c3a-de32-bcca-9fe9e5c6a156@collabora.com>
Date:   Tue, 21 Feb 2023 14:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] scsi: ufs: mediatek: Guard runtime PM functions
To:     Stephen Zhang <starzhangzsd@gmail.com>, stanley.chu@mediatek.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        artin.petersen@oracle.com, matthias.bgg@gmail.com,
        beanhuo@micron.com, bvanassche@acm.org, avri.altman@wdc.com,
        yoshihiro.shimoda.uh@renesas.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, zhangshida@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20230221113808.1050790-1-zhangshida@kylinos.cn>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221113808.1050790-1-zhangshida@kylinos.cn>
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

Il 21/02/23 12:38, Stephen Zhang ha scritto:
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
> Fix these errors by guarding the runtime PM functions with CONFIG_PM.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>


