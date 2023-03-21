Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2736C33BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCUOKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCUOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:09:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5846159;
        Tue, 21 Mar 2023 07:09:53 -0700 (PDT)
Message-ID: <2eeef5a3-cbe7-7a01-489a-87c5ac00adf7@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679407791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5H8ASVSpeYXRfPAZlDn5w3NGbDKpfLoIK9F2WWvxoA=;
        b=EGvo+aT61qfofgcSXv3K8G1MMOu3tStw9OEXH1vZb9SoRHZ2B7mO8S7Ao9XQMjibgFggcn
        18eURZVuSD/DA9p6M3KChX3Zrz9mF2GXbX4hV744zO+HObNbQfhGatkZwpwfXX4dyNWCgV
        hejHnLgymlGYeugr9NJTw1nssYjITT4bfXCDZRxGFBmW6E0yaOfUIkRT3b3HeppCbSuQQj
        BcNWv4Yv4a6BYx/QdzvLqypvJkq3Sk7lxpMUPhZEuAImEywmT5A2wDixCRnOJLhGQkne9O
        t+Z/wOBYt/st0WrZyqnK37ngNAJm+HOeTvnglw1IFenWaAbkhUOHLiLT9Rck+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679407791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5H8ASVSpeYXRfPAZlDn5w3NGbDKpfLoIK9F2WWvxoA=;
        b=/MOUIY6Jl9ficd77bzu9nZrapxO1JboBPr+MC/oT4b3oCnf2sw+mCQLVAVMZCTRnryoMMp
        X502lf5YhjeA2VDA==
Date:   Tue, 21 Mar 2023 15:09:40 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     Donglin Peng <pengdonglin@sangfor.com.cn>, mhiramat@kernel.org,
        rostedt@goodmis.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230320131650.482594-1-pengdonglin@sangfor.com.cn>
 <20230320131650.482594-2-pengdonglin@sangfor.com.cn>
From:   Florian Kauer <florian.kauer@linutronix.de>
Subject: Re: [PATCH v5 1/2] function_graph: Support recording and printing the
 return value of function
In-Reply-To: <20230320131650.482594-2-pengdonglin@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.23 14:16, Donglin Peng wrote:
> When using the function_graph tracer to analyze system call failures,
> it can be time-consuming to analyze the trace logs and locate the kernel
> function that first returns an error. This change aims to simplify the
> process by recording the function return value to the 'retval' member of
> 'ftrace_graph_ent' and printing it when outputing the trace log.

I just came across your patch by pure luck and it helped me a lot
to trace down a problem I had, thanks!

So you can have my
Tested-by: Florian Kauer <florian.kauer@linutronix.de>
 
> New trace options are introduced: funcgraph-retval and graph_retval_hex.

I would personally prefer to have the second option scoped better, so for example
"funcgraph-retval-hex".

Greetings,
Florian
