Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDDC6F6342
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEDDR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEDDRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:17:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D8E74
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 20:17:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so13100041a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 20:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683170267; x=1685762267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5ozZPD1eRitxmLVpmwZ2WhYcThQgSne38lv/tIUIxw=;
        b=SB/4/Sd6kYDjF1yVlzJvLkf+cs/1PkoYYMclUjirIMHzR4O8TbvUSYgpq/jeDniEGZ
         kTl7EaLgTxdhC9V2YC+3FwMcAanTxY6eVykJpcHuZ/iUnkuTLYs/nTkbmRx+wYLzy8nK
         inZJNYQoTScwhk0kOeQln5r4UKiOcwwTSNqUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683170267; x=1685762267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5ozZPD1eRitxmLVpmwZ2WhYcThQgSne38lv/tIUIxw=;
        b=cY63sWF/I2MD9lXNWZzL/SW5nIEnET29F4qDMJRkt4Y6Y6R3KXNxWRoc+bFATQ2+PS
         2bR9t9eUHMaudb+0ix0qaD69ocMpEzOKg47wHWNa7IdYkPREgPVYe/y5fPfY7+0QUbI2
         ceFoTDYpePJNmdprzVKw1xpwa/wmtCJBVBW4IF42wkN1KMZT9DeykanmkGPhzaek+KdH
         GEKnFNmFWFfDV33mYpbZpLiMSEVIJCTUFxvBODIOpoR/7THQHJrka6YyuL5vi6Ot61q3
         U+20PEy+oQaTs0oUU+ibJWVnzAhXEiqv448MCKhEw+fMq80/6+dBBY5tXjTah2ns2bxQ
         gTFQ==
X-Gm-Message-State: AC+VfDzaZK2jpP2MULJl/MBwZwC+C+HG1i5dGN9TkF1r16dvcw7cEuZk
        ByH7Wpgj20xkrP0yPnsie12ngEAbtMmhWX7ceO6hXW0r
X-Google-Smtp-Source: ACHHUZ7psdIQwmIueNNICbTvFrmUAHPh7HfsZshvR4qAtWkSCJG6Dw8+80EFHVBGfDjkOTV1mzS1Kg==
X-Received: by 2002:a17:907:25c1:b0:94e:b3a1:a3d5 with SMTP id ae1-20020a17090725c100b0094eb3a1a3d5mr3284434ejc.21.1683170267434;
        Wed, 03 May 2023 20:17:47 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id me9-20020a170906aec900b0094a962da55dsm18011356ejb.195.2023.05.03.20.17.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 20:17:47 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so13099971a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 20:17:47 -0700 (PDT)
X-Received: by 2002:a17:906:6a07:b0:94f:6316:ce8d with SMTP id
 qw7-20020a1709066a0700b0094f6316ce8dmr3770779ejc.34.1683169956655; Wed, 03
 May 2023 20:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org> <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
In-Reply-To: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 20:12:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
Message-ID: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.4
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 8:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I did consider it, but the end result doesn't even build, so I unpulled a=
gain..
>
> I get some libbpf error, and I'm just not interested in trying to
> debug it. This has clearly not been tested well enough to be merged.

Side note: its' not even about testing.

The error message makes it clear that this is garbage and should never
be merged even if it were to compile.

There is not a way in hell that it is correct that a 'perf' tool build
should ever even look at the vmlinux binary to build.

The fact that it does shows that something is seriously wrong in
perf-tool land, and I will not be touching any pulls until that
fundamental mistake is entirely gone.

The vmlinux image that is present in my tree (ie
/home/torvalds/v2.6/linux/vmlinux) is a test build with an insane
config. And the fact that the perf tool even looks at it is seriously
broken.

Whatever you are doing - stop it right now.

               Linus
