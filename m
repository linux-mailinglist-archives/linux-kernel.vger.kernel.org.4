Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CFE686596
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBALwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjBALw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:52:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF28627BB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:52:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 685906176A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF54C433EF;
        Wed,  1 Feb 2023 11:52:12 +0000 (UTC)
Date:   Wed, 1 Feb 2023 11:52:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64/signal: Signal handling cleanups
Message-ID: <Y9pSafJX23rftasQ@arm.com>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
 <Y9kO1egKjKNqE0zg@arm.com>
 <20230131153816.GA2646@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131153816.GA2646@willie-the-truck>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:38:16PM +0000, Will Deacon wrote:
> On Tue, Jan 31, 2023 at 12:51:33PM +0000, Catalin Marinas wrote:
> > Hi Mark,
> > 
> > On Tue, Jan 03, 2023 at 08:25:15PM +0000, Mark Brown wrote:
> > > This series collects a number of small cleanups to the signal handling
> > > code which removes redundant validation of size information and avoids
> > > reading the same data from userspace twice.
> > > 
> > > There are some overlaps with both the TPIDR2 signal handling and SME2
> > > serieses which are also in flight, applying this will require
> > > adjustments in those serieses and vice versa.
> > [...]
> > > Mark Brown (6):
> > >       arm64/signal: Don't redundantly verify FPSIMD magic
> > >       arm64/signal: Remove redundant size validation from parse_user_sigframe()
> > >       arm64/signal: Make interface for restore_fpsimd_context() consistent
> > 
> > I'm fine with the first three patches, they seem correct and make the
> > frame checking more consistent.
> > 
> > >       arm64/signal: Avoid rereading context frame sizes
> > >       arm64/signal: Only read new data when parsing the SVE context
> > >       arm64/signal: Only read new data when parsing the ZA context
> > 
> > I'm not sure these add much to the code readability (and the performance
> > improvement I guess is negligible). We avoid some copy_from_user() into
> > the context structures but rely on data read previously or some
> > get_user() into local variables. Personally I'd make the
> > restore_fpsimd_context() also do a copy_from_user() for consistency with
> > the current sve and za frames restoring.
> > 
> > Personal preference, not sure whether Will has the same view.
> 
> That main thing I'm worried about is the potential for ToCToU bugs if we
> read userdata more than once. For example, if we end up splitting checks
> between the two reads, then an attacker could update the value in the
> middle and potential cause us issues. If we just read the stuff once, we
> don't have to worry about that.

I thought this may be the case but I couldn't come up with an exploit.
The actual size validation is done after the second read. The first read
of the size is used to walk the frame and check the magic values.

Anyway, you are probably right, it's easier to reason about ToCToU if we
only read the size once.

-- 
Catalin
