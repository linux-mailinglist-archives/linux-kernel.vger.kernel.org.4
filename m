Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00D74B4DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGGQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGGQFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:05:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FA91BF4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bJ/4kMFcEoq8yUORvnawnYnp0O3fDyhi4EaF0dDHN1M=; b=X4uzKM1S/N/fpykIccHmpd97lZ
        SFhlm1MT3eEzFbhMXIl5XfK5jpy8pmt39+4nZhlbeAkD3AfcgJ45kHHc+JK27xxwE/lWPb04w4hs6
        uYPDNg9dXb13SrAvexid7FAsGZfXfPZ/p3zYYKmH91XD6qd+yHrkyzhQJ2T/8QLRVkRlu21pvcjzy
        O0G/vIV/r+oJKcz4RGR3/M6SalMSl5y9daeswFCyKGTWfsKM4cJfjSireZu+nvIriQXvOjDc5v6qZ
        0BYSwcU5eMgWb8uIFyH7xigHwNII4oSPimCZD3mKNmEL1gMswLuN4jesS9ERCE6J8jAoz9ZiAaN2P
        EGDGXJoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHnxF-00C9fa-FD; Fri, 07 Jul 2023 16:05:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7481300274;
        Fri,  7 Jul 2023 18:05:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 949172BEFEB3E; Fri,  7 Jul 2023 18:05:08 +0200 (CEST)
Date:   Fri, 7 Jul 2023 18:05:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Henry Wu <triangletrap12@gmail.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Fwd: Possible race in rt_mutex_adjust_prio_chain
Message-ID: <20230707160508.GE2883469@hirez.programming.kicks-ass.net>
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
 <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
 <CAG-UpRTQ-ovVO02HRd5z-9oZGCPvZ0vODJse8oyuA9L-3NV_pQ@mail.gmail.com>
 <CAG-UpRRLFTHg64b0hG4=FbuzhhqNQEU8jGt6TygCVAK1BaT2kQ@mail.gmail.com>
 <20230707125942.GB2883469@hirez.programming.kicks-ass.net>
 <f4e839ac5ecb285b8a9d666f1a73e0a39b698864.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e839ac5ecb285b8a9d666f1a73e0a39b698864.camel@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 05:39:38PM +0200, Mike Galbraith wrote:
> On Fri, 2023-07-07 at 14:59 +0200, Peter Zijlstra wrote:
> >
> > The below implements this duplication and seems to not insta-crash.
> 
> RT bits of ww_mutex.h needed tree_entry -> tree.entry.  Modulo that, RT
> seems content.

Ah indeed, just in time. Added, I'll post a real patch soon.
