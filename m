Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212C266BADC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjAPJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAPJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:48:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4585714EA9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HB509Ij8BgRiGYsjt7/oG8BMyaiBytgGWhNBYz1sI3M=; b=gUKdb+N60yZcN6esZvgZc4c1wS
        hS/1n8zmoi5E2SO5yP308fph8rnw2z+oytIie0Kd1xzBmz4C8a1YRkh6dtOXAwbpdP4Qfqd3mWyRo
        eAHkdQqzinxiwP24IQI0KH1RIAtOhbGH/69MFqwCT/DkdHgO5Qy2o9ah0RaB4MmQrGCyg19x+CrmZ
        5Us6spLsT5eDBODMjXLrEzktWC8yC78BlCvgMhuTflYqVIYn27piX3dJ5lY5s5RWgvpAJEFGHd0+y
        SMZYbaeIED6LC4+v/xRr7qgHXi454do9dDAERbeEfY8dYe4Bz/mbZ5ha4yF/kerU/8zhxStS+x3Ui
        cpjt94jA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHM6O-008cai-Tr; Mon, 16 Jan 2023 09:48:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC4143005C9;
        Mon, 16 Jan 2023 10:48:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A123C20D30481; Mon, 16 Jan 2023 10:48:13 +0100 (CET)
Date:   Mon, 16 Jan 2023 10:48:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 1/5] seccomp: don't use semaphore and wait_queue together
Message-ID: <Y8UdXRt7rhm61ATD@hirez.programming.kicks-ass.net>
References: <20230110213010.2683185-1-avagin@google.com>
 <20230110213010.2683185-2-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110213010.2683185-2-avagin@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:30:06PM -0800, Andrei Vagin wrote:

> +	atomic_add(1, &match->notif->requests);

atomic_inc() ?

