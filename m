Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BBE74DA03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjGJPhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjGJPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:37:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C76129;
        Mon, 10 Jul 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fBHMLUIRsBctfnOcEvVXM28ONXqkgcr6sBN2BdpcQ3A=; b=t/Q29L37ndFcJ11/WkGAVTQihD
        t/6qyFm+419RijcKBYmxxPgG3ByKZ2o65laA+mYtk3SkfmbBVa4E8+V7n3PzVaEehNZvd8JiAtZUi
        XMsrokmf+frorzkEkf39PqGbeBtNsPCaTWoDfZp2+DF2Oh9VyQoQtv8yzEiSAChZJu6sabqwnv2lu
        /y2o01BwVv3Rml5lUGRWhwUmgPXY+qShDndgOqz14q4AOfFgVuVWu5JN7s3eN3nso2kjDmwo8U6VR
        RKk4IyH9rdqyPE98ImcE7e+igk6gglhZDFZl1oZ6EDOB6YLM0W56Rk/6WXr2YfEzrumTQG61jZHKe
        gOL1GlfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIsx4-00EidV-0F; Mon, 10 Jul 2023 15:37:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8958130014A;
        Mon, 10 Jul 2023 17:37:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70EBA26716928; Mon, 10 Jul 2023 17:37:24 +0200 (CEST)
Date:   Mon, 10 Jul 2023 17:37:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kprobes: Prohibit probing on CFI preamble symbol
Message-ID: <20230710153724.GA3040258@hirez.programming.kicks-ass.net>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
 <168899126450.80889.16200438320430187434.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168899126450.80889.16200438320430187434.stgit@devnote2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 09:14:24PM +0900, Masami Hiramatsu (Google) wrote:


> +#ifdef CONFIG_CFI_CLANG
> +static bool is_cfi_preamble_symbol(unsigned long addr)
> +{
> +	char symbuf[KSYM_NAME_LEN];
> +
> +	if (lookup_symbol_name(addr, symbuf))
> +		return false;
> +
> +	return str_has_prefix("__cfi_", symbuf)
		|| str_has_prefix("__pfx_", symbol);

The __pfx_ symbols can happen when !CFI_CLANG but still having
FUNCTION_PADDING_BYTES.

> +}
> +#else
> +#define is_cfi_preamble_symbol(addr)	(0)
> +#endif

As such I think we can do the above unconditionally, without either
there should not be any matching symbols.

