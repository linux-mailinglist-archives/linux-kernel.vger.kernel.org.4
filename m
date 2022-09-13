Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3B5B7D72
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIMXVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIMXVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:21:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC1CDC5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03466B8117E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F33C433C1;
        Tue, 13 Sep 2022 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663111302;
        bh=2jbRZFM4qeN5YCFSazhxEpg8n/mzzbUnwtHXj+NPhSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQRkj0WSpOD0mkodtfH5ZqEdy/82uRTYQRN/rH8aQvU9JdxvkiPEvMDbEcu0YcI/x
         Sm7a/8lxbDZUY6jHhoUdjLKqqwDQLmSzPtdmmb7y04/0AvFDwK61h0r9Cyo9huyMyP
         mxeMYqixBSYDI3YEVGjBxXkCXbirCJOk+sRFU+Tgb4TybK5/ySljL8J8560paUxVdj
         MGJhmRgNVdoPwWyMQ6TccuVUgNwxQXOTrXen80+N+7HvzeOlTFQkVP4BrT+A5XP3Pv
         jYeW41xBnEplbpE0547ZjE+URTB+1Uc52wmkNy36ht5M7oaycoagHZlwir7rtgJBDq
         GUTrHn7V3rdCg==
Date:   Tue, 13 Sep 2022 16:21:40 -0700
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
Message-ID: <YyEQhKlesZjXJzAC@dev-arch.thelio-3990X>
References: <20220913205600.155172-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913205600.155172-1-nhuck@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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
