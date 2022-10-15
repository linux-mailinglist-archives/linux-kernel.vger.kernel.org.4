Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B865FFB13
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJOPpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJOPpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:45:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C1832EF8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TCYigD6+fv9brUkPEpPZrIgBgjf/B+BAp40/5vtMfH4=; b=QuZ2DaRmc5QmhQxhZryxYvCbfJ
        bg0ibfC57oc95v6G7aXovygFf59cpCZrLlpKpFgQ6PDM0E81pt2HBYF8n3mYScvpMyGs1CMLDOlHe
        gpESsw2YlpxTlisntdc+Tv1ydOPfaKtdXKA4mSa8qZAiBQd5iJwUKY4uLdSB554BLxIQrKrruuQ/1
        CfAD8/BqVVJ83jgoKrMUr3zHqQpJFLDDAtHqXcNmLk2f1EomfnRHqDnEqT2Qs5EB6DJZDa1zue9L7
        ZBab1UzvVi0udMVCbgq/onEPPxtzogmq9pmA57drtSzM/8efb3dOjlJbs/9hkmbEXPST2dnHZ5vr1
        4dQNn3vA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojjLF-003iXd-48; Sat, 15 Oct 2022 15:44:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5F77300451;
        Sat, 15 Oct 2022 17:44:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B7B9201FD2EC; Sat, 15 Oct 2022 17:44:47 +0200 (CEST)
Date:   Sat, 15 Oct 2022 17:44:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Message-ID: <Y0rVb1+PEai6vUWy@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:44:50PM +0000, Connor O'Brien wrote:
> Proxy execution has been discussed over the past few years at several
> conferences[3][4][5], but (as far as I'm aware) patches implementing the
> concept have not been discussed on the list since Juri Lelli's RFC in
> 2018.[6] This series is an updated version of that patchset, seeking to
> incorporate subsequent work by Juri[7], Valentin Schneider[8] and Peter
> Zijlstra along with some new fixes.

I actually did a forward port at some point after core-scheduling and
had a sort-of working version -- although I do remember it being an even
bigger pain in the arse than normal.

I think I handed those patches to Joel at some point...
