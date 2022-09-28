Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F63A5EDC80
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiI1MYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1MYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8FD1117C;
        Wed, 28 Sep 2022 05:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B00D61D15;
        Wed, 28 Sep 2022 12:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3412C433C1;
        Wed, 28 Sep 2022 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664367876;
        bh=dBwYyIOq7xKF2yq5mWzeWyI6QLDHI+INr6nNI1xPzAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpuW2ZIyPzbpYaGo3QDSDvBrtWqXtDUC+j3uR7J3Bojq4/w5XMcNNuN1MTSMm3AH1
         M2soWfAHndJq5YYyEMVkglILBCy85fKd4Vx9y27d5Vyn1ux+VVMARTqmWpJOwxvpk/
         kr/XrqEokc8BN4DvN/MWjY/22JOzvDwwuxsdc2zG2URG8BAZqAUsKk39G0enec/fS4
         yl2hygFdXnojRHQiXobCPhN7bRw9QNyH5lIo3ce7pnw+xCYp6sOOWl4ax3V5F5fT5w
         1aNnSi49wg8Wt3RUx4GL2iK5R5+zaryKXyjRN+f2UNvpsELPgLjLmDDxc806OLwZhh
         XHlVMPz+GExoA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odW7E-0001cB-VT; Wed, 28 Sep 2022 14:24:41 +0200
Date:   Wed, 28 Sep 2022 14:24:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] drm/msm/dp: drop modeset sanity checks
Message-ID: <YzQ9CPwxZXFJCQGG@hovoldconsulting.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <20220913085320.8577-10-johan+linaro@kernel.org>
 <d05290d8-7603-13b3-3cc4-d8509b03fc02@quicinc.com>
 <YzKi8XfV6V0p0TJi@hovoldconsulting.com>
 <d7688497-6229-40d4-3378-5036d699dfd7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7688497-6229-40d4-3378-5036d699dfd7@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:42:53AM -0700, Abhinav Kumar wrote:
> On 9/27/2022 12:14 AM, Johan Hovold wrote:
> > On Mon, Sep 26, 2022 at 11:17:20AM -0700, Abhinav Kumar wrote:
> >> On 9/13/2022 1:53 AM, Johan Hovold wrote:
> >>> Drop the overly defensive modeset sanity checks of function parameters
> >>> which have already been checked or used by the callers.
> >>>
> >>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>
> >> The change LGTM, hence
> >>
> >> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>
> >> I think we can use below fixes tag so that we can pick up this entire
> >> series for the fixes cycle.
> >>
> >> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> > 
> > Perhaps that's a requirement for drm, but I wouldn't add a Fixes tag for
> > this otherwise as it's not a bug.
> > 
> > You also have to watch out for Sasha and his autosel scripts which will
> > probably try to backport this to stable if it finds a Fixes tag.

> Discussed with Rob on IRC, we will apply everything except the last two 
> patches of this series in the -fixes and take these two for the next 
> kernel rev push.

So the fixes go in 6.0 and the two follow-on cleanups in 6.1? Or did you
mean 6.1 and 6.2?

Johan
