Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0C73B34F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFWJNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFWJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:13:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30327C2;
        Fri, 23 Jun 2023 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DZQQmjQ1drwcgq6Oa05wX61/L3ksY1VFD/yuj1ZSbCU=; b=Slb6Zo8nbLsH9VzI4HIiUYvaGW
        XkE1nMQYkl1kV6+8WonAHB6G+7fY0d7KSiDeHoRWGCWc27CZrUoqco1Yl3WAl6vILgCyQQ/kbWt9X
        aGPf2QPuzSpW2uaReFapa7G8lxByjtd599oist8mgTHM6TLIEFBiSUjVV5Tsbf5H8C6nNti1tVwvS
        S32Ned2ANqs3HF7JeLYu3VFHb7LiRAdRKKoImXHGaI+OJS5b1+RHKVswUENLsTm81A+I0DfpbVZc1
        Q1AcHtKA0B7qBHXXK2LRW+cg8SLoKsjy6b54p7/5liYFhVAvoEtI75WuwXqr1QchE6PuIuP6vuX6c
        spL1xD5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCcqy-002Bi3-23;
        Fri, 23 Jun 2023 09:13:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36C3B300392;
        Fri, 23 Jun 2023 11:13:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C460245257D7; Fri, 23 Jun 2023 11:13:13 +0200 (CEST)
Date:   Fri, 23 Jun 2023 11:13:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix CFI failures with GCOV_PROFILE_ALL
Message-ID: <20230623091313.GS4253@hirez.programming.kicks-ass.net>
References: <20230623001140.1111494-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623001140.1111494-4-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 12:11:41AM +0000, Sami Tolvanen wrote:
> Hi folks,
> 
> The following two patches fix CFI failures with GCOV_PROFILE_ALL,
> where the compiler injects indirectly called functions to object
> files that otherwise contain no executable code, and are not
> processed by objtool or don't have CFI enabled. This results in
> missing or incorrect type hashes during boot and when modules are
> loaded.
> 
> Sami Tolvanen (2):
>   kbuild: Fix CFI failures with GCOV
>   kbuild: Disable GCOV for *.mod.o
> 
>  init/Makefile             | 1 +
>  scripts/Makefile.modfinal | 2 +-
>  scripts/Makefile.vmlinux  | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 

Urgh, tricky stuff this.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

And yes, objtool essentially assumes vmlinux.o is complete and does LTO
like passes. Is there something kbuild can do to ensure noting else gets
linked in after this?
