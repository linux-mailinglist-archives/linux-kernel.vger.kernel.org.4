Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F6E6F04F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbjD0LZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243679AbjD0LZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:25:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB944C2B;
        Thu, 27 Apr 2023 04:24:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB5AF2F4;
        Thu, 27 Apr 2023 04:25:07 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272F23F5A1;
        Thu, 27 Apr 2023 04:24:21 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:24:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     ron minnich <rminnich@gmail.com>
Cc:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
Message-ID: <ZEpbTE4gcsf8meXc@FVFF77S0Q05N>
References: <20230426034001.16-1-cuiyunhui@bytedance.com>
 <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N>
 <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 09:04:56PM -0700, ron minnich wrote:
> The device tree is self describing data. Adding new information is easy. If you
> add new information to a node, and older software does not know about it, it is
> no big deal.

It's true that it's easy to add fields to an extensible format, but that wasn't
my point of contention. The *semantic* (e.g. all of the relevant DT bindings)
and *consumption* of that data is the important part, and that's what I was
referring to, though I appreciate my wording did not make that clear.

> So I can't agree with this comment: "We'd have to create entirely new ways to
> pass that information, which is not
> very desirable."
> 
> The whole point of the dt is that you can always add new ways to pass
> information, by design. 
> 
> Adding memory attributes would be quite easy.

I don't disagree that is physically possible, and in isolation adding
properties to a DT is trivial, but the approach proposed is not "easy" unless
you ignore the cost of specifying analogues for all the EFI portions that you
plan to omit, ensuring that those stay functionally equivalent to their EFI
analogues as EFI and ACPI evolve over time, developing and maintaining the code
which must consume that, avoiding the issues that will arise due to novel
interactions (as e.g. DT and ACPI are mutually exclusive today, by design),
etc.

For example, the UEFI memory map is semantically and structurally different
from DT memory nodes. It encodes *different* information, and in practice needs
to encode a larger number of physical extents with properties (e.g.
cacheability, permissions) associated with each extent. The existing DT memory
nodes format isn't really amenable to encoding this, inventing a parallel
structure for this opens up all the usual problems of the two becoming
out-of-sync, and inventing a new mechanism to describe all of this in a
consistent way duplicates all the work done for EFI.

I appreciate that at a high level of abstractions this seems conceptually
simple, but in practice this is a complex area where components have subtle and
often implicit dependencies, and so there is inherent fractal complexity.

Thanks,
Mark.

> On Wed, Apr 26, 2023 at 8:38 PM 运辉崔 <cuiyunhui@bytedance.com> wrote:
> 
>     Hi Mark,
> 
>     On Wed, Apr 26, 2023 at 6:07 PM Mark Rutland <mark.rutland@arm.com> wrote:
>     >
>     > Ard's point is that the device tree doesn't have all the same information
>     (e.g.
>     > nothing in DT describes the memory type attributes), and so this isn't
>     > sufficient.
> 
>     The device tree only needs to complete the parse of the memory type
>     attributes,
>     it should not be very complicated.
> 
>     >
>     > We'd have to create entirely new ways to pass that information, which is
>     not
>     > very desirable.
>     >
> 
>     >
>     > Can you extend coreboot to provide EFI services, or to chain-load an EFI
>     > payload?
> 
>     Currently, coreboot does not support UEFI, and it may not support it
>     in the future.
>     Hi rminnich, what do you think?
> 
>     Thanks,
>     Yunhui
> 
