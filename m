Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BB68DFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjBGSVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjBGSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:21:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DBC2C646
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:20:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675794032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqVOLnVnMX6UDkY+RItugHfiHw/9Kb9FpGSA2i9DJ5E=;
        b=WhXBviB4BHJjJVen8eb1aP1fjEnWzw/FPqfRhmVafIcygitIIvMF2oO/bMETw1JvYk9RE2
        jYgLcMOywf/6tPjPVlqqkWa9FLM1FB7klKskPFRewD1ItQaG1usHibIeZCE1XR8q3JX6JG
        t+CCacFkgQ1ZPXjfMcuE9mxRm/rKOY3W1WM2hEAICaV1p0mCdpAanNlPc6tQwWnjR2AQ6V
        ZBA/fIYF5Q7jGizAhE0L7X806XDdGGbH112pr+gO32rtLqq8kTsJ28EtjrjbKIeyBUll3y
        yAeI+JnmFOBQ5OBzAAUXZNsmcB5gdGuRCf4rYSBuzEOOnss/De8KxTJ0z12AXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675794032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqVOLnVnMX6UDkY+RItugHfiHw/9Kb9FpGSA2i9DJ5E=;
        b=djI7tbngs34lJ3Yv4vHU19/5lNr1NS22fGrjPTpBd4Gu8gqFRqFbopZBYtsDn+810r5iIs
        8cTx7NyDVX3LUSDQ==
To:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: mm, slab/slub: Ensure kmem_cache_alloc_bulk() is available early
In-Reply-To: <8b7762c3-02be-a5c9-1c4d-507cfb51a15c@suse.cz>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx> <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
 <875ycdwyx6.ffs@tglx> <871qn1wofe.ffs@tglx>
 <6c0b681e-97bc-d975-a8b9-500abdaaf0bc@suse.cz>
 <8b7762c3-02be-a5c9-1c4d-507cfb51a15c@suse.cz>
Date:   Tue, 07 Feb 2023 19:20:31 +0100
Message-ID: <87edr1uykw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07 2023 at 15:47, Vlastimil Babka wrote:
> From 340d7c7b99f3e67780f6dec480ed1d27e6f325eb Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 7 Feb 2023 15:34:53 +0100
> Subject: [PATCH] mm, slab/slub: remove notes that bulk alloc/free needs
>  interrupts enabled
>
> The slab functions kmem_cache_[alloc|free]_bulk() have been documented
> as requiring interrupts to be enabled, since their addition in 2015.
> It's unclear whether that was a fundamental restriction, or an attempt
> to save some cpu cycles by not having to save and restore the irq
> flags.

I don't think so. The restriction is rather meant to avoid huge
allocations in atomic context which causes latencies and also might
deplete the atomic reserves.

So I rather avoid that and enforce !ATOMIC mode despite the
local_irq_save/restore() change which is really only to accomodate with
early boot.

Thanks,

        tglx
