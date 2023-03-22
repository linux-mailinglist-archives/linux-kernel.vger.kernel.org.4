Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4013C6C41B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCVEx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVEx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:53:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F501F5F0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F92461E67
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11341C433EF;
        Wed, 22 Mar 2023 04:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679460805;
        bh=Wo6x+GkPPT8Pl8Uu3LpccWeB7CQyzGI5HckGtYH3xU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beKRsCbdUXU4yxrYpN8JnvAKOQ1QBcoOj76fxlYLdbRTr6nZSrU/gFB+LQPDHEpsO
         YdowDgoyyFHM8UiZZ8ZCmt8itFvmonu6cbG6L4soE0iYZ5HXDOJQ0rURjK74TSPcwP
         hyo3ORuiWArkyTEB4Bag8ajbBlIG8XG9tJ+rHsWGetw7Cewshg2nQlRNm69w/4WTrv
         0hGAXLIt3VO3CpV3Qke/WAJwbjsDn/b8DOavfMz9iZlCJrilpxdqoI6f5l9PuBnWSO
         CYi44mzDwaT0b5UecXn4/tCm8I6fAXtFa+/8cTCZOtBeUm1N3JdKjNLPKUXhym5zrP
         qNc2vjbQQ5B3g==
Date:   Tue, 21 Mar 2023 21:53:23 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] static_call: Improve key type abstraction
Message-ID: <20230322045323.zxlf5wuhizabvvlc@treble>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <c8bc83b2c70aeaad3ce01d12dc1153981ab693f8.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8bc83b2c70aeaad3ce01d12dc1153981ab693f8.1679456900.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:00:07PM -0700, Josh Poimboeuf wrote:
> diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
> index 639397b5491c..41f6bda6773a 100644
> --- a/kernel/static_call_inline.c
> +++ b/kernel/static_call_inline.c
> @@ -112,15 +112,21 @@ static inline void static_call_sort_entries(struct static_call_site *start,
>  
>  static inline bool static_call_key_has_mods(struct static_call_key *key)
>  {
> -	return !(key->type & 1);
> +	return !!(key->type & 1);
>  }
>  
> -static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
> +static inline struct static_call_mod *static_call_key_mods(struct static_call_key *key)
>  {
>  	if (!static_call_key_has_mods(key))
>  		return NULL;
>  
> -	return key->mods;
> +	return (struct static_call_mod *)(key->type & ~1);
> +}
> +

Oops, these parts belonged in the next patch.

-- 
Josh
