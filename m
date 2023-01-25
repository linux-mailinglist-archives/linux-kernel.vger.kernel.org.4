Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D0067AF54
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbjAYKIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjAYKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:08:53 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8AD32516
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:08:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id f11so457347pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ekQpdkJMaH8YaGTIBesy/IkLIBnP9FQ2VC8iw7R/F0=;
        b=raatX0cFeimVn8opFxRN9jpPHlRM3X7p1pF391BCIttZ2fwWoxqFp3El4MhskMZ/KE
         PiS5XP7VnpNVIPhxNNuL7bhkblasaxz5xc283zks6500Gr3F7byddiAaoyMGGHPiNM7D
         XIgt7SKWpoBNY+Abff9ZBM9bpnLNhFGN4RUz/hTJ81IFupEFsdKVAfjM2bxVoQbdWhD/
         RGwwpTMcEjy5ZK+D9QmmXGu1QiCCjHf5FqRdXQbWm4tSnUXccFooiy68dF1FsY/s/pEy
         vBszJ8pAM9a0x+9HXDXoJx/rcCo27RLH/+D8NP07PccL010UaY7JaM240nRqgzRQ9gGp
         1j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ekQpdkJMaH8YaGTIBesy/IkLIBnP9FQ2VC8iw7R/F0=;
        b=grengWMhGx2AbMkf9sqgkRomMbufInDAhJqJ02GBek2pJHrPJUskQREGpsqP69+4vD
         QsYuS4ntkmJHipbnexDtYqffyYMp6ZlLQbASWR0JbueyaVMImHm0w6Vy5eOIhCfrE58+
         oGYRKwKr8gjei2SkTgRZM6U78gVwGVPnaM+uSbQQ7ER1w3xAupsapQ9hP3+V6oxZRpef
         nm/V2O+Vnr+2uWUildSUmTYi0d4dLxaB8F0PU+g8c43LAQtzEY5Lt0NbAGWMXnrNxN1r
         AU1FgeT0f/N0M4vUjh/QpAbzZ2fGQ3GjZanWU11wx3AYy/PaxEuhGNsvExChAj4kF1vH
         FSWg==
X-Gm-Message-State: AFqh2konOVq95zQoP6K1P8v/hXi2vxoKwNvZzSYBoo6fPIKuVN15NikT
        eWy6Bc/7PljOkcjVhUfDVX54asZnjul2iEvz+3mhEQ==
X-Google-Smtp-Source: AMrXdXsksTQgDm0eEuAGBewfAnZPI6f3ECk9PVhAlHpJNiaECDQYX3E/cByZs37ogC/vZmvk3fazJDB6XW9XRqEwqSU=
X-Received: by 2002:a62:e80a:0:b0:58d:982a:f1ea with SMTP id
 c10-20020a62e80a000000b0058d982af1eamr2899393pfi.28.1674641320478; Wed, 25
 Jan 2023 02:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20230119184228.683892-1-krzysztof.kozlowski@linaro.org>
 <20230124153411.nwkbjgoqgkua2icm@bogus> <c247710b-369a-67d0-0637-b32192d25e4d@linaro.org>
In-Reply-To: <c247710b-369a-67d0-0637-b32192d25e4d@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Jan 2023 11:08:04 +0100
Message-ID: <CAPDyKFrS6OER2h3XmHMfbjBA09HT8LYN9A90TPjd0RPim3jMaw@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 at 08:43, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/01/2023 16:34, Sudeep Holla wrote:
> > On Thu, Jan 19, 2023 at 07:42:28PM +0100, Krzysztof Kozlowski wrote:
> >> The runtime Power Management of CPU topology is not compatible with
> >> PREEMPT_RT:
> >> 1. Core cpuidle path disables IRQs.
> >> 2. Core cpuidle calls cpuidle-psci.
> >> 3. cpuidle-psci in __psci_enter_domain_idle_state() calls
> >>    pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
> >>    spinlocks (which are sleeping on PREEMPT_RT).
> >>
> >> Deep sleep modes are not a priority of Realtime kernels because the
> >> latencies might become unpredictable.  On the other hand the PSCI CPU
> >> idle power domain is a parent of other devices and power domain
> >> controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).
> >>
> >> Disable the runtime PM calls from cpuidle-psci, which effectively stops
> >> suspending the cpuidle PSCI domain.  This is a trade-off between making
> >> PREEMPT_RT working and still having a proper power domain hierarchy in
> >> the system.
> >>
> >> Cc: Adrien Thierry <athierry@redhat.com>
> >> Cc: Brian Masney <bmasney@redhat.com>
> >> Cc: linux-rt-users@vger.kernel.org
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes since v1:
> >> 1. Re-work commit msg.
> >> 2. Add note to Kconfig.
> >>
> >> Several other patches were dropped, as this is the only one actually
> >> needed.  It effectively stops PSCI cpuidle power domains from suspending
> >> thus solving all other issues I experienced.
> >> ---
> >>  drivers/cpuidle/Kconfig.arm    | 3 +++
> >>  drivers/cpuidle/cpuidle-psci.c | 4 ++--
> >>  2 files changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> >> index 747aa537389b..24429b5bfd1c 100644
> >> --- a/drivers/cpuidle/Kconfig.arm
> >> +++ b/drivers/cpuidle/Kconfig.arm
> >> @@ -24,6 +24,9 @@ config ARM_PSCI_CPUIDLE
> >>        It provides an idle driver that is capable of detecting and
> >>        managing idle states through the PSCI firmware interface.
> >>
> >> +      The driver is not yet compatible with PREEMPT_RT: no idle states will
> >> +      be entered by CPUs on such kernel.
> >> +
> >
> > Any particular reason for even compiling this file in or allowing the
> > ARM_PSCI_CPUIDLE when PREEMPT_RT=y ? If we can't enter idle states, we
> > can as well compile this file out ?
>
> It's the power domain sued for other devices, so we need it. Otherwise
> other devices will keep waiting for this missing power domain provider.

Yes.

And we are still able to use those idle states that are solely per
CPU, which is probably nice to have. No?

Kind regards
Uffe
