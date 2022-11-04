Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE761A2F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKDVKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:10:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731A43843
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:10:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-333a4a5d495so54504947b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cwXqFzxAtkrKTKzZGzLe9Mfbky8J4s9QItvkhLD83kU=;
        b=EWQoU8YoAt/OYgfH63ml03fy9cAdpDGtKVVbEOGaBuxHDcTLtKtI2Od7HxiH9Z8aCI
         PTRdz7+5X8wjKiSlJ9N0t9EMZdLNvSsQ1T73CpdIaMnitMEZJkB0xe4YWbBP7wn1xQL5
         Md4rbCATJQNHQI1DbkJPVxl0+ORssqj1JkHFDtK7wCi4HjsI2GZeIixiNLujzjDWBqEr
         ZLHtGD/Ym7N3EzMNdarE9A/oStXORsO043pkBzGruzsIvxz4OOZceH5P0pkV/B5ZE4p5
         Xdv16t1NzN3RD8SxPcbBJ09Hh2iumMeMwWTfOgW4zWnZ4Eqyb6fmgArDSRMR/NtFRJA5
         FbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwXqFzxAtkrKTKzZGzLe9Mfbky8J4s9QItvkhLD83kU=;
        b=uU6ItMnFlLR2mA7SoFYtFkXxzdvew/QV9jTPvD4QuoIocAS5w3nAevr772kJMtMj9Q
         XTLsEgwMiCZN5YlNIRSTDh1RTEIdPVgjQZqaqLhHgDfnFtRoUAoBXFYRqHvAGpAky8Ue
         yHvmIp2L12OdwlRtT5Qs/x4PDOIgP9tX8efxDvmoVTCda8lk2VOzM+XnY0REfQIgbmdR
         0R2ImpsWcqfKyPML/VsTQOBX7LE9VQDTKYQgkIFx8F8ApZSFEfCJ6NqO2zrK10MmShg9
         WlOzBXZnEvTljI8t+ehJ5kV4xkWXhQLSagcpzf4f/orFjCF0O5sROeNJ9dz7PopZb94M
         uWmw==
X-Gm-Message-State: ACrzQf1J7vVyGafRHy65G0Hd16U8rN3BXiSEhrvorNs9rL6UkEtpzIbT
        8a4FzWjFrIUiMZF7ME1BZ8A8iifS9EVUTxsQk+jxxg==
X-Google-Smtp-Source: AMsMyM6p8Mijb2ZJqrpdINSR2OUp+/sgY+NK1HyQavD90xTWt/vMGVt3m08ouSoQg8PL+7ErmgpGiE0png2t2TIo7g8=
X-Received: by 2002:a81:5905:0:b0:370:853a:80e4 with SMTP id
 n5-20020a815905000000b00370853a80e4mr24444604ywb.418.1667596215061; Fri, 04
 Nov 2022 14:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
In-Reply-To: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 5 Nov 2022 00:10:04 +0300
Message-ID: <CAA8EJppmNeNFHA4r8ycsjqeYDiL7HnJ=q5N7vmuuHfdzJ3euww@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: qcom: lpass-sc7280: Fix pm_runtime usage
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 16:57, Douglas Anderson <dianders@chromium.org> wrote:
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

I don't remember. Most probably so.

>
> [1] https://lore.kernel.org/r/20220922154354.2486595-1-dianders@chromium.org
>
> Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock controller for SC7280")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
