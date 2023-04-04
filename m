Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB536D5E0F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjDDKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjDDKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5332030EB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEE2A6318E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4CDC4339B;
        Tue,  4 Apr 2023 10:50:37 +0000 (UTC)
Date:   Tue, 4 Apr 2023 11:50:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] arm64: mops: document boot requirements for MOPS
Message-ID: <ZCwA+rbmFT2HaZ7G@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-5-kristina.martsenko@arm.com>
 <ZBSCObGmIXjyeMA6@arm.com>
 <61b0e30a-568c-d7f6-7b67-e9fc8b68de25@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b0e30a-568c-d7f6-7b67-e9fc8b68de25@arm.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 01:00:43AM +0000, Kristina Martsenko wrote:
> On 17/03/2023 15:07, Catalin Marinas wrote:
> > On Thu, Feb 16, 2023 at 04:00:06PM +0000, Kristina Martsenko wrote:
> >> +  For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
> >> +
> >> +  - If the kernel is entered at EL1 and EL2 is present:
> >> +
> >> +    - HCRX_EL2.MSCEn (bit 11) must be initialised to 0b1.
> >> +
> >> +    - HCRX_EL2.MCE2 (bit 10) must be initialised to 0b0.
> > 
> > Regarding MCE2, does EL1 actually care if EL2 wants to handle all the
> > memcpy/memset exceptions? 
> 
> No, EL1 does not need to handle the exceptions itself, but I don't see any
> current use case for allowing EL2 to handle it.
> 
> If it was allowed, I think booting.txt would need to specify exactly what Linux
> expects EL2 to do if MCE2 is set (eg, that EL2 handles the exception by
> reformatting registers, modifying single step state, etc).

What I meant is that an EL1 kernel shouldn't care if MCE2 is 0 or 1. We
could clarify that if set to 1, it is expected that the hypervisor
handles the memory copy/set exceptions accordingly.

> > There may even be a valid case to do this at
> > EL2 if you run a guest that uses these instructions but has no clue on
> > how to deal with the specific exception like WrongOption.
> 
> Not sure I follow - this series adds the exception handling, so how can a Linux
> guest not know how to handle the exception?

The guest may not always be Linux (e.g. some microkernel) and may not
expect the hardware implementation to change underneath.

> Or do you mean that there may be times when EL1 can't take the exception but
> EL2 may move it to another CPU, and so EL2 would need to handle the exception?

I haven't thought of this but it's actually a good point. Are there any
cases where Linux can't handle a memcpy exception? I guess we need to be
careful with taking such exception in an atomic context (e.g. no
rescheduling on the return path).

> I'm not sure if Linux ever uses mops instructions at times like that.

The compiler may generate a memcpy() call by simply assigning a
structure to another. So we can't control where those instructions are
used.

> Note that this series does not add support for mops in guests yet. 

You mean there's no KVM support. But Linux may be run under a different
hypervisor (e.g. Hyper-V) as a guest.

> I think booting.txt can be updated when that support is added.

In booting.txt, when you say the kernel entered at EL1, it implies that
it may be run as a guest under a random hypervisor.

So maybe we should detail the MCE2 requirement a bit, saying that it can
be either 0 or 1 but, for the latter, the hypervisor must handle the
corresponding exceptions.

-- 
Catalin
