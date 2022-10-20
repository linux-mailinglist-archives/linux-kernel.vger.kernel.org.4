Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36303606638
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJTQte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJTQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:49:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E9192A0;
        Thu, 20 Oct 2022 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T7NFAlWXiDOdD8hrOWZsURbJ6xGlGiUzpSW9Xx/xw94=; b=Fcat6CrG1qZV6RP7UT13XG9Xrp
        B2bM6JFD7vNC6a2n4Dmb3gWK2F/sjSXck7j0Eqx8bF6fS7whnAJZAPGPWqTnoDuwTstKwZ6iCsSEg
        HBsxZwsUrGU5gvZVeOMlGdln8wQ5wIQIc1RPMRXH/guF4I4V4KbeTiSAGWvybLlKzyCgQaszgecmC
        FmtPI4oAyt+lPC+gtE1m1qgPXY2qcJZxCZu8qEfuL9ub0AGRRpmmMh4ZAqtRI+T/qou7wSffvBmas
        XXvA7DKytGsbOcQo0Lr3s9WnWqnbn7N3c2c72d5sdhpOy8J4AXpkIwIdSGEAysAAYoMCvProEBEXd
        TPzSxlyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYjT-00CWdr-7p; Thu, 20 Oct 2022 16:49:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E82D530045D;
        Thu, 20 Oct 2022 18:49:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD51E2C15969B; Thu, 20 Oct 2022 18:49:17 +0200 (CEST)
Date:   Thu, 20 Oct 2022 18:49:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
Message-ID: <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
References: <20221020101921.1219533-1-james.clark@arm.com>
 <20221020101921.1219533-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020101921.1219533-2-james.clark@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:19:20AM +0100, James Clark wrote:
> From: Andrew Kilroy <andrew.kilroy@arm.com>
> 
> Perf report cannot produce callgraphs using dwarf on arm64 where pointer
> authentication is enabled.  This is because libunwind and libdw cannot
> unmangle instruction pointers that have a pointer authentication code
> (PAC) embedded in them.
> 
> libunwind and libdw need to be given an instruction mask which they can
> use to arrive at the correct return address that does not contain the
> PAC.
> 
> The bits in the return address that contain the PAC can differ by
> process, so this patch adds a new sample field PERF_SAMPLE_ARCH_1
> to allow the kernel to send the masks up to userspace perf.
> 
> This field can be used in a architecture specific fashion, but on
> arm64, it contains the ptrauth mask information. The event will
> currently fail to open on architectures other than arm64 if
> PERF_SAMPLE_ARCH_1 is set. It will also fail to open on arm64 if
> CONFIG_ARM64_PTR_AUTH isn't set, as the data would always be zeros.

A little more information please; wth is pointer authentication? Are we
going to be having the same thing with x86 LAM where only a subset of
the available bits have meaning to the hardware?

Why do we want the same mask repeated over and over with each sample;
should this not be part of the address space (side-band) data?
