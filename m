Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42474728F00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjFIEja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFIEj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:39:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B70330EC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:39:25 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39c84863e7cso312376b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 21:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686285565; x=1688877565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bcEflOU4iUVjcAk/wdq8BgKNM3U6s2M2OfqszliSE8=;
        b=GmzTSyNHSEqe2Wm4Sz/AaNNuwPm4RZEJGpl6eGc6KmwuxjU5fU+CLR75jh7Avk3fep
         1LRlZeh9e2sTz95yAxsGxfXmIcVOlpHZ//qu7nj4SSM+bH0+xXbAcD5lvQ5pWdNj/d2d
         mdh1PPUsUbKpYUd7b6zvQ5MbrQ8JvwUsyaMYu74B4h6AdbFrhiG4pAahCRvogSvBKySh
         Xgasz0tT3bUns/aFqabf1R6Ulv0K5GFTETDd+adFetaZnS9I7gp0SHzx8Yyh+5le8ytJ
         igpZUqjZTh3ANWHxfGsW8OwwGF8Q7gQpirr5QVKaddlJzcuNTZ/3pUY+iDY2/UDeloX7
         F4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285565; x=1688877565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bcEflOU4iUVjcAk/wdq8BgKNM3U6s2M2OfqszliSE8=;
        b=gvxhTKzHOU42Rq91OmxzM1/sUxuLrFsIA7HxNTbyA0yNXP7uDBdePHT7SmdI7q9izf
         QfQc5ZDxEsQlWA70jIbcZ0EZc5Q0XRp/Wa/zIuVO7uXcbCRgvrljNbrW3N1T30CEV+nr
         K53j8KjUMpaOqc+urP3obWPBzeGKV/aFyFq808VhuK4pAZ3lxWvSvrAASzlTn9houdTV
         A2R6YUfJ6WncichBl3tALJwOO0SocifyLHeKXVc1wvUNqcAuPZpD95gaPSlMgP4z/Cb6
         +OWfCZzJ6VvDrCc3V+a3KE5ZRI0NjWweADTbUgzbXNlspwUhfFKaisC7ESyhGiiKa/eL
         Oq4w==
X-Gm-Message-State: AC+VfDz11hOxjHrirwK5uWPHtQwRTUxE405czga0z/rYt8riqk7XMK79
        c5LTv/ZqzOnP8l5ZOIvddYBOxw==
X-Google-Smtp-Source: ACHHUZ4f3urZQiUQUFHTuUkleJmR9aUE5AHvJV+LrNRJat3QjIrPLAWNLGuGPzoB5sI6JReuh+wmbw==
X-Received: by 2002:aca:101a:0:b0:398:59fe:6ee3 with SMTP id 26-20020aca101a000000b0039859fe6ee3mr451486oiq.54.1686285564707;
        Thu, 08 Jun 2023 21:39:24 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id lk16-20020a17090b33d000b0025374fedab4sm3795283pjb.22.2023.06.08.21.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 21:39:24 -0700 (PDT)
Date:   Fri, 9 Jun 2023 10:09:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will@kernel.org, rafael@kernel.org,
        sudeep.holla@arm.com, ionela.voinescu@arm.com, sumitg@nvidia.com,
        yang@os.amperecomputing.com, Len Brown <len.brown@intel.com>,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <20230609043922.eyyqutbwlofqaddz@vireshk-i7>
References: <20230606155754.245998-1-beata.michalska@arm.com>
 <20230608051509.h4a6gn572mjgdusv@vireshk-i7>
 <20230608051816.2ww7ncg65qo7kcuk@vireshk-i7>
 <ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-23, 15:45, Beata Michalska wrote:
> For those CPUs that are in full dynticks mode , the arch_freq_scale_factor will
> be basically useless (as there will be no regular sched_tick which eventually
> calls topology_scale_freq_tick()), so the code below will look for any other
> available CPU within current policy that could server as the source of the
> counters. If there is none it will fallback to cpufreq driver to provide
> current frequency.

Understood.

> There is a little bit of ambiguity around both 'cpuinfo_cur_freq' and
> 'scaling_cur_freq' and how those two are being handled on different platforms.
> If I got things right, the first one is supposed to reflect the frequency as
> obtained from  the hardware,

Yes, this must be accurate, as much as possible.

> whereas the latter is more of a sw point of view on that,

Historically, it was more about the last frequency requested by the software.
But that has changed, for example for X86 and now there is no limitation here
which disallows one to report the more accurate one.

> That could work, I guess. But then we would have 'cpuinfo_cur_freq' ==
> 'scaling_cur_freq' for platforms that do provide arch_freq_get_on_cpu,
> which might lead to more confusion as per what is the actual difference between
> the two (?)

The behavior should be same for all platforms. That's my primary concern here.
If getting same freq from both these files is okay for X86, then it should be
for ARM as well.

If the X86 commit (f8475cef9008) wasn't already merged, I would have suggested
to do this aperf/mperf thing only in cpuinfo_cur_freq() and not
scaling_cur_freq().

Maybe we can still revert back if there is no hard dependency here.

Len / Rafael ?

The question is if we should make scaling_cur_freq() to always return the last
requested frequency and make cpuinfo_cur_freq() to return the most accurate one,
preferably using aperf/mperf ?

-- 
viresh
