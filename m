Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A637E6AFBFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCHBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCHBQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:16:13 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B78AB0A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:16:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v11so16183039plz.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 17:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678238167;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ild2aOAw0SSnaRUE1Z6/lJxrkOZZmZupy/Fq/JRIlso=;
        b=nUbraQvxaiPSqzqCATDgonC9FmtkQ0fxf3SeASKXE5yOb+an9bw9B18yNtNfh0UYqQ
         UchPiniXQ57F+9dl817EXAaDnP9yBtWw7ZTTh0v6X0e51DTvuQ+24KoLRNm6Ji22XKcF
         otS96Mfht1G2m9keg2wS7VZ0t0QUwhk9H9Fo/nOpYmN/YcSYbwJJY9XN/KINGxz2uqRW
         aq/n5FllulQtvDw9MEnX+agu6qGEQV6/cnR+hA6bBwOeP1cHty7R93e+yXsgcCaKeIvO
         2vpgMtTDNzsrWETSiwwGn5VvFuvngnl5nCbD3TK9OSHRA9nzJ1kTKlp66StNO3b7Ebfv
         Q+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238167;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ild2aOAw0SSnaRUE1Z6/lJxrkOZZmZupy/Fq/JRIlso=;
        b=fBToASu42rEmmBlWexkO1jVt6n7gloC7ALSa+wBXBIB2FRPHOvJP+eSE28uuo+TicH
         B3FOinlSbiTwabbRa5G4Qei+0dTpuVcTqZ71BcnQ3lqg5aqVsd6V4iLBxaKV9qCYYSVu
         BFhW6HRjyOgb8ITAhhKgiIFTEIK0ua/y+ZzTbHXuNjM5bC0ZyTUzjJGr2wjr0zm38t2S
         oOpEFIuwzYS64708U6z5KKJ7b/XTmQe0HDl1XZDbQUqQCkoIp7RHtyyCw/hALTSB5fp/
         C0cdDlUjnI8nPArkcC5Yd9b2KKvI+3MHuYwvMK5EIEHI7Jpx/XiqxPmkOr55JqsuTwYr
         AhHg==
X-Gm-Message-State: AO0yUKVx+eU5TPSgkMEIPPYdXPxe7gDZHNK7cApGOkHBZXtQ4/gE9WOm
        GIqo5PAM2/XYQfvienvppbNxQw==
X-Google-Smtp-Source: AK7set/1ndIB85fieFwPsMv5bffYHzdyjT8LWWI27Vh5jtWoWeEkcM/uXo3dtAqvP2JOPFHNOn9AIw==
X-Received: by 2002:a05:6a21:32a4:b0:c7:8644:a9f3 with SMTP id yt36-20020a056a2132a400b000c78644a9f3mr15671877pzb.11.1678238166923;
        Tue, 07 Mar 2023 17:16:06 -0800 (PST)
Received: from T480 (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q21-20020a62e115000000b0058bcb42dd1asm8452554pfh.111.2023.03.07.17.16.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Mar 2023 17:16:06 -0800 (PST)
Date:   Wed, 8 Mar 2023 09:15:55 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] cpuidle: psci: Iterate backwards over list in
 psci_pd_remove()
Message-ID: <20230308011554.GA18319@T480>
References: <20230304074107.59083-1-shawn.guo@linaro.org>
 <CAJZ5v0h9=vZwENELK+w7HnTTsayaNb1D7wnBgjsXvgopc_t-cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h9=vZwENELK+w7HnTTsayaNb1D7wnBgjsXvgopc_t-cA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 02:06:31PM +0100, Rafael J. Wysocki wrote:
> On Sat, Mar 4, 2023 at 8:41 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > In case that psci_pd_init_topology() fails for some reason,
> > psci_pd_remove() will be responsible for deleting provider and removing
> > genpd from psci_pd_providers list.  There will be a failure when removing
> > the cluster PD, because the cpu (child) PDs haven't been removed.
> >
> > [    0.050232] CPUidle PSCI: init PM domain cpu0
> > [    0.050278] CPUidle PSCI: init PM domain cpu1
> > [    0.050329] CPUidle PSCI: init PM domain cpu2
> > [    0.050370] CPUidle PSCI: init PM domain cpu3
> > [    0.050422] CPUidle PSCI: init PM domain cpu-cluster0
> > [    0.050475] PM: genpd_remove: unable to remove cpu-cluster0
> > [    0.051412] PM: genpd_remove: removed cpu3
> > [    0.051449] PM: genpd_remove: removed cpu2
> > [    0.051499] PM: genpd_remove: removed cpu1
> > [    0.051546] PM: genpd_remove: removed cpu0
> >
> > Fix the problem by iterating the provider list reversely, so that parent
> > PD gets removed after child's PDs like below.
> >
> > [    0.029052] CPUidle PSCI: init PM domain cpu0
> > [    0.029076] CPUidle PSCI: init PM domain cpu1
> > [    0.029103] CPUidle PSCI: init PM domain cpu2
> > [    0.029124] CPUidle PSCI: init PM domain cpu3
> > [    0.029151] CPUidle PSCI: init PM domain cpu-cluster0
> > [    0.029647] PM: genpd_remove: removed cpu0
> > [    0.029666] PM: genpd_remove: removed cpu1
> > [    0.029690] PM: genpd_remove: removed cpu2
> > [    0.029714] PM: genpd_remove: removed cpu3
> > [    0.029738] PM: genpd_remove: removed cpu-cluster0
> >
> > Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> 
> So I guess there should be Cc: stable for 5.10 and later?

Yes.  I was thinking that stable team will pick it up due to the Fixes
tag, but yes, explicitly copying stable would be the best.

> 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > Hi Rafael,
> >
> > This is a resend of the patch [1].  Could you help pick it up or let me
> > know if there is anything need to be improved, thanks!
> 
> Is this regarded as 6.3-rc material, or can it wait for 6.4?

As it's regarded as a fix, it would nice to apply it for 6.3-rc.

Shawn
