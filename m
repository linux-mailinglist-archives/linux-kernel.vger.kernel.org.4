Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB266D1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjAPWuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjAPWtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:49:47 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B625E26
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:46 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id b18so982175uan.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0IEpt49/65E0wGkbn3RYoaG0iQiOmclklQOb+UN4RXU=;
        b=kVs7w+0I28gjlBzuI/gIhfx+so8q2yysPSVzIWrNOGS9rqKYUMOU/8QVCBdFk3JBoW
         LqofLbwAC8DQpo0ItS0cDQNjxA/Q9qrX0YNuFVBWfUEM7PhL3HvxR1zdwzXLI1Sjxqhl
         uCPTIlucAzxhKmTP666Nh90oD+1B7ndvd1tjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IEpt49/65E0wGkbn3RYoaG0iQiOmclklQOb+UN4RXU=;
        b=DTB2wbp8ZGsaz2WXwl2Aoo4gnHhzqMQILLz33Btu/9aTLwmnPOsc4gx6De6ujnY+rI
         5MnSlojouPTz8mm6td/JBJtPM9OITt42xFVzT6SpNc2yL0H4vztEDZ26kI+jwG/E36Tn
         7uZCT22JtTnwPz+qQqBOXE5o79yWshuXdPbq2mTx023Pf34B9U28OkhBXBojY4ysAohr
         fGD9es+FVHJPRs6gn3lq/g4do6kHIay3MM9HCyL3Q0sQVA4hRRQQUYFf/jdd0XijbLLd
         C+RJXH8xNr2KxHMPOKQNcve916+tPW7xwfI7dzmYRlEY004+yNvpr6Vij20gQkPQf1g0
         cn/g==
X-Gm-Message-State: AFqh2kqWI3wM4n+Umzrng5OuyGz53Fu6j1XDgVvaE2kyidYVk4t+pdDc
        te8KykyD4GJBicIMzokw7qnrdKBrHNP/i88Elp/ijw==
X-Google-Smtp-Source: AMrXdXtwfbujXEmrpHh1D8hu3UQ2BUu4tyjxDDaOO6XcpcdIsuLMlwUgNRJxCrVjED8qrBxFxcawcPiPC4YFDJP+sKM=
X-Received: by 2002:a9f:37c5:0:b0:60a:bb33:8267 with SMTP id
 q63-20020a9f37c5000000b0060abb338267mr48403uaq.47.1673909385284; Mon, 16 Jan
 2023 14:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com> <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
 <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
In-Reply-To: <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Mon, 16 Jan 2023 14:49:34 -0800
Message-ID: <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
Subject: Re: [PATCH] tools: bpf: Disable stack protector
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 4:59 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> A bit tangential, but since BPF LLVM backend does not support the
> stack protector (should it?) there is also an option to adjust LLVM
> to avoid this instrumentation, WDYT?
>

That would probably be worth doing, yes.
But given that won't help already released versions of clang, it
should probably happen in addition to this patch.
