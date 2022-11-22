Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65F26348FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiKVVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKVVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:14:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85B2EF78
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 251A3618D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FECC433D6;
        Tue, 22 Nov 2022 21:14:47 +0000 (UTC)
Date:   Tue, 22 Nov 2022 16:14:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] jump_label: use atomic_try_cmpxchg in
 static_key_slow_inc_cpuslocked
Message-ID: <20221122161446.28907755@gandalf.local.home>
In-Reply-To: <20221019140850.3395-1-ubizjak@gmail.com>
References: <20221019140850.3395-1-ubizjak@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 16:08:50 +0200
Uros Bizjak <ubizjak@gmail.com> wrote:

> Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
> in static_key_slow_inc_cpuslocked.  x86 CMPXCHG instruction returns success
> in ZF flag, so this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old" when
> cmpxchg fails, enabling further code simplifications.
> 
> No functional change intended.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  kernel/jump_label.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 714ac4c3b556..4d6c6f5f60db 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -115,8 +115,6 @@ EXPORT_SYMBOL_GPL(static_key_count);
>  
>  void static_key_slow_inc_cpuslocked(struct static_key *key)
>  {
> -	int v, v1;
> -
>  	STATIC_KEY_CHECK_USE(key);
>  	lockdep_assert_cpus_held();
>  
> @@ -132,11 +130,9 @@ void static_key_slow_inc_cpuslocked(struct static_key *key)
>  	 * so it counts as "enabled" in jump_label_update().  Note that
>  	 * atomic_inc_unless_negative() checks >= 0, so roll our own.
>  	 */
> -	for (v = atomic_read(&key->enabled); v > 0; v = v1) {
> -		v1 = atomic_cmpxchg(&key->enabled, v, v + 1);
> -		if (likely(v1 == v))
> +	for (int v = atomic_read(&key->enabled); v > 0; )

Although it's permitted by the compiler, the kernel style is to not add
declarations in conditionals.

Please keep the "int v;" at the beginning.


> +		if (likely(atomic_try_cmpxchg(&key->enabled, &v, v + 1)))

I'm fine with this change.

-- Steve


>  			return;
> -	}
>  
>  	jump_label_lock();
>  	if (atomic_read(&key->enabled) == 0) {

