Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE32866D6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjAQHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjAQHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:09:14 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F318E72B5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:09:12 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id k4so31279552vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iw9KmqXhQAK464aHwakno69xYQNB+Zg+iX2cv1NWImM=;
        b=hGb6/ZwlYS4Z4sYL4sdBPzJBB1kEeESnRfHAzm9pTHGbUux8nTYlBo+Kqp2G23KdBS
         /WqjngEvKDZ+CUXpwC5QLqF7ChP2yqAMU/RjcxQCK+nm+/YAhCZYb3nJa+LzMDzF30Ui
         LLq5LkF50pnavsFQzNqzIv8Jl6SrbRqYhN7gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iw9KmqXhQAK464aHwakno69xYQNB+Zg+iX2cv1NWImM=;
        b=rnG5IXH9R0+dkIVpnztevvLCSOqQGAZ8IyB1jd9D8YU2nODejpOCF/GgDwYXOrviJo
         IxgJynDE6Xic0qkiylYH9q0C1yKLyi+RTcy16kYunKxIfkmhH1pSP+C+odgaNv8J0eU+
         WMCa1o6pY0uSsM4j/pNxhlhYogEHsptiZp4BJk3mtUZ5sh2ruUh6Z2XZDUngudQC4syK
         6eNb+TkLhNDKW4U8Vd5AeD5UF1rYFZ3vaRcT236LFBheQo6qonO93fCMW1d888pqpCUP
         FDT3tm4zM1HJlKLYCXS/OfipirNbn8N1+BBcXaU+jch+WdSQyc2YOqI5tNcdyejRojdJ
         AGBQ==
X-Gm-Message-State: AFqh2koE8m/lhPYZhE8bvCtr83s3HP0a9hnaTaAyc3Opk8YD1IBbcHEy
        yJzIzmcYrw4EKWtZPC4BLIhDsnOAzLmTOoWZTt4/OQ==
X-Google-Smtp-Source: AMrXdXuznbTWfKXHBoqIxnpdKiYSTwB8VxhxTRxnELjfH+dgvQFQXM/KyS8aB9RwhLIYscJ1Hq3DdNGeM8INU2lrDUE=
X-Received: by 2002:a67:e9ca:0:b0:3d3:d06a:3229 with SMTP id
 q10-20020a67e9ca000000b003d3d06a3229mr213632vso.28.1673939351950; Mon, 16 Jan
 2023 23:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com> <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
 <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
 <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com> <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com>
In-Reply-To: <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Mon, 16 Jan 2023 23:09:01 -0800
Message-ID: <CAOFdcFPnHEc2qd-=C+hdK4nTjJfbHsf4r-G7pdJTRBAT6MuOzg@mail.gmail.com>
Subject: Re: [PATCH] tools: bpf: Disable stack protector
To:     Yonghong Song <yhs@meta.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
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
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:05 PM Yonghong Song <yhs@meta.com> wrote:
>
> If I understand correctly (by inspecting clang code), the stack
> protector is off by default. Do you have link to Gentoo build
> page to show how they enable stack protector? cmake config or
> a private patch?
>
The relevant override appears to be
https://github.com/gentoo/gentoo/blob/c5247250e9d4a09e67a602965a5f72be3cebbf34/sys-devel/clang-common/clang-common-15.0.7.ebuild#L93
