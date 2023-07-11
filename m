Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E68874F79B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjGKR4D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGKR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:56:00 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB75E6F;
        Tue, 11 Jul 2023 10:55:59 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-991f9148334so136085466b.1;
        Tue, 11 Jul 2023 10:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689098158; x=1689702958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgzkTpou4QHWe/2pRU5/Ualjk4fqFrZ7g3GXd8Lq7w0=;
        b=Aael6yJrk4vFb+kkrEpRltvxqep9zR7L7HZTRlYPA6BzyJXCVbz7BVk3n5FQBUeEkN
         ibrDCaWhv/f/7MOk2Jwna+8A+msomxduohnKYn0MmIOlY270r5iThwzoHi9WTJVYBD8s
         M5a8oVeQAMSSq1j5iaHwfgdjnjRVgqGW4vNuxZE3vIMAGDExrjPiqbDXCJE5Q/Zxp7Y6
         Y+7LJqX7nT/xdo1MQFTyZDrZafkm0QDlUqaLiDHANXFeV0sMf/XdMWS54QneITy98RoY
         5LxUTRSI2ciU2Zt249lnz9qg2NK4qotqCXx2q4LIGb0kjMuvCEEzwIzOplydYDUGMpvk
         M8fQ==
X-Gm-Message-State: ABy/qLbQO2+a5xGDnrtTqHL0w+qsO7Ptlif48w15p92ia5CzX/9WsDjV
        aZ30L7YR1GkKHnhvPRtANGHL0D4Ru/yBsWfB970=
X-Google-Smtp-Source: APBJJlGC2MUe+TO2cMb4ulCnph/8unEsh7CuN6Cs5UgUC9dDBiaQdPncuQL/pkLElhudtTiNMSZo/8hHmXqHA27UlI4=
X-Received: by 2002:a17:906:739a:b0:993:f349:c989 with SMTP id
 f26-20020a170906739a00b00993f349c989mr9105584ejl.7.1689098157990; Tue, 11 Jul
 2023 10:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230711-cpuidle-v1-0-f391224b3140@gmail.com> <20230711-cpuidle-v1-2-f391224b3140@gmail.com>
In-Reply-To: <20230711-cpuidle-v1-2-f391224b3140@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jul 2023 19:55:46 +0200
Message-ID: <CAJZ5v0hBJoCHk_hFN2unez+Qi9v_zAFCZHXHa=Rb95pCFRLk6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: s2idle: Fully prevent the system from entering
 s2idle when cpuidle isn't supported
To:     Kazuki Hashimoto <kazukih0205@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 7:54 AM Kazuki Hashimoto <kazukih0205@gmail.com> wrote:
>
> In order for systems to properly enter s2idle, we need functions both in
> the idle subsystem (such as call_cpuidle_s2idle()) and the suspend subsystem
> to be executed.
>
> s2idle got blocked in the idle subsystem on platforms without cpuidle after
> commit ef2b22ac540c ("cpuidle / sleep: Use broadcast timer for states that stop
> local timer").

What do you mean by "blocked in the idle subsystem"?

> However, the suspend subsystem doesn't have this, which can cause
> the suspend subsystem to begin entering s2idle behind the idle subsystem's back,

What do you mean by this?

> which in turn can cause the system to enter s2idle even though all the functions
> necessary for s2idle hasn't been executed, breaking the system
> (e.g. ClOCK_MONOTONIC keeps ticking during suspend even though it's not supposed
> to).

Why is this a problem?

> Prevent the system from entering s2idle when cpuidle isn't supported in the
> suspend subsystem as well.

I'm sure that there's a real problem you're trying to address, but I
cannot help you without understanding what the problem is.

So please explain what exactly is going on, what is expected to happen
and what happens instead and why this is problematic.

Till then, the patches are not going anywhere.

Thanks!
