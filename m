Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A02622DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiKIOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiKIOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:23:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C171B27B0F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:21:44 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9FDB5896;
        Wed,  9 Nov 2022 15:21:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668003702;
        bh=kP5lC0vCldZuVd7ukcL4OuhKGJfq527jSr9BMS6LjxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YS+x2KWmsZNgtsyH6EfEhLBfJKSAlbi5DgNlGN7Y0g+/b8Luh/UiLTUtTDMqwI/Ia
         1oCpbIqcqljqF9SpzFS8G5Uq5HQHqxN/o+6V5IpcqlJFHRTb5lAjS78bZiKqzj1Me0
         ymo2e5OxlO3nJ0Ju3J7VpIyZqfeOUp0VzGkjBAdM=
Date:   Wed, 9 Nov 2022 16:21:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] drm: xlnx: Fix return type of
 zynqmp_dp_bridge_mode_valid
Message-ID: <Y2u3Y34bxiS//kyj@pendragon.ideasonboard.com>
References: <20221109001424.1422495-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109001424.1422495-1-nathan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Thank you for the patch.

On Tue, Nov 08, 2022 at 05:14:25PM -0700, Nathan Chancellor wrote:
> From: Nathan Huckleberry <nhuck@google.com>
> 
> The mode_valid field in drm_bridge_helper_funcs is expected to be of
> type
> enum drm_mode_status (* mode_valid) (struct drm_bridge *bridge,
>                                      struct drm_display_mode *mode);
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition. A new
> warning in clang will catch this at compile time:
> 
>   drivers/gpu/drm/xlnx/zynqmp_dp.c:1573:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_bridge *, const struct drm_display_info *, const struct drm_display_mode *)' with an expression of type 'int (struct drm_bridge *, const struct drm_display_info *, const struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .mode_valid = zynqmp_dp_bridge_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> The return type of zynqmp_dp_bridge_mode_valid should be changed from
> int to enum drm_mode_status.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> [nathan: Rebase on drm-misc-next and fix conflicts
>          Add note about new clang warning]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> Please consider picking this up so that it makes 6.2.

I'll send a pull request shortly.

> v2:
>   - Take over for Nathan, as he is busy with other matters.
>   - Rebase on drm-misc-next and resolve conflicts.
>   - Add a note about new clang warning that will catch this issue at
>     compile time.
> 
> v1: https://lore.kernel.org/20220913205600.155172-1-nhuck@google.com/
> 
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 7c9ae167eac7..0a7b466446fb 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1362,9 +1362,10 @@ static void zynqmp_dp_bridge_detach(struct drm_bridge *bridge)
>  	zynqmp_dp_aux_cleanup(dp);
>  }
>  
> -static int zynqmp_dp_bridge_mode_valid(struct drm_bridge *bridge,
> -				       const struct drm_display_info *info,
> -				       const struct drm_display_mode *mode)
> +static enum drm_mode_status
> +zynqmp_dp_bridge_mode_valid(struct drm_bridge *bridge,
> +			    const struct drm_display_info *info,
> +			    const struct drm_display_mode *mode)
>  {
>  	struct zynqmp_dp *dp = bridge_to_dp(bridge);
>  	int rate;
> 
> base-commit: 1a0257c352638916fdaffaac2ddedb8e049312f3

-- 
Regards,

Laurent Pinchart
