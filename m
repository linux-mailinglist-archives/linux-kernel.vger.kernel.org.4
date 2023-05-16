Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0384A7048E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjEPJRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjEPJRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:17:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DD25596;
        Tue, 16 May 2023 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OBCPnu+BGgk3Cuo/WyqzF95R9vjNP+oDEXn6EOL1COY=; b=lcr10CU58+Jlc6aMR4VdoWQDzU
        gfmE+pQ0R2xS9GUIF3mYGcJolDhMlwgK+pyi4K47xEFvl8zzXP2LsKocJQRnvsUqEaBGg8DIJFtYe
        tB8AfT8e3/r1pfkeX77oiVWDWfTzLeYwA8mkfMpgo9FqvsEkKFutAaTP4C0iQym+AtcgP+uiP6aA4
        RrlILmh7I5FHd203lw31XCkm+ljoMJb8uZh0ccyaTu42TaOPqNV09hU7GImexwdwEn4r2OQVnMbpm
        paN7hUtaAtOMbUyOkTaWhz64qNT4rzhooZIdDBINYUJbVklaZKGe/IdQZYtFGp2HAMDJTwG/rwt65
        lhhGPQyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyqmf-00482M-RS; Tue, 16 May 2023 09:15:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63E8630008D;
        Tue, 16 May 2023 11:15:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E722C20118D79; Tue, 16 May 2023 11:15:48 +0200 (CEST)
Date:   Tue, 16 May 2023 11:15:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
Message-ID: <20230516091548.GA2587705@hirez.programming.kicks-ass.net>
References: <20230516071830.8190-1-zegao@tencent.com>
 <20230516071830.8190-3-zegao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516071830.8190-3-zegao@tencent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:

> +static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> +		struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct fprobe *fp;
> +	int bit;
> +
> +	fp = container_of(ops, struct fprobe, ops);
> +	if (fprobe_disabled(fp))
> +		return;
> +
> +	/* recursion detection has to go before any traceable function and
> +	 * all functions before this point should be marked as notrace
> +	 */
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0) {
> +		fp->nmissed++;
> +		return;
> +	}
> +	__fprobe_handler(ip, parent_ip, ops, fregs);
>  	ftrace_test_recursion_unlock(bit);
> +
>  }
>  NOKPROBE_SYMBOL(fprobe_handler);
>  
>  static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
>  				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> -	struct fprobe *fp = container_of(ops, struct fprobe, ops);
> +	struct fprobe *fp;
> +	int bit;
> +
> +	fp = container_of(ops, struct fprobe, ops);
> +	if (fprobe_disabled(fp))
> +		return;
> +
> +	/* recursion detection has to go before any traceable function and
> +	 * all functions called before this point should be marked as notrace
> +	 */
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0) {
> +		fp->nmissed++;
> +		return;
> +	}

Please don't use this comment style; multi line comments go like:

	/*
	 * Multi line comment ...
	 *                    ... is symmetric.
	 */

Same for your next patch.
