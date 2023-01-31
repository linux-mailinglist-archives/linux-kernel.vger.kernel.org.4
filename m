Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB296836EB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjAaT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:58:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325BB10ABD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Boqe77xXw/WW6/Jx9IzSgzEvG7AsRtZEZ4We5AQ2oY=; b=gI25N3EUJYmiNAQBK3q8AnSBDE
        7L4MN1uk34doF7bYxOUAQ2SE0jH3ShvXili1sCp+XAi6jaAdi4XMKAI8zhHXGDXR7XM5fYB+coGn3
        8kOOfcw+BLqZR/y7Hb/fcV6sA1R1krlWimbsw2RBkI5E63mQm1n8v3TmK6OqYnzoYCrkl7D7NcnVW
        v0zKa+gzmq/wgTspAbsKVd1DsWzhulvgqVluwo/RmM7g6lLFfrEG0uPQo8LBPpOIQh8Rfi4mYlhZ/
        5Wv9oKXuqXAs6ULw4qPQXzZ9r8EKMeEJhjsha1wI5i+F5r6Kj2JvIt9n0NRGysJI9F1NGt4JX1snz
        oQg82jeA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMwlU-00BcdF-S0; Tue, 31 Jan 2023 19:58:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C175300577;
        Tue, 31 Jan 2023 20:57:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 370BD20D6DE1C; Tue, 31 Jan 2023 20:57:59 +0100 (CET)
Date:   Tue, 31 Jan 2023 20:57:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, liwei391@huawei.com, adobriyan@gmail.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
Message-ID: <Y9lyx38kHmKEF5CQ@hirez.programming.kicks-ass.net>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <87357q228f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87357q228f.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:44:00PM +0100, Thomas Gleixner wrote:

> P.S.: I hate the spinlock in the idle code path, but I don't have a
>       better idea.

seqcount? It would avoid the obvious interleave and put most of the onus
on the reader (which never happens anyway).



