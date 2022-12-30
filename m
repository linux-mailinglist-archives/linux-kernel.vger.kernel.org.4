Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CDA659A37
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiL3Pw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3Pwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:52:53 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D85178BE;
        Fri, 30 Dec 2022 07:52:52 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id i83so11263601ioa.11;
        Fri, 30 Dec 2022 07:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMhrVDylLdSSZiiGal6d5OdoolcBpjlvVV/YDpmQ7VU=;
        b=Ziao3QSV6HLqXT5s8OmszhM5Am86trE6Xo9QP9Wplr36PwL+CPVa32w/XvqOFH9JA7
         4LE+PAd6Wp3IopDyqFPM29E8nqPym2JaEsBLVuTVBDSFCjq3fn4FxHehcl5+TSg6prtV
         nzUrc3wMBoHyYq8J5FNjA5PGpeFVkmfUCrNgkjebGK8Mf0jWcG5H3BsHdLkM3sQtYDiT
         iJCftmiTs8b3WmzHYnKIwLkV2LqimmUFfHUuHv9PKJ8+KAGrK3AEK141lWzxH91GRhPK
         YD5rOkJwoFCvT96Ggu/Vsx4zk1+Uceg9hXXjJcch//B0BF7528OzHWrm5frtsp/h7LEC
         a4FA==
X-Gm-Message-State: AFqh2kqq5YiYCyZMEWmI3lJKvEBJXPfaYlRcUJt9fqVhMyQZTLOJoFmU
        oxg2EWzClSwNQZEQ9yFzR4rosBsEInTv0LoD5BSrYTP2
X-Google-Smtp-Source: AMrXdXvpAT6YjQ1nFxmbN0JScsZwmWSZj8k0RnFLb5ZBFiFYx+MhcFMACLWS+pIETR4njRRbXgw/tFMgL5UNRgb5+WA=
X-Received: by 2002:a05:6638:8d:b0:38a:3357:8a4 with SMTP id
 v13-20020a056638008d00b0038a335708a4mr2559982jao.53.1672415572137; Fri, 30
 Dec 2022 07:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20221214233106.69b2c01b@gandalf.local.home> <Y5trUep9IvCv1Uwy@google.com>
 <20221215141146.6ceb7cf2@gandalf.local.home> <CAEXW_YQLtK=4LMJ+LHPVWU0wbV-027HJoCEKTjZvBZ6krrn6vw@mail.gmail.com>
 <20221215151333.49af5442@gandalf.local.home>
In-Reply-To: <20221215151333.49af5442@gandalf.local.home>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 16:52:36 +0100
Message-ID: <CAJZ5v0iNdLyOpAxsCTTq-zqRfWDrJ5_c2DUcJYE5ZFn7u+2qdQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring buffer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 9:13 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 15 Dec 2022 14:52:48 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Another approach could be to always enable the trace event by default,
> > if the CONFIG is turned on. Or do a printk() telling the user about
> > the event to enable, so they know why their trace buffer is empty.
>
> Yeah, that is another option.
>
> And, yes I need to document it better. I started to, but then decided to
> hold off until I get some feedback in case this is rejected.
>
> >
> > Up to you and the ACPI maintainers. ;-)
>
> I'm going to guess I may not hear back until the new year. I'm fine with
> that :-)

It's just a couple of days, but still.

Personally, I would use a command line option to control the behavior
and the Kconfig option to provide its default value.

This way it can be flipped without rebuilding the kernel if need be.

I would also make the ACPI debug output go into the trace buffer so
long as the Kconfig option is not changed or the command line option
is not flipped.

Cheers!
