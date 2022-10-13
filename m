Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044455FDBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJMOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJMOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:02:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631E2F667;
        Thu, 13 Oct 2022 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TSbLsygvt/UKK7OWwe4sbMWUF0YqxhXqCgezFd8rTMg=; b=VmAPCvkLV/pXm4OznNKxE0S3ZD
        dtgrIDAn82q6JupwgzjuBCYYC5yrGTFQf/Cif1ZkjicREWOaUwi9yfxfU5cWU3Qi/l2vlHi/TygBl
        RY5wtfjUo8q6Wz3MhcafuZlkGUSEe2IMlqwnIYgReAHO7qjNsKVIUUS9rAR1UHoZdJrLCaR1KrC29
        cQeuwpQ+mW/WKvB+PSf4uePTluVOPWChizPi6ol4RbRiNjv+SQ2EGvXpEAQIAdxgsyI+wmNHzzLKH
        HMrg8oxUDIkz4mlBv2C6cObXSH+XEcU4UzRbRciWQf+bbH8uBOyrETKF5fGf0JrSUvVf5jiQf7/95
        +CtcEvLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiykM-006l3l-Mj; Thu, 13 Oct 2022 13:59:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 365C73001CB;
        Thu, 13 Oct 2022 15:59:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A42962024E158; Thu, 13 Oct 2022 15:59:32 +0200 (CEST)
Date:   Thu, 13 Oct 2022 15:59:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cody Yao-oc <CodyYao-oc@zhaoxin.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, shyaololo@163.com
Subject: Re: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
Message-ID: <Y0gZxOA4XBDn1tXj@hirez.programming.kicks-ass.net>
References: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 09:31:09AM +0800, Cody Yao-oc wrote:
> From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> 
> Nano processor may not fully support rdpmc instruction, it works well
> for reading general pmc counter, but will lead to GP(general protection)
> when accessing fixed pmc counter. Futhermore, family/model information
> is same between Nano processor and ZX-C processor, it leads to zhaoxin
> pmu driver is wrongly loaded for Nano processor, which resulting boot
> kernal fail.
> 
> To solve this problem, stepping information will be checked to distinguish
> between Nano processor and ZX-C processor.
> 
> [https://bugzilla.kernel.org/show_bug.cgi?id=212389]
> 
> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>

I suppose I'll queue it up for perf/urgent post -rc1
