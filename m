Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967BE61409A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJaWYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJaWYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:24:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D341E14082
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 781D0614A4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E666C433D7;
        Mon, 31 Oct 2022 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667255072;
        bh=c430a9vtJ9VLpdvhysJooW/JnUHf5Y1ouH47JEN2P14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTWhq78uRNLiqVdI4TGtO46oG1p4v/zCTpBX8wI2zjC/49Ea74Bx/W3KE9TmaCzdF
         hxwiG13aeaNMJGIRuNr92vPbxk2TxonFCbZ1ucQ4wk+pL2aFBFyOWDzuUSV7nL3Laf
         6SE3mn0W61+oV9Uf3RpX26XUKDYq/sLpULaZOHlyffJZ6BvYyJHbNSxOLMTagKFUUN
         xlNnIDnqGganQImu8fzJCmlVWV/U0rB3e4qfbWnRjhV4VL6J+4gqlqdxRwOGP4lDHl
         F39PT3miQm9J2K8S4mc0WnZHEAtfLoORFJ3cTkRpf2FsrrK6XKSPlV+PCrCaq8vk9g
         sHy3KIFTr/27w==
Date:   Mon, 31 Oct 2022 15:24:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: Fix return type of
 zynqmp_dp_connector_mode_valid
Message-ID: <Y2BLHjC0q3rbIL0d@dev-arch.thelio-3990X>
References: <20220913205600.155172-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913205600.155172-1-nhuck@google.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Sep 13, 2022 at 01:56:00PM -0700, Nathan Huckleberry wrote:
> The mode_valid field in drm_connector_helper_funcs is expected to be of
> type
> enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
>                                      struct drm_display_mode *mode);
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
> 
> The return type of zynqmp_dp_connector_mode_valid should be changed from
> int to enum drm_mode_status.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index d14612b34796..f571b08d23d3 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1352,8 +1352,9 @@ zynqmp_dp_connector_best_encoder(struct drm_connector *connector)
>  	return &dp->encoder;
>  }
>  
> -static int zynqmp_dp_connector_mode_valid(struct drm_connector *connector,
> -					  struct drm_display_mode *mode)
> +static enum drm_mode_status
> +zynqmp_dp_connector_mode_valid(struct drm_connector *connector,
> +			       struct drm_display_mode *mode)
>  {
>  	struct zynqmp_dp *dp = connector_to_dp(connector);
>  	u8 max_lanes = dp->link_config.max_lanes;
> -- 
> 2.37.2.789.g6183377224-goog
> 
> 

Did this patch get lost somewhere? I do not see it picked up. It is
needed to avoid a new WIP warning from clang for catching these CFI
failures:

drivers/gpu/drm/xlnx/zynqmp_dp.c:1396:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_connector *, struct drm_display_mode *)' with an expression of type 'int (struct drm_connector *, struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
        .mode_valid     = zynqmp_dp_connector_mode_valid,
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Cheers,
Nathan
