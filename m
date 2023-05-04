Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26076F7927
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjEDW36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEDW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:29:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA34186
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 15:29:54 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef4daaf906so5175831cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683239393; x=1685831393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4uBgz0yZBTHWQuliVmtKoGkSIHeFOTfO6AJGNbOg9A=;
        b=RYnBMo/FBENSx485xmllRwcdT2LOlsijFLR+4+LXTHNnb+uIbqo0VGREYLfNS3ph38
         rRvT1n5WRlAhuLW606DRpdTMA39297Y4ALQUz6WfZcF4fv5iZ2xL+iWjGiBNBhxj0iCF
         8bvh/s7A8rMHhEEpmGzMNOfHAaVVrBTEM5OEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683239393; x=1685831393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4uBgz0yZBTHWQuliVmtKoGkSIHeFOTfO6AJGNbOg9A=;
        b=UJUZIom5TgR8RzCt53S4hwYHlw1OaMGiQ7MHoUXJqIzHObjtdZj3JDk0D1tajzUEpd
         V2CNa35moCFwIZGRcDDtndYNvAjqbjHuj645kdKb8cISVTogZqnMTFxjqIQ4CNVOrTOD
         XHTilXR51Lt0uOxG/+K6TNZtGSa5YOwK95EA3tLwKgBMW+yWcAMOGMSlR7gCEmLVq6Or
         tZUs7XrqcxTLtOzkMn9OVaeVu6/IaXqwNnS6tQ0F/TIPma7epoNl+AFUgv1SN3repX8y
         EMVntpeZH1Kug6A78oz8GHR57povyo2fKYxw/nxeggslxiOSox/GE/Q182n0ZqDdpY9l
         I+zQ==
X-Gm-Message-State: AC+VfDxzhkOVeR1k9SjqquL99UfUANYRLqBV/6XTrpoR+qeMOeXutoAv
        wXzLK0KaiQSii+LfbUUK0HRFBJRSPRnPdsWiwKo=
X-Google-Smtp-Source: ACHHUZ6suvev75w1wTCU9MjiXMK3+YuS+yXDTrQDcFzOAmhE7O8CUYXUqjz9daXSLBisvzdGt98VXg==
X-Received: by 2002:ac8:7e94:0:b0:3d5:500a:4819 with SMTP id w20-20020ac87e94000000b003d5500a4819mr9179406qtj.23.1683239392860;
        Thu, 04 May 2023 15:29:52 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id cr19-20020a05622a429300b003ef33e02eb9sm34963qtb.83.2023.05.04.15.29.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:29:52 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3ef34c49cb9so886491cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:29:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1487:b0:3f3:75c2:7466 with SMTP id
 t7-20020a05622a148700b003f375c27466mr43810qtx.8.1683239371523; Thu, 04 May
 2023 15:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <ZFErmshcrcikrSU1@alley>
In-Reply-To: <ZFErmshcrcikrSU1@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 May 2023 15:29:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UVFR5YvJ8QrZ8YYPpwzYeymuy_JhcmZknbwUXg9njoGA@mail.gmail.com>
Message-ID: <CAD=FV=UVFR5YvJ8QrZ8YYPpwzYeymuy_JhcmZknbwUXg9njoGA@mail.gmail.com>
Subject: Re: shared code: was: Re: [PATCH v3] hardlockup: detect hard lockups
 using secondary (buddy) CPUs
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ian Rogers <irogers@google.com>, ravi.v.shankar@intel.com,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>, Andi Kleen <ak@linux.intel.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 2, 2023 at 8:26=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> > +int __weak watchdog_nmi_enable(unsigned int cpu) { return 0; }
> > +void __weak watchdog_nmi_disable(unsigned int cpu) { return; }
>
> Honestly, the mix of softlockup and hardlockup code was a hard to
> follow even before this patch. And it is going to be worse.
>
> Anyway, the buddy watchdog is not using NMI at all. It should not
> get enable using a function called *_nmi_enabled().

Thanks for your review! I'm not going to individually reply to all
your comments below, but I've sent out a v4 [1] where I think I've
done a semi-decent job of making this a little cleaner (not perfect,
but hopefully a step in the right direction). Please take a look.

[1] https://lore.kernel.org/r/20230504221349.1535669-1-dianders@chromium.or=
g


> Also some comments are not longer valid, for example:
>
> static void watchdog_enable(unsigned int cpu)
> {
> [...]
>         /* Enable the perf event */
>         if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
>                 watchdog_nmi_enable(cpu);

Ugh, after I sent the new version I just realized that I missed
updating the above comment. :( If I need to send a v5 I can update it
then, or if v4 lands I can send a follow-on patch to update that
comment. My eyes are glazed over enough from trying to organize a
17-patch series, so I somewhat imagine it's not the only comment I
missed...

-Doug
