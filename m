Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA11A701993
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 21:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjEMT5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjEMT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 15:57:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0AA2D63
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 12:56:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684007817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkxD4jDFwjLSBHfJ/c7FKLTS33arAD1vzMDqCSf5Pqw=;
        b=WecT/scqjLIK4s1VjLSGGyFo6Jr1XXzXXa7ew7a08lM3Cc2LHE+s4zmMPCPIvNECejz+09
        87fbFNALX/Zp+UJRamTk9VK8yhJr+tFbUFAlSdpMq6+uNqrfb6Pxl8tTlZf5YXh6iTKo+f
        TWLO/fAsZChUP7p2Ke4ZEC50klOeE1NBd8F8IdQ+f42jv/Ri4LXiAAZerNVFEuO0f0OTAP
        49SNHsfXxg7npfLUnrb3cg3yme5cB6bsNk9EJ0P5TDYVdftfjG8QemHEHV1r9IdMKbgoSp
        cuiem2FT9GMotBK2ZTViDARfY+e5A+bTiwA6e3hr1Rdw1c88Odvy6BIG1UPpsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684007817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkxD4jDFwjLSBHfJ/c7FKLTS33arAD1vzMDqCSf5Pqw=;
        b=SUX0/ToMzEcB41KnS0g0Ax0kdf6JxQPb/f2pebxSdCW+QrA33POroMty+gImglWABdG5dz
        NygQwc3rBZelmEAQ==
To:     Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        linux-mm@kvack.org
Subject: Re: Futexes & Folios
In-Reply-To: <ZF+3xpmouwur4sVE@casper.infradead.org>
References: <ZF+3xpmouwur4sVE@casper.infradead.org>
Date:   Sat, 13 May 2023 21:56:56 +0200
Message-ID: <87cz349f93.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13 2023 at 17:16, Matthew Wilcox wrote:

> Here's a patch which converts the futex code from using pages to using
> folios.  I do have some questions.
>
>  - I assume we really do want to base the key on the page offset of the
>    futex in the file.  That is, it's not good enough to base the key
>    on the folio's index because the folio can be split after setting up
>    the key, and if it is we'd then fail to find the futex later.

Correct.

>  - In hugetlbfs, it doesn't matter whether the pgoff is based on base
>    pages or huge page size -- as long as it's consistent between
>    invocations, everything will work

Yes.

The patch looks sane, but I need to have a look with brain more awake

Thanks,

        tglx
