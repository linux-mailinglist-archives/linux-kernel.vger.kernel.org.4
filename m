Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2D6EE466
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjDYPE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjDYPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:04:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37F9EEF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eZ6qtyBTxkPS/Vd6G2zvBKtjNEGs0l5IwnRWNQv4ceI=; b=qfDe1Xx2pTGaH8oKy3ozg07+Dg
        UqwX3yrdRvoVtgghHWQ5NF0v5tXDpo7cZFmfvmChI+uXFkzvfn2yhXiLcqVus7ZrR2g7ONHdITy8j
        PL36iyC5lCzwxcStYwaKpNYGTZqtNhEk5ukUIHLnLMz+w9eGz8kXTObCVvDogCXMUdsIZmYmROCXi
        icz/g2vUGwtzbzDS8y7zVfOWfGGvQ8UihIJF6IOuD5IyDHg0Byz51rJmVqCDzQcDV/7gKr/Fg+Rx8
        5MatZEPFj0xaVzPPfrRPXyiB9IjMrFJNFjQzZurgtX+5LhmFEFCkaJKf47dXfh7zMh+ffHZar3426
        O+C7WdmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prKCt-001Xn3-IN; Tue, 25 Apr 2023 15:03:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 215C73000D5;
        Tue, 25 Apr 2023 17:03:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12C6531C76403; Tue, 25 Apr 2023 17:03:50 +0200 (CEST)
Date:   Tue, 25 Apr 2023 17:03:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>, Zqiang <qiang1.zhang@intel.com>,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2] kasan: Fix lockdep report invalid wait context
Message-ID: <20230425150349.GG1335080@hirez.programming.kicks-ass.net>
References: <20230327120019.1027640-1-qiang1.zhang@intel.com>
 <CANpmjNOjPZm0hdxZmtp4HgqGpkevUvpj-9XGUe24rRTBRroiqg@mail.gmail.com>
 <be865fb8-b3f8-4c80-d076-3bbd15f3c0e8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be865fb8-b3f8-4c80-d076-3bbd15f3c0e8@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:50:23AM +0200, Vlastimil Babka wrote:
> Yes, the problem seems to be that if there's different paths tor RT and !RT
> kernels, PROVE_RAW_LOCK_NESTING doesn't know that and will trigger on the
> !RT path in the !RT kernel. There's was an annotation proposed for these
> cases in the thread linked below, but AFAIK it's not yet finished.
> 
> https://lore.kernel.org/all/20230412124735.GE628377@hirez.programming.kicks-ass.net/

Oh, thanks for the reminder, I'd completely forgotten about it. I just
replied with a new version... fingers crossed ;-)
