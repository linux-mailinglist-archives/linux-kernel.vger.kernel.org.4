Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F033762C11E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiKPOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiKPOkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:40:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812FF32061
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vuj1ZMaLxnEHkBHYUzCsAoGtXzFPsOqUukrW2+e/14g=; b=nHgGLnB5H7e41SDA6soqChrfFr
        dtkv7F3s4Q8w294h7ZljnpCui3NPQLXwAl9Dc7ajvbThXkHlQgbNfBhFx2UV/F2uXPB32cwKP7JtQ
        DT+xkqPmzogul/oXmjBCWaBBlzGxfc2YEYnfGUdiS3VWgvW/IwNvqbWu2uAprjnnKwv28JhF4KzPa
        okTnGZqmP5JBVErOo6D7S+BvpUsWT8vOw+mYju/8JUBKhZFB38eP8RIFQgdxIddXy6QAsSZGO9ud8
        bNOdZ7tI/EaxGUHK7TNNgjbHtbhM3kdQdzTDBDycqotG/VCooEQA918yoaXP1Km1CX0/w+tiUPTm0
        Gh6hLIMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovJaa-00HUla-3W; Wed, 16 Nov 2022 14:40:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CA9D300282;
        Wed, 16 Nov 2022 15:40:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18B692BCD72CA; Wed, 16 Nov 2022 15:40:24 +0100 (CET)
Date:   Wed, 16 Nov 2022 15:40:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     peter.zijlstra@intel.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y3T2WAzyJTZnDl8m@hirez.programming.kicks-ass.net>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:39:53AM +0800, Pengfei Xu wrote:
> Hi Peter and perf expert,
> 
> Greeting!
> 
> Platform: TGL-H
> 
> There is "__perf_event_overflow" WARNING issue in v6.1-rc5 kernel in
> guest in double check test.
> 
> Found first bad commit is ca6c21327c6af02b7eec31ce4b9a740a18c6c13f
> "perf: Fix missing SIGTRAPs"
> 
> And revert this commit on top of v6.1-rc5, this issue could not be reproduced.
> 
> Guest kconfig, reproduce code from syzkaller, and bisect info are in attached.
> 
> And more detailed info is in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/221114_134736___perf_event_overflow
> 
> If it's helpful and in time, please add the Reported-by tag from me.

Does this help?

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/urgent&id=bb88f9695460bec25aa30ba9072595025cf6c8af
