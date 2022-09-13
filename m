Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3E35B690B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiIMHxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiIMHxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5323554651;
        Tue, 13 Sep 2022 00:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D74A6612E7;
        Tue, 13 Sep 2022 07:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DA7C433D7;
        Tue, 13 Sep 2022 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663055626;
        bh=rFPbnv2DxX3rBK1a7Jmm1zE+iq04DfP9/i/2IqvALRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlGrmphSQgEThIAQsJUpshNn2BE0nacqeqs8Un/E4gMkyv1wHHJevTQNjLxpzPwPO
         79tm1goievGKLE8mqyJYBRtHSP2cbkez1QlJfEtWCp67OAaS1wkzYC+Hsv+r++ibRf
         +8s88EmcISfP1CLtcVK9YQKe2RNDEMYIHwq0SB+zhJrR30JQm34isT9nd2jzII2ddg
         Gh+XeLDhPYWBdpk2sp1AlTHVOv4V363IpEu8P2J+90YBc5ZBH+w7iKtiVuOS45et7I
         eTtpsdSjQrXqo2fLL3nixe2uzN8mejPBbKLMNWXIFmeQidRgiWQmzL0fBwOiOhT7XR
         fA5hXas4pgW8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oY0jo-00010R-LD; Tue, 13 Sep 2022 09:53:44 +0200
Date:   Tue, 13 Sep 2022 09:53:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] drm/msm: drop modeset sanity checks
Message-ID: <YyA3CDQit8OR6DgL@hovoldconsulting.com>
References: <20220912154046.12900-1-johan+linaro@kernel.org>
 <20220912154046.12900-8-johan+linaro@kernel.org>
 <39cbf0cb-9f25-6a0d-6e56-3f9e0aaa0296@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39cbf0cb-9f25-6a0d-6e56-3f9e0aaa0296@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 09:06:28PM +0300, Dmitry Baryshkov wrote:
> On 12/09/2022 18:40, Johan Hovold wrote:
> > Drop the overly defensive modeset sanity checks of function parameters
> > which have already been checked or used by the callers.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Again, please split into dp and dsi patches. After that:

Sure, if you prefer. But without the stable-tree argument I think
there's little point in splitting.

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> > ---
> >   drivers/gpu/drm/msm/dp/dp_display.c | 7 +------
> >   drivers/gpu/drm/msm/dsi/dsi.c       | 7 +------
> >   2 files changed, 2 insertions(+), 12 deletions(-)

Johan
