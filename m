Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3608861876F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKCSZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:25:52 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099C31A203;
        Thu,  3 Nov 2022 11:25:51 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id c15so1767243qtw.8;
        Thu, 03 Nov 2022 11:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wqjlvfob7OA40NjGEU4olyxWzhDQZWGXkHy6aPsYtY=;
        b=numkZY8r1Gb4hHtbjr+YvrX08pu8Ly+cU/fW+DI8/qJ7IytElnXIOH3vTKXe8KbhPx
         drd4I2mqICLdVgyfQN7i0cu89GvHP/r7wkrBpdlKH+qtUdiea55TcEnHlMwkKpWAMXpt
         Ex0hhiJoivzIxKvoKPH7cIBnlFZ5pENsK4iVbII9f3Tr3P00mdySqUFcxHWAxSGKHQz1
         SFRXdugcerqjpJ45AUua+MXCBSUGmFAlrqYpOwzisNtTKeK0e4hHnL9Q5NbiXd2h3k6d
         3op0BmhLhODUUY5KaY34dEcTWLUH/uZqj1ug+877Y906opn0e2bJ9Uw9CVlvS0mRqgyE
         HcdQ==
X-Gm-Message-State: ACrzQf3oTUoLWpYLh91RoiOUZ0Vrok2Dyc5h3d02WuPCOXIwY6izXzvG
        Itj8qrzzSB9ST4JoAwB/xhSq1nbyNk1PLGpZ9Rg=
X-Google-Smtp-Source: AMsMyM7ssy9s6uiXREhds9ukxe6eFdRWpC2c9GJHYElZSTMpxx2pXUVj8pKRa6hV1mlvx7P/I0c+tm4YOIBhYoxt8b0=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr26026848qtb.147.1667499950150; Thu, 03
 Nov 2022 11:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221027220056.1534264-1-srinivas.pandruvada@linux.intel.com> <CAJZ5v0hVaO-j6PEZ0u+uz==0it3qvZ8XdkrXk4F2x692OfgBcQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hVaO-j6PEZ0u+uz==0it3qvZ8XdkrXk4F2x692OfgBcQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:25:38 +0100
Message-ID: <CAJZ5v0gMgq+=WvzL8yiKr6AW9+dGb9w5uVOYjthC6a1HJRXMOQ@mail.gmail.com>
Subject: Re: [PATCH] x86: intel_epb: Set Alder Lake N and Raptor Lake P normal EPB
To:     dave.hansen@linux.intel.com, bp@alien8.de
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        rafael@kernel.org, len.brown@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 5:24 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 28, 2022 at 12:01 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > Intel processors support additional software hint called EPB ("Energy
> > Performance Bias") to guide the hardware heuristic of power management
> > features to favor increasing dynamic performance or conserve energy
> > consumption.
> >
> > Since this EPB hint is processor specific, the same value of hint can
> > result in different behavior across generations of processors.
> >
> > commit 4ecc933b7d1f ("x86: intel_epb: Allow model specific normal EPB
> > value")' introduced capability to update the default power up EPB
> > based on the CPU model and updated the default EPB to 7 for Alder Lake
> > mobile CPUs.
> >
> > The same change is required for other Alder Lake-N and Raptor Lake-P
> > mobile CPUs as the current default of 6 results in higher uncore power
> > consumption. This increase in power is related to memory clock
> > frequency setting based on the EPB value.
> >
> > Depending on the EPB the minimum memory frequency is set by the
> > firmware. At EPB = 7, the minimum memory frequency is 1/4th compared to
> > EPB = 6. This results in significant power saving for idle and
> > semi-idle workload on a Chrome platform.
> >
> > For example Change in power and performance from EPB change from 6 to 7
> > on Alder Lake-N:
> >
> > Workload    Performance diff (%)    power diff
> > ----------------------------------------------------
> > VP9 FHD30       0 (FPS)         -218 mw
> > Google meet     0 (FPS)         -385 mw
> >
> > This 200+ mw power saving is very significant for mobile platform for
> > battery life and thermal reasons.
> >
> > But as the workload demands more memory bandwidth, the memory frequency
> > will be increased very fast. There is no power savings for such busy
> > workloads.
> >
> > For example:
> >
> > Workload                Performance diff (%) from EPB 6 to 7
> > -------------------------------------------------------
> > Speedometer 2.0         -0.8
> > WebGL Aquarium 10K
> > Fish                    -0.5
> > Unity 3D 2018           0.2
> > WebXPRT3                -0.5
> >
> > There are run to run variations for performance scores for
> > such busy workloads. So the difference is not significant.
> >
> > Add a new define ENERGY_PERF_BIAS_NORMAL_POWERSAVE for EPB 7
> > and use it for Alder Lake-N and Raptor Lake-P mobile CPUs.
> >
> > This modification is done originally by
> > Jeremy Compostella <jeremy.compostella@intel.com>.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'm wondering if there are any plans to pick up this one into the x86
tree?  If not, I can take care of it.

> > ---
> >  arch/x86/include/asm/msr-index.h | 1 +
> >  arch/x86/kernel/cpu/intel_epb.c  | 7 ++++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 10ac52705892..a3eb4d3e70b8 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -796,6 +796,7 @@
> >  #define ENERGY_PERF_BIAS_PERFORMANCE           0
> >  #define ENERGY_PERF_BIAS_BALANCE_PERFORMANCE   4
> >  #define ENERGY_PERF_BIAS_NORMAL                        6
> > +#define ENERGY_PERF_BIAS_NORMAL_POWERSAVE      7
> >  #define ENERGY_PERF_BIAS_BALANCE_POWERSAVE     8
> >  #define ENERGY_PERF_BIAS_POWERSAVE             15
> >
> > diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> > index fbaf12e43f41..3b8476158236 100644
> > --- a/arch/x86/kernel/cpu/intel_epb.c
> > +++ b/arch/x86/kernel/cpu/intel_epb.c
> > @@ -204,7 +204,12 @@ static int intel_epb_offline(unsigned int cpu)
> >  }
> >
> >  static const struct x86_cpu_id intel_epb_normal[] = {
> > -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 7),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,
> > +                                  ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,
> > +                                  ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,
> > +                                  ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
> >         {}
> >  };
> >
> > --
> > 2.31.1
> >
