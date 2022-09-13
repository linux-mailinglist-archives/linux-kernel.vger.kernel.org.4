Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766675B7D71
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIMXUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIMXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:20:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C45E27DE6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EF2EB81178
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90208C433D6;
        Tue, 13 Sep 2022 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663111230;
        bh=OkP3AB4BNr1hUTAE2knTD/oF21cHVgadoi0HWaJ0SLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaG8wFr0Psffi9JspzPru/GXaGT31Tfy0p63bSRRqfCwuyyhTBkvV3TfOMHLio4Yh
         FONjnotfc5J+UDhI/D8W4zMvyvLL4yDn62ng5yothHBqic01UQAPxbaFbuwhTsNugx
         sbWkYYeNEbC5wgzXf/TVe+jVIIiOnkcUYSe7ZJIbplTSlV3F/yuiO1a1bphlDTyooE
         DoNtdvWoQwzV+wbBI8K9lavbO4IDr6F0G//6qdG1L7W6ORdWS1+wXSECCeUtiQ93PT
         g1m3sqxpQdSrYVhd/nJattv5U4sARnRjlPFalr6A2+u4eh/N/zZG13j5+lSA5PuLIA
         SznubJmBFyvKA==
Date:   Tue, 13 Sep 2022 16:20:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Fix return type of
 cdn_dp_connector_mode_valid
Message-ID: <YyEQOztVBGl9D3u1@dev-arch.thelio-3990X>
References: <20220913205555.155149-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913205555.155149-1-nhuck@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 01:55:55PM -0700, Nathan Huckleberry wrote:
> The mode_valid field in drm_connector_helper_funcs is expected to be of
> type:
> enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
> 				     struct drm_display_mode *mode);
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
> 
> The return type of cdn_dp_connector_mode_valid should be changed from
> int to enum drm_mode_status.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index c204e9b95c1f..518ee13b1d6f 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -283,8 +283,9 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> -static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
> -				       struct drm_display_mode *mode)
> +static enum drm_mode_status
> +cdn_dp_connector_mode_valid(struct drm_connector *connector,
> +			    struct drm_display_mode *mode)
>  {
>  	struct cdn_dp_device *dp = connector_to_dp(connector);
>  	struct drm_display_info *display_info = &dp->connector.display_info;
> -- 
> 2.37.2.789.g6183377224-goog
> 
> 
