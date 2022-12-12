Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FCB64A927
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiLLVCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiLLVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:02:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CDB18E3F;
        Mon, 12 Dec 2022 13:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F32B6122B;
        Mon, 12 Dec 2022 21:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B883C433EF;
        Mon, 12 Dec 2022 21:01:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ROzf0OEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670878895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+33heWZqPNvN/OOyLci+aYXHO8pTl7ySUh12yfzj1hI=;
        b=ROzf0OEVcwV9kZSenrrYUtosBdsEhtxY7C5PILTab3NuW9wgoBfEK7sg5PUW//W6yifT10
        ENmm15ZqndAQutSnhGJelFw/OERj0DcstMOjf1WGns0U/WRd3zssrruw/4aQoaNXtR6aB3
        zGr3RiiFUgrPUH0iNcctwVACAJvXiS4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b60ecb78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Dec 2022 21:01:35 +0000 (UTC)
Date:   Mon, 12 Dec 2022 14:01:33 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de
Cc:     linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH RFC v12 2/6] x86: mm: Skip faulting instruction for
 VM_DROPPABLE faults
Message-ID: <Y5eWrYSCmKBG3MVS@zx2c4.com>
References: <20221212185347.1286824-1-Jason@zx2c4.com>
 <20221212185347.1286824-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212185347.1286824-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:53:43AM -0700, Jason A. Donenfeld wrote:
> +	if (fault & VM_FAULT_SKIP_INSN) {
> +		u8 insn_buf[MAX_INSN_SIZE];
> +		struct insn insn;
> +		size_t len;
> +
> +		len = sizeof(insn_buf) - copy_from_user(insn_buf, (void *)regs->ip, sizeof(insn_buf));
> +		if (!len)
> +			return;
> +
> +		if (insn_decode(&insn, insn_buf, len, in_32bit_syscall() ? INSN_MODE_32 : INSN_MODE_64) < 0)
> +			return;
> +
> +		regs->ip += insn.length;
> +		return;
> +	}

I just found umip.c, which does basically the same thing, but does it
correctly. For v+1, the above snippet will instead do this:

	if (fault & VM_FAULT_SKIP_INSN) {
		u8 buf[MAX_INSN_SIZE];
		struct insn insn;
		int nr_copied;

		nr_copied = insn_fetch_from_user(regs, buf);
		if (nr_copied <= 0)
			return;

		if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
			return;

		regs->ip += insn.length;
		return;
	}

Same thing, but those helpers do correct inspection of the environment
and registers.

Also, seeing this already being done in umip.c is heartening that the
approach here isn't overly insane.

Jason
