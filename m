Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C25665D64
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjAKONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbjAKOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:12:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6F19285;
        Wed, 11 Jan 2023 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kh81VbIZ8aAFzaPbdCIb8iu76NXqMZK7Zl9jSAAgmmY=; b=umNiLZslPng9U4Yh/wYN4u+NL/
        KrbNWXqFAYwPFMKMKlrhpcKUivQwycoi2QKvUn/9M6dvKzVbboik7gXkf8rcTtG/Hdd1kwZ3SD0Mb
        m8hMUwxA7IeKof01lpGO7pO3fy4rdDunWueIozaoUndTuQNdR0JQ5gSVHvbxI6LIyWXIlRwOYLzv4
        EB+O9gEmju4MyNNjm/y7NN7szc3vF8dPfQFjEsZei7ThMFlJSEfKLMRbjDrmdsTo3KaaUWVxPLMyd
        aBw5lAkGYy6S8g9SbiM8iIdkfvJ/DIZI7qGWwjcW+oy/OAqclsibkPaNGRSALijmBjii6bO2vHWGg
        1N3KzOYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFbqU-004Bwu-DA; Wed, 11 Jan 2023 14:12:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9355300327;
        Wed, 11 Jan 2023 15:12:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D09F2CA101E8; Wed, 11 Jan 2023 15:12:35 +0100 (CET)
Date:   Wed, 11 Jan 2023 15:12:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH tip] selftests/rseq: Revert "selftests/rseq: Add
 mm_numa_cid to test script"
Message-ID: <Y77D0+e2tdl8c1k1@hirez.programming.kicks-ass.net>
References: <20230104163542.10004-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104163542.10004-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 11:35:42AM -0500, Mathieu Desnoyers wrote:
> The mm_numa_cid related rseq patches from the series were not picked up
> into the tip tree, so enabling the mm_numa_cid test needs to be
> reverted.
> 
> This reverts commit b344b8f2d88dbf095caf97ac57fd3645843fa70f.

Oh my bad, I got confused between the regular numa_id (which I did do
merge, right?) and the fancy numa_cid, which I indeed didn't merge yet.
I meant to give that a wee bit more thought, but that sadly hasn't
happened yet :/

Applied, thanks!
