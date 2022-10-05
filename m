Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE135F59E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJES3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiJES3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:29:45 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984C3DEDD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:29:39 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 789713EED5;
        Wed,  5 Oct 2022 20:29:37 +0200 (CEST)
Date:   Wed, 5 Oct 2022 20:29:35 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH 5/5] drm/dsc: Prevent negative BPG offsets from shadowing
 adjacent bitfields
Message-ID: <20221005182935.7xdp5axnags5obu6@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-6-marijn.suijten@somainline.org>
 <55d7e20b-79cd-ece6-b643-8b542beb7474@quicinc.com>
 <20221004215745.zdfvulqx4exlujgk@SoMainline.org>
 <1a5ed43e-914e-079d-96bf-c9e3912a9473@quicinc.com>
 <20221004223940.stfsyvubx7ecd3a3@SoMainline.org>
 <57732804-9eb1-2f92-f2cd-0ae66f3e28cd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57732804-9eb1-2f92-f2cd-0ae66f3e28cd@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-05 08:33:23, Abhinav Kumar wrote:
[..]
> hmm .... downstream seems to have the & just before the reg write
> 
> https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/DISPLAY.LA.2.0.r1-08000-WAIPIO.0/msm/sde/sde_hw_dsc_1_2.c#L310

https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/DISPLAY.LA.2.0.r1-08000-WAIPIO.0/msm/sde/sde_hw_dsc.c#L156

The reference code for NON-v1.2 doesn't do this here, but you already
confirmed by the docs - and I confirmed by testing a set of size #1 -
that the register is fine with having only 6 bits.

> But yes, we can move this to the dsi calculation to match what others 
> are doing. I am fine with that.

Thanks, done that in v2.

> > [..]
> 
> Even I wasnt. When I was reviewing this series, it seemed like a valid 
> change so I checked the latest downstream code like i always do to see 
> whether and how this is handled and found that these issues were 
> addressed there so thought i would update that here.

Thanks for confirming that it was done in the correct/same way :)

> > [..]
> Its not really parallel development OR competing drivers.
> The design of these features downstream (not just DSC but many others) 
> is quite different because some of the downstream designs wont get 
> accepted upstream as its tightly coupled with our 
> compositor/device-tree. Thats where we are slowly trying to implement 
> these in an upstream compatible way.

But this is what it feels like.

To me this sounds like downstream is more of a staging / prototyping
area that is actively used in production, while the driver
implementation is fleshed out and slowly brought to mainline in a
careful and controlled manner.

That's not a bad thing, but it does mean that mainline always lags
behind in terms of features and hardware support.  At least I'm glad
to hear that downstream is slowly using more DRM primitives, and the
driver is becoming more digestible as well.

> BTW, that being said. Its not always the case that every issue seen 
> upstream has already been fixed downstream. In fact, on some occasions 
> we found something fixed in upstream in a better way and ported them 
> downstream too.

I wasn't expecting anything else, as different drivers have inevitably
different details and different bugs.  The issues this series fixes
weren't applicable to the downstream kernel because it (at the time)
wasn't even using this drm_dsc_config struct with different semantics.
Regardless, it's good to hear that fixes are transplanted in both ways
even if it does mean extra overhead maintaining and keeping tabs on two
drivers at once.

- Marijn
