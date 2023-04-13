Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0826E0885
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjDMIBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMIBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:01:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE32170F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T9sVN4rg2Z41Wudwx/KXXQSY+VS5hpGcnbFAqVe2a3o=; b=KU7AL/pDt81QuW6LhjmoXrVisO
        7kIGQwTVxdFHZabCObB4CUnlT5hJXVV+NrlNsqc0Q9sQP/6q5wF7Ap+YIniN7cEi3wEg90PDmZtQb
        wpoIt6Bj6NtCMTn7vosxF8cKHQbN2x9T8WkIeA2Johd2jr1kYTkV8aBxN21AOv0M+M1ZRPEotsNBZ
        mMfKD8C3Tt9U60Dc4vBJpKnPe6HE44HMC4X1/gxqyY3FTznqGUNaUlvvmYmpDWAxkk3zwNy5tGbPg
        jEhw5J4Dk+tvS4p/J56wG8vD+bRpreakRJsVAur3JyTc450Z12ElalQ/GBrlVCQfJvtVLS8zrI5vC
        fR3ilODQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmrtI-00EfZq-21;
        Thu, 13 Apr 2023 08:01:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31BBB3001E4;
        Thu, 13 Apr 2023 10:01:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15A45235CC4A0; Thu, 13 Apr 2023 10:01:12 +0200 (CEST)
Date:   Thu, 13 Apr 2023 10:01:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 3/9] objtool: Limit unreachable warnings to once per
 function
Message-ID: <20230413080112.GF4253@hirez.programming.kicks-ass.net>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <81ed0b8e5218ac6ecae49af901bf5e0fb3687cef.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ed0b8e5218ac6ecae49af901bf5e0fb3687cef.1681325924.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:03:18PM -0700, Josh Poimboeuf wrote:

> diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
> index b1c920dc9516..4ef9b278e5fd 100644
> --- a/tools/objtool/include/objtool/warn.h
> +++ b/tools/objtool/include/objtool/warn.h
> @@ -55,7 +55,10 @@ static inline char *offstr(struct section *sec, unsigned long offset)
>  
>  #define WARN_INSN(insn, format, ...)					\
>  ({									\
> -	WARN_FUNC(format, insn->sec, insn->offset,  ##__VA_ARGS__);	\
> +	if (!insn->sym || !insn->sym->warned)				\
> +		WARN_FUNC(format, insn->sec, insn->offset, ##__VA_ARGS__);\
> +	if (insn->sym)							\
> +		insn->sym->warned = 1;					\
>  })

Do we want to write that like:

#define WARN_INSN(insn, format, ...)					\
({									\
	struct instruction *_insn = (insn);				\
	if (!_insn->sym || !_insn->sym->warned)				\
		WARN_FUNC(format, _insn->sec, _insn->offset, ##__VA_ARGS__);\
	if (_insn->sym)							\
		_insn->sym->warned = 1;					\
})

instead ?
