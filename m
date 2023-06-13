Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D9072DC88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbjFMIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241355AbjFMIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:32:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6AC199A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZLpF5uaE5vEXK70soXXBTsKAuRo8FWQfkbFKAKFSYT8=; b=bgk+OBXW7KObNsaL+te0/3zM6l
        FeBmWiBjT5yIidb7PY2IJMoTVg/8HDi6igjPC5y7lEiHZlt8WIC8/lhGKKsM4aH8y13P82jUo+Lnb
        rNTgukeW1c9qX8huTtw1LocfDYnjT9UDZVobYB8hAMaXUD6JybndnYltwlXi0GcLNrT8ZjHpo6SNP
        O1k0GIFFjcJrdknPMzp61Z02SXReIQ5op7fMOt5D8AxihE2d5tUDmcd4KMyuzjKtAmwBXyETSZ4RK
        1Np3DXbTKOhabpgbVJn85cvCkQLgzBdrXkCHUZawP6sThOizbopJemlQO0a180RZFPPML6rMyecbz
        ySco/46A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8zRd-003hZW-32; Tue, 13 Jun 2023 08:32:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1D3C3002F0;
        Tue, 13 Jun 2023 10:32:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DBF6262C92A6; Tue, 13 Jun 2023 10:32:03 +0200 (CEST)
Date:   Tue, 13 Jun 2023 10:32:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230613083203.GR4253@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613052004.2836135-4-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Still gotta read it properly, however:

On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> Single-socket | 32-core | 2-CCX | AMD 7950X Zen4
> Single-socket | 72-core | 6-CCX | AMD Milan Zen3
> Single-socket | 176-core | 11-CCX | 2-CCX per CCD | AMD Bergamo Zen4c

Could you please also benchmark on something Intel that has these stupid
large LLCs ?

Because the last time I tried something like this, it came apart real
quick. And AMD has these relatively small 8-core LLCs.

