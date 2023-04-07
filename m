Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FCD6DA78B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjDGCMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbjDGCM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:12:26 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80510B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:12:18 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 3371u0xM047933;
        Fri, 7 Apr 2023 09:56:00 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 Apr
 2023 10:11:35 +0800
Message-ID: <d72b0fd9-844e-a422-45b6-261d73dbad18@aspeedtech.com>
Date:   Fri, 7 Apr 2023 10:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/ast: Fix ARM compatibility
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <airlied@redhat.com>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <giantl@nvidia.com>
References: <20230302021905.2777-1-jammy_huang@aspeedtech.com>
Content-Language: en-US
In-Reply-To: <20230302021905.2777-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 3371u0xM047933
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Could you help review this patch??

We met some problem on nvidia's ARM platfrom and need this patch to fix it.

On 2023/3/2 上午 10:19, Jammy Huang wrote:
> ARM architecture only has 'memory', so all devices are accessed by MMIO.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   drivers/gpu/drm/ast/ast_main.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
> index 794ffd4a29c5..f86d01e9f024 100644
> --- a/drivers/gpu/drm/ast/ast_main.c
> +++ b/drivers/gpu/drm/ast/ast_main.c
> @@ -424,22 +424,7 @@ struct ast_device *ast_device_create(const struct drm_driver *drv,
>   	if (!ast->regs)
>   		return ERR_PTR(-EIO);
>   
> -	/*
> -	 * If we don't have IO space at all, use MMIO now and
> -	 * assume the chip has MMIO enabled by default (rev 0x20
> -	 * and higher).
> -	 */
> -	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
> -		drm_info(dev, "platform has no IO space, trying MMIO\n");
> -		ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
> -	}
> -
> -	/* "map" IO regs if the above hasn't done so already */
> -	if (!ast->ioregs) {
> -		ast->ioregs = pcim_iomap(pdev, 2, 0);
> -		if (!ast->ioregs)
> -			return ERR_PTR(-EIO);
> -	}
> +	ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
>   
>   	ast_detect_chip(dev, &need_post);
>   
>
> base-commit: 254986e324add8a30d0019c6da59f81adc8b565f

-- 
Best Regards
Jammy

