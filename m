Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19863615A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiKBD35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiKBD3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:29:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF202649D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:29:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id be13so26237747lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKlZFLQoOIAO4LNc5IIof0dGye9IlGMG8e3bXJR87d4=;
        b=LX2kR4FnaqTB5X4KJKL0kO3ZLojgqOXHaQzGTjioK4YsYaNL64BzWTf/4unMGCju5G
         dtzlPaM5Kd1KHDGxhgvkpq1xgr6QqOnPpKkNMAOw562FUbnz7KO6NpclaKUw4mB5ehFG
         jpp+OF5ubCq9KW9iLaqnkGqsofsFgDT6bedKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKlZFLQoOIAO4LNc5IIof0dGye9IlGMG8e3bXJR87d4=;
        b=4N8J+cvXbxBv+7rAIo5/1qjx9+kHfMGYTl5h0KijIaC7iBadjL5kBbug0h82JkYcKD
         o0PgYF5lPhE6rut1BnIhr2ghOBex/nNsF6p0sS8P4mSUBWt443XMvM+WkomE2oSRg+AS
         YgSjvj8kE2oob/EoIw4BI22JxhQuuFXSnVq7mdGyzZ3gRx95e5MWEQ9L3IRKcgtynMoX
         OcAH3rDbBhayZIpAHXvgRTzUkyWtVvUXUxCeHqGvXbPWFIdJ4WaatELbvBFLQMMrdFPV
         mQaPwkmzS1gJ/R3esprtfglUd+QpOO0Rub6Iadms9X7q7fJ9i3FQB5E2bq5l/9Wu2rvf
         81Ww==
X-Gm-Message-State: ACrzQf3DhUDgsGaeqKoBzmBzB57O8PV59Z0mFPjLz6ooKXKP+U/4POoI
        ySAxiRre1MaKo4G5wDnxgzX4uyhSrhUA/xoNM/o8kw==
X-Google-Smtp-Source: AMsMyM5ZD/clrC9Dvhtr0Y3CzvqOq0IoUZD4MVNwUAPNrsOtrhTTF7pk8evY6CcHsU6n6gxtRSPMaUUQmH5ySoh748o=
X-Received: by 2002:a05:6512:3403:b0:48c:9727:50b0 with SMTP id
 i3-20020a056512340300b0048c972750b0mr8100340lfr.309.1667359761658; Tue, 01
 Nov 2022 20:29:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Nov 2022 20:29:20 -0700
MIME-Version: 1.0
In-Reply-To: <20221102024927.n5mjyzyqyapveapa@builder.lan>
References: <20221101233421.997149-1-swboyd@chromium.org> <20221102024927.n5mjyzyqyapveapa@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 1 Nov 2022 20:29:20 -0700
Message-ID: <CAE-0n50uVf-xapfX5A_c7XU7gV58HrKBOf5DCUPCcahPrgkU0Q@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gdsc: Remove direct runtime PM calls
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-11-01 19:49:27)
> On Tue, Nov 01, 2022 at 04:34:21PM -0700, Stephen Boyd wrote:
> > We shouldn't be calling runtime PM APIs from within the genpd
> > enable/disable path for a couple reasons.
> [..][
> > Upon closer inspection, calling runtime PM APIs like this in the GDSC
> > driver doesn't make sense. It was intended to make sure the GDSC for the
> > clock controller providing other GDSCs was enabled, specifically the
> > MMCX GDSC for the display clk controller on SM8250 (sm8250-dispcc), so
> > that GDSC register accesses succeeded. That will already happen because
> > we make the 'dev->pm_domain' a parent domain of each GDSC we register in
> > gdsc_register() via pm_genpd_add_subdomain(). When any of these GDSCs
> > are accessed, we'll enable the parent domain (in this specific case
> > MMCX).
> >
>
> It's correct that adding the GDSCs as subdomains for the device's
> parent-domain will ensure that enabling a GDSC will propagate up and
> turn on the (typically) rpmhpd resource.
>
> But the purpose for the explicit calls was to ensure that the clock
> controller itself is accessible. It's been a while since I looked at
> this, but iirc letting MMCX to turn off would cause the register access
> during dispcc probing to fail - similar to how
> clk_pm_runtime_get()/put() ensures the clock registers are accessible.

The dispcc and videocc on sm8250 don't use pm_clk APIs. They do use
pm_runtime APIs during probe (i.e. pm_runtime_resume_and_get()). That
will enable the MMCX domain and keep it on. Then when the GDSCs are
registered it will create genpds for each GDSC and make them subdomains
of the 'dev->pm_domain' genpd for MMCX. If the GDSCs are enabled at
probe time they will increment the count on MMCX to put the count into
sync between MMCX and the GDSC provided.

The clk framework also has runtime PM calls throughout the code to make
sure the device is runtime resumed when it is accessed. Maybe the
problem is if probe defers and enough runtime puts are called to runtime
suspend the device thus disabling MMCX? Can MMCX really ever be disabled
or does disabling it act as a one way disable where you can never enable
it again?

Or maybe this is the problem where not all constraints are determined
yet but we're letting runtime PM put calls from the dispcc device shut
down the entire multimedia subsystem while other devices that are within
the same domain haven't probed and been able to sync their state but
they're actively accessing the bus (i.e. continuous splash screen). I
could see this problem being avoided by the pm_runtime_get() call in
gdsc registration keeping MMCX on forever because there isn't a matching
put anywhere.

>
> Perhaps I misunderstood something in the process, or lost track of the
> actual issues?

I dunno. It clearly is a problem to call runtime PM in the noirq phase
of system suspend though.
