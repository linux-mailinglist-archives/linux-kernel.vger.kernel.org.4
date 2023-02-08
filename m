Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578EA68EA41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjBHI7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBHI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:59:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8A458BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YIr+WvRrqpP3+1Gb7DlI4a9hYJolEl0aoP3FwoajPnU=; b=M+Cuko+DDafXE2+OKwVRfMRF6r
        Z4NhTgVyflNRDEoIgjfLP9brqfFmHrn8tHe81rHPB+Qrlrv15QjfNHhDfF3Noa8/rOLEgsngBrSr5
        HyONr73/l+ZuMlAgbt4rW24UjhP1CthpmKjSRxPfPoo+GKs0cd2twFk55agaBDV4ZtvwH4bdmUCSA
        r5Dhb3W4D849rwWWpW0H9WaRItnXl73tz1hTGyjmMj1D1O6Iaq/Z9jogoVapriQx3louIOGGqONfv
        7woLEWcsYryQRCymtHhyMJMiq26R0YfPBJT6WD4EpFYvWT1FJP1wGguVRgMQJrfNezXxzJh7nvwIM
        uHDtoWrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPgHR-007J8u-14;
        Wed, 08 Feb 2023 08:58:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD97C3001CB;
        Wed,  8 Feb 2023 09:58:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95C0B20F1933F; Wed,  8 Feb 2023 09:58:53 +0100 (CET)
Date:   Wed, 8 Feb 2023 09:58:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternative: Support relocations in alternatives
Message-ID: <Y+NkTXTqlqKvEIA2@hirez.programming.kicks-ass.net>
References: <Y+EXQlGSI9WUU8nn@hirez.programming.kicks-ass.net>
 <20230207113813.rqwpuaung2hr433q@box.shutemov.name>
 <Y+J2x5sPU0uL8bE0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+J2x5sPU0uL8bE0@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 05:05:27PM +0100, Peter Zijlstra wrote:

> Also, Masami, how difficuly would it be to do insn_is_nop() that matches
> most/all conventional NOP instructions?

Just looked at that, while NOP and NOPL are relatively easy to do, the
32bit NOPs are a pain to decode since they're actual instructions with
the side-effect of not actually doing anything, like 'mov %reg,%reg' and
'lea (%reg),%reg'. Esp. that latter is popular since it has all the
various displacement encodings to grow it into a very long instruction.

I'll put it on the todo list I suppose, not something for now.
