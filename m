Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE270E0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbjEWPsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjEWPsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:48:20 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A67A188
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:48:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7747df5b674so101286539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684856893; x=1687448893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x5e13pLue9gd0mjknfh1ueHFaOMB2mYai6GBGGHDPQ=;
        b=KjrRyvq7itVM9XQaqT/hcFVQSwSdUzYfE35MLyguHdED9Paww08dYB3LGRhGOp4KPO
         XCoHv/2pN1/uk1TwHkUoMUaBjOlrjnPPaa7meZ4OoOXRgjRu+29SfpByT0gJN9B9eBOT
         IhmuoPZZN5zTcXPuQ0aOo7JXPQKbzsId7PMWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684856893; x=1687448893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x5e13pLue9gd0mjknfh1ueHFaOMB2mYai6GBGGHDPQ=;
        b=APd6HYNwugvqyfUQgal/HO/NcFfQHuJDF1Y/exmnw6Hn+wDCgCe3EY3i6R0kTYYZOQ
         OlUxKLFLPuxdR7KGY88K9q1c4StupJGHmuwEAJVGP7Njg0XhZhdnhmPa+WKz0bNdseeD
         +775zh9HujQQIhIMW0vuE0H5iJmnDwkwiokujnawDQ0/mijZPXqhyJabHRuBItmYJAax
         OrGhbs/9u5LWFu1yet4R8LFS7h9YvY7oo8XH8OKkWxgA2T35ptRlxuqwCFBNbvfQ5Uzq
         kn7XJe7jKodVpWtZBqKN6/5dA18PyAeX7Rd5sohDE4i1pHvpVHFDSqD7VM9RLMXMpg2Y
         V5VQ==
X-Gm-Message-State: AC+VfDzA5Unw/vu8mz106t+2RcvPtjfpgYFwpMY+mCLEPyF5u4gFPBSJ
        6H2eERN5xHu6KBCbo79WTdqh0AZK+Fie2BMlKeU=
X-Google-Smtp-Source: ACHHUZ5wINZVKNQDt6NVBg1ScCiy2jjJ9GY5doRzUYEQFRjj1oJoYzrXny3q0dhY1KT99MM8+GZB3w==
X-Received: by 2002:a5d:91cb:0:b0:76c:71dc:55f3 with SMTP id k11-20020a5d91cb000000b0076c71dc55f3mr9707841ior.6.1684856893658;
        Tue, 23 May 2023 08:48:13 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id cn6-20020a0566383a0600b004141ce991aesm2475261jab.179.2023.05.23.08.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 08:48:12 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-335d6260e9bso154235ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:48:11 -0700 (PDT)
X-Received: by 2002:a05:6e02:b2f:b0:32b:7232:dac6 with SMTP id
 e15-20020a056e020b2f00b0032b7232dac6mr320895ilu.18.1684856891263; Tue, 23 May
 2023 08:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230522114922.1052421-1-arnd@kernel.org> <CAD=FV=XrTVVEP8gLx3e7Sqa_3fod3Ox79Ao5fk3S_ORH7jHS9Q@mail.gmail.com>
In-Reply-To: <CAD=FV=XrTVVEP8gLx3e7Sqa_3fod3Ox79Ao5fk3S_ORH7jHS9Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 May 2023 08:47:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XS6ZXbZvMVYTm8p46SauE6t_qsE7o2AUOJLbsTzK3Jpw@mail.gmail.com>
Message-ID: <CAD=FV=XS6ZXbZvMVYTm8p46SauE6t_qsE7o2AUOJLbsTzK3Jpw@mail.gmail.com>
Subject: Re: [PATCH] arm64: watchdog_hld: provide arm_pmu_irq_is_nmi stub
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Petr Mladek <pmladek@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 22, 2023 at 7:31=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, May 22, 2023 at 4:49=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The newly added arch_perf_nmi_is_available() function fails to build
> > when CONFIG_ARM_PMU is disabled:
> >
> > arch/arm64/kernel/watchdog_hld.c: In function 'arch_perf_nmi_is_availab=
le':
> > arch/arm64/kernel/watchdog_hld.c:35:16: error: implicit declaration of =
function 'arm_pmu_irq_is_nmi' [-Werror=3Dimplicit-function-declaration]
> >    35 |         return arm_pmu_irq_is_nmi();
> >
> > As it turns out, there is only one caller for that function anyway,
> > in the same file as the __weak definition, and this can only be called
> > if CONFIG_ARM_PMU is also enabled.
> >
> > I tried a number of variants, but everything ended up with more
> > complexity from having both the __weak function and one or more
> > added #ifdef. Keeping it in watchdog_perf.c is a small layering
> > violation but otherwise the most robust.
>
> Sorry for the breakage!
>
> The intention here is that turning on CONFIG_HARDLOCKUP_DETECTOR_PERF
> doesn't make any sense if the PMU is not enabled. In that sense, maybe
> a better option would be to just fix this in Kconfig? What about going
> into `arch/arm64/Kconfig` and instead of:
>
> select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_N=
MI
>
> We do:
>
> select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS &&
> HAVE_PERF_EVENTS_NMI && HW_PERF_EVENTS
>
> It looks like HW_PERF_EVENTS is a synonym for ARM_PMU and that's the
> same symbol used to include the needed definition.
>
> Making that change seems to fix the compile error and has the added
> benefit that enabling CONFIG_HARDLOCKUP_DETECTOR will automatically
> choose the "buddy" backend when CONFIG_ARM_PMU isn't turned on.

Breadcrumbs: since I didn't see a patch this morning and I'd love to
get this resolved, I've posted the Kconfig fix:

https://lore.kernel.org/r/20230523073952.1.I60217a63acc35621e13f10be16c0cd7=
c363caf8c@changeid

Assuming people think that's OK, it should land instead of ${SUBJECT} patch=
.

-Doug
