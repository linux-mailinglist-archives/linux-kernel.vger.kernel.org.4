Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5740C603AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJSHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJSHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:30:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C805F204
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=21/ckJWCOxn0XfQspA5XjzoM+FA0LGSZXaDWxW/e6gM=; b=LLqccD4lEA9JYP1m9eRP7lH2vN
        td4WwVpAXSKBq2fK28Ns9M1/xqupZYqgTcOr39szzoX67P/A7Y30hNt9KAK3GTLit3RNuKbLi4kfl
        lW9+OtD9jDoKglvnE6hX6dupUZjkFlSNavMmwR0VswFLnRbIisyyvdzC619ApW4pwfPpzCU2EGm7V
        lYXet24L/NwbWtaVALVk1vOou3/aGqZy26zG8IiNT4MPzQEQQf8CB1fYCIOpXiJAIbaZWgtrRsLKp
        iylJLT6k5W9YCq00mC5/T27UvWJ38nzrs9w9zQwviTrA2uSemJZN7JagdSUuH2VCC2Et8o+TY9tOX
        LEwydVtQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ol3WZ-004hQA-Qh; Wed, 19 Oct 2022 07:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BF40300431;
        Wed, 19 Oct 2022 09:29:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5ADCB2B124979; Wed, 19 Oct 2022 09:29:58 +0200 (CEST)
Date:   Wed, 19 Oct 2022 09:29:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y0+ndrbwtKV0muPC@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <20221018233854.qj3vrdxsnc6ds7qs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018233854.qj3vrdxsnc6ds7qs@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:38:54PM -0700, Josh Poimboeuf wrote:

> Can the objtool changes be moved to a separate patch?

Yep, will do.

> The RFC was 11 patches, is it now much smaller because of the new
> dependencies?  The RFC had some eBPF changes and a test module, are
> those no longer needed?

Yeah; it's all become much simpler with the infrastructure we get from
the call-depth-tracking nonsense.
