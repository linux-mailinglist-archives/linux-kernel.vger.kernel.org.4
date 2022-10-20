Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CEF60669F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJTRBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTRBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:01:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AAB19D88B;
        Thu, 20 Oct 2022 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cNSLBsKzCRIUurXKxibUZ4iV/rXzCfaN7SiOZ3WxXrA=; b=lXG8/LbTcMdxz0IfQ5G/WVEhM3
        46zvWJfc8xilRyVv/setRDzxTcqcUQAsuvsM5CDltALZO6N2VhsH77WW8NlaeJ8+T6/890VoyPLab
        b+l71bY3d12e6QEg3Lz4n+zZgs/M3CWXQ/2sIGiV3/Z2/xqA9OSPnO7b1ZL3z5SJo1WdbEDlAYj0G
        TjObZL8BspoaBlOreEbs//sfeL+S9Iu2RVDdvVDs2g0h+KWkFBSCMrx3WOSB7uWuYTOkIeMyeYBXy
        OvIfHTQMYLslp7dutHMPLCUAC5y5gWNWfMhNX9W10NrRFte1AmNkhckue/Ji571na0oOCmpz3HZkR
        kyLv3tWg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYuj-00CX40-JI; Thu, 20 Oct 2022 17:01:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 759C7300472;
        Thu, 20 Oct 2022 19:00:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56C3F2C1596B5; Thu, 20 Oct 2022 19:00:56 +0200 (CEST)
Date:   Thu, 20 Oct 2022 19:00:56 +0200
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
Message-ID: <Y1F+yAWy4VVaDb+5@hirez.programming.kicks-ass.net>
References: <20221020101921.1219533-1-james.clark@arm.com>
 <20221020101921.1219533-2-james.clark@arm.com>
 <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:49:17PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 20, 2022 at 11:19:20AM +0100, James Clark wrote:
> > From: Andrew Kilroy <andrew.kilroy@arm.com>
> > 
> > Perf report cannot produce callgraphs using dwarf on arm64 where pointer
> > authentication is enabled.  This is because libunwind and libdw cannot
> > unmangle instruction pointers that have a pointer authentication code
> > (PAC) embedded in them.
> > 
> > libunwind and libdw need to be given an instruction mask which they can
> > use to arrive at the correct return address that does not contain the
> > PAC.
> > 
> > The bits in the return address that contain the PAC can differ by
> > process, so this patch adds a new sample field PERF_SAMPLE_ARCH_1
> > to allow the kernel to send the masks up to userspace perf.
> > 
> > This field can be used in a architecture specific fashion, but on
> > arm64, it contains the ptrauth mask information. The event will
> > currently fail to open on architectures other than arm64 if
> > PERF_SAMPLE_ARCH_1 is set. It will also fail to open on arm64 if
> > CONFIG_ARM64_PTR_AUTH isn't set, as the data would always be zeros.
> 
> A little more information please; wth is pointer authentication? Are we

Mark got me: https://events.static.linuxfound.org/sites/events/files/slides/slides_23.pdf

> going to be having the same thing with x86 LAM where only a subset of
> the available bits have meaning to the hardware?
> 
> Why do we want the same mask repeated over and over with each sample;
> should this not be part of the address space (side-band) data?
