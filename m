Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD66156B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 01:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKBApe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 20:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKBApU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 20:45:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1A19C3A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 17:45:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sc25so41298263ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eSaSz/Z4qDcGiTl8x7mCllVE7aLOvaKXoGQ851RVNJk=;
        b=AfgzHUqFn7VGV4Kz8Fi8rM1Hwq5OyFKM90jljZgJl17I9Ubqo0jCjbpO4e5kuB579S
         qM6aPojZ5+HAqmj/1DU8AkQMDrQbOCzgHyS007RwUMkW9iE7lGfZ0+aQddSXZZsVixSE
         R/G9WJ8YXjy7TaD2ShD2tdlUyQhK42JfXZ0EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSaSz/Z4qDcGiTl8x7mCllVE7aLOvaKXoGQ851RVNJk=;
        b=uE64fL3vndicbt79lwKp1EliWLs88Qd4Vp3/QYh12/ywEYQDVdQ6oCR79C3kgqBSKi
         Zv6EiWPp2KWGUQBJqCPBaY4UsSoPY1bEMrWe+DAZ23p+/4kD7gDG/Z/lDSWvZ8+Qe30u
         AjTIDP/OeC+Gh/6eJvfu1H/2vkND7nCMsWsXL37gEMV0txEaNhlaxmYlsEiuR4+V69SJ
         Dy3+HsX5NCOMrve14R+pWkYAWIRHHS5s9EDer2PBdtMxQt3FItaAYRQKyufa+KpKQAoH
         jFF9mt/6dFjH7b4znAAC5lSO+0zDlVYPou17pP1OigBIRaBO/cPh/3p7owMY8MVrR9LS
         km0g==
X-Gm-Message-State: ACrzQf0lYCKWAAmb8BH9iNrZ+y8KWKblcmxYTForkb18dZtWhc/erJUK
        cP/1HM0Z6XkYvRKN/qQeSb7YY/Bu1ODQl4n+
X-Google-Smtp-Source: AMsMyM4u0kvpVT2qv5sVTHq33dHjO3fK3kkj/mFJSyL2b+dteAPtrFrxwrIH/RcFn5YaYow3R95y/Q==
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id o22-20020a17090611d600b007adfd3e2a01mr1676063eja.545.1667349917423;
        Tue, 01 Nov 2022 17:45:17 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id f15-20020a50ee8f000000b00462e4de6891sm5102023edr.35.2022.11.01.17.45.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 17:45:16 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so364756wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 17:45:15 -0700 (PDT)
X-Received: by 2002:a1c:4c16:0:b0:3cf:6f1a:9038 with SMTP id
 z22-20020a1c4c16000000b003cf6f1a9038mr10071773wmf.151.1667349915421; Tue, 01
 Nov 2022 17:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221101233421.997149-1-swboyd@chromium.org>
