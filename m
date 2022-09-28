Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7E5EE112
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiI1P6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiI1P6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591BCDF68A;
        Wed, 28 Sep 2022 08:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D570061F0D;
        Wed, 28 Sep 2022 15:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE40C433D6;
        Wed, 28 Sep 2022 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380645;
        bh=tjK6Iwi9Ql5KmK46x2ExPsr0zxrzgi8K1Jt3JCk5wG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAPMUszGIv2DzN4/h8aUlomn7hJkaXcbEvnq+G8MmPtvaiXjWPLFEpQw+L0tXj8mv
         nSaXwxfw7KUH+zCsO5eeRCqfrqy8XD6usPAvTwWrke4CwDjCt4a+/ZsTF2rx75qBxF
         gpCTcdLvPqxW2+SJqI+/lDxbhDcqnglftQdLbNxPDKuQbreUK7iNwpV7ghPIkCZzBx
         XNbgdsuNq0LCORR/LB70/RUBeDfx47cC1JsnWK2uQkBXesAC9OWYHTy7JwEQ5ZiS2w
         DNLX8L0Dq+FWd1EoA3LeTe7ub9tsZgCZ1J1KPoO+EEV8rcKvV27AGtoBXpLLHySD/a
         sdVbUcOrIOylA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odZRD-0005f9-N1; Wed, 28 Sep 2022 17:57:31 +0200
Date:   Wed, 28 Sep 2022 17:57:31 +0200
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
Message-ID: <YzRu64bdqjnhbjlc@hovoldconsulting.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <20220913085320.8577-10-johan+linaro@kernel.org>
 <d05290d8-7603-13b3-3cc4-d8509b03fc02@quicinc.com>
 <YzKi8XfV6V0p0TJi@hovoldconsulting.com>
 <d7688497-6229-40d4-3378-5036d699dfd7@quicinc.com>
 <YzQ9CPwxZXFJCQGG@hovoldconsulting.com>
 <3a5f006d-2735-5af5-48fa-4397bfb5e3ba@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5f006d-2735-5af5-48fa-4397bfb5e3ba@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 08:33:52AM -0700, Abhinav Kumar wrote:
> On 9/28/2022 5:24 AM, Johan Hovold wrote:
> > On Tue, Sep 27, 2022 at 11:42:53AM -0700, Abhinav Kumar wrote:

> >> Discussed with Rob on IRC, we will apply everything except the last two
> >> patches of this series in the -fixes and take these two for the next
> >> kernel rev push.
> > 
> > So the fixes go in 6.0 and the two follow-on cleanups in 6.1? Or did you
> > mean 6.1 and 6.2?

> The fixes will go in 6.1 first.
> 
> The two follow-on cleanups in 6.2.

Ok, sounds good. Thanks.

Johan
