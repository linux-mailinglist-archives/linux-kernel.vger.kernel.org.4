Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409B86BFB98
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCRQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289481B31B;
        Sat, 18 Mar 2023 09:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A48D760EBD;
        Sat, 18 Mar 2023 16:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEBFC433EF;
        Sat, 18 Mar 2023 16:40:30 +0000 (UTC)
Date:   Sat, 18 Mar 2023 12:40:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        mhiramat@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing
 the return value of function
Message-ID: <20230318124028.4faf75d1@rorschach.local.home>
In-Reply-To: <34781b74-8d3e-a7e6-9abe-e8d45d680eec@sangfor.com.cn>
References: <20230315133911.958741-1-pengdonglin@sangfor.com.cn>
        <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
        <ZBOkY8FkqgoBfzQ2@shell.armlinux.org.uk>
        <34781b74-8d3e-a7e6-9abe-e8d45d680eec@sangfor.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 10:49:49 +0800
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> > So, really it depends what size of return value we want to report.
> > Also, please bear in mind that where a function returns a 32-bit
> > value, that will be in r0, and r1 will be whatever happened to be
> > in it at function exit - there's no defined value for r1.
> >   
> 
> Thank you. I will document this as a limitation of fgraph return value.
> It can just cover most cases at present and I think the r0 is enough.

One thing we could possibly do here is to use BTF or objtool to denote
the return value of each function and use 2 bits of the ftrace
rec->flags to state that it is:

0 - void
1 - 1 word size return
2 - 2 word size return

I believe we can get access to the function's rec via the return call
(or add that access) and pass both words to the return function, and
then the return callback can use this lookup to determine what values
are useful or not.

In any case, I would suggest passing both regs to the callback, and for
now just ignore the second reg until we can come up with a way to
differentiate each function.

-- Steve
