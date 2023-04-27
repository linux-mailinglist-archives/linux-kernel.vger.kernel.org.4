Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421476F0A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243982AbjD0RQx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 13:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244441AbjD0RQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:16:42 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C77B55A1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:16:20 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ps5Dr-0006cU-50; Thu, 27 Apr 2023 19:15:59 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, kito.cheng@sifive.com, jrtc27@jrtc27.com,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu,
        richard.henderson@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] RISC-V: add support for vendor-extensions via
 AT_BASE_PLATFORM and xthead
Date:   Thu, 27 Apr 2023 19:15:58 +0200
Message-ID: <5016896.Mh6RI2rZIc@diego>
In-Reply-To: <20230426-spirits-ludicrous-a5d8275686e6@wendy>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <20230424194911.264850-5-heiko.stuebner@vrull.eu>
 <20230426-spirits-ludicrous-a5d8275686e6@wendy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Conor,

Am Mittwoch, 26. April 2023, 14:29:16 CEST schrieb Conor Dooley:
> On Mon, Apr 24, 2023 at 09:49:11PM +0200, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > 
> > T-Head cores support a number of own ISA extensions that also include
> > optimized instructions which could benefit userspace to improve
> > performance.
> > 
> > Extensions supported by current T-Head cores are:
> > * XTheadBa - bitmanipulation instructions for address calculation
> > * XTheadBb - conditional basic bit-manipulation instructions
> > * XTheadBs - instructions to access a single bit in a register
> > * XTheadCmo - cache management operations
> > * XTheadCondMov - conditional move instructions
> > * XTheadFMemIdx - indexed memory operations for floating-point registers
> > * XTheadFmv - double-precision floating-point high-bit data transmission
> >               intructions for RV32
> > * XTheadInt - instructions to reduce the code size of ISRs and/or the
> >               interrupt latencies that are caused by ISR entry/exit code
> > * XTheadMac - multiply-accumulate instructions
> > * XTheadMemIdx - indexed memory operations for GP registers
> > * XTheadMemPair - two-GPR memory operations
> > * XTheadSync - multi-core synchronization instructions
> > 
> > In-depth descriptions of these extensions can be found on
> >     https://github.com/T-head-Semi/thead-extension-spec
> > 
> > Support for those extensions was merged into the relevant toolchains
> > so userspace programs can select necessary optimizations when needed.
> > 
> > So a mechanism to the isa-string generation to export vendor-extension
> > lists via the errata mechanism and implement it for T-Head C9xx cores.
> > 
> > This exposes these vendor extensions then both in AT_BASE_PLATFORM
> > and /proc/cpuinfo.
> 
> I'm not entirely sure if this patch is meant to be a demo, but I don't
> like the idea of using these registers to determine what extensions are
> reported.

It took me a while to grasp the above, but I think you mean determining
extensions based on mvendor etc, right?


> riscv,isa in a devicetree (for as much as I might dislike it at this
> point in time), or the ACPI equivalent, should be the mechanism for
> enabling/disabling these kinds of things.

> Otherwise, we are just going to end up causing problems for ourselves
> with various lists of this that and the other extension for different
> combinations of hardware.
> The open source c906 has the same archid/impid too right? Assuming this is
> a serious proposal, how would you intend dealing with modified versions
> of those cores?
> 
> I am pretty sure that you intended this to be a demo though, particularly
> given the wording of the below quote from your cover,

yeah, this one was more following a train of thought. Thinking about the
issues, this was more of an addon thought, as I wasn't really sure which
way to go.

So you're right, vendor isa-extensions should also come from the ISA
string from firmware, similar to the base extensions. Not based on the
mvendor-id and friends.



> but in case you did
> not:
> 
> NAK to this way of sourcing the information.
> 
> Anyways, since your cover's considerations section seems partly aimed at
> me, given my discussion with head-the-ball last week:
> 
> > Things to still consider:
> > -------------------------
> > Right now both hwprobe and this approach will only pass through
> > extensions the kernel actually knows about itself. This should not
> > necessarily be needed (but could be an optional feature for e.g. virtualization).
> 
> What do you mean by virtualisation here? It's the job of the hypervisor
> etc to make sure that what it passes to its guest contains only what it
> wants the guest to see, right?
> IIUC, that's another point against doing what this patch does.

I guess I'm still seeing Zbb and friends - with just computational
instructions as always good to have. But I guess you're right that the
hypervisor should be able to control itself which extensions.


> > Most extensions don’t introduce new user-mode state that the kernel needs to
> > manage (e.g. new registers). Extension that do introduce new user-mode state
> > are usually disabled by default and have to be enabled by S mode or M mode
> > (e.g. FS[1:0] for the +floating-point extension). So there should not be a
> > reason to filter any extensions that are unknown.
> 
> I think in general this can be safely assumed, but I don't think it is
> unreasonable to expect someone may make, for example, XConorGigaVector
> that gets turned on by the same bits as regular old vector but has some
> extra registers.
> Not saying that I think that that is a good idea, but it is a distinct
> possibility that this will happen, and I don't think forwarding it to
> userspace is a good idea.

The thead-vector (0.7.1) would probably fit this description. Though in
that case, userspace definitly needs to know about it, to use it :-) .

But of course this should only be forwarded when relevant support
is available in the kernel.


> > So it might make more sense to just pass through a curated list (common
> > set) created from the core's isa strings and remove state-handling
> > extensions when they are not enabled in the kernel-side (sort of
> > blacklisting extensions that need actual kernel support).
> 
> Yeah, as discussed with Christoph the other day I don't think we can
> really avoid such a blacklist. I don't think it'd require any sort of
> vendor specific handling, since, as you point out, a vendor may well
> implement extensions that were created by other companies.
> 
> It's easy, right?? "Just" parse the dt, tokenise the extensions & delete
> whatever is in the blacklist, right?

And then reality happens ;-)


> Hyperbole aside, I think that doing something like this increases the
> need for a system like Evan's, as userspace may need a way to
> differentiate between what the hardware is capable of (as reported by
> the isa string in /proc/cpuinfo or the content of 3/4) and what the
> kernel actually supports.
>
> > However, this is a very related, but still independent discussion.
> 
> Aye, this discussion and the first two patches are relevant whether 3/4
> is accepted or not IMO.

I guess I'll poke this some more in the meantime, taking into account
all the comments from above :-) .


Thanks
Heiko



