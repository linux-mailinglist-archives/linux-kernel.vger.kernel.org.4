Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7825D6C3212
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCUMzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCUMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E81E9C0;
        Tue, 21 Mar 2023 05:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DF6661AF9;
        Tue, 21 Mar 2023 12:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFF7C433D2;
        Tue, 21 Mar 2023 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679403321;
        bh=ZnXocfbauUx27rTMEEdy0hmwDjF0EF1+mrismXf3kiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tkw3jE14tuIpxUec0cs3nE3qxp8ZBfKbxRKUg55YFfOnzbL/8/S3KrPpUoKdJHU2i
         4mUJI6g/rQbbAFz2jxUneGOR8wqUvPmT0NvbyId6LHEIDQCsOdf1Df0BdCCglgOgMT
         DqVH7MxiyAQUxqQG6pZNF17CeuX3jRPfQrCdyWqH8pxM+7whiwd8ja1TeyQf5FiJGc
         eG4rXCakQOZv6YV3wu9roXASPomgovdLHsrSDhoG/7lNPHZKyzcjSupONRbDQfO3y4
         o5MtyhWOX0uEMBPomTuXKiaLgVkUjzNAeMN3Wsp+/O3i/FotomcFIFKPq91tZCqPYT
         Rg+BG/birDn5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pebXg-0005uQ-Tw; Tue, 21 Mar 2023 13:56:44 +0100
Date:   Tue, 21 Mar 2023 13:56:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/msm/adreno: fix runtime PM imbalance at unbind
Message-ID: <ZBmpjF6DKMGDiOhT@hovoldconsulting.com>
References: <20230303164807.13124-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303164807.13124-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 05:48:03PM +0100, Johan Hovold wrote:
> As reported by Bjorn, we can end up with an unbalanced runtime PM
> disable count if unbind() is called before the DRM device is opened
> (e.g. if component bind fails due to the panel driver not having been
> loaded yet).
> 
> As runtime PM must currently stay disabled until the firmware has been
> loaded, fix this by making the runtime PM disable call at unbind()
> conditional.
> 
> The rest of the series fixes further imbalances in the load_gpu() error
> paths and removes a bogus pm_runtime_set_active() call. Included is also
> a related indentation cleanup.

I noticed that Rob picked up the first patch below from v1 of this
series. Any comments to the remaining three?

Johan

> Changes in v2
>  - fix the runtime PM imbalance in the gpu load error paths (new)
> 
>  - drop the patch removing the pm_runtime_disable() from
>    adreno_gpu_cleanup() as this function can currently still be called
>    with runtime PM enabled if suspending the scheduler in
>    adreno_system_suspend() at unbind fails
> 
> 
> Johan Hovold (4):
>   drm/msm/adreno: fix runtime PM imbalance at unbind
>   drm/msm/adreno: fix runtime PM imbalance at gpu load
>   drm/msm/adreno: drop bogus pm_runtime_set_active()
>   drm/msm/adreno: clean up component ops indentation
> 
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 26 +++++++++++++---------
>  1 file changed, 16 insertions(+), 10 deletions(-)
