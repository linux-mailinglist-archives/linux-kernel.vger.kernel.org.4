Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C06D436F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjDCL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjDCL0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:26:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209022D4A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:26:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id cm5so13070044pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680521167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPfN6H9GzSSwoyl7nWUpLiWgOMSJP2rcV6xsiUErpvA=;
        b=DhS9E/8WyR3JS9FsRm9YYu3/KJdAKSHtR6KiImoIMS9reKvRnaBgwNbsl/pz+4oCk1
         dyPfknbbYslWE826HseDt8gvc4gPdcKljTlSoe50J50j5/5sDPfh+Bn2Gm/r+UJXU+bf
         3E6RmSy5Ss+wurpPFAD/KtrsrdonrrsIyQqQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPfN6H9GzSSwoyl7nWUpLiWgOMSJP2rcV6xsiUErpvA=;
        b=SaSyAgzsLMPYGqWOl5pnipJyBUgBoOy1h6ybdDy9k+LbSjCsAq3yF2aKKBHBTITTLL
         xnySEvkNtEh7ss49+FU2dcI7ngml7bLcI+UCILop0kewU/WJb85yrWRTgeQzDJHZqxVh
         RCyLl+C6FVSyFB8bFYc4NqW1UucIEk/X2wuzugZsLdWQ7Ey104eklF0/yUAKR3wKeS7L
         RvbQv2IJ0UeQJyNkGmasj0B3XXcFzJ/4UDVijbVoEMpNQVH5NoRiScbPIbNBfAfYc0Mu
         oi7TTunH4kqj9MWaOoO+ZwC5+cTZhrL8j312K1vcWxAvScnqvNGqXksSeo+y6GFVAVnq
         Y5aA==
X-Gm-Message-State: AAQBX9fojMFVIUWvbrPvmGTzss5lFS3GGAegdk0TgGboni5N4QnWmazm
        6nNRuoVFMc5Fl4Qbr/dEZ275wwWBuUVfz2llPFkNuQ==
X-Google-Smtp-Source: AKy350Z1SB2ADtmNWWYX+uAfqdQ/xVxYHIbU/JDIrSe10oRa3VNheGlpMbMMQwMoIj6X+d2LGdVT0WFTkT9DyDoLJgM=
X-Received: by 2002:a05:6a00:881:b0:62d:dd8d:56ac with SMTP id
 q1-20020a056a00088100b0062ddd8d56acmr5893169pfj.0.1680521167488; Mon, 03 Apr
 2023 04:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230403112059.2749695-1-revest@chromium.org>
In-Reply-To: <20230403112059.2749695-1-revest@chromium.org>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 3 Apr 2023 13:25:56 +0200
Message-ID: <CABRcYm+p-_z0i7TyyA16NPY3GkR37mFxN1SKiV6RBS1pGEoa1Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add ftrace direct call for arm64
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 1:21=E2=80=AFPM Florent Revest <revest@chromium.org>=
 wrote:
>
> This series adds ftrace direct call support to arm64.
> This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64=
.
>
> It is meant to be taken by the arm64 tree but it depends on the
> trace-direct-v6.3-rc3 tag of the linux-trace tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> That tag was created by Steven Rostedt so the arm64 tree can pull the pri=
or work
> this depends on. [1]
>
> Thanks to the ftrace refactoring under that tag, an ftrace_ops backing a =
ftrace
> direct call will only ever point to *one* direct call. This means we can =
look up
> the direct called trampoline address stored in the ops from the ftrace_ca=
ller
> trampoline in the case when the destination would be out of reach of a BL
> instruction at the ftrace callsite. This fixes limitations of previous at=
tempts
> such as [2].
>
> This series has been tested on arm64 with:
> 1- CONFIG_FTRACE_SELFTEST
> 2- samples/ftrace/*.ko (cf: patch 3)
> 3- tools/testing/selftests/bpf/test_progs (cf: patch 4)
>
> Changes since v3 [3]:
> - Added "BTI C" instructions at the beginning of each ftrace direct call =
sample

Ugh, I am an idiot (let's just blame Mondays!) and didn't actually
amend this change, I'm sending the series again as a v5 and this time
with the change actually folded in... Please ignore this v4, sorry for
the noise! :|
