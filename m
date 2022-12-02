Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2215B640034
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiLBGRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiLBGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:17:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F78E64DA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 22:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TH02mBytaDzh5iQfGbuoc4JvSikfs4XT5NtLopIJyJc=; b=JcEiuaCit0zgkjbJ/ZsniAIrEj
        GT3uUi98A6/eg9VVBUxvUBtjp9a6ZZcpKaVdZ7d3fgt9fqi7bxv7RsT0cPuDw+gJHtofXCbdo/puT
        s1lvdkYFr+8RCcMdFEqwL3gYQd4pgUfuuKE2k21IEQnpo2zciI9fQj243c/gltoKvBLtw5lyZ7TaG
        aWxJtvTB5M3bKmnNgIO+JcNY0RDlcbY5+ei6jZv5VA9DfPrivGEvF1zWJ3n4WJpzDVmHqxheRTfQF
        dsygGGRNlRg2B1/2CVETedSXNgu2UVzNTK7YOEev0QWmZZeS+XMSgrnh/C9+xHcD4By7cq4Y9FMtf
        H1JtFGhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0zMU-00DneU-VQ; Fri, 02 Dec 2022 06:17:26 +0000
Date:   Thu, 1 Dec 2022 22:17:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chris Mason <clm@meta.com>, Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] panic: Add new taint flag for fault injection
Message-ID: <Y4mYdhRPsgfUrNyt@infradead.org>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
 <166991263326.311919.16890937584677289681.stgit@devnote3>
 <202212010838.B0B109DA@keescook>
 <20221201114848.13a87aca@gandalf.local.home>
 <202212010852.6D4B542@keescook>
 <20221201141426.08411b29@gandalf.local.home>
 <78b7a67f-8c5b-6b2e-7fb5-01c47d75c104@meta.com>
 <CAHk-=wi_rTJOjbMxtyWe41QNMs2ojYTHhyNrAEebz-fyGh5Wiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_rTJOjbMxtyWe41QNMs2ojYTHhyNrAEebz-fyGh5Wiw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 01:18:09PM -0800, Linus Torvalds wrote:
> They aren't. They need fixing. Thankfully they haven't made it
> upstream, and I most definitely do not want random users mis-using
> "error injection" to inject random bpf code for non-error cases.

Which seem to be what HID-BPF is all about.  And if I see linux-next
reports correctly that actually got merged despite all the oustanding
objections.
