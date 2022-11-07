Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3BC61F0DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiKGKhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiKGKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:37:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4036A13F8C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:37:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005E523A;
        Mon,  7 Nov 2022 02:37:21 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970723F534;
        Mon,  7 Nov 2022 02:37:13 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:37:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thorsten Glaser <t.glaser@tarent.de>
Cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, arnd@arndb.de,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v2] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
Message-ID: <Y2jf1nd63iBGMCz0@FVFF77S0Q05N>
References: <20220203161243.3955547-1-mark.rutland@arm.com>
 <fcafd6d9-7d3e-67b0-3176-5fb8e9c322ef@tarent.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcafd6d9-7d3e-67b0-3176-5fb8e9c322ef@tarent.de>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 12:05:30AM +0100, Thorsten Glaser wrote:
> On Thu, 3 Feb 2022, Mark Rutland wrote:
> 
> > -	smp_store_release(&(v)->counter, i);
> > +	if (__native_word(atomic_t)) {
> > +		smp_store_release(&(v)->counter, i);
> > +	} else {
> > +		__atomic_release_fence();
> > +		arch_atomic_set(v, i);
> > +	}
> 
> Shouldn’t this also update Documentation/atomic_t.txt which
> currently states:
> 
> | The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
> | implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> | smp_store_release() respectively. Therefore, if you find yourself only using
> | the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
> | and are doing it wrong.
> 
> With this, direct use of atomic64_set_release() and atomic64_read_acquire()
> is (IIUC) not “doing it wrong” any more?

Direct use was never "wrong" if you were doing anything other than
atomic64_set_release() and atomic64_read_acquire(), and I suspect we don't want
to see those abused as a way to get a 64-bit smp_store_release() or
smp_load_acquire() since those won't necessarily do the right thing w.r.t. a
plain READ_ONCE() and so on.

So I think this is still correct as-is.

Do you have a particular case in mind that you care about?

Thanks,
Mark.
