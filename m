Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066D6D630C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjDDNfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjDDNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:35:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE7949C0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:35:16 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680615313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3jkqQU9u0FGRKfr6X7BhcjwPJIyo70dv86K9eyZnJs=;
        b=K7jq9X9zphFGzCX/Y2e1u85MfVHCgShqlZIvmy54Is7n/BxsBoE/ti3Ca0DdiLg7SKvgrP
        8ZCMvLRMXrVmU6dnWvOWd75VgXE+5H7EhhY2AlajItneCFYUrwaH7R7AtN58cj7/N+wNWV
        qn2BkUAGZq9CHKqU3DcYFgrSUWL8wIC7KpEbtgbexApWGWGyobuiGeyC4AV5XHq1aT2OTc
        KStG9firEVOcUFXW9INf0xH2l49Ta2PkUJXNgaV5aQ2B15vWHAoJIq8ZIME5hmeCDAdnXT
        TtlD2GQqm4OE6c+kqnPhIj5NW5nWgS1xJy73qAuRIJm+bl7bzBARQrKb1LyJzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680615313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3jkqQU9u0FGRKfr6X7BhcjwPJIyo70dv86K9eyZnJs=;
        b=hyCzel/xCsxrD66YB4Q/kUqPRBY97in+yN46PAQDSXtsEw8jrs5PhkPwJ1y4oT7KvqX54s
        uLgSnNQbVLgscEDQ==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 00/18] timer: Move from a push remote at enqueue to
 a pull at expiry model
In-Reply-To: <20230321124646.GM2234901@hirez.programming.kicks-ass.net>
Message-ID: <e0da9a2d-671-2dfe-4457-2e476920b7e8@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de> <20230321124646.GM2234901@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023, Peter Zijlstra wrote:

> On Wed, Mar 01, 2023 at 03:17:26PM +0100, Anna-Maria Behnsen wrote:
> > quater of the remaining CPUs was kept busy. This measurement was repeated
> 
> /me hands you a bucket of spare 'r' :-)
> 

Thanks for all the grammar fixes... this was the easy part :)
