Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1AB6BD428
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjCPPm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjCPPl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:41:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1FF4C23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:41:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ix20so2184725plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678981279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1jWVsLcHnLgluES/TZZIa08/2lUaIDoh9NhTqSDt50=;
        b=DANpDHYSOlUDZQAJ/zJmFLsz80ZTHOjNZaezhmrWu2X7VwgGLvTSlAPG9KTz93gGHS
         Ziqg5ULEYOP0BGSsxKAA/7CnVA0LzRxGLo1xdWCwbjbSB/V3PRmkqdvxOruPQZFQwLXJ
         H7FZN2lwlIrvTu28nfhwNsMgOJGrhzBvo08Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678981279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1jWVsLcHnLgluES/TZZIa08/2lUaIDoh9NhTqSDt50=;
        b=wiTHS3i61oBI6ZUdfeCWRR9Aso37vrPxTF76mAnvk0wJyOmnfAzwelUUsEDv+0FVdF
         QrTW6ULvple+agZiumhFGTpwy8aG/uU1qit9otnaZKScwqh1MiwSzdm6kGBhkP8zBprA
         cf9kryBDdyk4bCmw5pvQ4t6LZ7PJcpiMVknphtHE+0DbRjDlwGDm5v8x2OQHpF/p294Y
         J0KoenuZ8J9h7f9mHZ37+ywUiTq6SfCNpnnci0ZxtyKi3DrqogPkIX90YvPPDLoAu7CG
         1qrcdaC5/JNajy9X3pbzQwQtUuV0XKZKPjjs133lkqAesXdrzm0BnSPAD7D0SdENFwrX
         Ge9A==
X-Gm-Message-State: AO0yUKVbZkfX/Iqs8IwvichC8qc+jD8j8ixCUmjzYoxwwpbtTZZ9WELo
        iRcmedVHqcwgwzkbTfapAG9UQz6TcNd4iHKs8UCGvQ==
X-Google-Smtp-Source: AK7set/ZjYExtZvnQuADH2/TCv0j8SwedLL2ms+4BZIr/3P+qNJHpodSZrEJEMbc9FcE/1mlAQzh2N6IEeQ4fFaIJ3M=
X-Received: by 2002:a17:903:32ce:b0:19f:3cc1:e3c3 with SMTP id
 i14-20020a17090332ce00b0019f3cc1e3c3mr1634726plr.12.1678981279615; Thu, 16
 Mar 2023 08:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230207182135.2671106-1-revest@chromium.org> <20230207182135.2671106-7-revest@chromium.org>
 <20230315195136.2996b1dd@gandalf.local.home>
In-Reply-To: <20230315195136.2996b1dd@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 16 Mar 2023 16:41:08 +0100
Message-ID: <CABRcYmJYUVsZyRY2Bo1DDnJogkcasi=g7TCY07vb0DELH6Hy+A@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ftrace: selftest: remove broken trace_direct_tramp
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:51=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue,  7 Feb 2023 19:21:31 +0100
> Florent Revest <revest@chromium.org> wrote:
>
> > From: Mark Rutland <mark.rutland@arm.com>
> >
> > The ftrace selftest code has a trace_direct_tramp() function which it
> > uses as a direct call trampoline. This happens to work on x86, since th=
e
> > direct call's return address is in the usual place, and can be returned
> > to via a RET, but in general the calling convention for direct calls is
> > different from regular function calls, and requires a trampoline writte=
n
> > in assembly.
> >
> > On s390, regular function calls place the return address in %r14, and a=
n
> > ftrace patch-site in an instrumented function places the trampoline's
> > return address (which is within the instrumented function) in %r0,
> > preserving the original %r14 value in-place. As a regular C function
> > will return to the address in %r14, using a C function as the trampolin=
e
> > results in the trampoline returning to the caller of the instrumented
> > function, skipping the body of the instrumented function.
> >
> > Note that the s390 issue is not detcted by the ftrace selftest code, as
> > the instrumented function is trivial, and returning back into the calle=
r
> > happens to be equivalent.
> >
> > On arm64, regular function calls place the return address in x30, and
> > an ftrace patch-site in an instrumented function saves this into r9
> > and places the trampoline's return address (within the instrumented
> > function) in x30. A regular C function will return to the address in
> > x30, but will not restore x9 into x30. Consequently, using a C function
> > as the trampoline results in returning to the trampoline's return
> > address having corrupted x30, such that when the instrumented function
> > returns, it will return back into itself.
> >
> > To avoid future issues in this area, remove the trace_direct_tramp()
> > function, and require that each architecture with direct calls provides
> > a stub trampoline, named ftrace_stub_direct_tramp. This can be written
> > to handle the architecture's trampoline calling convention, and in
> > future could be used elsewhere (e.g. in the ftrace ops sample, to
> > measure the overhead of direct calls), so we may as well always build i=
t
> > in.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Li Huafei <lihuafei1@huawei.com>
> > Cc: Xu Kuohai <xukuohai@huawei.com>
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Florent Revest <revest@chromium.org>
> > Signed-off-by: Florent Revest <revest@chromium.org>
>
>
> Care to respin with my update requests? I can take up to this patch and
> base it directly on v6.3-rc3 when it comes out. I'm expecting that to hav=
e
> the fixes in other code that is breaking my tests.

Okay! :) I'll send you a subset of this series (first 6 patches with
your review addressed and rebased on v6.3-rc2 for now).

> Then I'll push it out after it passes all my tests, and you can take it
> and add the arm64 specific bits on top. I'm currently running these patch=
es
> as is on my tests to see if they fail (with a patched kernel for the othe=
r
> code that's breaking my tests).
>
> Does that sound OK?

Sounds good to me, yes!
