Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B17C6354B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiKWJJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiKWJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:09:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF6630C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=26XbUthJg/tMs7H747g2gbGgSfiMyZZOL8m1eg+hpWc=; b=BzjTR8A8V852bhy6ymyvQTou12
        wx+VKWTOVMkDgqno1C+vM53mTcl+xBL+UrllMfgT/zWkCpYHfh+SnWEFbxpVydfWNVAnW9zCd4CBB
        P8TM3NT/EpDGpVP3b52fNHeUhaHaxRRQK8MxsjWrsaPzaZaACj0hl6l/GVU5cbncs2PhPmfgz7tmI
        wHBa5EDsmsE/skp6kWmVCujxaurF1AMBTO7859qdKP1Srh3I9i1zNhBZ/WryiI+J2Ksd5vnYSoSSK
        nm2C6NNlXZA9l6Fm12LPo4Gu1TiMdZrndbEF3CdpPtskEus/BwhjG8X3iju94Mb8wuqPFYJcF+Xvc
        xHtEFUNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxlkj-007Mq0-O8; Wed, 23 Nov 2022 09:09:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4E6630036C;
        Wed, 23 Nov 2022 10:08:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF7502D815CDE; Wed, 23 Nov 2022 10:08:59 +0100 (CET)
Date:   Wed, 23 Nov 2022 10:08:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] jump_label: use atomic_try_cmpxchg in
 static_key_slow_inc_cpuslocked
Message-ID: <Y33jK7p2Xc6KD1ax@hirez.programming.kicks-ass.net>
References: <20221019140850.3395-1-ubizjak@gmail.com>
 <20221122161446.28907755@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122161446.28907755@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:14:46PM -0500, Steven Rostedt wrote:

> > +	for (int v = atomic_read(&key->enabled); v > 0; )
> 
> Although it's permitted by the compiler, the kernel style is to not add
> declarations in conditionals.

I'm thinking the whole motivation for upping to C99 was exactly so that
we could start using this pattern.

