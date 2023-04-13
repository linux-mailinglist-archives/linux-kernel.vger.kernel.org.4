Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026106E0A47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDMJan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDMJag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:30:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F7372B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RcVjd7ZQQPDvUk1mn2qjBVkSgdbvat+crpA+5uI3J6w=; b=Oxx1AtuVQG9bA3C21VKgVVJYsX
        Q830fuooX1OebU51DzZ+0E9ujSQkAB+qem+hYT40M6YAT50DlhSZTARZRDMDCO5MJGujATtR8siaV
        k/n3mwnxhTep1Oud0pnr3TKX2cyY4TSaUgtFDYHMDHY7xc65BWshfwhCSc6dhqKiRxUf3zuyUjTqt
        j+CwTfL3gAAD/pZa/FM7Hkrohd9W5IyvSUM3R/NSwHkz2JMwGAT9WyNyWhFkpvQtPrGLlLKC2olHw
        MNzZZ+Eu7TVq6znaCnpg8LJx43Bl+sZ4S9MA3vCbacUW8etVjTLkfeMEJ3L1CleqfZ79vv1cGLjbN
        QOSugE5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmtHk-007g9h-5w; Thu, 13 Apr 2023 09:30:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6B143001E4;
        Thu, 13 Apr 2023 11:30:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 985ED235CC46F; Thu, 13 Apr 2023 11:30:31 +0200 (CEST)
Date:   Thu, 13 Apr 2023 11:30:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/3] objtool: Separate prefix code from stack validation
 code
Message-ID: <20230413093031.GK4253@hirez.programming.kicks-ass.net>
References: <cover.1681331135.git.jpoimboe@kernel.org>
 <d7f31ac2de462d0cd7b1db01b7ecb525c057c8f6.1681331135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f31ac2de462d0cd7b1db01b7ecb525c057c8f6.1681331135.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:26:13PM -0700, Josh Poimboeuf wrote:
> Simplify the prefix code and make it a standalone feature.

The main thing being that you moved it all after
validate_reachable_instructions() ?


> +static int add_prefix_symbols(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct symbol *func;
> +	int ret, warnings = 0;
> +
> +	for_each_sec(file, sec) {
> +		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
> +			continue;
> +
> +		list_for_each_entry(func, &sec->symbol_list, list) {

One of the other patches did a sec_for_each_symbol() thing.

> +			if (func->type != STT_FUNC)
> +				continue;
> +
> +			add_prefix_symbol(file, func);
> +		}
> +	}
> +
> +	return warnings;
> +}
