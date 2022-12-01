Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9663F99B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiLAVMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiLAVMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:12:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7EDE98
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:12:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77301B82027
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BA3C433D7;
        Thu,  1 Dec 2022 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669929157;
        bh=ESBUZqzGtDNUEoKoNhyM+rRWNZFT5fSTe1bIeGft5mY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T7mbNDNbr172q4ma/Sih0o5jrItD9Yn3CVYnvaTzID/eAQctFnUyb6dnP2mNOtrmW
         jqJO7U+qc0FJDRB5tNtbZM2R555R8HX2FQqsuxfxD/CZkwKfpNfIpJb6AKW9DgHKNy
         hu2wbhOXp4DA1ZNJpc2FZUkjWfzpzp+wfmY0EqBo=
Date:   Thu, 1 Dec 2022 13:12:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Chris Mason <clm@meta.com>, Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
Message-Id: <20221201131235.06ba19ee600b2424e97d9c55@linux-foundation.org>
In-Reply-To: <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
References: <20221121104403.1545f9b5@gandalf.local.home>
        <Y3vSQo85ofkfD/L8@zn.tnic>
        <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
        <Y3ymzAYRyH5IWEe/@zn.tnic>
        <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
        <20221122132905.12a8d5ad@gandalf.local.home>
        <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
        <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
        <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 08:58:55 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> but the better option for now would be to drop this patch.
> For the next next merge window we can come up with alternative way
> (instead of ALLOW_ERROR_INJECTION) to mark kernel functions
> purely on the bpf side.
> I don't think we have time to add this marking infrastructure
> for the upcoming merge window.

OK, thanks, dropped.  Let's revisit this next cycle.
