Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE91E68DDCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjBGQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjBGQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:19:31 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C72684D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:19:30 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 5so6839018pgd.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RlSiKVYitHXZrK+MPuhrh3DUz6tNwiqlJs7cik50spA=;
        b=hxkUF7IJQKTCWwX0hcn7zpX/5nQj+y+GbwSoUJNewmfW1dCYjU+zo8xNG2mW9a9Tv4
         j1+c+GB7a2uk1a23oO0b0lYBFkK4+yUhGaSEw8VJ+chXhRvZbRuy6QzlV4GFowV4BfVi
         5ZCCM2MoD9dRz+sdAwNO7SlUDjrgnzg3jCRyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlSiKVYitHXZrK+MPuhrh3DUz6tNwiqlJs7cik50spA=;
        b=XD5VRVZlaXFht5bICsG8S6UYcSwB99ORoFU/GODXB35YRC2j8wO/X2VXfuLlyjA31f
         OWoc1y43QPQndn2rIf69tYgntkX0SoCptnkiEp4YQzvGlG88V+mIvF1ydtgJPTBGz3Q1
         UniPfU17mEXFzw0NFRsaVrqNsByYlO3hltdOxuN4YCIPY322VX97U8TUxCU3FXGNq8sa
         Bxm3LqosDVjgUuCOn7J7w3yc5odJY0BKSeQhIESzHOgbR89cQrpmEXmn4n2d6MTNN181
         1Dssn+wovdvjPY+Me6oTNs+O/6OkUHcw86lIH3mFN9cimtv0Kq34Ed13TV59KFEHpabK
         h88g==
X-Gm-Message-State: AO0yUKUbCJF9megf+kdxU6Lc0bvl41abGJO9gvvuhD8X1RCZ/b/y/3yJ
        F74ueJmRl9e2CNy8JSpD3qf1IEGOjpu1zIZTZhWxZQ==
X-Google-Smtp-Source: AK7set8QApAe5LqnuLywRCcIgA1Kw2RoXeF3miD2dWA1oV2FQwTn96+upFkZJB415Y9E8hNLaCZRsXhbYygWyhc6oVU=
X-Received: by 2002:a62:3808:0:b0:5a6:5841:6570 with SMTP id
 f8-20020a623808000000b005a658416570mr977619pfa.51.1675786769835; Tue, 07 Feb
 2023 08:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-2-revest@chromium.org>
 <Y9vPAdFBJF/gKXaO@FVFF77S0Q05N.cambridge.arm.com> <CABRcYmLrYXuP-yio0dy4WskENn81Qw2WS0ArMp=rdHuiGyjYhQ@mail.gmail.com>
 <CABRcYmL7exDGnBTzj-DHLSf49_tz6bSDfjn9CDLO9ZEbfFyh-w@mail.gmail.com> <20230207103519.1f0ef013@gandalf.local.home>
In-Reply-To: <20230207103519.1f0ef013@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 7 Feb 2023 17:19:18 +0100
Message-ID: <CABRcYmJQUPp=0TGKACX8-c69hgf8xuLAiLVO3oCFn3i1FCXUfw@mail.gmail.com>
Subject: Re: [PATCH 1/8] ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jolsa@kernel.org, xukuohai@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 4:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 7 Feb 2023 16:21:49 +0100
> Florent Revest <revest@chromium.org> wrote:
>
> > Actually, I'm not sure anymore if we should delete the !multi samples...
> >
> > I realized that they are also used as part of the ftrace selftests in:
> > - tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > - tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> >
> > It does not really make sense to use the ftrace-direct-muti sample as
> > a drop-in replacement for the ftrace-direct sample there since they
> > don't really do the same thing so we would either need to change the
> > test a bit or the multi sample.
> > Also, we would still need to adapt the ftrace-direct-too sample since
> > it has no multi equivalent and is required there.
>
> Let's not delete the samples, and they do test slightly different use cases
> (although the code may be somewhat the same). I rather still keep that test
> coverage.
>
> -- Steve

Ack :) Thanks Steve!

I'll undo the work I've started to do on this and send a v2 shortly afterward.
