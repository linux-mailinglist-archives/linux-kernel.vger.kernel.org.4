Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829FF6DF1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDLKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDLKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:07:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C61D975D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:06:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F7FC14;
        Wed, 12 Apr 2023 03:07:17 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B6283F587;
        Wed, 12 Apr 2023 03:06:31 -0700 (PDT)
Date:   Wed, 12 Apr 2023 11:06:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] stackleak: allow to specify arch specific stackleak
 poison function
Message-ID: <ZDaCpRp5wnh3VFuQ@FVFF77S0Q05N>
References: <20230405130841.1350565-1-hca@linux.ibm.com>
 <20230405130841.1350565-2-hca@linux.ibm.com>
 <ZDZz8QvPdpGJqMd6@FVFF77S0Q05N>
 <ZDaAr0Tg5DPJM9BY@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDaAr0Tg5DPJM9BY@osiris>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:58:07AM +0200, Heiko Carstens wrote:
> On Wed, Apr 12, 2023 at 10:03:46AM +0100, Mark Rutland wrote:
> > On Wed, Apr 05, 2023 at 03:08:40PM +0200, Heiko Carstens wrote:
> > > Factor out the code that fills the stack with the stackleak poison value
> > > in order to allow architectures to provide a faster implementation.
> > > 
> > > Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > As on patch 2, it might be nicer to have a noinstr-safe memset64() and use that
> > directly, but I don't have strong feelings either way, and I'll defer to Kees's
> > judgement:
> 
> Wouldn't that enforce that memset64() wouldn't be allowed to have an own
> stackframe, since otherwise it would write poison values to it, since we
> have
> 
> 	if (on_task_stack)
> 		erase_high = current_stack_pointer;
> 
> in __stackleak_erase()?

Yes, sorry -- I was implicitly assuming that a noinstr-safe version would be
__always_inline.

> That was actually my motiviation to make this s390 optimization an always
> inline asm.
> 
> Besides that this wouldn't be a problem for at least s390, since memset64()
> is an asm function which comes whithout the need for a stackframe, but on
> the other hand this would add a quite subtle requirement to memset64(), if
> I'm not mistaken.

That's a fair enough justification, I think. Thanks for the details!

Thanks,
Mark.
