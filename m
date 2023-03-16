Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D876BD782
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCPRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCPRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:50:49 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F534E250F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:50:32 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id r4so1425992ilt.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678989031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVREMZ5kpSW/gc2Ge3hXpJkQknE5nkfYCVcEvxv4EXI=;
        b=asLa2HDFhrf4l/5L/rbsFjIMDSD0pGnamZAh61JnlEKslGh4/ioiqBPX5uimZuV0/A
         l9Uu2x/ecW9+abZ5qSQlxUkjLcxSO4AjWkr2OAV6V20nTK80dRjDAVHq9s4SNcHZaCTh
         b/EMGCnN6cbq8pBPRyI3yiSwd4l+szi8F2T9/R/zJdHOpp2H+nZM+3rja9gmrjzL09aV
         8lzePT6Z0KcwYBoJ83jCr/EoE3t87+M/o+qfIQ5LGn+BHwcypDU2tBHD+I1ut+qd2cmS
         ccWeNJOdkJgAGQDu7tIrozPi3pqswZfkqeC1NtX9dIp0M+C033XYN3Mw5Raq2rTKVtl0
         qSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVREMZ5kpSW/gc2Ge3hXpJkQknE5nkfYCVcEvxv4EXI=;
        b=jLYQMnDfMB8qiss1cins9Yrpq67xye29YilGpmdY611VPAI981d5/LLusDF3Yoot3a
         FMvlpE8scQUIVqESCarBwOxNjfqD1clEUYaOakuk4sP9nbm3Iu4vp+efg4UsFhp9ekSD
         ZEVkuMHhVUmXGrSmhjZDBeVPnKaa+lSgCXnGunwwnrCWMkORRpqGmW3WjsFwDMLEf4sF
         7sggw/JqGusWWqoZjeuV0bbVOs/pK09lg7RVbGk/iAuisEDxXDCoaGRZwEK+Jd7WTCpi
         jLfVd31XBi62XQq5DV0tp5iEMeWcPR26QmFsB9nzClcN2/nqukOKWYKA0FeTEu82MWo5
         65fQ==
X-Gm-Message-State: AO0yUKWwRZIxWaCDvFaAi4ME1oi6WPH9k1TBWJ7dRDRFdfG88aTv0sA6
        g/xYntXKNq50t+DnzrMr9Mi7rVNLvcmLYZSTXJzgiA==
X-Google-Smtp-Source: AK7set8mXf20D2vvZ13VDFjuQCTRthMKZlP5n2x8/krArMampywj3ASCIlATMoK0zgwEG6o2Ok5YuhGPd3VwvvLLZVk=
X-Received: by 2002:a92:c542:0:b0:313:93c8:e71b with SMTP id
 a2-20020a92c542000000b0031393c8e71bmr243410ilj.15.1678989031152; Thu, 16 Mar
 2023 10:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <ZBNTMZjEoETU9d8N@casper.infradead.org>
In-Reply-To: <ZBNTMZjEoETU9d8N@casper.infradead.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Mar 2023 10:50:16 -0700
Message-ID: <CAP-5=fVYriALLwF2FU1ZUtLuHndnvPw=3SctVqY6Uwex8JfscA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:35=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Mar 16, 2023 at 06:01:40PM +0100, Jiri Olsa wrote:
> > hi,
> > this patchset adds build id object pointer to struct file object.
> >
> > We have several use cases for build id to be used in BPF programs
> > [2][3].
>
> Yes, you have use cases, but you never answered the question I asked:
>
> Is this going to be enabled by every distro kernel, or is it for special
> use-cases where only people doing a very specialised thing who are
> willing to build their own kernels will use it?
>
> Saying "hubble/tetragon" doesn't answer that question.  Maybe it does
> to you, but I have no idea what that software is.
>
> Put it another way: how does this make *MY* life better?  Literally me.
> How will it affect my life?

So at Google we use build IDs for all profiling, I believe Meta is the
same but obviously I can't speak for them. For BPF program stack
traces, using build ID + offset stack traces is preferable to perf's
whole system synthesis of mmap events based on data held in
/proc/pid/maps. Individual stack traces are larger, but you avoid the
ever growing problem of coming up with some initial virtual memory
state that will allow you to identify samples.

This doesn't answer the question about how this will help you, but I
expect over time you will see scalability issues and also want to use
tools assuming build IDs are present and cheap to access.

Thanks,
Ian
