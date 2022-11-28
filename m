Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9863AD34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiK1QDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiK1QDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:03:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3361D663
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:03:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E7CBA21BB4;
        Mon, 28 Nov 2022 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669651426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+/cSTvQGSKuihsIOEU271usRMSNRubkrFCCNR/vHtA=;
        b=gvhOdQAhJOZ4d4F6QzPEf/iGvAJG9p9Xc4ACcjX+wne1a7VrqG8PXWZy3ZfROltWvHrvHU
        IU2MMki6K0LM2nM1sKkTeUxn+3boC2eSann5EBDMw1ZYMnhzAexyPjx9XE6EZPrgViqzDt
        fsCq1qb6NvOF9WRaRNPfjAA9ZVbB/nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669651426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+/cSTvQGSKuihsIOEU271usRMSNRubkrFCCNR/vHtA=;
        b=17hrYVGACstTDz1PANhqhIcXlO7rnmOPs7o0Cu9lacgJq7ncDqe9QrtQOgKoafjwzY+zq2
        YJBS5Fsg57yRZwBw==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id B17632C141;
        Mon, 28 Nov 2022 16:03:46 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 8E81744002E; Mon, 28 Nov 2022 17:03:46 +0100 (CET)
From:   Andreas Schwab <schwab@suse.de>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: head: use 0 as the default text_offset
References: <20221128152442.3403-1-jszhang@kernel.org>
X-Yow:  ...Get me a GIN and TONIC!!...make it HAIR TONIC!!
Date:   Mon, 28 Nov 2022 17:03:46 +0100
In-Reply-To: <20221128152442.3403-1-jszhang@kernel.org> (Jisheng Zhang's
        message of "Mon, 28 Nov 2022 23:24:42 +0800")
Message-ID: <mvm35a383rx.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28 2022, Jisheng Zhang wrote:

> Commit 0f327f2aaad6 ("RISC-V: Add an Image header that boot loader can
> parse.") adds an image header which "is based on ARM64 boot image
> header and provides an opportunity to combine both ARM64 & RISC-V
> image headers in future.". At that time, arm64's default text_offset
> is 0x80000, this is to give "512 KB of guaranteed BSS space to put
> the swapper page tables" as commit cfa7ede20f13 ("arm64: set TEXT_OFFSET
> to 0x0 in preparation for removing it entirely") pointed out, but
> riscv doesn't need the space, so use 0 as the default text_offset.

Doesn't that clash with the memory reserved for openSBI?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
