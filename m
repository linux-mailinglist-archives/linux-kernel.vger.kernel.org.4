Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1676062C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJTORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJTORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:17:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376D5BC82
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5TtrbH9V8UjenTj6D/8BLrhRN2GQ4zhxuiI6Q8cXLKU=; b=nIdsZp7VG4Mpr4TEUCiLZK3RpR
        xidnrNmCvpON9u60Q+zHOsqitxyw5P/id5zBswF/GI8b3iZgamFX+4N/kAelHVu++e8SZe6AVsE1m
        XmIW/bd8Z19DLGKyLO4jwDCsDGwfDIA73MpgTVGALXKNONcjcBwHhJHciwNqoAGN+Cb6n52CFCKPD
        k0ib3ypEr1Rf9vd3NOFZxoyiuPa7U7KJM/Co4CC+VQvZXnQGZi50B5O/DEtWF8Yl4Ho4N4FbRF/jT
        FOmlulskfj/RgqDiJZvAFNXvSovQ/Ld/kMRjsePSLM+fWgZGOmnCnWfAUXoKtPxgT2oP9Fk3f+20w
        xs1xX4fQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olWKE-00CQtJ-1E; Thu, 20 Oct 2022 14:15:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D07930045D;
        Thu, 20 Oct 2022 16:15:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18B5D28576687; Thu, 20 Oct 2022 16:15:04 +0200 (CEST)
Date:   Thu, 20 Oct 2022 16:15:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/5] sched: add a few helpers to wake up tasks on the
 current cpu
Message-ID: <Y1FX6FmPHCsdQn9A@hirez.programming.kicks-ass.net>
References: <20221020011048.156415-1-avagin@gmail.com>
 <20221020011048.156415-4-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020011048.156415-4-avagin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 06:10:46PM -0700, Andrei Vagin wrote:
> Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wake
> up processes on the current CPU.

There is an astounding lack of *why* in this changelog.
