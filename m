Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3A16831A8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjAaPi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjAaPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:38:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48CB462
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:38:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7495B81D5C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E766C4339E;
        Tue, 31 Jan 2023 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675179501;
        bh=JOJOT+dxC37NT2M/AJqQ1MByxjCpME4HBG9QuRUBGbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7jdyTCWhHEgfbVkZp8EPxVb5wxo15WRUN9VaE/kyFfeYrmgc/b3KArn6r7mKeEJd
         z6GfDmlKAOJ4gCRsfF/KNIGjfCnvqX4u+XeIAMiKUS+NWc+SZiz/nEnYbX0Z98UQMG
         juUBEtUwNUeJAzDIPcjAjWaTdBEko1o0mloBWuDJ9PcYiMLqZV0jC6epcmwWgHBp4l
         X2Fx3fizCntIq/E8cbbGAenlC0/9H55p6sbz4To0dOHPfm2mf3r9e4SqSOViWhfKRw
         ckYwx1rVamHb48NyjFT64c3MBFElmI4nNK4Hq47aiEzTly/lyIdCqQUnquoYl99Xo2
         v34ZBKxS6XCxQ==
Date:   Tue, 31 Jan 2023 15:38:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64/signal: Signal handling cleanups
Message-ID: <20230131153816.GA2646@willie-the-truck>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
 <Y9kO1egKjKNqE0zg@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kO1egKjKNqE0zg@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:51:33PM +0000, Catalin Marinas wrote:
> Hi Mark,
> 
> On Tue, Jan 03, 2023 at 08:25:15PM +0000, Mark Brown wrote:
> > This series collects a number of small cleanups to the signal handling
> > code which removes redundant validation of size information and avoids
> > reading the same data from userspace twice.
> > 
> > There are some overlaps with both the TPIDR2 signal handling and SME2
> > serieses which are also in flight, applying this will require
> > adjustments in those serieses and vice versa.
> [...]
> > Mark Brown (6):
> >       arm64/signal: Don't redundantly verify FPSIMD magic
> >       arm64/signal: Remove redundant size validation from parse_user_sigframe()
> >       arm64/signal: Make interface for restore_fpsimd_context() consistent
> 
> I'm fine with the first three patches, they seem correct and make the
> frame checking more consistent.
> 
> >       arm64/signal: Avoid rereading context frame sizes
> >       arm64/signal: Only read new data when parsing the SVE context
> >       arm64/signal: Only read new data when parsing the ZA context
> 
> I'm not sure these add much to the code readability (and the performance
> improvement I guess is negligible). We avoid some copy_from_user() into
> the context structures but rely on data read previously or some
> get_user() into local variables. Personally I'd make the
> restore_fpsimd_context() also do a copy_from_user() for consistency with
> the current sve and za frames restoring.
> 
> Personal preference, not sure whether Will has the same view.

That main thing I'm worried about is the potential for ToCToU bugs if we
read userdata more than once. For example, if we end up splitting checks
between the two reads, then an attacker could update the value in the
middle and potential cause us issues. If we just read the stuff once, we
don't have to worry about that.

Will
