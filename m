Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32E26FFB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbjEKUZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbjEKUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F47ED2D7;
        Thu, 11 May 2023 13:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD590651B7;
        Thu, 11 May 2023 20:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37836C433AE;
        Thu, 11 May 2023 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683836719;
        bh=nNBnN/oc6VGOrnZ4IGZwzzm7SrkfBnpPL25ydS2TfcQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n7Jgt1a6EFbQapbeq52054DyE66s6fX0tFO9Bdocmu7zE6lnolLMoeCynVmq03P1x
         ooZACuTSUkqrTA5kUnAZUeJ15vfPV+Ee+GDPCuG8aTqDxk8aEssGLy1wiO52XUyggQ
         9w9pjjpbQnaWMW5/UAQwlkPWlOI3aO1noKieHewl9e152+39LOD0KGafmY57C9XgGQ
         J8hwaUmr1V634EDP7ct64L3dblfUPKouKGPxfam8Wmij57kEc4tQA0T0ecyT95fafi
         WJRhzXBRCZCDmieGIlWBUaVqw75Ge83kC+HOF1FSqPAxqacCo6mN7zohLkofrZU1A7
         AvnGeAV2leRTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C1AEACE0FED; Thu, 11 May 2023 13:25:18 -0700 (PDT)
Date:   Thu, 11 May 2023 13:25:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <613a2d06-30f1-4140-aa6c-16d5298d9909@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <20230511193856.GA2296992@hirez.programming.kicks-ass.net>
 <c619d689-e7b5-4136-9bd3-8f41954f43cd@paulmck-laptop>
 <20230511200142.GC2296992@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511200142.GC2296992@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:01:42PM +0200, Peter Zijlstra wrote:
> On Thu, May 11, 2023 at 12:53:46PM -0700, Paul E. McKenney wrote:
> > Do you have an alternative suggestion for generating the kernel-doc?
> > The current lack of it is problematic.
> 
> I've never found a lack of kernel-doc to be a problem. And I'm very much
> against complicating the scripts to add it.

I am sure that you have not recently found the lack of kernel-doc for
the atomic operations to be a problem, given that you wrote many of
these functions.

OK, you mentioned concerns about documentation people nitpicking.  This
can be dealt with.  The added scripting is not that large or complex.

> Also, there's Documentation/atomic_t.txt

Yes, if you very carefully read that document end to end, correctly
interpreting it all, you will know what you need to.  Of course, first
you have to find it.  And then you must avoid any lapses while reading
it while under pressure.  Not particularly friendly to someone trying
to chase a bug.

							Thanx, Paul
