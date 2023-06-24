Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715E073CC4B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjFXRvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFXRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 13:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEB698
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 10:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E1B60907
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 17:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFC3C433C0;
        Sat, 24 Jun 2023 17:50:57 +0000 (UTC)
Date:   Sat, 24 Jun 2023 13:50:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>
Subject: Re: [GIT PULL] tracing: user_event fix for 6.4
Message-ID: <20230624135056.263e0ba9@rorschach.local.home>
In-Reply-To: <20230623220959.6461cc02@rorschach.local.home>
References: <20230623152926.128aa568@gandalf.local.home>
        <CAHk-=whmnhEY6s1USY+hHX5+31orf7U_TxXvx+Y89xhL-Ydvzg@mail.gmail.com>
        <20230623220959.6461cc02@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

On Fri, 23 Jun 2023 22:09:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The code that does the write is basically something being monitored by
> something else that will tell it to start writing. But that something
> else could have the buffer disabled for writes. The use case for this
> is to disable the buffer, enable all the trace events you care about,
> and then enabled the buffer which is the same as enabling all events at
> the same time to get a more coherent trace.

Are you fine with the above explanation? The thing is, writes that are
dropped due to the buffer being disabled shouldn't be a concern of the
producer. It's the consumer that controls that. This is the same
behavior that is used by internal kernel trace events, and we wanted to
keep it consistent.

Would you like me to resend the pull request with an updated change log?

-- Steve
