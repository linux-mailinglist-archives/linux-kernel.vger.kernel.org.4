Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BA960C892
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJYJlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiJYJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:41:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5113FBD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SnlWmlZs9Pxy2O2ggquCnxseiG5kK9xU+YyulkAU+YI=; b=E7bK1udZg7G93L+OwM9gihzZmR
        9n6Usq2uUkl4vgZlHfEG95j0DCASoLnS2RlRN1OqxKb5DuQh9sLfIaFVKti3TbQGsUdaUtqsaH7le
        X9K4H42I2njFongaKh7EJT+i06UuPKrkl14/dub4+dRdidoSCXiUsdMUcx/JRq7Ea749xIg4Yl/rq
        QHDuoXhogvbz+92tZohLVkFlLg3+vstOQJzt36hAiICzUkWlBguUMWplrSPTGnzNBaSsYvrE7K5Pq
        AmvWmiebNJQB4/cVnG0uYt9f6Kv70P/VC2zaEwI16B7JWqhUZz3Ye0fGWpvKdAUI0mlLrvv9JXvUs
        AuetJHnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onGPN-006HmG-31; Tue, 25 Oct 2022 09:39:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 871ED300169;
        Tue, 25 Oct 2022 11:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CD1F2C431FA0; Tue, 25 Oct 2022 11:39:39 +0200 (CEST)
Date:   Tue, 25 Oct 2022 11:39:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Message-ID: <Y1eu2wFVp1zcLg5b@hirez.programming.kicks-ass.net>
References: <20221024114536.44686c83@gandalf.local.home>
 <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
 <20221024145250.08cfc147@gandalf.local.home>
 <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:08:49PM -0700, Linus Torvalds wrote:
> I suspect it would be fixed by just moving 'poking_init()' earlier. In
> many ways I suspect it would make most sense as part of 'mm_init()',
> not as a random call fairly late in start_kernel().

dup_mm() doesn't work until after proc_caches_init() at the very least.

Let me see if I can untangle some of this..
