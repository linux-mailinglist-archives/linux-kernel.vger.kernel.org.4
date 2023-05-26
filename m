Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB6712BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbjEZRj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjEZRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:39:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C785AC9;
        Fri, 26 May 2023 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=EVtoXAEMDy6OIa/WgDvWQDrR2tkjZNPgZSP3RRLS+io=; b=iN9yxKbCvPFS+c+eNY+VvRh50C
        SGuiPHWQpnZRPgc2oRLQqcvKCLzl2LkUiEjDC5lTlo2LALP+Mp95Y5U37s3FQghkj93x9xLuLOUbF
        6wTzPeeqabzYU1DV/5Mdy8xej21vPVpRX7KgsM8AjZiUJEdvb0nhltHYQKsJVzGYFG/PFBnMLxcuM
        SJ1B6YPGp6Tr69x4JHzeB996BKGQhMaEmoKivW4unzJ9fsTtNNVcopSgUqT/ReXK4yLkKA5fT+MeN
        PvB5rixoYCHIBF26Iho3K+Oyi0CI/tpUcSquVjhlSbpejk3PLAev9nNVRS+IbCVSsFcOiDATAmz+7
        KAI2Ah9Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2bPJ-003KUo-1d;
        Fri, 26 May 2023 17:39:17 +0000
Date:   Fri, 26 May 2023 10:39:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Song Liu <song@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-modules@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
Message-ID: <ZHDuxYBsaGn7xJBn@bombadil.infradead.org>
References: <20230517131820.936553-1-arnd@kernel.org>
 <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
 <a3d01d39-3d45-4fdc-8f73-b6c33bcae24b@app.fastmail.com>
 <ZG27pExhUqFpGexM@bombadil.infradead.org>
 <CAPhsuW4ZksuhhXqDNrb4fPqQFVgW+cfpNLGHOWoLoYWjCKZGpA@mail.gmail.com>
 <ZHAmYSclm+5QlLcM@bombadil.infradead.org>
 <2591bdc4-a198-446c-8bfe-37ea39c51964@app.fastmail.com>
 <872b0c40-651e-6989-cd4c-8ca7f655dc79@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <872b0c40-651e-6989-cd4c-8ca7f655dc79@oracle.com>
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

On Fri, May 26, 2023 at 03:39:22PM +0100, Alan Maguire wrote:
> On 26/05/2023 07:41, Arnd Bergmann wrote:
> > On Fri, May 26, 2023, at 05:24, Luis Chamberlain wrote:
> >> On Thu, May 25, 2023 at 06:45:35PM -0700, Song Liu wrote:
> >>> On Wed, May 24, 2023 at 12:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>>
> >>> This change broke compilation of BPF selftests in modules-next
> >>> branch:
> >>>
> >>> progs/bpf_iter_ksym.c:62:13: error: no member named 'pos_arch_end' in
> >>> 'struct kallsym_iter'
> >>>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
> >>>              ~~~~  ^
> >>> progs/bpf_iter_ksym.c:62:35: error: no member named 'pos_arch_end' in
> >>> 'struct kallsym_iter'
> >>>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
> >>>                                    ~~~~  ^
> >>>
> >>> I haven't looked into the proper fix for it yet.
> >>
> >> A quick attempt:
> >>
> >> Arnd, can you verify?
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c 
> >> b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> >> index 5ddcc46fd886..521267818f4d 100644
> >> --- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> >> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> >> @@ -59,9 +59,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
> >>  	} else {
> >>  		BPF_SEQ_PRINTF(seq, "0x%llx %c %s ", value, type, iter->name);
> >>  	}
> >> -	if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
> >> -		BPF_SEQ_PRINTF(seq, "CORE ");
> >> -	else if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
> >> +	if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
> >>  		BPF_SEQ_PRINTF(seq, "MOD ");
> >>  	else if (!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > 
> >> iter->pos)
> >>  		BPF_SEQ_PRINTF(seq, "FTRACE_MOD ");
> > 
> > This looks correct to me, but I'm still failing to cross-build
> > the selftests on my randconfig build setup, so I can't confirm that
> > this avoids the build failure, and I don't understand the code well
> > enough to be sure.
> >
> 
> Thanks for the fix! The change above works ; maybe having
> anything less than iter->pos_mod_end marked as a "CORE/MOD " symbol
> might be worth tweaking, but that's a minor thing.
> 
> before:
> 
>   CLNG-BPF [test_maps] bpf_iter_ksym.bpf.o
> progs/bpf_iter_ksym.c:62:13: error: no member named 'pos_arch_end' in
> 'struct kallsym_iter'
>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>              ~~~~  ^
> progs/bpf_iter_ksym.c:62:35: error: no member named 'pos_arch_end' in
> 'struct kallsym_iter'
>         if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
>                                    ~~~~  ^
> 2 errors generated.
> 
> after the above is applied, bpf selftests build and iter ksym test
> passes:
> 
> $ sudo ./test_progs -t bpf_iter
> ...
> #12/37   bpf_iter/ksym:OK
> ...
> Summary: 3/39 PASSED, 0 SKIPPED, 0 FAILED
> 
> Feel free to add a
> 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

I just folded this into Arnd's patch and pushed to modules-next.

Thanks!

  Luis
