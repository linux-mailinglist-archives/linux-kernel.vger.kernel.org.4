Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB84B64E202
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLOTxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLOTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:53:04 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9D537E4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:53:01 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f20so75722lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7WnaZc2bs26QE2S1hFU0wWVtk2SkMXSSpzkb6FSS1RI=;
        b=aGblDN6+LiroAi5Ce2HI0sla+sv/MZ0o1VnWUgJkTxIOUl93xZYtZDnsd8zl1DABm2
         OfhiFJBPHg9RSV8cw+9sGyvjAUzHb9igov4etIG+PT6jB8if72VmeESBXHF3IHsiLc5M
         b2CmaXYJsYqhGPOOzKvG2srf3DxtCyWSKXn2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WnaZc2bs26QE2S1hFU0wWVtk2SkMXSSpzkb6FSS1RI=;
        b=L3pOJjBuhqPh8Gy2hg2Bpqj6+4xWdx1V5WnvD1w5gFIsoF/KKl8Bvd1xkNZ9KlAPLA
         RgACEXYKfbuaxrL3bxScKRHn+cLbPmeHWrDXNgi3EPh2N1RboQWT1oGSpMmKoop/UzSm
         yMUPTe5PGkGSGhtNh/7unO69qqVb+sPhjbHV93iiwdNk3KylraANWyJWLYsC0/5vor+7
         ihpONcV6i8qxwkgOjVyXzfqcX0E9DvgFVBLZtqJesqUZJb0Gvq37jqKEdz7VhDjZfChs
         DbCFVdK1UGY7BxJnLcst09Zs1q6vixdE9rf+ECw1Chpsg5/hSBMfsyeSGjAHCbxustbn
         j2KQ==
X-Gm-Message-State: ANoB5pkF6CqCpKpUr3CZcvu73l+3SLtUw5RzQwTnguzOuuBhGNN0rhde
        Nx/k7SLB/bktZ8gLBpkXZrvwcYwgx6fYt8oiJhWr5Q==
X-Google-Smtp-Source: AA0mqf4FW9H2CtluhofbPQJiA6xZ7ZdK14RZtc7ewZw8cqvcl+H7LOmqZe+1wc0FJ8tx6X3g9uIC6DD8PJrYGi5UrrE=
X-Received: by 2002:a05:651c:124c:b0:279:f45e:ccd6 with SMTP id
 h12-20020a05651c124c00b00279f45eccd6mr7839328ljh.483.1671133979884; Thu, 15
 Dec 2022 11:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20221214233106.69b2c01b@gandalf.local.home> <Y5trUep9IvCv1Uwy@google.com>
 <20221215141146.6ceb7cf2@gandalf.local.home>
In-Reply-To: <20221215141146.6ceb7cf2@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Dec 2022 14:52:48 -0500
Message-ID: <CAEXW_YQLtK=4LMJ+LHPVWU0wbV-027HJoCEKTjZvBZ6krrn6vw@mail.gmail.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring buffer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
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

On Thu, Dec 15, 2022 at 2:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 15 Dec 2022 18:45:37 +0000
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Wouldn't it be better to also check trace_acpi_print_enabled() here in the
> > else if() condition, along with IS_ENABLED()? That way if the CONFIG is
> > enabled but the tracepoint is not enabled, at least the messages will go to
> > dmesg instead of skipped.
>
> I really don't want that. This was purposely done to be mutually exclusive.
> The reason I added this in the first place, is because too much enabled
> will render the system useless if printk() is used.
>
> After boot up, if I had enabled all debug events and then I were to disable
> the acpi tracepoint, it will likely render the system useless again if it
> were to switch over to printk.

Ok, sure. I see where you were going. So you want no debugging
messages at all if the trace event is disabled. That's fine with me. I
would also add a note about the need to enable the specific trace
event, in the Kconfig message and/or the Documentation. Otherwise, you
might get someone say, "hey I enabled the CONFIG option but I see
nothing in the trace buffer".

Another approach could be to always enable the trace event by default,
if the CONFIG is turned on. Or do a printk() telling the user about
the event to enable, so they know why their trace buffer is empty.

Up to you and the ACPI maintainers. ;-)

thanks,

 - Joel
