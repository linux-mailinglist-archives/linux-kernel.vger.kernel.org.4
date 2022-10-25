Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD860CD53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiJYNXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiJYNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:23:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53662175372
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zqj2D4OM3E2KTCX2KEwatxIgqnl9+T6VoS/62bkMnMw=; b=PvUQ9YBXlIuGc2cZib5FMfCkUQ
        V3ETvLRH021A9vwnmA/pWlktMtr/fiy6jvnldU18vYhzVJ89ksTkAUSC64Q2HpF4OMi5Y6m5tDauY
        YL1K7jPLhkXnlUMZupy8Z7nA/cu+9a/OIZ55icJYfhhz9FZFwWKFqqzz4wDgaFEDlGv+zrB066C9W
        D7yb5TeSZfEl9QdEa9MHYOxuAKSRHfjNJx+L8/OJptUPusuR4zMq3bcH7g0zbX2DoWIGMtsjyRXoS
        3es3a2N6fJuph00oclMxfOzyJ2ll4yhsOJGsY+fL71iOgM0p87/6L8Ok6XzEZ1rgVXQQZSxWGqeYG
        vnNp5k2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onJtY-00GI5O-7f; Tue, 25 Oct 2022 13:23:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF1383000DD;
        Tue, 25 Oct 2022 15:22:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9C572C22E2E2; Tue, 25 Oct 2022 15:22:58 +0200 (CEST)
Date:   Tue, 25 Oct 2022 15:22:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, Yu1.Wang@intel.com,
        conghui.chen@intel.com, fengwei.yin@intel.com
Subject: Re: [PATCH] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Message-ID: <Y1fjMnX9UOVo2+K5@hirez.programming.kicks-ass.net>
References: <20221025084147.4118463-1-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025084147.4118463-1-fei1.li@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:41:47PM +0800, Fei Li wrote:
> Avoiding recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
> This patch also removes `inline` for acrn_get_tsc_khz() since
> it doesn't make sense.

Can we have a few words on how this is supposed to work at all?

Supposedly the HV is providing host rate through this ACRN CPUID leaf?
How does it deal with systems where TSC isn't known stable?

