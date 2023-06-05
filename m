Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15620723300
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjFEWQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFEWQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:16:09 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089A510F;
        Mon,  5 Jun 2023 15:16:07 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-3f81396e435so48174521cf.0;
        Mon, 05 Jun 2023 15:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686003367; x=1688595367;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJrnkGnSFwog5Y4q66MLZZft9WNaKoyKFpILcI7piBc=;
        b=fWU6pYvyjEspd6CdD6sw9ngq9Qqo12PyB68m+xHX5PZXKh4igsuUjDkIwYkTrMdRkr
         PQTN47BYFXTPca8VrYWH4/S9+fV43JaKrVsszeHHAoDi3GG+ppk8GIuH9l55Ro34ZUmg
         xmnSRwID73gdTiP27EiG9d5uNhPHx+yGQMFL7U5ucI7KFrz2rHtks5ma2O+zBwIqetqi
         DcWXG+pzjs7HpM6S3PY0WKumm0IX4o7n3uUOqe7btA/mdPjuNrPBbeEIdDWRWrpdUjKo
         0EzFKoSKTauc/qf0mWE0iU34CN3ZJ4FOSqrC7/23VvlmQJYyP10l2R1URkl29Ab2k4gV
         Hczg==
X-Gm-Message-State: AC+VfDxvNN4LL9/gvVT8NQIvFbxgTzb9/AA01NswRN7gIHxjAPuteN0x
        /hC8V8S/XNBuBskfVD+zkDs=
X-Google-Smtp-Source: ACHHUZ5NM3VLqMiYLRb8bVuc9tyU5/FQzEYHUEgBzy/kzwunBJ3KctP0ep1TLVLzclm3HmSC6oJVZg==
X-Received: by 2002:ac8:4e43:0:b0:3f3:8ddc:d760 with SMTP id e3-20020ac84e43000000b003f38ddcd760mr219132qtw.12.1686003366713;
        Mon, 05 Jun 2023 15:16:06 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:7447])
        by smtp.gmail.com with ESMTPSA id bp17-20020a05622a1b9100b003e4f1b3ce43sm5124531qtb.50.2023.06.05.15.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:16:06 -0700 (PDT)
Date:   Mon, 5 Jun 2023 17:16:03 -0500
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_for_each_map_elem
 on BPF_MAP_TYPE_HASH_OF_MAPS
Message-ID: <20230605221603.GB1892218@maniforge>
References: <20230605200508.1888874-1-void@manifault.com>
 <20230605200508.1888874-2-void@manifault.com>
 <CAADnVQLZkUFtCwZEaRKMrdnDJzj-9_7fMYY9P55MndiNTrSnkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLZkUFtCwZEaRKMrdnDJzj-9_7fMYY9P55MndiNTrSnkA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 03:07:21PM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 5, 2023 at 1:05 PM David Vernet <void@manifault.com> wrote:
> >
> > +
> > +static __u64 set_invoked(struct bpf_map *map, __u64 *key, __u64 *val, struct callback_ctx *ctx)
> > +{
> > +       struct bpf_map *inner_map;
> > +
> > +       ctx->invoked = true;
> > +       inner_map = bpf_map_lookup_elem(map, key);
> > +       if (!inner_map) {
> > +               ctx->failed = true;
> > +               return 1;
> > +       }
> 
> This doesn't look right. 'val' is not 'u64 *'.
> It probably should be 'struct bpf_map *',
> so lookup shouldn't be necessary.
> 
> map_set_for_each_callback_args() just sets it to PTR_TO_MAP_VALUE.
> It probably should be CONST_PTR_TO_MAP.
> Also for normal hash map for_each_elem 'val' is writeable.
> It shouldn't be in this case.
> So to cleanly support iterating hash_of_maps patch 1 needs more work.

Thanks for the review and pointing out these issues. This all makes
sense, I'll incorporate it into v2.
