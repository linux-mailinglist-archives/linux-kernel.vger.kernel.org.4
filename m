Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B66DFBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDLQ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjDLQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6775076BB;
        Wed, 12 Apr 2023 09:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0C84633BD;
        Wed, 12 Apr 2023 16:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128B9C433D2;
        Wed, 12 Apr 2023 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681318614;
        bh=7sNwtUtvHwFJqLlrY6hXeBl/C/V+/yCFZfC2xHM6jtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noTkHizbzGsV1rdMjY8GEVn+pJ376VD0mzSeQH+AiXz814SDMFFCDURI1FPJd5qLH
         JjUDqkHkN624/Fn/MpwUFGH7kpVEC2A/QXUoIxAKAP2hqA1+5BGMowE5xvM/fJfDde
         G/TtsvQzu/bITiVQ1BWXLK7vIWLxNFiQHf17Shfkh/PZQQnKwE/Znfdr0LkEZFs9sE
         HYgX4T1empUUM6MW8PUWsCf3zhd6VPDzLV8iWaEtkRr8dxE0lif1rsD34S7fOXrV4H
         LbYo9C+svJIHPTcOmMNIK8OWCGmcpLtaKpeVbfL47uhEI0DxaTSXG9x7cud0zoNnHy
         REwwzSdLVkiGg==
Date:   Wed, 12 Apr 2023 09:56:52 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230412165652.umuiemo7ifnhr2nz@treble>
References: <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
 <20230412162517.gji52t34zlvcu5bh@treble>
 <6527c6fa-8908-1d8d-2f9e-bb7636a27874@kernel.dk>
 <c4d8e079-91bd-62e8-7725-b03802398c83@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4d8e079-91bd-62e8-7725-b03802398c83@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:44:11AM -0600, Jens Axboe wrote:
> On 4/12/23 10:35 AM, Jens Axboe wrote:
> > On 4/12/23 10:25?AM, Josh Poimboeuf wrote:
> >> On Wed, Apr 12, 2023 at 01:44:00PM +0200, Peter Zijlstra wrote:
> >>> On Tue, Apr 11, 2023 at 05:14:00PM -0700, Josh Poimboeuf wrote:
> >>>
> >>>> Peter, what do you think, should we make track uaccess state across
> >>>> function boundaries?
> >>>
> >>> So IIRC the goal was to explicitly dis-allow that. You want minimal code
> >>> executed with STAC and hence disallow calling stuff.
> >>
> >> I guess I was wondering if we could make an exception for calls to
> >> static IPA-optimized functions, so we wouldn't have to scramble to "fix"
> >> compiler optimizations.
> >>
> >> But for now, yeah let's just keep it simple.
> >>
> >> Jens, can you confirm this works?  I added __noclone instead of removing
> >> static.
> > 
> > Yep, works for me.
> 
> Want me to slap that patch on top of the branch that has the commit
> that causes it?

Yes, please.  Thanks!

-- 
Josh
