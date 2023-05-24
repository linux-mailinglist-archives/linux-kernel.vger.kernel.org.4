Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9170ECE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbjEXFHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjEXFHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:07:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4D186;
        Tue, 23 May 2023 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sjlVDFCPLE+4lwQnEgEPXV61uw4obZVe0UBJaCWFloI=; b=EwjxuVgRcIHzk7ncH+d2n5azXG
        +iplFO8wtiw09cEU/n7Zr9UIH5uxFvNyngxkhc/rgxEqrssoIYnrqclCcLbO4QvbfurNsFNj0MQtK
        Gptr8s9C5+BgQMRDczZkF54NjtjMNDEgUtl3rjhLanVs9vlawLJ+ydIKiuLOuTehihx/ATHh6OGY3
        h4btws9clssYFywTJ4zq9jwhflDtB4p1by6OlKYqwBl7iXHkxjMtOkxvcyOTz8Y2SKvaMhkDocKaO
        UcaGEJ7MUZ2cOifYnaCrAmmcfEX3hyBiUBjA3hdY4FJsT+P5MueUh6SWh12RrcJ2kW2vPzxv5DSDv
        MDEly9LA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1giM-00CNQG-1C;
        Wed, 24 May 2023 05:07:10 +0000
Date:   Tue, 23 May 2023 22:07:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>
Cc:     linux-modules@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
Message-ID: <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
References: <20230517131820.936553-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517131820.936553-1-arnd@kernel.org>
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

On Wed, May 17, 2023 at 03:18:07PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The arch_get_kallsym() function was introduced so that x86 could override
> it, but that override was removed in bf904d2762ee ("x86/pti/64: Remove
> the SYSCALL64 entry trampoline"), so now this does nothing except causing
> a warning about a missing prototype:
> 
> kernel/kallsyms.c:662:12: error: no previous prototype for 'arch_get_kallsym' [-Werror=missing-prototypes]
>   662 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
> 
> Restore the old behavior before d83212d5dd67 ("kallsyms, x86: Export
> addresses of PTI entry trampolines") to simplify the code and avoid
> the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Shouldn't this go through x86 as this sort of fixesss commit
bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")?

  Luis
> ---
>  kernel/kallsyms.c | 28 +---------------------------
>  1 file changed, 1 insertion(+), 27 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index e01c435595f9..dac13659601f 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -646,7 +646,6 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
>  /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
>  struct kallsym_iter {
>  	loff_t pos;
> -	loff_t pos_arch_end;
>  	loff_t pos_mod_end;
>  	loff_t pos_ftrace_mod_end;
>  	loff_t pos_bpf_end;
> @@ -659,29 +658,9 @@ struct kallsym_iter {
>  	int show_value;
>  };
>  
> -int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
> -			    char *type, char *name)
> -{
> -	return -EINVAL;
> -}
> -
> -static int get_ksymbol_arch(struct kallsym_iter *iter)
> -{
> -	int ret = arch_get_kallsym(iter->pos - kallsyms_num_syms,
> -				   &iter->value, &iter->type,
> -				   iter->name);
> -
> -	if (ret < 0) {
> -		iter->pos_arch_end = iter->pos;
> -		return 0;
> -	}
> -
> -	return 1;
> -}
> -
>  static int get_ksymbol_mod(struct kallsym_iter *iter)
>  {
> -	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
> +	int ret = module_get_kallsym(iter->pos - kallsyms_num_syms,
>  				     &iter->value, &iter->type,
>  				     iter->name, iter->module_name,
>  				     &iter->exported);
> @@ -764,7 +743,6 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
>  	iter->nameoff = get_symbol_offset(new_pos);
>  	iter->pos = new_pos;
>  	if (new_pos == 0) {
> -		iter->pos_arch_end = 0;
>  		iter->pos_mod_end = 0;
>  		iter->pos_ftrace_mod_end = 0;
>  		iter->pos_bpf_end = 0;
> @@ -780,10 +758,6 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
>  {
>  	iter->pos = pos;
>  
> -	if ((!iter->pos_arch_end || iter->pos_arch_end > pos) &&
> -	    get_ksymbol_arch(iter))
> -		return 1;
> -
>  	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
>  	    get_ksymbol_mod(iter))
>  		return 1;
> -- 
> 2.39.2
> 
