Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8136E5498
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDQWPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQWPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:15:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE45275;
        Mon, 17 Apr 2023 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JDQzZLMFJDW5Lkfe1LxMQV8f8XQI7ptxaDWypTR6ENw=; b=aoKysKwocvLQSxSr8k6YPuhx1T
        TpfprTvFoskLH4J1OC5XkCLUQYmYrS8OK2bRUbEYgqWoRLUxoK3cQIM+TK9fbiKFzLehx5//x0q4N
        BqPl7tzAmWGK7zzvyZddo7lHkZB4hicgpRzc5LhiJHIK4S7E1iO69kKn0OsefyaPyyi1iEPE22Rnb
        52INLLlyQR26JLT7X9XL519lVVbr2YaeztBIGDIbYzdmebdDlafjdXWZK4abe7LypyWrTBWp9+1G/
        sLRNsGFQkdRJOieGwxlDoxuR0H5XxXpsJj1eKfTB6bI8iFKXKptA05d5YC4q/zoRYzPrYNPupxoL0
        nLALzLrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poX84-000FNP-2U;
        Mon, 17 Apr 2023 22:15:20 +0000
Date:   Mon, 17 Apr 2023 15:15:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Aaron Tomlin <atomlin@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Viktor Malik <vmalik@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Song Liu <song@kernel.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] module: fix building stats for 32-bit targets
Message-ID: <ZD3E+AYPzq/EO2Gs@bombadil.infradead.org>
References: <20230417220254.3215576-1-arnd@kernel.org>
 <20230417220254.3215576-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417220254.3215576-2-arnd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:02:47AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new module statistics code mixes 64-bit types and wordsized 'long'
> variables, which leads to build failures on 32-bit architectures:

Doh. 0-day had not complained!

> kernel/module/stats.c: In function 'read_file_mod_stats':
> kernel/module/stats.c:291:29: error: passing argument 1 of 'atomic64_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   291 |  total_size = atomic64_read(&total_mod_size);
> x86_64-linux-ld: kernel/module/stats.o: in function `read_file_mod_stats':
> stats.c:(.text+0x2b2): undefined reference to `__udivdi3'
> 
> To fix this, the code has to use one of the two types consistently.
> 
> Change them all to fixed-size 64-bit ones here.
> 
> Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I have no idea if there is a risk of these variables actually
> overflowing 'long' on 32-bit machines. If they provably can't, it
> would be better to do the opposite patch.

I had originally used atomic64_t and added a debugfs knob for it but
Linus had advised against it because its not a stat we care too much
on 32-bit and atomic64 is nasty on 32-bit [0].

So I went with atomic_long and the cast becuase we're just reading.
 
Is there a way to fix this without doing the fully jump? If not oh well.

[0] https://lkml.kernel.org/r/CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com

  Luis

