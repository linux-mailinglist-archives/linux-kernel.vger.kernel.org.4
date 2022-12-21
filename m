Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72584653765
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiLUUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:13:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A8EFE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:13:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3509071pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zLXJYoqrA8qjYj9G2HQZKjo0c3Ld+Ma9nTGSOm1fY/s=;
        b=lDjSKwbp4bofJhEAqRo/WnqiarwYW0DG6LpPc3cfdsyZB0jGuYoqb8cutonM3jZ3uI
         zcmaJMlCgyeqGvUKzXavLKYDm/sW6Qyl/zCiaX32ela93wCMV1a7JKBS3UkxVkTU72Z6
         FXAK7UUh24Fc4fg3dXP/Ua5Cj3Cx0smUVJG4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLXJYoqrA8qjYj9G2HQZKjo0c3Ld+Ma9nTGSOm1fY/s=;
        b=0P1YFWkcS5Z6/K7VRnzgzdN1PlkoESISWMilUbPUn9LatycEj8xjG0wd2RAPg5rgre
         R8Rn365MlOzrVmsDgIoR+LfwYW+23rj/ge/xfdnV1Wgs7u8bfxyChBM1XTfM2e9ncXT7
         z0wJAN//SjnT0A46B4QKADcfs2G5GvDdc6qFN9QnjCkV7GlvDg8hHxpDWxWwXbMd3dIU
         vCFcDJPzZ6+qJF90gIeJn2SekBYOQbOfO9FAt5zRafoKMhzsD1H6S6JWiH8Gc+f32FFe
         TY1uA8lHvhBvlEV8yoa1/bbZHsxtrkVx38XMCC3GN/YPSqhte+3UINGoB4TFDH5nqz5D
         DtjA==
X-Gm-Message-State: AFqh2koA9fDA5mdkSRUlFvK1xKIAsCPyvIAVxCgTiGvEm65Byu46oJD5
        8bhMT5ifceSfSYI69u8AIJYzil867doarh3hk5U=
X-Google-Smtp-Source: AMrXdXtlX6Qg/QoUZdg/sJvyK/B3sCmmXqb0oXwpsY1cTQgkixx9aj/J8rJpuq73KCQmtzo79Ncxrw==
X-Received: by 2002:a17:90a:cc01:b0:223:e152:2ec0 with SMTP id b1-20020a17090acc0100b00223e1522ec0mr3583033pju.24.1671653604319;
        Wed, 21 Dec 2022 12:13:24 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a604800b00219752c8ea3sm1747155pjm.48.2022.12.21.12.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 12:13:24 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso3573266pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:13:23 -0800 (PST)
X-Received: by 2002:a17:902:a984:b0:189:d081:1ebb with SMTP id
 bh4-20020a170902a98400b00189d0811ebbmr142129plb.130.1671653603257; Wed, 21
 Dec 2022 12:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org> <CAKH8qBuLhZ+T9fvP=DXeYevdrNofTPpEiQqq2RenBUKVghPmtA@mail.gmail.com>
In-Reply-To: <CAKH8qBuLhZ+T9fvP=DXeYevdrNofTPpEiQqq2RenBUKVghPmtA@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 21:13:12 +0100
X-Gmail-Original-Message-ID: <CANiDSCv0EObZHCL1D1CHBRaNf68Df4Ur9kFgaoGSGH=KYwgOPw@mail.gmail.com>
Message-ID: <CANiDSCv0EObZHCL1D1CHBRaNf68Df4Ur9kFgaoGSGH=KYwgOPw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove unused field initialization
To:     Stanislav Fomichev <sdf@google.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanislav

On Wed, 21 Dec 2022 at 21:10, Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 11:55 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Maxlen is used by standard proc_handlers such as proc_dointvec(), but in this
> > case we have our own proc_handler. Remove the initialization.
>
> Are you sure?
>
> bpf_stats_handler
>   proc_dointvec_minmax
>     do_proc_dointvec
>       __do_proc_dointvec
>         vleft = table->maxlen / sizeof(*i);

I believe do_proc_dointvec is using the value from:

struct ctl_table tmp = {
  .maxlen=sixeof(val);
}

>
> Maybe we should really do the following instead?
>
> .maxlen: sizeof(int)
>
> ?
>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > bpf: Trivial remove of unitialised field.
> >
> > I have inspired myself in your code and heritaded this bug :). Fixing this
> > here so none else makes the same mistake.
> >
> > To: Alexei Starovoitov <ast@kernel.org>
> > To: Daniel Borkmann <daniel@iogearbox.net>
> > To: John Fastabend <john.fastabend@gmail.com>
> > To: Andrii Nakryiko <andrii@kernel.org>
> > To: Martin KaFai Lau <martin.lau@linux.dev>
> > To: Song Liu <song@kernel.org>
> > To: Yonghong Song <yhs@fb.com>
> > To: KP Singh <kpsingh@kernel.org>
> > To: Stanislav Fomichev <sdf@google.com>
> > To: Hao Luo <haoluo@google.com>
> > To: Jiri Olsa <jolsa@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/bpf/syscall.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 35972afb6850..8e55456bd648 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -5319,7 +5319,6 @@ static struct ctl_table bpf_syscall_table[] = {
> >         {
> >                 .procname       = "bpf_stats_enabled",
> >                 .data           = &bpf_stats_enabled_key.key,
> > -               .maxlen         = sizeof(bpf_stats_enabled_key),
> >                 .mode           = 0644,
> >                 .proc_handler   = bpf_stats_handler,
> >         },
> >
> > ---
> > base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> > change-id: 20221221-bpf-syscall-58d1ac3f817a
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>



-- 
Ricardo Ribalda
