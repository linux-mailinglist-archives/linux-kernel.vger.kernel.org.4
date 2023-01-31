Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4B682ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjAaOGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjAaOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:06:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0F865A2;
        Tue, 31 Jan 2023 06:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGbvhb+qCuJjCKrOeUzYH+Q16SMbBipJr3cDz0yKTrU=; b=ENOUUp0rf8gdWziPdYIo9BcbyV
        OdRu8NsaILTN0YbAQcSzcNWa+TFGBf6BeWROyrEywISyWNGan8jSvDYj6bmR3/veXaDZZmX2+NOF4
        5RZ01IqpkonyLFnyjtKxPUWjGuQTvXbZxKvm9aSppc+YhFviL1LU6NKmmq1WKgG6QM6Ir5dWYWY/+
        CXM7GBad8I+cy4wP9dfppvxbSsssyeLUhkeicSNgG2IGtePtMH/diGa+CLgsE55g1G0ixZmfjRQKC
        7rbmNyBC16wPUveU5RLuF597YO6OHrtQ7p1mVfi03MNvhkENZV9iur7RW0ydxKaQDijh0zIZeU64o
        vfpAANZg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pMrGw-004NT0-1P;
        Tue, 31 Jan 2023 14:06:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FF4330008D;
        Tue, 31 Jan 2023 15:06:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B90D20306BCE; Tue, 31 Jan 2023 15:06:39 +0100 (CET)
Date:   Tue, 31 Jan 2023 15:06:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Message-ID: <Y9kgblwd/wUZ1KCJ@hirez.programming.kicks-ass.net>
References: <20230130182109.3571524-1-song@kernel.org>
 <Y9jau76YwdCElzZ0@hirez.programming.kicks-ass.net>
 <1302e2b6-8980-e6e5-7433-6754634c98f3@csgroup.eu>
 <Y9kDyUaOe57IL/yF@hirez.programming.kicks-ass.net>
 <6420c572-3d0c-eb64-208e-26b38d3da873@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6420c572-3d0c-eb64-208e-26b38d3da873@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:14:48PM +0000, Christophe Leroy wrote:

> >> Something like
> >>
> >> 	return within(addr, mod, MOD_TEXT) || within(addr, mod, MOD_DATA) ||
> >> 	       within(addr, mod, MOD_RODATA) || within(addr, mod,
> >> MOD_RO_AFTER_INIT);
> > 
> > Urgh, how about?
> > 
> > 	for_each_mod_mem_type(type) {
> > 		if (!mod_mem_type_is_init(type) && within(addr, mod, type))
> > 			return true;
> > 	}
> > 	return false;
> > 
> > Then you have have a bunch of mod_mem_type_id_foo() filter functions
> > that are non-contiguous without having to endlessly repeat stuff
> > manually.
> 
> But that's un-readable.

"For all except init."

> You have to have the list of possible types in front of you in order to 
> understand what the function does. Which means that one day or another 
> someone will change the order of types in the enum, and it will break.

I really don't agree, if you do explicit type lists everywhere you have
to update each and every sites when you modify the enum.

If you make category helpers, like: data, text, init, then you only need
to update the helpers without having to worry about each site. Only if
you add an enum that doesn't fit the existing categories do you need to
do something new.


