Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642D9628DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiKOAI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiKOAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:08:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161082F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:08:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s5so3453967edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8DEyGtnR3E51A3LHZsY+6bNt9izsNvoJTKMNpkota0=;
        b=b6losVzSt1LsO1uAuD3bhs2NGAXC8uf9KiabRTwzuTa1mNOajTwAvj9lgPz9xCqgB0
         OdhliqNT3S6ehFbfekme7ex+RkUMXEWjyv6U1s2uSsBulLxff149DQJCXq1NlLq4UFuO
         MfstcMGHw/zmNh7ohyPGNT6fQZUtaFre4lAxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8DEyGtnR3E51A3LHZsY+6bNt9izsNvoJTKMNpkota0=;
        b=QGCbcJd0pLJf8LXtwBvAs6xmWTrAbNkxZsHneOkQ+804K0ubNYxst40XUYl4oawqk/
         XWnzS0A8XO8MOKes5HxsCy3ua9uDB5HE8ZPtj8OeDuVcxkB/vEEeozwisVJybgPLL72n
         URVOzfY+NJxjTKDQeiJSWJ6p8JW6ouTjct1y8dRlC940hg6ND9tQamRP8aAOGebg9+Ga
         Psl6QVrtMfAZGEfFCyRvOcTI5S5GUcIrzapgzca7iIfPjd8g8Vn5dDbpJFlabsCcOECD
         91K3ROLZmE8Ru2pSXOES9QIYNSOtuBpY+HfG70qq+4BWQyf5AH9bIsSGm0N+0VdqhCzk
         p0Qw==
X-Gm-Message-State: ANoB5pmMAPJ2IbHHu6ldOvcBwKnXlXv+a9hUK94PotP/IpVn8rhYZE70
        Tk6wgX8EjMElvv0Y2OflMCpI9EhyJsrgmYu8
X-Google-Smtp-Source: AA0mqf7Oq20BF+yV8umP/C0dkptriLOIpUOdc7NXFm6f9psNOhf2KJ4axR6uCrS0gJyzfKJPDm3g+w==
X-Received: by 2002:a05:6402:501a:b0:467:6b55:3cf5 with SMTP id p26-20020a056402501a00b004676b553cf5mr12287483eda.22.1668470902468;
        Mon, 14 Nov 2022 16:08:22 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id w12-20020a056402128c00b0046730154ccbsm5422758edv.42.2022.11.14.16.08.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 16:08:18 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so9152249wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:08:17 -0800 (PST)
X-Received: by 2002:a05:600c:1c97:b0:3cf:b0ed:de9d with SMTP id
 k23-20020a05600c1c9700b003cfb0edde9dmr9143461wms.188.1668470896844; Mon, 14
 Nov 2022 16:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
In-Reply-To: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Nov 2022 16:08:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UD-mcLuV0qSOQiQZyb8+HbpOEORdMQB6g9+_teB1Yn_Q@mail.gmail.com>
Message-ID: <CAD=FV=UD-mcLuV0qSOQiQZyb8+HbpOEORdMQB6g9+_teB1Yn_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: qcom: lpass-sc7280: Fix pm_runtime usage
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Fri, Nov 4, 2022 at 6:57 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The pm_runtime usage in lpass-sc7280 was broken in quite a few
> ways. Specifically:
>
> 1. At the end of probe it called "put" twice. This is a no-no and will
>    end us up with a negative usage count. Even worse than calling
>    "put" twice, it never called "get" once. Thus after bootup it could
>    be seen that the runtime usage of the devices managed by this
>    driver was -2.
> 2. In some error cases it manually called pm_runtime_disable() even
>    though it had previously used devm_add_action_or_reset() to set
>    this up to be called automatically. This meant that in these error
>    cases we'd double-call pm_runtime_disable().
> 3. It forgot to call undo pm_runtime_use_autosuspend(), which can
>    sometimes have subtle problems (and the docs specifically mention
>    that you need to undo this function).
>
> Overall the above seriously calls into question how this driver is
> working. It seems like a combination of "it doesn't", "by luck", and
> "because of the weirdness of runtime_pm". Specifically I put a
> printout to the serial console every time the runtime suspend/resume
> was called for the two devices created by this driver (I wrapped the
> pm_clk calls). When I had serial console enabled, I found that the
> calls got resumed at bootup (when the clk core probed and before our
> double-put) and then never touched again. That's no good.
>   [    0.829997] DOUG: my_pm_clk_resume, usage=1
>   [    0.835487] DOUG: my_pm_clk_resume, usage=1
>
> When I disabled serial console (speeding up boot), I got a different
> pattern, which I guess (?) is better:
>   [    0.089767] DOUG: my_pm_clk_resume, usage=1
>   [    0.090507] DOUG: my_pm_clk_resume, usage=1
>   [    0.151885] DOUG: my_pm_clk_suspend, usage=-2
>   [    0.151914] DOUG: my_pm_clk_suspend, usage=-2
>   [    1.825747] DOUG: my_pm_clk_resume, usage=-1
>   [    1.825774] DOUG: my_pm_clk_resume, usage=-1
>   [    1.888269] DOUG: my_pm_clk_suspend, usage=-2
>   [    1.888282] DOUG: my_pm_clk_suspend, usage=-2
>
> These different patterns have to do with the fact that the core PM
> Runtime code really isn't designed to be robust to negative usage
> counts and sometimes may happen to stumble upon a behavior that
> happens to "work". For instance, you can see that
> __pm_runtime_suspend() will treat any non-zero value (including
> negative numbers) as if the device is in use.
>
> In any case, let's fix the driver to be correct. We'll hold a
> pm_runtime reference for the whole probe and then drop it (once!) at
> the end. We'll get rid of manual pm_runtime_disable() calls in the
> error handling. We'll also switch to devm_pm_runtime_enable(), which
> magically handles undoing pm_runtime_use_autosuspend() as of commit
> b4060db9251f ("PM: runtime: Have devm_pm_runtime_enable() handle
> pm_runtime_dont_use_autosuspend()").
>
> While we're at this, let's also use devm_pm_clk_create() instead of
> rolling it ourselves.
>
> Note that the above changes make it obvious that
> lpassaudio_create_pm_clks() was doing more than just creating
> clocks. It was also setting up pm_runtime parameters. Let's rename it.
>
> All of these problems were found by code inspection. I started looking
> at this driver because it was involved in a deadlock that I reported a
> while ago [1]. Though I bisected the deadlock to commit 1b771839de05
> ("clk: qcom: gdsc: enable optional power domain support"), it was
> never really clear why that patch affected it other than a luck of
> timing changes. I'll also note that by fixing the timing (as done in
> this change) we also seem to aboid the deadlock, which is a nice
> benefit.
>
> Also note that some of the fixes here are much the same type of stuff
> that Dmitry did in commit 72cfc73f4663 ("clk: qcom: use
> devm_pm_runtime_enable and devm_pm_clk_create"), but I guess
> lpassaudiocc-sc7280.c didn't exist then.
>
> [1] https://lore.kernel.org/r/20220922154354.2486595-1-dianders@chromium.org
>
> Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock controller for SC7280")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/clk/qcom/lpassaudiocc-sc7280.c | 55 ++++++++++----------------
>  1 file changed, 21 insertions(+), 34 deletions(-)

Is anything blocking this series from landing? I noticed a few other
patches have landed since then to your Qualcomm clk branch, but I
don't see these there. I assume it'll land through your tree.

Thanks!


-Doug
