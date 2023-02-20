Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E26D69D3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjBTTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjBTTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:08:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37C92202A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L5VPpGTtCs18Enl9uUmL/D3SAVe3eOldpMdvBGEOLTw=; b=HZoR4431yQ3YTudCIzSsTOj93J
        01QQovjLxGQJkHOVxUBF2lPiB8+EBJX4b6xXyTcg5S4cImz91wOGugsiXLe377RZm9b3hgeIlBFtz
        dlQdYlVeTghFikiV+vU3ExTVOkiEnmuzktMpzV3HOHdENDyFEIN669T/apideHqBdf5DXvODCTtLx
        XtX1ECVaEmQg3oEJ0+n5XgRa2uxB0GUlVcpXDgBuQgmFJM06DIx3tOx1l/n/ePiockluPYEUEeoWz
        iyosuSN/Q+uuYiG+d7pVZhd8qFh+3lh0ea6ZAI0LGeMGpJJ5I5wP3/MOk36KY3jbNKgQu+qPzZPhP
        dIoyJ7/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUBUH-00BtUl-1b;
        Mon, 20 Feb 2023 19:06:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08A143002BF;
        Mon, 20 Feb 2023 20:06:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E04F0201E58DE; Mon, 20 Feb 2023 20:06:07 +0100 (CET)
Date:   Mon, 20 Feb 2023 20:06:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Message-ID: <Y/PEnzRCZXA94cuw@hirez.programming.kicks-ass.net>
References: <20230220032856.661884-1-rui.zhang@intel.com>
 <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
 <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 02:33:09PM +0000, Zhang, Rui wrote:

> > If only there was a sane way to tell these things without actually
> > bringing everything online first :-(
> 
> I thought of improving this by parsing all the valid APIC-IDs in MADT
> during BSP bootup, and get such information by decoding the APIC-IDs
> using the APIC-ID layout information retrieved from BSP. But this is
> likely to be a fertile new source of bugs as Dave concerned.

Yes and no, aren't we using those APIC-IDs to send INIT to the APs?
Consequently, those APIC-IDs must be good, otherwise SMP bringup will go
side-ways -- and it typically doesn't.

We could add an assertion in SMP bringup that the APIC-ID from MADT
matches the state as read from CPUID ? If that matches (it really
should) then using the MADT table IDs early should work and at least
give us a litle bit more data.

APIC-ID is of no use vs hybrid though, and MADT doesn't include any
either, so that's all still buggered.

Luckily it looks like MADT is fairly extensible, ideally we add an field
to entry-type-0 to help with the hybrid mess.

TL;DR, I really think we should try this.
