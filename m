Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33171688777
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBBTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjBBTUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:20:45 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50AC8000B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:20:23 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c2so3077545qtw.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JXDOSIgEEoHR6xTZYXK64ggEfAX9oGh0xr53bP11U+I=;
        b=L8jTekOKG7ZkdA59DuF4ggneg4XbzgOCkCPGFxmBkHXzkeKPFn1dHq8BsBArzQ70lM
         xMv/JuswS+sNL9Ef+sdqxPdJyZfAR/afJyB7Bn0di3cCO53pWQjCpvKm6Jun/fRWlUL4
         iUYvhfpGl3yRUBIl+3e+5eUTvQworRHZo1vrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXDOSIgEEoHR6xTZYXK64ggEfAX9oGh0xr53bP11U+I=;
        b=LLCwx4lfXF+laShx8TsQtLZvfEplahmiuxNh6LJICwc/vsatzajiGQE1uksnYlHpNJ
         2oevHiXlts2RlkK/fIann5qFErYYocBzlACFgdtOeC7VBCbtRve+L+FHou8AfgKQjifZ
         alreW/PBKmJKGpjwiLU3zKsXFYH6HelqHNoT87FVOiUXHZ4m551tdbPOAC/B6lxh+U+R
         aNyvx0s+EPSxDvw9yHEfTozB2suMb5N4HpMwXwadgsB2UvddZyk3timNYMNPnG4aUpw2
         E5M2OX/XjdKrhmpvw3J4fvSZQmYj6/0Sobei+kJm5eiEKUYYh4lsbgcpJoABhOx5IjoP
         mRUg==
X-Gm-Message-State: AO0yUKVmM3CfRnoY7jIyweVRiQsscPc45BydyncsKzjlYqfF4YYF7w6z
        7lLr028OpRMACPhp9N9tZ4qycPIFhpCvcMp7
X-Google-Smtp-Source: AK7set+Pf7CWgPzo3Nmq4rwVc5cMo4eZHRQH0ZWu2kxqQBOIIV3+zYoeLtsJU8ts/Qn98T+IXTJTfg==
X-Received: by 2002:a05:622a:290:b0:3b9:c0b4:8afe with SMTP id z16-20020a05622a029000b003b9c0b48afemr4806062qtw.2.1675365622613;
        Thu, 02 Feb 2023 11:20:22 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id o11-20020ac8698b000000b003b9f1b7895asm139750qtq.10.2023.02.02.11.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:20:20 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 123so3533244ybv.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:20:20 -0800 (PST)
X-Received: by 2002:a25:ab2e:0:b0:862:2861:6e7b with SMTP id
 u43-20020a25ab2e000000b0086228616e7bmr168861ybi.211.1675365619797; Thu, 02
 Feb 2023 11:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20230127104054.895129-1-abel.vesa@linaro.org> <Y9v/z8CYik3faHh7@google.com>
In-Reply-To: <Y9v/z8CYik3faHh7@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Feb 2023 11:20:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XsiANcf1bp9aVuiQsDD8cRO=yzWMW7pffHwv9D9djvfw@mail.gmail.com>
Message-ID: <CAD=FV=XsiANcf1bp9aVuiQsDD8cRO=yzWMW7pffHwv9D9djvfw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 2, 2023 at 10:24 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Abel,
>
> On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > Currently, there are cases when a domain needs to remain enabled until
> > the consumer driver probes. Sometimes such consumer drivers may be built
> > as modules. Since the genpd_power_off_unused is called too early for
> > such consumer driver modules to get a chance to probe, the domain, since
> > it is unused, will get disabled. On the other hand, the best time for
> > an unused domain to be disabled is on the provider's sync_state
> > callback. So, if the provider has registered a sync_state callback,
> > assume the unused domains for that provider will be disabled on its
> > sync_state callback. Also provide a generic sync_state callback which
> > disables all the domains unused for the provider that registers it.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >
> > This approach has been applied for unused clocks as well.
> > With this patch merged in, all the providers that have sync_state
> > callback registered will leave the domains enabled unless the provider's
> > sync_state callback explicitly disables them. So those providers will
> > need to add the disabling part to their sync_state callback. On the
> > other hand, the platforms that have cases where domains need to remain
> > enabled (even if unused) until the consumer driver probes, will be able,
> > with this patch in, to run without the pd_ignore_unused kernel argument,
> > which seems to be the case for most Qualcomm platforms, at this moment.
>
> I recently encountered a related issue on a Qualcomm platform with a
> v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> highest corner until sync_state"). The issue involves a DT node with a
> rpmhpd, the DT node is enabled, however the corresponding device driver
> is not enabled in the kernel. In such a scenario the sync_state callback
> is never called, because the genpd consumer never probes. As a result
> the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> system suspend, which results in a substantially higher power consumption
> in S3.
>
> I wonder if genpd (and some other frameworks) needs something like
> regulator_init_complete(), which turns off unused regulators 30s after
> system boot. That's conceptually similar to the current
> genpd_power_off_unused(), but would provide time for modules being loaded.

Just for completeness, there are at least a few other similar concepts
in the kernel where the kernel needs to decide that it's going to stop
waiting for modules to show up and it just shuts off anything that's
unused. The other one that jumps to the top of my head is related to
"driver_deferred_probe_timeout". There we give 10 seconds (by default)
for userspace to load modules. After that point in time we start
returning errors instead of waiting longer. You can even see that the
default depends on whether "CONFIG_MODULES" is set.

-Doug
