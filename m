Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065B9711E66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjEZDY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEZDY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:24:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC1E6;
        Thu, 25 May 2023 20:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=FGc2DpRwzN2CfKjvI105cUP9f2PjEF2afGAtgtqFB38=; b=YTvd3rCSPD25KbM3zkOAIlVuR3
        Y5s+ExS6tTZlXbDqpXmqzSK36KOhFcQlkX6awiu+skf+fogZ0Mcpnu5OYgnCeS3OIT7GxLGDygWoa
        qmuQ0mRx4ABgpPWVLwjmXhZ9hhPGRpt0FiIdItqNzX/DNA/+o54fZWx1/w2uAXntceixEkzZyrPYP
        fwZKLmMh/U1qV1o9VDbM3qWnfkydv7jpMGMgoWDk7f2FpzjpUmK00cBNsTez9m/FJPeddt6em4F0s
        E1znANbwABARAz8t7GPcYarxWvxmj6SSdTYeWGaWacJlDaTvisgIISzBWC+P4bSe6cuqkd/3LHZ9H
        NOaHeNQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2O3t-000rME-2a;
        Fri, 26 May 2023 03:24:17 +0000
Date:   Thu, 25 May 2023 20:24:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-modules@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
Message-ID: <ZHAmYSclm+5QlLcM@bombadil.infradead.org>
References: <20230517131820.936553-1-arnd@kernel.org>
 <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
 <a3d01d39-3d45-4fdc-8f73-b6c33bcae24b@app.fastmail.com>
 <ZG27pExhUqFpGexM@bombadil.infradead.org>
 <CAPhsuW4ZksuhhXqDNrb4fPqQFVgW+cfpNLGHOWoLoYWjCKZGpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4ZksuhhXqDNrb4fPqQFVgW+cfpNLGHOWoLoYWjCKZGpA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 06:45:35PM -0700, Song Liu wrote:
> + Alan Maguire
> 
> On Wed, May 24, 2023 at 12:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, May 24, 2023 at 08:25:13AM +0200, Arnd Bergmann wrote:
> > > On Wed, May 24, 2023, at 07:07, Luis Chamberlain wrote:
> > > > On Wed, May 17, 2023 at 03:18:07PM +0200, Arnd Bergmann wrote:
> > > >> From: Arnd Bergmann <arnd@arndb.de>
> > > >>
> > > >> The arch_get_kallsym() function was introduced so that x86 could override
> > > >> it, but that override was removed in bf904d2762ee ("x86/pti/64: Remove
> > > >> the SYSCALL64 entry trampoline"), so now this does nothing except causing
> > > >> a warning about a missing prototype:
> > > >>
> > > >> kernel/kallsyms.c:662:12: error: no previous prototype for 'arch_get_kallsym' [-Werror=missing-prototypes]
> > > >>   662 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
> > > >>
> > > >> Restore the old behavior before d83212d5dd67 ("kallsyms, x86: Export
> > > >> addresses of PTI entry trampolines") to simplify the code and avoid
> > > >> the warning.
> > > >>
> > > >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Shouldn't this go through x86 as this sort of fixesss commit
> > > > bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")?
> > >
> > > That works for me as well, as long as someone picks it up. It's
> > > not really x86 any more though since that commit is five years
> > > old and removed the last reference from the x86 code.
> >
> > Fair enough.
> >
> > > I sent it to you since you are the one that merged most of
> > > the kallsyms patches through the module tree, but I guess
> > > you are not actually maintaining that file (not blaming you,
> > > I'd also try to stay away from kallsyms).
> > >
> > > I can resend it to Andrew for the -mm tree.
> >
> > OK, I just took the patch in, it's on the train, better get on before
> > it gets lost.
> 
> This change broke compilation of BPF selftests in modules-next
> branch:
> 
> progs/bpf_iter_ksym.c:62:13: error: no member named 'pos_arch_end' in
> 'struct kallsym_iter'
>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>              ~~~~  ^
> progs/bpf_iter_ksym.c:62:35: error: no member named 'pos_arch_end' in
> 'struct kallsym_iter'
>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>                                    ~~~~  ^
> 
> I haven't looked into the proper fix for it yet.

A quick attempt:

Arnd, can you verify?

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
index 5ddcc46fd886..521267818f4d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
@@ -59,9 +59,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
 	} else {
 		BPF_SEQ_PRINTF(seq, "0x%llx %c %s ", value, type, iter->name);
 	}
-	if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
-		BPF_SEQ_PRINTF(seq, "CORE ");
-	else if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
+	if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
 		BPF_SEQ_PRINTF(seq, "MOD ");
 	else if (!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > iter->pos)
 		BPF_SEQ_PRINTF(seq, "FTRACE_MOD ");
