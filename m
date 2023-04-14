Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BCB6E2813
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDNQKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDNQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:10:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0272BB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pOItpe4K2B/uyL9ziK41aa/WOEdcNwwsDocQo6Y63jE=; b=MtDEII8Xl2535nBe2KGTmM59J6
        ltDrxcucvqIGwuQ9C8iNWMDbEsSTbiAgWxlIQC7cpMPj+dfMK+DRPQ9g8B759ra9ADPL8arqp7yHy
        ccPCc8dG6GkRRZcptlzbUS26YoYajsio1yX0lJ4Lux+VguCtCFrzZdaeQ0TG5kZC+SUcssJV1CNsX
        WCJE+AkQaHC45wSxFH57gweQLwaX2EOXKK0F8a7jfAiMEZEiwuKmVO5X0Fbh4G9Y51xhjQ8ntOTB0
        50oPAvvdDs3IK/aT8C0E4sB5SQ1AKas+FCqDZfL56pWuSzD+pTqUGWygPNg3SZ/bJ/lTQrJXuTzgl
        Pigdv42Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnLze-008slc-Rs; Fri, 14 Apr 2023 16:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1FFA3002A3;
        Fri, 14 Apr 2023 18:09:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 819BB2BA5BF83; Fri, 14 Apr 2023 18:09:45 +0200 (CEST)
Date:   Fri, 14 Apr 2023 18:09:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Message-ID: <20230414160945.GC761523@hirez.programming.kicks-ass.net>
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
 <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:56:41AM -0400, Liang, Kan wrote:
> > If it were to only support 4, then
> > we're in counter scheduling contraint hell again 
> 
> Unfortunately, yes.
> 
> > and we need to somehow
> > group all these things together with the LBR event.
> 
> Group will bring many limits for the usage. For example, I was told
> there could be someone wants to use it with multiplexing.

You can create two groups, each with an LBR event, no?
