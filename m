Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB18567A6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjAXXgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjAXXgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:36:41 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC42CC0C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:36:38 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7C3054215D;
        Wed, 25 Jan 2023 00:36:33 +0100 (CET)
Date:   Wed, 25 Jan 2023 00:36:31 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/14] drm/msm/disp/dpu1: revise timing engine
 programming to work for DSC
Message-ID: <20230124233631.rojijcfy6xhntl3p@SoMainline.org>
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
 <1674498274-6010-13-git-send-email-quic_khsieh@quicinc.com>
 <8392e1f3-8459-4408-41de-564a41980b4c@linaro.org>
 <3588a5d0-ca28-918f-e072-35f15a5a5132@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3588a5d0-ca28-918f-e072-35f15a5a5132@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-24 09:55:24, Kuogee Hsieh wrote:

<snip>

> This timing engine code is derived from our downstream code directly and 
> it has been used at many mobile devices by many vendors for many years 
> already.
> 
> On the other words, it had been tested very thorough and works on 
> dsi/dp/hdmi/dsc/widebus applications.

And the code already in mainline has seen 12 rounds of review, with a
focus on inter-SoC compatibility.  Regardless of that, we have processes
to make changes on mainline: formatting changes (when actually making an
improvement) go separate from semantic changes.  Bugfixes are clearly
described in individual patches with Fixes: tags.  If you really think
the code has to be as proposed in this patch, follow Dmitry's advice and
split this accordingly.

> When i brought dsc v1.2 over, I just merged it over and did not consider 
> too much.

And that is exactly what is wrong with this *entire* series: copying
over downstream code without "considering too much", stomping over
previous review and even reverting bugfixes [1] [2] without giving it
ANY ATTENTION in your patch description.  That's unacceptable and
insulting to contributors and reviewers.  Full stop.  Or did you expect
us to turn a blind eye?  This is mainline, not some techpack playground.

[1]: https://lore.kernel.org/linux-arm-msm/20230123201133.zzt2zbyaw3pfkzi6@SoMainline.org/
[2]: https://lore.kernel.org/linux-arm-msm/20221026182824.876933-10-marijn.suijten@somainline.org/

> Can we adapt this code so that both upstream and down stream shared same 
> timing engine programming so that easier to maintain?

Easy, I've said this before in IRC and will state it again: stop this
techpack nonsense and focus on upstream-first.  When something passes
mainline review (and please don't bother maintainers and reviewers with
series like this) it is inevitably good enough to be copied to
techpack... at which point techpack becomes worthless as you can just
backport a mainline patch or use a recent-enough kernel.


tl;dr: it seems like you nor anyone involved in pre-reviewing/vetting
this series is familiar with upstream guidelines.  Follow the global
advice from Dmitry [3] to reach a more efficient v2, and please don't
let this run to v10 (or beyond) again.

One suggestion to improve efficiency: split off the DPU v1.2 hardware
block addition (and related changes) into a separate series.  A smaller
series (and properly split patches!) will give everyone less moving
parts to worry about, and paves the way for DSI support without blocking
on DP.

[3]: https://lore.kernel.org/linux-arm-msm/47c83e8c-09f1-d1dd-ca79-574122638256@linaro.org/

- Marijn
