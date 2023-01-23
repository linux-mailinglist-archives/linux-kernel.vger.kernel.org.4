Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA36774A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjAWE2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjAWE2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:28:31 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4A12069
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 20:28:28 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id m17so2592830uap.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 20:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vjjHK/TOmoBm6O8k+2N7BkktCx3pSWAVz7qW+oPVNVE=;
        b=hPpsuvAwLZh1RRCrs7FTPeEjeZ1bFN6J74cr1RlkEBHsUWLp1jcyckOkVISwJOsUJd
         ocwNmh7jSMAxjyZr95W33Vdo0HkqHvnUYFOqLpAwJBZASXSAMVc+L8dHPjYvGMrJac7t
         hGiweTAlxha7IXjucOyG1O4TnBDS1rqatTJ7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjjHK/TOmoBm6O8k+2N7BkktCx3pSWAVz7qW+oPVNVE=;
        b=G1vpTOFCOLS7o3cyjEMl1upmg5ZmvCVTyF2XS1o9yNvQAC9ohLCw/sJQ9yJtscBeOp
         lreECMDt7dRq3TLkBrQA0QjzCAWB8VxCQQxpJkK7mSfn55SxNveLUgRRorDlnLLYpdmV
         31/xLtGmezh/dRdse6Md2CSdV6xhtnl4BE8IhmYrmq8dByjhf7R1SJlb8eYLvqWA1+iU
         U89BF/M8202TYseknXE5tGqHqfWFmappmV7arBCKVx994WGJJ6ue3S1AdFIqaeCMovks
         vjXFh1UfI/tOKKlW/mb2lWOWGjxCVHZb+RPZevBkAT1NbRBQiV1LLq17+YdYkHNC8CJv
         nXWg==
X-Gm-Message-State: AFqh2kqUXyFLbJIY2LSA++UlWVtISpS+gNm/vPZVWWiNMTHAsY/JNMmh
        snYCFyAqW5O3S6GvMAQOPYGvbar/XOFvS7dfu0FqeA==
X-Google-Smtp-Source: AMrXdXsdoh8iqfsdbvQAPcLKMxmJ8Wx/zLXGK4/3eZvXbxxCNwT+oiDSGJknhi0DYvFAGaxJ3CyQrZHmh0JrQHnX4I0=
X-Received: by 2002:ab0:1427:0:b0:5f7:89e9:d714 with SMTP id
 b36-20020ab01427000000b005f789e9d714mr2463881uae.0.1674448107340; Sun, 22 Jan
 2023 20:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com> <701abf4bbf5b7957a24d2f164c643e1d9f586fad.camel@gmail.com>
 <4dc6a571-8564-b38c-31df-0d9741dfc592@meta.com>
In-Reply-To: <4dc6a571-8564-b38c-31df-0d9741dfc592@meta.com>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Sun, 22 Jan 2023 20:28:15 -0800
Message-ID: <CAOFdcFOh_rNt3pfkNHPPeK=Kojro==Kpgmmu-VnLuaMYfFoiwg@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 11:34 PM Yonghong Song <yhs@meta.com> wrote:
> On 1/18/23 11:28 AM, Eduard Zingerman wrote:
> >
> > While working on clang patch to disable stack protector
> > for BPF target I've noticed that there is an option to
> > disable default configuration file altogether [1]:
> >
> >    --no-default-config
> >
> > Should we consider it instead of -fno-stack-protector
> > to shield ourselves from any potential distro-specific
> > changes?
>
> Peter, could you help check whether adding --no-default-config works
> in your environment or not?
>
> >
> > [1] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-no-default-config

I guess I could, but I'm not convinced that's the right thing to do.
Ideally problems with distro-specific configs would cause loud
failures (like this one) and result in fixes like the changes being
made to upstream clang/gcc.
Simply unconditionally disabling distro configs seems to be the wrong
way to approach this and makes it less likely that future problems
will be reported in the first place.
