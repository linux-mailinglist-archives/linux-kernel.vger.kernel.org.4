Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E673634AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiKVXRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiKVXRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:17:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16004C622A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:17:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A27DB61935
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CF4C433D7;
        Tue, 22 Nov 2022 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669159040;
        bh=tRxl97TXH1zQb1p9Wgh7fX6XVw3AYxkMguDDWCvykUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uwYg2hnRmQeuHFDhUQ/xftb3p/N3e54S9xwTQE9POjfF3ijxzz1xP8ezx9p5p8oGH
         +QNT/oa4dEzT4kuLPrmnwiTcevCagRD9ykVqV81X2/V5fkIvkfVD7hsg+0NNTK0B3H
         ED9/OWBRNjrdy2uGVHa8GZb4jlo2Vqrykl4lUA3c=
Date:   Tue, 22 Nov 2022 15:17:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <linux-mm@kvack.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/2] mm/slab: add is_kmalloc_cache() helper macro
Message-Id: <20221122151718.4f7ffcb656dd7dc0eceb0ad2@linux-foundation.org>
In-Reply-To: <Y3xeYF5NipSbBFSZ@feng-clx>
References: <20221121135024.1655240-1-feng.tang@intel.com>
        <20221121121938.1f202880ffe6bb18160ef785@linux-foundation.org>
        <Y3xeYF5NipSbBFSZ@feng-clx>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 13:30:19 +0800 Feng Tang <feng.tang@intel.com> wrote:

> > If so, that's always best.  For (silly) example, consider the behaviour
> > of
> > 
> > 	x = is_kmalloc_cache(s++);
> > 
> > with and without CONFIG_SLOB.
> 
> Another solution I can think of is putting the implementation into
> slab_common.c, like the below?

I'm not sure that's much of an improvement on the macro :(

How about we go with the macro and avoid the
expression-with-side-effects gotcha (and the potential CONFIG_SLOB=n
unused-variable gotcha)?  That would involve evaluating the arg within
the CONFIG_SLOB=y version of the macro.
