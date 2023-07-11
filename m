Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D085274E6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGKGBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGKGBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:01:12 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE73E4B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:01:08 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b8a6ca994eso4688379a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689055268; x=1691647268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kP2Qn64jJ8vkju5gUnFLPppk/VOAK+fecMr3ry9BHWE=;
        b=jFqQrHVm4ADc4ms2fN447ZE1LEYqCrYggX8571mB2EXc0a9usoDIXpGo6hDohKMgyF
         YMOeKoKd+rsGjUq3ji8SQFVEhXJxi4MeaoH+nAKAfizkFLfxTXIAX+xrek/oZ0LWWWfR
         B2cGKDbrAcK34mvMGHsdg73km/566rbPSSQFTjhdUish+SwJ4zVH/xQQIumfjg+NsGrX
         zurYXwT4eKVOpKgTIECucu3wwcqE9ZBNMWG67Ooo6B2vWc6Z8z4Rp41z0cyaOSzqL3ne
         HxIOcv/26QTSgv0Ljte0nTI/gIKcNUKYZe1xLYtTSfoSZIENh3FiSf3M4jh0WTpFhZWr
         eLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055268; x=1691647268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP2Qn64jJ8vkju5gUnFLPppk/VOAK+fecMr3ry9BHWE=;
        b=DnrwIPS1YTtPpuc8INNnV81jsJ5bpje5eAaI9Bh5zH8BR8geGk86D7diCXTtg7+L3/
         6seiMsvkgFtA96SsgGNVy/DURi8/cZ5ifmHl+D9gQ0u6t/OC0hvLU45yEFHeqY7Jj01U
         QDFTkmBZPiqF5tT/PoULaHp/WgLwFy9l9qHWHQsDsnDOjwfE3U9SCCNW8l0RwauKxUHv
         zEQ7mK8UD7W9ocS9zTe6ToaHDnjwWtbSHZLDVJzIBV+MvPrf9QsalBdLTEeqDGOzTNlD
         Re23ys+X7BS5irY/1uynt8GzqBNPRDekZA08/44gkmfH0Us8FdPx/doxtpXMqoSBI130
         VW5A==
X-Gm-Message-State: ABy/qLayXIKcuz3KJrTPcSwC7QPqSK6tmZkW7VWYa0Lni+mcMEwWVKAN
        X2qcBHA0zp/PpnJStr3UexamKb9/0kthW6QGiEk=
X-Google-Smtp-Source: APBJJlHRSt1CS4ZNrXn86/Rkb0QRE4QmBMGeSdPZEPvWtIoRG0nciNIsyAS3LkcL1bMDsvA4h3Ijag==
X-Received: by 2002:a9d:744b:0:b0:6b8:8269:aa3e with SMTP id p11-20020a9d744b000000b006b88269aa3emr14739905otk.14.1689055267769;
        Mon, 10 Jul 2023 23:01:07 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b00263d7c5323dsm885421pjp.49.2023.07.10.23.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 23:01:07 -0700 (PDT)
Date:   Tue, 11 Jul 2023 11:31:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: Build regressions/improvements in v6.5-rc1 (cpufreq/sparc*)
Message-ID: <20230711060103.al3qpticc53qy4mp@vireshk-i7>
References: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
 <20230710100012.2625532-1-geert@linux-m68k.org>
 <b464f2b4-d2bc-11e0-bb2e-45ff43934bf6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b464f2b4-d2bc-11e0-bb2e-45ff43934bf6@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-07-23, 22:33, Randy Dunlap wrote:
> Hi--
> 
> On 7/10/23 03:00, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v6.5-rc1[1] compared to v6.4[2].
> > 
> > Summarized:
> >   - build errors: +3/-4
> >   - build warnings: +36/-18
> > 
> > Note that there may be false regressions, as some logs are incomplete.
> > Still, they're build errors/warnings.
> > 
> > Happy fixing! ;-)
> > 
> > Thanks to the linux-next team for providing the build service.
> > 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5/ (all 162 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (160 out of 162 configs)
> > 
> > 
> > *** WARNINGS ***
> > 
> > 36 warning regressions:
> 
> >   + modpost: WARNING: modpost: drivers/cpufreq/sparc-us2e-cpufreq: section mismatch in reference: cpufreq_us2e_driver+0x20 (section: .data) -> us2e_freq_cpu_init (section: .init.text):  => N/A
> >   + modpost: WARNING: modpost: drivers/cpufreq/sparc-us3-cpufreq: section mismatch in reference: cpufreq_us3_driver+0x20 (section: .data) -> us3_freq_cpu_init (section: .init.text):  => N/A
> 
> The way that I read this is that these __init functions (us2e_freq_cpu_init and us3_freq_cpu_init)
> should not be marked as __init since they can be called at any time by exercising the CPU hotplug
> code path.

I have prepared a patch for this, waiting for some builds to finish
before sending it.

-- 
viresh

Subject: [PATCH] cpufreq: sparc: Don't mark cpufreq callbacks with __init

These callbacks can be called again by the cpufreq core after the driver
is initialized and must be kept around. We currently get section
mismatch build warnings.

Don't mark them with __init.

Fixes: dcfce7c2cee4 ("cpufreq: sparc: Don't allocate cpufreq_driver dynamically")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

 drivers/cpufreq/sparc-us2e-cpufreq.c | 2 +-
 drivers/cpufreq/sparc-us3-cpufreq.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index d3510cfdb3eb..2783d3d55fce 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -269,7 +269,7 @@ static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
 	return smp_call_function_single(cpu, __us2e_freq_target, &index, 1);
 }
 
-static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
+static int us2e_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index 91d1ed558136..6c3657679a88 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -117,7 +117,7 @@ static int us3_freq_target(struct cpufreq_policy *policy, unsigned int index)
 	return smp_call_function_single(cpu, update_safari_cfg, &new_bits, 1);
 }
 
-static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
+static int us3_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
