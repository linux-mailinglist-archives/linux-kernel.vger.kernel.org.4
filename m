Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729806CB9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjC1Irb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjC1Ir3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:47:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C454C05
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:47:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0273E1FDA1;
        Tue, 28 Mar 2023 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679993247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwlX1ZKKkpep42Df/aSvGTZTqr74ekNzHcssqi3oj/A=;
        b=y+ToxPFHRRDoH/1AcZt/wwqBWPfU577F891yLLh3rAIGlz1IkVe6E9I8E6vmBecBpJYta1
        QkgLA6PwJg04DeVRUjsz0W2I710EB4iy3unqoULBVAHo4qw0f7IhAoIaD96ZrnCq7KuNdu
        uXlp4e7UrWF615UkL9LHd+X33Bx13gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679993247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwlX1ZKKkpep42Df/aSvGTZTqr74ekNzHcssqi3oj/A=;
        b=1rSMvy3cHaVPk78kum3InCQzJB4kOLdLih2r/iRZ0x89j3+kAwIGpWMtz0KdCWjD39JJB5
        cSruqpzBTcLMg7Dg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D490F2C141;
        Tue, 28 Mar 2023 08:47:26 +0000 (UTC)
Date:   Tue, 28 Mar 2023 10:47:26 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] objtool: Add '--verbose' option for disassembling
 affected functions
In-Reply-To: <217a005fe22f9d33f99fed499d6508af9f5cabd0.1679932620.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2303281046470.14873@pobox.suse.cz>
References: <cover.1679932620.git.jpoimboe@kernel.org> <217a005fe22f9d33f99fed499d6508af9f5cabd0.1679932620.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void objdump_func(struct section *sec, unsigned long offset)
> +{
> +	struct symbol *sym = find_func_containing(sec, offset);

Unnecessary assignment?

> +	const char *script_relative = "scripts/objdump-func";
> +	bool is_text = (sec->sh.sh_flags & SHF_EXECINSTR);
> +	char *cmd, *srctree, *script;
> +
> +	if (is_text)
> +		sym = find_func_containing(sec, offset);
> +	if (!sym)
> +		sym = find_symbol_containing(sec, offset);
> +	if (!sym)
> +		return;

Miroslav
