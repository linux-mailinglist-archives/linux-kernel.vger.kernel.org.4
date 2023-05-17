Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826937075BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEQXBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEQXBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:01:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 440F6526E;
        Wed, 17 May 2023 16:01:02 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4AA5620F32B2;
        Wed, 17 May 2023 16:01:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AA5620F32B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684364461;
        bh=Sx7I12MgI21IfjMTdz/sb80FwxyU0F3BNXVRLf4aVFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxrRMQa7TTr1X0TjqUCm//+svY6KZbH9tYmAPw+8nNFvginetlK4nlCkW1zTf43dy
         5R8xZ/rgUZeKe0i93HeJXlZgswahiJepbG7A7OidHSokQ2jztFc1Dq6xrHtVoeOtBE
         79o2I3HH9PbWv0MnCEk5aRssl/axM4kSkCii+DU8=
Date:   Wed, 17 May 2023 16:00:54 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20230517230054.GA195@W11-BEAU-MD.localdomain>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 12:37:11PM -0700, Linus Torvalds wrote:
> On Wed, May 17, 2023 at 12:36 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > .. this is the patch that I think should go on top of it to fix the
> > misleading "safe" and the incorrect RCU walk.
> 
> Let's actually attach the patch too. Duh.
> 
>                Linus

>  kernel/trace/trace_events_user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index b2aecbfbbd24..054e28cc5ad4 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -439,7 +439,7 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
>  	struct user_event_enabler *enabler;
>  	struct user_event_enabler *next;
>  
> -	list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
> +	list_for_each_entry(enabler, next, &mm->enablers, link) {
>  		if (enabler->addr == uaddr &&
>  		    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
>  			return true;
> @@ -455,19 +455,19 @@ static void user_event_enabler_update(struct user_event *user)
>  	struct user_event_mm *next;
>  	int attempt;
>  
> +	lockdep_assert_held(&event_mutex);
> +
>  	while (mm) {
>  		next = mm->next;
>  		mmap_read_lock(mm->mm);
> -		rcu_read_lock();
>  
> -		list_for_each_entry_rcu(enabler, &mm->enablers, link) {
> +		list_for_each_entry(enabler, &mm->enablers, link) {
>  			if (enabler->event == user) {
>  				attempt = 0;
>  				user_event_enabler_write(mm, enabler, true, &attempt);
>  			}
>  		}
>  
> -		rcu_read_unlock();
>  		mmap_read_unlock(mm->mm);
>  		user_event_mm_put(mm);
>  		mm = next;

Do you mind giving me your Signed-off-by for these?

I plan to do a series where I take these patches and then also fix up a
few comments and the link namings as you suggested.

First patch is clean, second patch I made the following changes and
after that passed all the self-tests without bug splats with
CONFIG_PROVE_LOCKING/RCU and ATOMIC_SLEEP:

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b2aecbfbbd24..2f70dabb0f71 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -437,9 +437,8 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
                                      unsigned long uaddr, unsigned char bit)
 {
        struct user_event_enabler *enabler;
-       struct user_event_enabler *next;

-       list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
+       list_for_each_entry(enabler, &mm->enablers, link) {
                if (enabler->addr == uaddr &&
                    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
                        return true;
@@ -495,7 +494,9 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
        enabler->values = orig->values & ENABLE_VAL_DUP_MASK;

        refcount_inc(&enabler->event->refcnt);
-       list_add_rcu(&enabler->link, &mm->enablers);
+
+       /* Enablers not exposed yet, RCU not required */
+       list_add(&enabler->link, &mm->enablers);
