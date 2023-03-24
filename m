Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349EA6C8332
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCXRTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjCXRTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:19:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9764DBC0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:18:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so5691795pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679678324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ341GCvg6YIFD2oT/Yqhgt/PFmq4abtkloi7GVbvVg=;
        b=axpBDSzM4wxY51DrQFnyncrYK9OldBbjXq4hz1P5YcJ+T7tXEB4YnBrOgPn9/Fv573
         5I///UmB7xAXnIk4KhUc5vLcvYs5bsDDImvMMFWiCCxrqNY3teDcySKnuDPe4biaMhtg
         ECn/0+IMbhiEJ40J4M2kBVhBiAc7ohgsmIP1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ341GCvg6YIFD2oT/Yqhgt/PFmq4abtkloi7GVbvVg=;
        b=3EEQ20gzzfu20b4vjdhQc4kU/UG96yWKCCaQ8cM2tgZjaZlrPWxbfOKbcKs6SSmOXK
         2cZqXN4o8ddGRzGyIjuSJCL0ljHkbbSdTO+15r1F9QC1bFc6a5QpeOGFj1djuMHjfqrv
         yj7aMfKqd2BXp6LHBiGD6tm4nLiLGXRrWASAEgNxx1KUfd0vw1yTjqbyzJnX7KdE3UXt
         ck0GuQXMJ0PXRDi1m+15/a11kPl6Ml3xTtFR2WoqgQO7qhy71S7IYelECejvC/FO9QVu
         Yr5qjj/Sc8uOEdlthFYds/zHS+JRl1pTFiB5mdBbQMXWPpeug9L5wBmJDfUGE1ucf0tc
         SRqQ==
X-Gm-Message-State: AAQBX9eX8Jnm+pzVmtsZvWgI9VPW3b+I2CdwUMT7E03JsiXkKschw9m/
        Dy/1fMrT09boLbTSHbIvyIfmPXmrvqJRRP/QNyZ63Q==
X-Google-Smtp-Source: AKy350bswPorGvZ7VpMUprWUtU23AX9/VmlQSrlhuzPYgLYG+BSz5F7xWyGX32U+W4ymIG0olhufPF5UtcpjmjWF8QY=
X-Received: by 2002:a17:902:c20c:b0:19f:3cc1:e3be with SMTP id
 12-20020a170902c20c00b0019f3cc1e3bemr1199305pll.12.1679678324622; Fri, 24 Mar
 2023 10:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230321140424.345218-1-revest@chromium.org> <20230323194355.3f714774@gandalf.local.home>
 <20230323220042.40ec4904@gandalf.local.home> <ZB2Nl7fzpHoq5V20@FVFF77S0Q05N>
In-Reply-To: <ZB2Nl7fzpHoq5V20@FVFF77S0Q05N>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 24 Mar 2023 18:18:33 +0100
Message-ID: <CABRcYmJbCAsVkgWmqq7g1qkM2qX7WurcU34TxgYRotJQQghFKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Refactor ftrace direct call APIs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        jolsa@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
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

On Fri, Mar 24, 2023 at 12:46=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
>
> On Thu, Mar 23, 2023 at 10:00:42PM -0400, Steven Rostedt wrote:
> > On Thu, 23 Mar 2023 19:43:55 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > Since that commit only contains the updates for the direct trampoline=
s that
> > > ARM64 needs, and I'm not going to rebase that branch, you can just me=
rge it
> > > into the ARM64 tree so that you can base your changes on it. Make sur=
e you
> > > merge that commit, not the branch, as I have more tracing specific pa=
tches
> > > on top of that commit.
> >
> > I just made it easier for you. I created a signed tag: trace-direct-v6.=
3-rc3
> >
> > So just pull from:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> >
> > tag: trace-direct-v6.3-rc3

Awesome! Thank you Steve :D

> Thanks Steve; much appreciated!
>
> Florent, can you post a new spinf of the remaining arm64 bits rebased ato=
p
> that?

Done! :)
https://lore.kernel.org/bpf/20230324171451.2752302-1-revest@chromium.org/
