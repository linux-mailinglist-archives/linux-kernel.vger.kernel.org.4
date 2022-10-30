Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88242612AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 14:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ3NT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3NT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 09:19:57 -0400
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6DFB7F9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1667135962; bh=7ZB8QhocN2s3hPoZ/1bKqbKsfF0/49Hms0o4+0l6fFc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FJRwjXgF1aJxSRirzjcSCeGAYHYxhTCdgxhQP+kVRDy0d7hWm3nSp63mBkgXq96+8
         iGq1Wjed2murfyBGX0nw14/IK1PoRaTBaivR3dQ4M/rlEkIs1JOSbOLDbTrlO10bFa
         GrMLlrvXU4X2Y0jDFMbkukp0zNbls+4uu8U767nktHE7nLDq0LDf+5EQ+0vb7tmRVN
         a7tAga2rL2KS1v0GR+6LF/aFYfMNW9R5RIOZTr7F+w73/Cm2iBmyICjrWIkBfJoyZ7
         aKyhmzQ2UE5XzWw8qkh+mNBogZel2JsmjEn/ZfXaAEzRzUtSbR0nNwCo012/cBC8uL
         jdX1mwR1vE58g==
Received: by gentwo.de (Postfix, from userid 1001)
        id C310CB001C0; Sun, 30 Oct 2022 14:19:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id BF90AB000A7;
        Sun, 30 Oct 2022 14:19:22 +0100 (CET)
Date:   Sun, 30 Oct 2022 14:19:22 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Wen Yao <haiwenyao@uniontech.com>
cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, dennis@kernel.org, tj@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] riscv: percpu:Add riscv percpu operations
In-Reply-To: <20221026104015.565468-2-haiwenyao@uniontech.com>
Message-ID: <f1b82a9-a88b-50f5-8b49-69e52d7bdaa9@gentwo.de>
References: <20221026104015.565468-1-haiwenyao@uniontech.com> <20221026104015.565468-2-haiwenyao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022, Wen Yao wrote:

> This patch use riscv AMO(Atomic Memory Operation) instructions to
> optimise some this_cpu_and this_cpu_or this_cpu_add operations.
> It reuse cmpxchg_local() to impletment this_cpu_cmpxchg macros.
> It reuse xchg_relaxed() to impletment this_cpu_xchg macros.

Are you sure that these changes gives you any benefit vs disabling preempt
or irq offs? I dont know too much about atomics on riscv but it looks like
you are using full atomics. The performance penalty for the use of those
is usually drastic. Often irq/preempt off is better.

Could you run some of the synthetic tests to establish the benefit? F.e.
run the synthetic tests for the slub allcator with and without these
patches.


> +			__asm__ __volatile__(                                  \
> +				"amo" #asm_op ".w"                             \

amo = atomic operation?
