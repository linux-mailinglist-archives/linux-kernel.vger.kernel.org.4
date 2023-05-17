Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD570612D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjEQHcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEQHb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:31:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5E10DA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oltwkFLlo0AQrYAodskSSe/CDS+m4jJFdNAkie40kHs=; b=mxW+jzZAT+OfI3RZ3aJBzvYA36
        2r7KbM2Y8CgWd0A+yep/cgiosCLSHyDBQB1vkwFs49tlZPuD9ld+0IwSZAoat0w4OGGcDO7A/NjUH
        Iy3bx5qWpysvQgyM6weyFOnUpGaSkIQLof96wyzEm1Y2QIxa94opIKsraMJu/7378F9zFUqXUR/3x
        8Gn/0FceU5yfAeQ2rbV/DGD6v0CEiz91ynIV2xg9vEoLb1bm7zxqYQqfUl+CM6shcQiED2A3zK2Af
        YcSj22Q7ksqY3ctXwnmbID3hHwoGhnuv7ZwQaEPn3X0F88eXP7dSFeQSiAeDxah3+SkoY/n97lMmC
        RpfZtI6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzBd3-00D9uS-0O;
        Wed, 17 May 2023 07:31:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0774B3001E4;
        Wed, 17 May 2023 09:31:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E15992419CD6B; Wed, 17 May 2023 09:31:19 +0200 (CEST)
Date:   Wed, 17 May 2023 09:31:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] watchdog: Prefer use "ref-cycles" for NMI watchdog
Message-ID: <20230517073119.GA2665450@hirez.programming.kicks-ass.net>
References: <20230516235817.2323062-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516235817.2323062-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 04:58:17PM -0700, Song Liu wrote:
> NMI watchdog permanently consumes one hardware counters per CPU on the
> system. For systems that use many hardware counters, this causes more
> aggressive time multiplexing of perf events.
> 
> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
> used. Try use "ref-cycles" for the watchdog, so that one more hardware
> counter is available to the user. If the CPU doesn't support "ref-cycles",
> fall back to "cycles".
> 
> The downside of this change is that users of "ref-cycles" need to disable
> nmi_watchdog.

I still utterly hate how you hardcode ref-cycles
