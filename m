Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059D0652FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLUKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiLUKin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:38:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ADD167F6;
        Wed, 21 Dec 2022 02:38:34 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F6256602CBF;
        Wed, 21 Dec 2022 10:38:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671619112;
        bh=IkQJWZasZIrnDPiyIB1GoQaNvpe67gEZajUnu33b75g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bc3MAK9zTC9soHtTCyi+kokUtU1Y0sO3YRPmUzkuCjpgq4BqaATzj7D41w2cKcxON
         JKY/46f6OzYd8jzwQrYa2unYHcOH1r9O/HEhUt7Q0yFG8/DPWNR6tGYmMhjcQoajww
         ZAjfZ3iGZoxzTNW22Fe706/WOYMupEcg8M6gUqykM7k9im8jg1kEJgr+irXkeFwe6c
         U2pVfi8B/v4c20NDV80Z2CK91ZESLYcYM2yJ8E3jxeE97c5kg5Z2ClY2mpmEaU/nk7
         cYQ2fqIteumZeMTWTR/PSE6e4syXEmgZc/RejXkLyY+yaa27HV3ykHsghE03HChCgr
         8L7ed3ZjE8Phw==
Message-ID: <9e2d13f2-03cc-1c4c-d24d-b653aae81936@collabora.com>
Date:   Wed, 21 Dec 2022 11:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: platform: mtk-mdp3: fix Kconfig dependencies
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221215164021.694343-1-arnd@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221215164021.694343-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/12/22 17:40, Arnd Bergmann ha scritto:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new mdp3 driver uses 'select' to force-enable a couple of drivers
> it depends on. This is error-prone and likely to cause dependency
> loops as well as warnings like:
> 
> WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU
>    Depends on [n]: MEDIA_SUPPORT [=m] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=n] && VIDEO_DEV [=m] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=y])
>    Selected by [m]:
>    - VIDEO_MEDIATEK_MDP3 [=m] && MEDIA_SUPPORT [=m] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && (MTK_IOMMU [=m] || COMPILE_TEST [=y]) && VIDEO_DEV [=m] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=y]) && HAS_DMA [=y] && REMOTEPROC [=y]
> 
> This specific warning was already addressed in a previous patch,
> but there are similar unnecessary 'select' statements, so turn those
> into 'depends on'. This also means the dependency on ARCH_MEDIATEK
> is redundant and can be dropped.
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Fixes: 9195a860ef0a ("media: platform: mtk-mdp3: remove unused VIDEO_MEDIATEK_VPU config")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


