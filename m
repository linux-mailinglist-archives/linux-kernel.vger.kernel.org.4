Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A7D6C4EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCVO7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:59:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE21BFB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0B9GN+Xs8p4f594QxpDWqsaTBFklL/W1QSOwUnXsrC8=; b=AkV2yymcNjDSYmYTD9UV5r2IkZ
        arPuiSnGgEqEZnQxHlNwndTaFRqumMaLPUqrBgJx7n47A5oaPASO1qg3HfsEHmKBuk3B9jVvjNYOs
        ULod1WQ8nNjZBiYfK72G9Sgv7tB//Az8KYV6jOclOYdjmRZH6VHubwxOnqgycIjhOBX4ZHkqgHWb9
        toGBkBxCl666oMYNmDHME3AnyXoby9hclcrtGxGRjjp3ZOkHhlf+63kvPySdV+d53LAlhvPjlmmcx
        ui5L8YxIVc8jSk+eVH+JzoLE8SvZUVcN5pwhKBf8lj2SPw492auHiUm3itE+30ziMa+J0h47chUrl
        dfRXszcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pezvr-004a19-1u;
        Wed, 22 Mar 2023 14:59:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE8CE30035F;
        Wed, 22 Mar 2023 15:59:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1D06201FFA49; Wed, 22 Mar 2023 15:59:18 +0100 (CET)
Date:   Wed, 22 Mar 2023 15:59:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/11] static_call: Make NULL static calls consistent
Message-ID: <20230322145918.GF2357380@hirez.programming.kicks-ass.net>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <7638861ae89606b1277ad4235654bba2b880f313.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7638861ae89606b1277ad4235654bba2b880f313.1679456900.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:00:15PM -0700, Josh Poimboeuf wrote:
> +void __static_call_nop(void)
> +{
> +}
> +EXPORT_SYMBOL_GPL(__static_call_nop);

Kees, is this a ROP target? The above is basically ENDBR;RET, push
something on the stack, jump there and you're in business or so.

