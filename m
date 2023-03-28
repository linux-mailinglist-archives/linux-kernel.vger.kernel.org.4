Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8086CB911
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjC1IHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjC1IHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:07:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD9186
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i2a5uRx5onqHxKU9cIPVHnDlKVMtyz/3zkPnQsdMlRc=; b=ljHXIIVoKYuPPp4pHEZEY6fE87
        aGZ8r7Tre/u9SmtY5aw1qe0Ee76MlGw5cshMTrs/4ZH0xb9tgOOOiLEjHnkZ8xhkeKRQTnov/QW6n
        HyfZ2LQ3nKee1muyO8RGDbNzPN5bUTCB724HgT9SGjBH9X8KfDqOa8WYVF2zDHP6vae7/p9DXS/ht
        B3ApZEm4cpxCznhLs9ivsDN69hFrxvlRZXO3ZgY48XIyrsSSsV5n6ZvXn8wBlAoUpqIqkzYzEA4pO
        WNn+ZfrvyhV0TJ7bQi4DTyajJxiLyhUKGAP9eeU+4BwV7pzGFGzoaVC/wFfJRDDMZM2Wwgnd12po2
        BOWskj+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph4Mt-008Enp-DB; Tue, 28 Mar 2023 08:07:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED3FF3000E6;
        Tue, 28 Mar 2023 10:07:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5AC22CB744A9; Tue, 28 Mar 2023 10:07:43 +0200 (CEST)
Date:   Tue, 28 Mar 2023 10:07:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] objtool: Combine '--backtrace' with '--verbose'
Message-ID: <20230328080743.GC4253@hirez.programming.kicks-ass.net>
References: <cover.1679932620.git.jpoimboe@kernel.org>
 <ef477e7cf3f188c623279764e831772eab2a4016.1679932620.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef477e7cf3f188c623279764e831772eab2a4016.1679932620.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:00:45AM -0700, Josh Poimboeuf wrote:
> Get rid of the '--backtrace' option, instead including that
> functionality in '--verbose'.  This makes it easy to gather all the
> information needed for diagnosing objtool warnings.

Hurmm.. can't we have verbose imply backtrace but keep the separate
option? I'm not sure if I always want the objdump thing -- esp with
multiple warnings on vmlinux that's going to be really slow -- better to
dump the whole of vmlinux.o once at the end.


