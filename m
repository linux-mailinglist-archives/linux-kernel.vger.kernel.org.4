Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DB4737CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjFUHjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjFUHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:38:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD44F19BE;
        Wed, 21 Jun 2023 00:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lTSU3An8gM6reX7gIYHv5XUzCbetDmgqSY0M6vDhJ+M=; b=uhiGbTsu70yxmQ3RrqI7soy7kc
        gixwosjeuBeVAWWonw8yp58ecXYP1x4VufUnGvKSlRPg5fThgCqYhjtItGx3i13zMyf/yoRiHiPxu
        m0eMFvyUuLKoeu3zvOcZP2nxDxEwrd2qkFM31exDIpqmut3qT1VIvZ/gABjXntICVcLfqQN02ZZiM
        Ynu0eohRqKQomQCb/FwcFaFWhK3CYinJVB0O26eZ6bZ7a2v5DtBND+MLZers/5cbtmHJr7pAO7zaM
        ymZnW/VwvKHTRSAPvtjXCT1dUjeYzL6VXZyUb9HVqEzwH3cWvCImmWV1n1eC/IO5jlgP2HDVNKU+H
        Q8YYf0IA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBsQG-00E6kq-1V; Wed, 21 Jun 2023 07:38:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72C2B3002A9;
        Wed, 21 Jun 2023 09:38:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56D222BC73BB9; Wed, 21 Jun 2023 09:38:35 +0200 (CEST)
Date:   Wed, 21 Jun 2023 09:38:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 3/5] intel_idle: Sync up the SPEC_CTRL MSR value to
 x86_spec_ctrl_current
Message-ID: <20230621073835.GD2046280@hirez.programming.kicks-ass.net>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620140625.1001886-4-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:06:23AM -0400, Waiman Long wrote:
> When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to 0
> in order disable IBRS. However, the new MSR value isn't reflected in
> x86_spec_ctrl_current. That will cause the new spec_ctrl_msrs debugfs
> file to show incorrect result. Fix that by updating x86_spec_ctrl_current
> percpu value to always match the content of the SPEC_CTRL MSR.

What debugfs file?
