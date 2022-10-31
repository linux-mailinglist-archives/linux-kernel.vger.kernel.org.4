Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7D614078
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJaWLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJaWK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5C4D46;
        Mon, 31 Oct 2022 15:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32DC9614C3;
        Mon, 31 Oct 2022 22:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF579C433D6;
        Mon, 31 Oct 2022 22:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667254256;
        bh=Ec7BYs/VjKf5gVDNbc8qVx8JTWU5+aUgupZduiEk6xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pT5bW3aTyD2EuAVm4k/RLXpPjuRxVK6suWbYA8jfqEjE1Q69fl8B4IYe+GJDgCbzP
         8Fxe8t7mGhlXUQnJtvF0NiiDCq/UDquQri93KsIYEYQnLDtc2pSpMaIYJr0moLXP1R
         5nMGVpVkQY/p9let6jVce7DQaDP1Lz4c1n3QpfG2S9SiUn/iwnXXiTZD8gEQJFp6R0
         W4F+nZMDWkkQaAT4SgHZTTi5GC3iEiTP3IQXUNEpompjkqoMA8gTdMRXqUIOPL9ZiM
         pkUxpBhCktL/UC14/5KK/IytKL99vIPn3Q3u6smUli5pwM+U6HB+iG1pesSbakBRxy
         zG5mV2LlKFDYQ==
Date:   Mon, 31 Oct 2022 15:10:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Fix return type of
 mdp4_lvds_connector_mode_valid
Message-ID: <Y2BH7sx09nqwKNmt@dev-arch.thelio-3990X>
References: <20220913205551.155128-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913205551.155128-1-nhuck@google.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Sep 13, 2022 at 01:55:48PM -0700, Nathan Huckleberry wrote:
> The mode_valid field in drm_connector_helper_funcs is expected to be of
> type:
> enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
>                                      struct drm_display_mode *mode);
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
> 
> The return type of mdp4_lvds_connector_mode_valid should be changed from
> int to enum drm_mode_status.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> index 7288041dd86a..7444b75c4215 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> @@ -56,8 +56,9 @@ static int mdp4_lvds_connector_get_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> -static int mdp4_lvds_connector_mode_valid(struct drm_connector *connector,
> -				 struct drm_display_mode *mode)
> +static enum drm_mode_status
> +mdp4_lvds_connector_mode_valid(struct drm_connector *connector,
> +			       struct drm_display_mode *mode)
>  {
>  	struct mdp4_lvds_connector *mdp4_lvds_connector =
>  			to_mdp4_lvds_connector(connector);
> -- 
> 2.37.2.789.g6183377224-goog
> 
> 

Did this patch get lost somewhere? I do not see it picked up. It is
needed to avoid a new WIP warning from clang for catching these CFI
failures:

drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c:89:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_connector *, struct drm_display_mode *)' with an expression of type 'int (struct drm_connector *, struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
        .mode_valid = mdp4_lvds_connector_mode_valid,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Cheers,
Nathan
