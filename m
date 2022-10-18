Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3F6034A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJRVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiJRVJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:09:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C472606
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=azLS4jtI34+AVvBn3oePJJ5T90tPMjIIZAeIJU4/1fw=; b=OoUitWYTA44ZCa0YmRW2sKqL66
        /bZZLWHBrJ/kRt5R05b28quHN9DIQiPppO2tMZqyyY2BddLLlLjeGPDsAmyotQ/nyuCjuOZ9ju76Q
        dXgHczkMg2sH+N56KLiWqwt9P6cMaZTgp0WGhyrrDF7m9JZ9FCHJYy9UsZtaijsTFjtdqmCKWC9wv
        MBlpDMHgVmqkGmTE1DDwjywpNNgCu+v/eBkjWepvVHSxKz1E6zgihej/GzTYxUOKZgzTDBcLLmYtt
        AK2e6l3w4a4N1pn/aS8yvvmYl3AXEjqmWg1NMF8xUc7gjmffV2ltNmPMGJguHW9ePFdsSxKBXw2td
        IUJg8t9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oktq0-004ZyB-VU; Tue, 18 Oct 2022 21:09:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27C313000DD;
        Tue, 18 Oct 2022 23:09:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 086432C0A0314; Tue, 18 Oct 2022 23:09:24 +0200 (CEST)
Date:   Tue, 18 Oct 2022 23:09:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y08WA+jFRNaH0eTQ@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08FhjK3fKsfRAaw@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08FhjK3fKsfRAaw@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:59:02PM +0200, Peter Zijlstra wrote:

> @@ -732,6 +734,8 @@ static __init int cfi_parse_cmdline(char
>  			cfi_mode = CFI_KCFI;
>  		} else if (!strcmp(str, "fineibt")) {
>  			cfi_mode = CFI_FINEIBT;
> +		} else if (!strcmp(str, "norand")) {
> +			cfi_rand = false;
>  		} else {
>  			pr_err("Ignoring unknown cfi option (%s).", str);
>  		}

Plus so I suppose, otherwise it'll still randomize the hashes even if it
then leaves the whole thing disabled, which seems a bit daft :-)

Index: linux-2.6/arch/x86/kernel/alternative.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/alternative.c
+++ linux-2.6/arch/x86/kernel/alternative.c
@@ -730,6 +730,7 @@ static __init int cfi_parse_cmdline(char
 			cfi_mode = CFI_DEFAULT;
 		} else if (!strcmp(str, "off")) {
 			cfi_mode = CFI_OFF;
+			cfi_rand = false;
 		} else if (!strcmp(str, "kcfi")) {
 			cfi_mode = CFI_KCFI;
 		} else if (!strcmp(str, "fineibt")) {