In-Reply-To: <20221101233421.997149-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Nov 2022 17:45:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XkhtgL_4-cpj-Xi3uH6FAtmWhk5u6sfakXABTnv5eYvw@mail.gmail.com>
Message-ID: <CAD=FV=XkhtgL_4-cpj-Xi3uH6FAtmWhk5u6sfakXABTnv5eYvw@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gdsc: Remove direct runtime PM calls
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        GUARANTEED_100_PERCENT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 1, 2022 at 4:34 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We shouldn't be calling runtime PM APIs from within the genpd
> enable/disable path for a couple reasons.
>
> First, this causes an AA lockdep splat because genpd can call into genpd
> code again while holding the genpd lock.
>
> WARNING: possible recursive locking detected
> 5.19.0-rc2-lockdep+ #7 Not tainted
> --------------------------------------------
> kworker/2:1/49 is trying to acquire lock:
> ffffffeea0370788 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
>
> but task is already holding lock:
> ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&genpd->mlock);
>   lock(&genpd->mlock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 3 locks held by kworker/2:1/49:
>  #0: 74ffff80811a5748 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x320/0x5fc
>  #1: ffffffc008537cf8 ((work_completion)(&genpd->power_off_work)){+.+.}-{0:0}, at: process_one_work+0x354/0x5fc
>  #2: ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
>
> stack backtrace:
> CPU: 2 PID: 49 Comm: kworker/2:1 Not tainted 5.19.0-rc2-lockdep+ #7
> Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
> Workqueue: pm genpd_power_off_work_fn
> Call trace:
>  dump_backtrace+0x1a0/0x200
>  show_stack+0x24/0x30
>  dump_stack_lvl+0x7c/0xa0
>  dump_stack+0x18/0x44
>  __lock_acquire+0xb38/0x3634
>  lock_acquire+0x180/0x2d4
>  __mutex_lock_common+0x118/0xe30
>  mutex_lock_nested+0x70/0x7c
>  genpd_lock_mtx+0x24/0x30
>  genpd_runtime_suspend+0x2f0/0x414
>  __rpm_callback+0xdc/0x1b8
>  rpm_callback+0x4c/0xcc
>  rpm_suspend+0x21c/0x5f0
>  rpm_idle+0x17c/0x1e0
>  __pm_runtime_idle+0x78/0xcc
>  gdsc_disable+0x24c/0x26c
>  _genpd_power_off+0xd4/0x1c4
>  genpd_power_off+0x2d8/0x41c
>  genpd_power_off_work_fn+0x60/0x94
>  process_one_work+0x398/0x5fc
>  worker_thread+0x42c/0x6c4
>  kthread+0x194/0x1b4
>  ret_from_fork+0x10/0x20
>
> Second, this confuses runtime PM on CoachZ for the camera devices by
> causing the camera clock controller's runtime PM usage_count to go
> negative after resuming from suspend. This is because runtime PM is
> being used on the clock controller while runtime PM is disabled for the
> device.
>
> The reason for the negative count is because a GDSC is represented as a
> genpd and each genpd that is attached to a device is resumed during the
> noirq phase of system wide suspend/resume (see the noirq suspend ops
> assignment in pm_genpd_init() for more details). The camera GDSCs are
> attached to camera devices with the 'power-domains' property in DT.
> Every device has runtime PM disabled in the late system suspend phase
> via __device_suspend_late(). Runtime PM is not usable until runtime PM
> is enabled in device_resume_early(). The noirq phases run after the
> 'late' and before the 'early' phase of suspend/resume. When the genpds
> are resumed in genpd_resume_noirq(), we call down into gdsc_enable()
> that calls pm_runtime_resume_and_get() and that returns -EACCES to
> indicate failure to resume because runtime PM is disabled for all
> devices.
>
> Upon closer inspection, calling runtime PM APIs like this in the GDSC
> driver doesn't make sense. It was intended to make sure the GDSC for the
> clock controller providing other GDSCs was enabled, specifically the
> MMCX GDSC for the display clk controller on SM8250 (sm8250-dispcc), so
> that GDSC register accesses succeeded. That will already happen because
> we make the 'dev->pm_domain' a parent domain of each GDSC we register in
> gdsc_register() via pm_genpd_add_subdomain(). When any of these GDSCs
> are accessed, we'll enable the parent domain (in this specific case
> MMCX).
>
> We also remove any getting of runtime PM during registration, because
> when a genpd is registered it increments the count on the parent if the
> genpd itself is already enabled. And finally, the runtime PM state of
> the clk controller registering the GDSC shouldn't matter to the
> subdomain setup. Therefore we always assign 'dev' unconditionally so
> when GDSCs are removed we properly unlink the GDSC from the clk
> controller's pm_domain.
>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Satya Priya <quic_c_skakit@quicinc.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/clk/qcom/gdsc.c | 64 ++++++-----------------------------------
>  1 file changed, 8 insertions(+), 56 deletions(-)

One small nit is that the kernel doc for "@dev" in "struct gdsc" is
incorrect after your patch. It still says this even though we're not
using it for pm_runtime calls anymore:

 * @dev: the device holding the GDSC, used for pm_runtime calls

Other than that, this seems OK to me. I don't feel like I have a lot
of good intuition around PM Clocks and genpd and all the topics talked
about here, but I tried to look at the diff from before all the
"recent" patches to "drivers/clk/qcom/gdsc.c" till the state after
your patch. In other words the combined diff of these 4 patches:

clk: qcom: gdsc: Remove direct runtime PM calls
clk: qcom: gdsc: add missing error handling
clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled
clk: qcom: gdsc: enable optional power domain support

That basically shows a combined change that does two things:

a) Adds error handling if pm_genpd_init() returns an error.

b) Says that if "scs[i]->parent" wasn't provided that we can imply a
parent from "dev->pm_domain".

That seems to make sense, but one thing I'm wondering about for "b)"
is how you know that "dev->pm_domain" can be safely upcast to a genpd.
In other words, I'm hesitant about the "pd_to_genpd(dev->pm_domain)"
call. I'll assume that "dev->pm_domain" isn't 100% guaranteed to be a
genpd or else (presumably) we would have stored a genpd. Is there
something about the "dev" that's passed in with "struct gdsc_desc"
that gives the stronger guarantee about this being a genpd?


In any case, I will note that this seems to make the hang that I
described [1] go away. I never totally dug into why the patch was
tickling it, but I'm happy for now that it's back to not reproducing.
:-)


[1] https://lore.kernel.org/r/20220922154354.2486595-1-dianders@chromium.org


-Doug
