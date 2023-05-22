Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9770C126
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjEVOb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEVOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:31:57 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3970092
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:31:56 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-331ad4cd4fdso12173675ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684765915; x=1687357915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRChCazQPjVecSBDbhU6PH7RXOsuVoE+Cq7IwpSDGxU=;
        b=MeGUxJYy+ZpKvwyEp/xt6Ksq0qexxzkjgQ1bC3W2dBkOZb89vF99k+fcgw7+TLKslE
         jD779UxPHL1PuWCLl7k8Y7glAsurYjmQ77FCJsItLG6NJSl11qY7teYxQvDUNeFfap6a
         qh2rA2Vv0YKoHa2Odg2uNworlaO0t5x03ZU5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684765915; x=1687357915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRChCazQPjVecSBDbhU6PH7RXOsuVoE+Cq7IwpSDGxU=;
        b=RCnGSKabiY3rd+YCi8ibxIJDWwZev5y1vUBu75Gl2qujURIFLLlBYS3UsVwy6Cvalk
         +wMJLudCPxSgJAYS7l0g3EWZ8iiid8dyWW0VLSdnvKRFdVF9z+qhUYRFT2HodJ1OtUs2
         PRDHIR51aRGAuudYQpAqrfe+PS2HvIo2RMv4vbPe7zi9duBDLD/iAjGUqVlo2GzjwEV6
         MzUEOPlIfRaWplNwKpJRHdtRN3Wx6C7OKJa0GLcwTuk/+n02yoaPlBWf0GEwhKQxtixQ
         jlhdfPJ88piK+WhgHrhKM0WKJ1tYklLDe7fmua58PlwSxSOtzweelaZ9OgSI9eHGM2n6
         L0/w==
X-Gm-Message-State: AC+VfDwd+FGsk337VKE7Cq2glwaaFE4jj6ujG80gbpne3O3uncuIw1Jd
        0sYw8Xbmg8G8wIebpx2ZbgmST5XU3xiEIvurHio=
X-Google-Smtp-Source: ACHHUZ4m7Fp+12nTHZLmCs7Tvl5afjvwc4E6CJXgVAqLyIBu+DiS+eq5Y697a2Jbg2NOMTgGCfdqBA==
X-Received: by 2002:a92:2910:0:b0:32c:a1d1:40c3 with SMTP id l16-20020a922910000000b0032ca1d140c3mr5616364ilg.32.1684765914843;
        Mon, 22 May 2023 07:31:54 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id z62-20020a0293c4000000b00411b4acc990sm1786230jah.7.2023.05.22.07.31.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 07:31:53 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-338458a9304so258075ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:31:53 -0700 (PDT)
X-Received: by 2002:a05:6e02:20cb:b0:32e:561d:b42d with SMTP id
 11-20020a056e0220cb00b0032e561db42dmr466193ilq.16.1684765913037; Mon, 22 May
 2023 07:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230522114922.1052421-1-arnd@kernel.org>
In-Reply-To: <20230522114922.1052421-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 May 2023 07:31:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XrTVVEP8gLx3e7Sqa_3fod3Ox79Ao5fk3S_ORH7jHS9Q@mail.gmail.com>
Message-ID: <CAD=FV=XrTVVEP8gLx3e7Sqa_3fod3Ox79Ao5fk3S_ORH7jHS9Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 22, 2023 at 4:49=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added arch_perf_nmi_is_available() function fails to build
> when CONFIG_ARM_PMU is disabled:
>
> arch/arm64/kernel/watchdog_hld.c: In function 'arch_perf_nmi_is_available=
':
> arch/arm64/kernel/watchdog_hld.c:35:16: error: implicit declaration of fu=
nction 'arm_pmu_irq_is_nmi' [-Werror=3Dimplicit-function-declaration]
>    35 |         return arm_pmu_irq_is_nmi();
>
> As it turns out, there is only one caller for that function anyway,
> in the same file as the __weak definition, and this can only be called
> if CONFIG_ARM_PMU is also enabled.
>
> I tried a number of variants, but everything ended up with more
> complexity from having both the __weak function and one or more
> added #ifdef. Keeping it in watchdog_perf.c is a small layering
> violation but otherwise the most robust.

Sorry for the breakage!

The intention here is that turning on CONFIG_HARDLOCKUP_DETECTOR_PERF
doesn't make any sense if the PMU is not enabled. In that sense, maybe
a better option would be to just fix this in Kconfig? What about going
into `arch/arm64/Kconfig` and instead of:

select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI

We do:

select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS &&
HAVE_PERF_EVENTS_NMI && HW_PERF_EVENTS

It looks like HW_PERF_EVENTS is a synonym for ARM_PMU and that's the
same symbol used to include the needed definition.

Making that change seems to fix the compile error and has the added
benefit that enabling CONFIG_HARDLOCKUP_DETECTOR will automatically
choose the "buddy" backend when CONFIG_ARM_PMU isn't turned on.

-Doug
