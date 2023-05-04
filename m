Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA46F71FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEDSg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEDSg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:36:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336761B1;
        Thu,  4 May 2023 11:36:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96598a7c5e0so138610266b.3;
        Thu, 04 May 2023 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683225380; x=1685817380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7SN19wDNYmU4q+XSqNk7FwWu0e+B21E4gPwmpCjIg2w=;
        b=AFp8jRlFwOgqYRC8iQqyvfOdG1oTQmfbyCnpPRnYnXDc4mKAqJEVxAXBmi7KEolldg
         83pq7e/lV+pkYBib08bQzL5nKyixKeZ43SOacXQkieoOaOD/5M1y4BhV5KO4CuoIldxe
         LZ7+Iq/5HrSgm7BNJu/e3qph+MRZcdTWGdpZCmkd4q6O0JNO9CaDIu+hu9kgPBy6Qwmc
         i/oQVC72NIBsqJ7p1usfbg+nI9LJFkdQnYPkHAgxMlgt6Tiy5kcL1rdVDayUqplnY/op
         NWLhibHoPyZ3WDjdRJsRo6KPYfP0/NdXQT56SlWjulP53Tc5byMs6z3cpWv9cDegJ4N4
         BWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225380; x=1685817380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SN19wDNYmU4q+XSqNk7FwWu0e+B21E4gPwmpCjIg2w=;
        b=eRSi6BiHYaqCdnJJyZtxzgsARhjugtNWb7IDILVLOfuqxpFwWezKAZSwaTmY5UYKkK
         qFWyqr17EvqQMLTVeqF1zBZAGMBMlaZuvxL1p7/ainWo1noiqvBpBETgZvNPfJBUKAIP
         7wwEb5wbs/82TlNgjJ9e0y8CjM3MJLi2W2/cjoWKBhNg7V5WIxFwsuJqW1xRxSud0jPz
         L9//TTZLqW6eLgoDc4vH4iw7sM253j7BtNW2O3TPyA4zUUPTa0o8pmwd1EEEYKXIERin
         fGSHMgvCz1Xd1Cwp+72BFdoBTAy+7uMBOgGFXKCz2sLCV6WbjcufLtXtnfUuQNzPXCdQ
         JGjA==
X-Gm-Message-State: AC+VfDy4ZOvcIeMDynWZYAZZce0GLGHkFNpk5ioHkwJ5KX32KEYwEh+k
        yQSyczIxY72BGGDQj/2PGYE=
X-Google-Smtp-Source: ACHHUZ7MFl1r5scwPi69aSlFCp5ZglXSrr//bvB8gP7PMR4+VkfxcDY6MOidFs/slXG3O344G4WHfw==
X-Received: by 2002:a17:907:25c2:b0:94e:75f8:668 with SMTP id ae2-20020a17090725c200b0094e75f80668mr7983708ejc.56.1683225379501;
        Thu, 04 May 2023 11:36:19 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090681c100b0094f67ea6598sm18991631ejx.193.2023.05.04.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:36:19 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 4 May 2023 20:36:16 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFP7IFEKdyx5NRYN@krava>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <CAP-5=fUNmiguiW+sv19EpGVVsrBD7dnVm4uMLOuutOo7_LUR=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUNmiguiW+sv19EpGVVsrBD7dnVm4uMLOuutOo7_LUR=A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 10:51:15PM -0700, Ian Rogers wrote:
> On Wed, May 3, 2023 at 8:12 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, May 3, 2023 at 8:00 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I did consider it, but the end result doesn't even build, so I unpulled again..
> > >
> > > I get some libbpf error, and I'm just not interested in trying to
> > > debug it. This has clearly not been tested well enough to be merged.
> >
> > Side note: its' not even about testing.
> >
> > The error message makes it clear that this is garbage and should never
> > be merged even if it were to compile.
> >
> > There is not a way in hell that it is correct that a 'perf' tool build
> > should ever even look at the vmlinux binary to build.
> >
> > The fact that it does shows that something is seriously wrong in
> > perf-tool land, and I will not be touching any pulls until that
> > fundamental mistake is entirely gone.
> >
> > The vmlinux image that is present in my tree (ie
> > /home/torvalds/v2.6/linux/vmlinux) is a test build with an insane
> > config. And the fact that the perf tool even looks at it is seriously
> > broken.
> >
> > Whatever you are doing - stop it right now.
> >
> >                Linus
> 
> I think the error you gave makes it pretty clear what is going on and
> Arnaldo's e-mail explains the motivation. Perhaps we can check a
> vmlinux.h into the perf tree so that we don't default to generating
> it. This would avoid the binary dependency but we may need different
> flavors for different architectures because of structs like pt_regs.

I think we could check that vmlinux with .BTF is present before
allowing to build skeletons

jirka
