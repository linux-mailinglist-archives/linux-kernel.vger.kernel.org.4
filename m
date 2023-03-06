Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B336E6ABE19
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCFLXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCFLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:23:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CF820692
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EbnwuiRgNY/kqdziXwSmOdmeqiqTjUlKsqwm+bsd9UQ=; b=fQ8QVSw82wR8gDnaD0q3Fsb51N
        fJQQlLr9/BuTuDG7Vmoaq1qvSQQqmwPIae+4VAur/zUIiJ4zpRxPjh5BqIImXvdDbO+xi2+THRzT4
        swV+Cj1aagOR/SgGZfuD7LWhBMunyOWTVjE7Koyb88EPFmAltTS7GQV4SNiTSeIguXDLvSNNExQIB
        9CcQs1R+crQKnHTXLGGFR5/4GX3dmuSo3jgX/JaHRezvdsG6MglxC4qkadhJuz7F/U03qHB07RTNY
        vI9HJUmoVPf/1fIZ4IJZKQOeOB9sYF1p7KdDzFgyUW5tG6KgOojjJMmvHcbZ30NuvEsRKa65edP8f
        1cSjE39w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZ8vR-005IJU-V3; Mon, 06 Mar 2023 11:22:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9076130013F;
        Mon,  6 Mar 2023 12:22:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C6A323B53549; Mon,  6 Mar 2023 12:22:40 +0100 (CET)
Date:   Mon, 6 Mar 2023 12:22:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 05/12] this_cpu_cmpxchg: x86: switch this_cpu_cmpxchg
 to locked, add _local function
Message-ID: <20230306112240.GB1267364@hirez.programming.kicks-ass.net>
References: <20230305133657.255737580@redhat.com>
 <20230305134053.537803923@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305134053.537803923@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 10:37:02AM -0300, Marcelo Tosatti wrote:
> Goal is to have vmstat_shepherd to transfer from
> per-CPU counters to global counters remotely. For this,
> an atomic this_cpu_cmpxchg is necessary.
> 
> Following the kernel convention for cmpxchg/cmpxchg_local,
> change x86's this_cpu_cmpxchg_ helpers to be atomic.
> and add this_cpu_cmpxchg_local_ helpers which are not atomic.

Urgh.. much hate for this. this_cpu_*() is local, per definition,
always.


