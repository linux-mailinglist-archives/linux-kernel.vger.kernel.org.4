Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A3679C76
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjAXOtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjAXOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:49:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E73B900B;
        Tue, 24 Jan 2023 06:48:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFCC24B3;
        Tue, 24 Jan 2023 06:49:25 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECA8B3F71E;
        Tue, 24 Jan 2023 06:48:41 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:48:39 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arch_topology: Build cacheinfo from primary CPU
Message-ID: <20230124144839.2szjjv256j3pdaif@bogus>
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <20230104183033.755668-7-pierre.gondois@arm.com>
 <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
 <20230124140420.4srnufcvamvff77v@bogus>
 <Y8/tl999NQwbPL/R@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/tl999NQwbPL/R@wendy>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:39:19PM +0000, Conor Dooley wrote:
> On Tue, Jan 24, 2023 at 02:04:20PM +0000, Sudeep Holla wrote:
> > Conor might help me remember the details.
> 
> And I can't shirk either since you know I just replied to Pierre!
> 
> > On Tue, Jan 24, 2023 at 02:50:16PM +0100, Geert Uytterhoeven wrote:
> 
> > > > @@ -840,6 +840,14 @@ void __init init_cpu_topology(void)
> > > >                 reset_cpu_topology();
> > > >                 return;
> > > >         }
> > > > +
> > > > +       for_each_possible_cpu(cpu) {
> > > > +               ret = fetch_cache_info(cpu);
> > > > +               if (ret) {
> > > > +                       pr_err("Early cacheinfo failed, ret = %d\n", ret);
> > > 
> > > This triggers on all my RV64 platforms (K210, Icicle, Starlight,
> > > RZ/Five).
> > > 
> > > This seems to be a respin of
> > > https://lore.kernel.org/all/CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com
> > > which had the same issue.
> > >
> > 
> > I need to recollect my memories reading all the thread, but even after the
> > fixes there were few platforms that failed with so early allocation but were
> > fine with initcalls. Are these such platforms or am I mixing up things here ?
> > Do you still see all the cacheinfo in the sysfs with initcalls that happen
> > later in the boot ?
> 
> IIRC that stuff was failing back then because riscv calls
> init_cpu_topology() far sooner in boot than arm64 does, and therefore
> caused allocation failures. You made that warning go away in the below
> patch by moving detect_cache_attributes() to update_siblings_masks(),
> which both arches call later during boot IIRC:
> https://lore.kernel.org/all/20220713133344.1201247-1-sudeep.holla@arm.com
> 
> Pierre's patch has added fetch_cache_info() to the problematic
> init_cpu_topology() which is called before we can actually do any
> allocation in smp_prepare_boot_cpu() or something like that.
> 
> That's what I get for only reviewing the patch that was specifically for
> riscv, and not the rest of the series... D'oh.
> 
> This actually came up a few weeks ago, although I kinda considered the
> reason it was triggered to be a bit bogus there, since that dmips property
> is not (yet?) a valid property on RISC-V. The patch for that is here:
> https://patchwork.kernel.org/project/linux-riscv/patch/20230105033705.3946130-1-leyfoon.tan@starfivetech.com/
> I tried it on a PolarFire SoC (unfortunately not an Icicle, I just went
> and bricked mine an hour ago) & it should be a fix for this problem too.
> 
> My suggested commit message for that is somewhat prophetic now that I
> look back at it:
> https://lore.kernel.org/all/Y7V4byskevAWKM3G@spud/
>

Ah, that thread, I remember that :).

I still need to understand how this is related to memory allocation.
Pierre was suggesting(in private) if we need to keep fetch_cache_info()
arch specific but I really don't want to go down that patch until I
understand and there is no other option.

Thanks for your time. I will try to recall boot flow and see if I can
gather the reasoning for the seen behaviour.

-- 
Regards,
Sudeep
