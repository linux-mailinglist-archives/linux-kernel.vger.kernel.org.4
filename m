Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9925B8621
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiINKVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiINKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FD7A537;
        Wed, 14 Sep 2022 03:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B8B61B7A;
        Wed, 14 Sep 2022 10:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A2FC433C1;
        Wed, 14 Sep 2022 10:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663150870;
        bh=DiPQNoNQNG+LQNzk/iOQ5X8mk924KHwwG68nSONOT+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLIIKfyfTOvDZbH9wZaRqn8c0Jveo+TQ6Zt7JqKiPzkEsMLIQ2+OrSOPk+A75ttv9
         cdYSrFuCTthS8RzN8Fv301CuEb8gxC/23zBONTWkIngBDkRj7kzEKYY+2WLrXUExAx
         PB05AkMjWJbeZwNBT6PLMz3GsjFf5jQ9L0QBC4fsSAFVVO2vF9bL+DlurkFyPXHYJj
         ExNEJTXC06DKdUMf1iLprTPmyOLqTvi1MjJX8basjkokHqeUbpyq3d2+r6WAKnnLav
         k6tHWhkuTxHDL3h18VQp1RJwgEhAOREqBPIheMRG2gg2U6A8bvuQw8pkSRGvyp8jy+
         LusWJ4Sfx2AIA==
Date:   Wed, 14 Sep 2022 11:21:00 +0100
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        Chen Zhongjin <chenzhongjin@huawei.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        linux-toolchains@vger.kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Jose E. Marchesi" <jemarch@gnu.org>, Michael Matz <matz@suse.de>
Subject: Re: [RFC] Objtool toolchain proposal:
 -fannotate-{jump-table,noreturn}
Message-ID: <20220914102100.thl5ad35plvazark@treble>
References: <20220909180704.jwwed4zhwvin7uyi@treble>
 <20220912113114.GV25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220912113114.GV25951@gate.crashing.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 06:31:14AM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Fri, Sep 09, 2022 at 11:07:04AM -0700, Josh Poimboeuf wrote:
> > 2) Noreturn functions:
> >    
> >    There's no reliable way to determine which functions are designated
> >    by the compiler to be noreturn (either explictly via function
> >    attribute, or implicitly via a static function which is a wrapper
> >    around a noreturn function.)
> 
> Or just a function that does not return for any other reason.
> 
> The compiler makes no difference between functions that have the
> attribute and functions that do not.  There are good reasons to not
> have the attribute on functions that do in fact not return.  The
> not-returningness of the function may be just an implementation
> accident, something you do not want part of the API, so it *should* not
> have that attribute; or you may want the callers to a function to not be
> optimised according to this knowledge (you cannot *prevent* that, the
> compiler can figure it out it other ways, but still) for any other
> reason.

Yes, many static functions that are wrappers around noreturn functions
have this "implicit noreturn" property.  I agree we would need to know
about those functions (or, as Michael suggested, their call sites) as
well.

> >    This information is needed because the
> >    code after the call to such a function is optimized out as
> >    unreachable and objtool has no way of knowing that.
> 
> Since June we (GCC) have -funreachable-traps.  This creates a trap insn
> wherever control flow would otherwise go into limbo.

Ah, that's interesting, though I'm not sure if we'd be able to
distinguish between "call doesn't return" traps and other traps or
reasons for UD2.

-- 
Josh
