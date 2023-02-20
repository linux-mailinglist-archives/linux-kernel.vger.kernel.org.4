Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C098869C9F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjBTLhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjBTLhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:37:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCAD1BF8;
        Mon, 20 Feb 2023 03:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3IfNPTAaPPBd75bAfyJDqCNuYWHBYxJ5ORy+gQ+26fY=; b=CW7ZdEbA+tIwqcxY/TQR5O6sig
        rjpaOoOEusUGWglCaLQzvzcZbw+vKe89jAwSB6MzYRcA+4hTwAByTSS6CPC8iGVTrY8AU4hdtK+bR
        5w2ioUDXinY3NStDBYTj1k9VZeJpblFV3ktovjby+P3F+XXauPYxAdPUjHUG+2oxpsTkQ139Wak2S
        sgmEc7of2YT9KGIBAaaCaMkd2ZmM0vBU5c02BbB/KR/E1dPchfv0zEqd4BMhTY+MQi9UU3Ob/pCRt
        wRI2ADxVrFYhXsawmN36WPFDgjsW79iNNjR6jmmguCS6nKN1gTExkUIP4QNbQ2RwL3zwSRy3qxqO8
        6hmuiBsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU4Tr-00Bgbk-Jf; Mon, 20 Feb 2023 11:37:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F37A63002BF;
        Mon, 20 Feb 2023 12:37:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D68362135FABD; Mon, 20 Feb 2023 12:37:13 +0100 (CET)
Date:   Mon, 20 Feb 2023 12:37:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] perf/x86/amd/core: Use sysfs_emit() in show() callback
 function
Message-ID: <Y/NbadiYAF5exJN0@hirez.programming.kicks-ass.net>
References: <Y++ukV1djYTd01vy@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y++ukV1djYTd01vy@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 10:12:57PM +0530, Deepak R Varma wrote:
> Using sprintf/snprintf functions are error prone and suggested to be
> replaced by scnprintf/vscnrptintf as outlined in this [1] LWN article.
> 
> A more recent recommendation is to use sysfs_emit() or sysfs_emit_at()
> as per Documentation/filesystems/sysfs.rst in show() callback function
> when formatting values to be returned to user-space. These helper
> functions are PAGE_SIZE aware and wrap a safer call to vscnprintf().
> 
> [1] https://lwn.net/Articles/69419/
> 
> Issue identified using the coccinelle device_attr_show.cocci script.

This Changelog fails to inform me of what the actual problem is and why
the proposed solution is better.

As such I cannot form an opinion on the patch and must decline.

(Also, I'm not going to chase down random links on the interweb,
Changelogs should be self contained)
