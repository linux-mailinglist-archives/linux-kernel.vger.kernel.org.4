Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E43966DD79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjAQMXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbjAQMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:23:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7432B603
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KPcxEANcwfX3iqDYXrP0qaBKg/IIzvrkL1jXD2O4/YU=; b=T37/fdyH3s0FoXrIwst2EWKWW2
        gWZV1W+E91gwq1HK6a/49VgIdqo+idZ6XnC5EolsKpR9J6SEA4x5mV228YM4nl/LqVkHXAv87cJHg
        AJE7gQpSpVbHwcysQlQQvz5d2KUQpnTwfNRun33w361Zbw4/eNEQqe1AbkaGLU75oBwowWHcS0HL7
        nP1LPydHLx7ZFZlAjm46I9fu01OOn1589OFzsMSMprpw34deb7I+GBxJa0tA8ywqvRqcbv45sYaHp
        huG6eQ3fAi/BuUQkxeMmOF/vQ/aRRDhp9PWAihhrUxezDkp53guytzHb8K3MN5IuPYzM0htYLo7Ra
        DUtJsC+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHkzP-009fbF-JC; Tue, 17 Jan 2023 12:22:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 361363005C9;
        Tue, 17 Jan 2023 13:22:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15B9420B1647C; Tue, 17 Jan 2023 13:22:41 +0100 (CET)
Date:   Tue, 17 Jan 2023 13:22:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
Message-ID: <Y8aTEfpw0Vm6g0hC@hirez.programming.kicks-ass.net>
References: <20230112152132.4399-1-jgross@suse.com>
 <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 08:27:50PM -0800, Srivatsa S. Bhat wrote:

> I see that's not an issue right now since there is no other actual
> user for these callbacks. But are we sure that merging the callbacks
> just because the current user (Xen PV) has the same implementation for
> both is a good idea?

IIRC the pv_ops are part of the PARAVIRT_ME_HARDER (also spelled as
_XXL) suite of ops and they are only to be used by Xen PV, no new users
of these must happen.

The moment we can drop Xen PV (hopes and dreams etc..) all these things
go in the bin right along with it.


