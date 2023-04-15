Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89D46E2EDF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 05:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjDODtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 23:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDODtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:49:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D44C2D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tj9FMMSSs+zbNutNJhDAMnGvzM0c1XlAU1yQHGHsxu4=; b=cMWckj9bkdAY1/LRDkH51APSpK
        gypvKgs2sJ8+8A6WllOijcrzhsZXMw9GB8tZjo2GLc+GzNHudVgRXP1WaC3VC/LcZ8BfhU+a2TP3p
        AxkZFaXN2thVbXc0L16Y9Dbi6AAW1MKWnl+16fiVp6yJAzRlWv+XghjC3nOly9adcQ4Gk8cLYl+Bw
        TARE8+mKyPsVIAc1NDzzYe192eZCHY9bs9RJQt5IcGS95lIjetNqg3raRMv7H4QsJ7VlpMkp3sPGQ
        miG/zj1mR7LXLkEldYyD7A1iklef8WOPAFRotvlX16ssC7VIer+BBSU88skLX65U09Av0/Epb2uCR
        oWfaArrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnWv2-009KXJ-1p; Sat, 15 Apr 2023 03:49:44 +0000
Date:   Sat, 15 Apr 2023 04:49:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on
 SLAB_TYPESAFE_BY_RCU example code
Message-ID: <ZDoe2K7mMu31/6Lb@casper.infradead.org>
References: <20230415033159.4249-1-sj@kernel.org>
 <20230415033159.4249-3-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415033159.4249-3-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 03:31:59AM +0000, SeongJae Park wrote:
> The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU
> read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
> similar example code snippet, and commit da82af04352b ("doc: Update and
> wordsmith rculist_nulls.rst") has broken it.  Apply the change to
> SLAB_TYPESAFE_BY_RCU example code snippet, too.

so the page cache (eg find_get_entry()) does not follow this "split
the RCU critical section" pattern.  Should it?  What's the benefit?
