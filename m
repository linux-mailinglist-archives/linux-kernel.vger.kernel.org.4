Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE88D707660
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEQXZf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 19:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQXZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFC22D47;
        Wed, 17 May 2023 16:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32FF4647D0;
        Wed, 17 May 2023 23:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C3FC433D2;
        Wed, 17 May 2023 23:25:29 +0000 (UTC)
Date:   Wed, 17 May 2023 19:25:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230517192528.043adc7a@gandalf.local.home>
In-Reply-To: <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
References: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
        <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
        <20230516222919.79bba667@rorschach.local.home>
        <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
        <20230517172243.GA152@W11-BEAU-MD.localdomain>
        <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
        <20230517190750.GA366@W11-BEAU-MD.localdomain>
        <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
        <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
        <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
        <20230517230054.GA195@W11-BEAU-MD.localdomain>
        <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 16:14:43 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, May 17, 2023 at 4:01 PM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> >
> > Do you mind giving me your Signed-off-by for these?  
> 
> Assuming you have some test-cases that you've run them through, then yes:

Beau,

Can you update the tools/testing/selftests/user_events/ to make sure that
it triggers the lockdep splat without these updates (assuming that it does
trigger without these patches). Then add these patches to make sure the
splat goes away. This will confirm that the patches do what is expected of
them.

I usually run the selftests for tracing and for your user events with
lockdep and prove locking enabled. But it may have triggered on something
else disabling it when I ran my tests, in which case I sometimes disable
that and forget to re-enable it.

-- Steve
