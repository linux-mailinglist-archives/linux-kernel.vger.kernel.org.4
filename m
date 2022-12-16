Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EFE64F1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiLPTTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLPTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:19:06 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A8322B18E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:19:05 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2BGJFiNr026484;
        Fri, 16 Dec 2022 13:15:44 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 2BGJFhmm026483;
        Fri, 16 Dec 2022 13:15:43 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 16 Dec 2022 13:15:43 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1] powerpc/64: Set default CPU in Kconfig
Message-ID: <20221216191543.GE25951@gate.crashing.org>
References: <3fd60c2d8a28668a42b766b18362a526ef47e757.1670420281.git.christophe.leroy@csgroup.eu> <20221215204202.mbw2ij4ou7t2ttpv@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221215204202.mbw2ij4ou7t2ttpv@pali>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Dec 15, 2022 at 09:42:02PM +0100, Pali Rohár wrote:
> On Wednesday 07 December 2022 14:38:40 Christophe Leroy wrote:
> >  	default "power8" if POWER8_CPU
> >  	default "power9" if POWER9_CPU
> >  	default "power10" if POWER10_CPU
> > +	default "e500mc64" if E5500_CPU
> 
> Now I'm looking at this change again... and should not E5500_CPU rather
> enforce -mcpu=e5500 flag? I know that your patch moves e500mc64 flag
> from the Makefile to Kconfig, but maybe it could be changed in some
> other followup patch...
> 
> Anyway, do you know what is e500mc64 core? I was trying to find some
> information about it, but it looks like some unreleased freescale core
> which predates e5500 core.

It looks that way yes.  It was submitted at
<https://gcc.gnu.org/pipermail/gcc-patches/2009-November/273251.html>
and committed as <https://gcc.gnu.org/g:b17f98b1c541>.  It looks as if
it was based on the e500mc core, while e5500 is a new core (or
significantly different anyway).

> ISA (without extensions like altivec) seems
> to be same for e500mc64, e5500 and e6500 cores and difference is only
> pipeline definitions in gcc config files. So if my understanding is
> correct then kernel binary compiled with any of these -mcpu= flag should
> work on any of those cores. Just for mismatches core binary will not be
> optimized for speed.

It appears the E500MC64 never made it outside of FSL, so it is best not
to use it at all, imo.


Segher