> ---
>  kernel/module/internal.h | 14 +++++------
>  kernel/module/main.c     | 10 ++++----
>  kernel/module/stats.c    | 50 ++++++++++++++++++++--------------------
>  3 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 9ba5f8df15bc..c1710b74027c 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -175,13 +175,13 @@ enum fail_dup_mod_reason {
>  
>  #ifdef CONFIG_MODULE_STATS
>  
> -#define mod_stat_add_long(count, var) atomic_long_add(count, var)
> +#define mod_stat_add_64(count, var) atomic64_add(count, var)
>  #define mod_stat_inc(name) atomic_inc(name)
>  
> -extern atomic_long_t total_mod_size;
> -extern atomic_long_t total_text_size;
> -extern atomic_long_t invalid_kread_bytes;
> -extern atomic_long_t invalid_decompress_bytes;
> +extern atomic64_t total_mod_size;
> +extern atomic64_t total_text_size;
> +extern atomic64_t invalid_kread_bytes;
> +extern atomic64_t invalid_decompress_bytes;
>  
>  extern atomic_t modcount;
>  extern atomic_t failed_kreads;
> @@ -189,7 +189,7 @@ extern atomic_t failed_decompress;
>  struct mod_fail_load {
>  	struct list_head list;
>  	char name[MODULE_NAME_LEN];
> -	atomic_long_t count;
> +	atomic64_t count;
>  	unsigned long dup_fail_mask;
>  };
>  
> @@ -199,7 +199,7 @@ void mod_stat_bump_becoming(struct load_info *info, int flags);
>  
>  #else
>  
> -#define mod_stat_add_long(name, var)
> +#define mod_stat_add_64(name, var)
>  #define mod_stat_inc(name)
>  
>  static inline int try_add_failed_module(const char *name, size_t len,
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1ed373145278..d1b213310e4b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2600,8 +2600,8 @@ static noinline int do_init_module(struct module *mod)
>  	mutex_unlock(&module_mutex);
>  	wake_up_all(&module_wq);
>  
> -	mod_stat_add_long(text_size, &total_text_size);
> -	mod_stat_add_long(total_size, &total_mod_size);
> +	mod_stat_add_64(text_size, &total_text_size);
> +	mod_stat_add_64(total_size, &total_mod_size);
>  
>  	mod_stat_inc(&modcount);
>  
> @@ -3052,7 +3052,7 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
>  	err = copy_module_from_user(umod, len, &info);
>  	if (err) {
>  		mod_stat_inc(&failed_kreads);
> -		mod_stat_add_long(len, &invalid_kread_bytes);
> +		mod_stat_add_64(len, &invalid_kread_bytes);
>  		return err;
>  	}
>  
> @@ -3081,7 +3081,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
>  				       READING_MODULE);
>  	if (len < 0) {
>  		mod_stat_inc(&failed_kreads);
> -		mod_stat_add_long(len, &invalid_kread_bytes);
> +		mod_stat_add_64(len, &invalid_kread_bytes);
>  		return len;
>  	}
>  
> @@ -3090,7 +3090,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
>  		vfree(buf); /* compressed data is no longer needed */
>  		if (err) {
>  			mod_stat_inc(&failed_decompress);
> -			mod_stat_add_long(len, &invalid_decompress_bytes);
> +			mod_stat_add_64(len, &invalid_decompress_bytes);
>  			return err;
>  		}
>  	} else {
> diff --git a/kernel/module/stats.c b/kernel/module/stats.c
> index bbf90190a3fe..c4db7f64cdae 100644
> --- a/kernel/module/stats.c
> +++ b/kernel/module/stats.c
> @@ -196,12 +196,12 @@ static LIST_HEAD(dup_failed_modules);
>   *    a separate module request was being issued for each CPU on a system.
>   */
>  
> -atomic_long_t total_mod_size;
> -atomic_long_t total_text_size;
> -atomic_long_t invalid_kread_bytes;
> -atomic_long_t invalid_decompress_bytes;
> -static atomic_long_t invalid_becoming_bytes;
> -static atomic_long_t invalid_mod_bytes;
> +atomic64_t total_mod_size;
> +atomic64_t total_text_size;
> +atomic64_t invalid_kread_bytes;
> +atomic64_t invalid_decompress_bytes;
> +static atomic64_t invalid_becoming_bytes;
> +static atomic64_t invalid_mod_bytes;
>  atomic_t modcount;
>  atomic_t failed_kreads;
>  atomic_t failed_decompress;
> @@ -222,21 +222,21 @@ static const char *mod_fail_to_str(struct mod_fail_load *mod_fail)
>  
>  void mod_stat_bump_invalid(struct load_info *info, int flags)
>  {
> -	atomic_long_add(info->len * 2, &invalid_mod_bytes);
> +	atomic64_add(info->len * 2, &invalid_mod_bytes);
>  	atomic_inc(&failed_load_modules);
>  #if defined(CONFIG_MODULE_DECOMPRESS)
>  	if (flags & MODULE_INIT_COMPRESSED_FILE)
> -		atomic_long_add(info->compressed_len, &invalid_mod_byte);
> +		atomic64_add(info->compressed_len, &invalid_mod_bytes);
>  #endif
>  }
>  
>  void mod_stat_bump_becoming(struct load_info *info, int flags)
>  {
>  	atomic_inc(&failed_becoming);
> -	atomic_long_add(info->len, &invalid_becoming_bytes);
> +	atomic64_add(info->len, &invalid_becoming_bytes);
>  #if defined(CONFIG_MODULE_DECOMPRESS)
>  	if (flags & MODULE_INIT_COMPRESSED_FILE)
> -		atomic_long_add(info->compressed_len, &invalid_becoming_bytes);
> +		atomic64_add(info->compressed_len, &invalid_becoming_bytes);
>  #endif
>  }
>  
> @@ -247,7 +247,7 @@ int try_add_failed_module(const char *name, size_t len, enum fail_dup_mod_reason
>  	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list,
>  				lockdep_is_held(&module_mutex)) {
>  		if (strlen(mod_fail->name) == len && !memcmp(mod_fail->name, name, len)) {
> -                        atomic_long_inc(&mod_fail->count);
> +                        atomic64_inc(&mod_fail->count);
>  			__set_bit(reason, &mod_fail->dup_fail_mask);
>                          goto out;
>                  }
> @@ -258,7 +258,7 @@ int try_add_failed_module(const char *name, size_t len, enum fail_dup_mod_reason
>  		return -ENOMEM;
>  	memcpy(mod_fail->name, name, len);
>  	__set_bit(reason, &mod_fail->dup_fail_mask);
> -        atomic_long_inc(&mod_fail->count);
> +        atomic64_inc(&mod_fail->count);
>          list_add_rcu(&mod_fail->list, &dup_failed_modules);
>  out:
>  	return 0;
> @@ -331,12 +331,12 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
>  
>  	if (live_mod_count && total_size) {
>  		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average mod size",
> -				 DIV_ROUND_UP(total_size, live_mod_count));
> +				 DIV64_U64_ROUND_UP(total_size, live_mod_count));
>  	}
>  
>  	if (live_mod_count && text_size) {
>  		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average mod text size",
> -				 DIV_ROUND_UP(text_size, live_mod_count));
> +				 DIV64_U64_ROUND_UP(text_size, live_mod_count));
>  	}
>  
>  	/*
> @@ -349,25 +349,25 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
>  	WARN_ON_ONCE(ikread_bytes && !fkreads);
>  	if (fkreads && ikread_bytes) {
>  		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail kread bytes",
> -				 DIV_ROUND_UP(ikread_bytes, fkreads));
> +				 DIV64_U64_ROUND_UP(ikread_bytes, fkreads));
>  	}
>  
>  	WARN_ON_ONCE(ibecoming_bytes && !fbecoming);
>  	if (fbecoming && ibecoming_bytes) {
>  		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail becoming bytes",
> -				 DIV_ROUND_UP(ibecoming_bytes, fbecoming));
> +				 DIV64_U64_ROUND_UP(ibecoming_bytes, fbecoming));
>  	}
>  
>  	WARN_ON_ONCE(idecompress_bytes && !fdecompress);
>  	if (fdecompress && idecompress_bytes) {
>  		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail decomp bytes",
> -				 DIV_ROUND_UP(idecompress_bytes, fdecompress));
> +				 DIV64_U64_ROUND_UP(idecompress_bytes, fdecompress));
>  	}
>  
>  	WARN_ON_ONCE(imod_bytes && !floads);
>  	if (floads && imod_bytes) {
>  		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average fail load bytes",
> -				 DIV_ROUND_UP(imod_bytes, floads));
> +				 DIV64_U64_ROUND_UP(imod_bytes, floads));
>  	}
>  
>  	/* End of our debug preamble header. */
> @@ -407,16 +407,16 @@ static const struct file_operations fops_mod_stats = {
>  	.llseek = default_llseek,
>  };
>  
> -#define mod_debug_add_ulong(name) debugfs_create_ulong(#name, 0400, mod_debugfs_root, (unsigned long *) &name.counter)
> +#define mod_debug_add_u64(name) debugfs_create_u64(#name, 0400, mod_debugfs_root, (s64 *)&name.counter)
>  #define mod_debug_add_atomic(name) debugfs_create_atomic_t(#name, 0400, mod_debugfs_root, &name)
>  static int __init module_stats_init(void)
>  {
> -	mod_debug_add_ulong(total_mod_size);
> -	mod_debug_add_ulong(total_text_size);
> -	mod_debug_add_ulong(invalid_kread_bytes);
> -	mod_debug_add_ulong(invalid_decompress_bytes);
> -	mod_debug_add_ulong(invalid_becoming_bytes);
> -	mod_debug_add_ulong(invalid_mod_bytes);
> +	mod_debug_add_u64(total_mod_size);
> +	mod_debug_add_u64(total_text_size);
> +	mod_debug_add_u64(invalid_kread_bytes);
> +	mod_debug_add_u64(invalid_decompress_bytes);
> +	mod_debug_add_u64(invalid_becoming_bytes);
> +	mod_debug_add_u64(invalid_mod_bytes);
>  
>  	mod_debug_add_atomic(modcount);
>  	mod_debug_add_atomic(failed_kreads);
> -- 
> 2.39.2
> 
