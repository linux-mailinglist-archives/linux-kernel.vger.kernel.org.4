Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338F770EB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbjEXCeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEXCeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:34:15 -0400
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809A6196
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:34:11 -0700 (PDT)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 May
 2023 10:34:10 +0800
Message-ID: <9d98962c-a508-e6ff-00cf-7c1927cce1da@aspeedtech.com>
Date:   Wed, 24 May 2023 10:34:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drm/ast: Fix long time waiting on s3/s4 resume
Content-Language: en-US
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <airlied@redhat.com>, <tzimmermann@suse.de>
CC:     <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230414074204.5787-1-jammy_huang@aspeedtech.com>
In-Reply-To: <20230414074204.5787-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Could you help review this patch?

This is an issue leading to kernel panic found by Intel. Wendy has 
confirmed issue resolved by this patch.

On 2023/4/14 下午 03:42, Jammy Huang wrote:
> In resume, DP's launch function, ast_dp_launch, could wait at most 30
> seconds before timeout to check if DP is enabled.
>
> To avoid this problem, we only check if DP enable or not at driver probe.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217278
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   v2 changes:
>    - Fix build error.
> ---
>   drivers/gpu/drm/ast/ast_dp.c   | 55 +++++++++++-----------------------
>   drivers/gpu/drm/ast/ast_drv.h  |  2 +-
>   drivers/gpu/drm/ast/ast_main.c | 11 +++++--
>   drivers/gpu/drm/ast/ast_post.c |  3 +-
>   4 files changed, 29 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index 56483860306b..eee2f264c880 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -119,53 +119,32 @@ int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
>   /*
>    * Launch Aspeed DP
>    */
> -void ast_dp_launch(struct drm_device *dev, u8 bPower)
> +void ast_dp_launch(struct drm_device *dev)
>   {
> -	u32 i = 0, j = 0, WaitCount = 1;
> -	u8 bDPTX = 0;
> +	u32 i = 0;
>   	u8 bDPExecute = 1;
> -
>   	struct ast_private *ast = to_ast_private(dev);
> -	// S3 come back, need more time to wait BMC ready.
> -	if (bPower)
> -		WaitCount = 300;
> -
> -
> -	// Wait total count by different condition.
> -	for (j = 0; j < WaitCount; j++) {
> -		bDPTX = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, TX_TYPE_MASK);
> -
> -		if (bDPTX)
> -			break;
>   
> +	// Wait one second then timeout.
> +	while (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, COPROCESSOR_LAUNCH) !=
> +		COPROCESSOR_LAUNCH) {
> +		i++;
> +		// wait 100 ms
>   		msleep(100);
> -	}
>   
> -	// 0xE : ASTDP with DPMCU FW handling
> -	if (bDPTX == ASTDP_DPMCU_TX) {
> -		// Wait one second then timeout.
> -		i = 0;
> -
> -		while (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, COPROCESSOR_LAUNCH) !=
> -			COPROCESSOR_LAUNCH) {
> -			i++;
> -			// wait 100 ms
> -			msleep(100);
> -
> -			if (i >= 10) {
> -				// DP would not be ready.
> -				bDPExecute = 0;
> -				break;
> -			}
> +		if (i >= 10) {
> +			// DP would not be ready.
> +			bDPExecute = 0;
> +			break;
>   		}
> +	}
>   
> -		if (bDPExecute)
> -			ast->tx_chip_types |= BIT(AST_TX_ASTDP);
> +	if (!bDPExecute)
> +		drm_err(dev, "Wait DPMCU executing timeout\n");
>   
> -		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5,
> -							(u8) ~ASTDP_HOST_EDID_READ_DONE_MASK,
> -							ASTDP_HOST_EDID_READ_DONE);
> -	}
> +	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5,
> +			       (u8) ~ASTDP_HOST_EDID_READ_DONE_MASK,
> +			       ASTDP_HOST_EDID_READ_DONE);
>   }
>   
>   
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index d51b81fea9c8..15e86394be4f 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -498,7 +498,7 @@ struct ast_i2c_chan *ast_i2c_create(struct drm_device *dev);
>   
>   /* aspeed DP */
>   int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata);
> -void ast_dp_launch(struct drm_device *dev, u8 bPower);
> +void ast_dp_launch(struct drm_device *dev);
>   void ast_dp_power_on_off(struct drm_device *dev, bool no);
>   void ast_dp_set_on_off(struct drm_device *dev, bool no);
>   void ast_dp_set_mode(struct drm_crtc *crtc, struct ast_vbios_mode_info *vbios_mode);
> diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
> index f83ce77127cb..8ecddf20113f 100644
> --- a/drivers/gpu/drm/ast/ast_main.c
> +++ b/drivers/gpu/drm/ast/ast_main.c
> @@ -254,8 +254,13 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
>   		case 0x0c:
>   			ast->tx_chip_types = AST_TX_DP501_BIT;
>   		}
> -	} else if (ast->chip == AST2600)
> -		ast_dp_launch(&ast->base, 0);
> +	} else if (ast->chip == AST2600) {
> +		if (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, TX_TYPE_MASK) ==
> +		    ASTDP_DPMCU_TX) {
> +			ast->tx_chip_types = AST_TX_ASTDP_BIT;
> +			ast_dp_launch(&ast->base);
> +		}
> +	}
>   
>   	/* Print stuff for diagnostic purposes */
>   	if (ast->tx_chip_types & AST_TX_NONE_BIT)
> @@ -264,6 +269,8 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
>   		drm_info(dev, "Using Sil164 TMDS transmitter\n");
>   	if (ast->tx_chip_types & AST_TX_DP501_BIT)
>   		drm_info(dev, "Using DP501 DisplayPort transmitter\n");
> +	if (ast->tx_chip_types & AST_TX_ASTDP_BIT)
> +		drm_info(dev, "Using ASPEED DisplayPort transmitter\n");
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
> index 82fd3c8adee1..90e40f59aff7 100644
> --- a/drivers/gpu/drm/ast/ast_post.c
> +++ b/drivers/gpu/drm/ast/ast_post.c
> @@ -380,7 +380,8 @@ void ast_post_gpu(struct drm_device *dev)
>   	ast_set_def_ext_reg(dev);
>   
>   	if (ast->chip == AST2600) {
> -		ast_dp_launch(dev, 1);
> +		if (ast->tx_chip_types & AST_TX_ASTDP_BIT)
> +			ast_dp_launch(dev);
>   	} else if (ast->config_mode == ast_use_p2a) {
>   		if (ast->chip == AST2500)
>   			ast_post_chip_2500(dev);
>
> base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d

-- 
Best Regards
Jammy

