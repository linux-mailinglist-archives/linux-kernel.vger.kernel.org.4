Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF22673A026
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFVL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFVL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:57:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A27198
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dnuSRjit9BClyf8ssWCLDDODxXJZmhDnJ4paeO5Nhx4=; b=pSWWLPWkaaoJwHc5BYho2poyPl
        eIWhn/5lqy2SEgEoeR3nAv0aJ8EHJmEWIJd1pNAfu6XYd3iA1O0K29sU64D64FD89ly99k0csSzr6
        /Yf44ZWG5r1/r112unkcSNqmOEFsnJ0IvnVjdtAkNmAO9AQWc1o4P0yHC+mBLwUSiUQ7FE0bdA9lh
        v6HwdXpSBBNckOoEpyjh5Vl/7X7BxoC8B860EG/qV4xYN9NQxldNh1LTQhU35lNy0OPwpkt+6q1EM
        TEp5tJ83ZWBXcldmwOlDKqgo28P7Gral3S6BrII6lffytuKus/FlQUaypbE+qdNfn7/7v3vGBBB92
        oDeVJM5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCIvr-00FZUB-Ln; Thu, 22 Jun 2023 11:56:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B83F300338;
        Thu, 22 Jun 2023 13:56:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FD74241BF9B6; Thu, 22 Jun 2023 13:56:59 +0200 (CEST)
Date:   Thu, 22 Jun 2023 13:56:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 14/14] powerpc: Implement UACCESS validation on PPC32
Message-ID: <20230622115659.GO4253@hirez.programming.kicks-ass.net>
References: <cover.1687430631.git.christophe.leroy@csgroup.eu>
 <be282f27ad808418c7475b51a00b4cb035f89a95.1687430631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be282f27ad808418c7475b51a00b4cb035f89a95.1687430631.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:54:36PM +0200, Christophe Leroy wrote:

> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index f850ab892ad5..8ac5711a055f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -218,6 +218,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"kthread_exit",
>  		"kunit_try_catch_throw",
>  		"lbug_with_loc",
> +		"longjmp",
>  		"machine_real_restart",
>  		"make_task_dead",
>  		"mpt_halt_firmware",
> @@ -230,7 +231,9 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"sev_es_terminate",
>  		"snp_abort",
>  		"start_kernel",
> +		"start_secondary_resume",
>  		"stop_this_cpu",
> +		"unrecoverable_exception",
>  		"usercopy_abort",
>  		"x86_64_start_kernel",
>  		"x86_64_start_reservations",

Someone went and changed all that in tip/objtool/core :-)

But perhaps, like the uaccess_safe_builtins[] array below, should we
start marking sections so we can remember where stuff comes from later?

> @@ -1335,6 +1338,8 @@ static const char *uaccess_safe_builtin[] = {
>  	"rep_stos_alternative",
>  	"rep_movs_alternative",
>  	"__copy_user_nocache",
> +	"__copy_tofrom_user",
> +	"__arch_clear_user",
>  	NULL
>  };

Do we want to rename the 'misc' sectino to 'x86' and start a 'ppc32'
section there?

