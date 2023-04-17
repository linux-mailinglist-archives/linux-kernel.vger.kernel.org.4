Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3C6E46C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDQLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjDQLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:48:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161961AB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2sbQzu7RniseVk+khnE2kGEB/bPWNfsL2nxC/lM0Zu0=; b=NXC0G2nchijGyOCEIYYKVhI4/k
        gECLFsUAU3H7pol0l1kU46JbLboQPhaXylBAd7rInZD95hRQix4LDeSRfaprvhhdQfmHtmLEben3z
        aC+KN1pwgbBbl4RYF8B94jdJ1SiOnOY7ATr6z48fjTZk1HRAx1hnKifSIAirgXsRuRISJ/zrdANoi
        atCNiiUdfWpqDVBgtGT0a14OG5MRSeYgF+UGout5J5yFAqQeBbSeiXnN3gU168PIeWGEyWM29eMYs
        /IA0nIt2mALw6mu2NccAXLF3seKWEzEUlQup7jUcC9WdKDmQ7w3EUyMFChuNMlaRvKBHSWq8CAFr9
        5agmYj7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1poNJv-00HJ1f-2o;
        Mon, 17 Apr 2023 11:46:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 682BF300338;
        Mon, 17 Apr 2023 13:46:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EC8024248739; Mon, 17 Apr 2023 13:46:54 +0200 (CEST)
Date:   Mon, 17 Apr 2023 13:46:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Message-ID: <20230417114654.GL83892@hirez.programming.kicks-ass.net>
References: <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
 <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
 <20230414192407.GA778423@hirez.programming.kicks-ass.net>
 <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
 <20230414220106.GC778423@hirez.programming.kicks-ass.net>
 <d53d4df7-d0b8-2fbc-4912-f89686b5d931@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53d4df7-d0b8-2fbc-4912-f89686b5d931@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:47:29PM -0700, Andi Kleen wrote:
> 
> > Yeah, don't do this. There is no guarantee what so ever you'll get any
> > of those events in the 0-3 range.
> 
> 
> The kernel can simply force to 0-3 if LBR is enabled and the feature too.
> It's in Kan's patch
> 
> and it isn't particularly complicated.

And what, totally leave 4-7 unused even if those counters were not
related to LBR at all? That seems exceedingly daft.
