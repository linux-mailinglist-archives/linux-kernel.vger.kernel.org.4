Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B135632BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiKUSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:03:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8745CD17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:03:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE033B81232
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57163C433C1;
        Mon, 21 Nov 2022 18:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669053808;
        bh=NPPlVNTPIt4eZj5V4vKEYND7lKQPzlo4Jgr8cU3tjk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNFJxEw69uAcvtWuATMKdAwYS+zHD+dtmBA9L1isrOaa2fTZn3v7Lrur5G6PrX4NG
         LfHeuTyApHTnDgYJZQ4+IJwHbJU6FFXTcci6aFO9+/dAUv6gwkuVe8B9O5Q+D7+wSc
         D25q/T49IUKIBj2q4WmrBK+VaVab0XZWI2YgZE0bipmrm0L2+8KBeAIuWxHgpG2J3C
         aSstHsMaEY3bDtSruJ1DzJ/u3GX8dCD/rlFjSkasAl6ppsQpHzFBidPBIkA5QBqYps
         cBPNPOOkZy2iBowz6Usnnmf7yN4xJM1pjcAqDMbE9m+8ooacLpojhX03s3jDFQoIbz
         k6FhMWvh2KpHQ==
Date:   Mon, 21 Nov 2022 18:03:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
Message-ID: <20221121180321.GA7645@willie-the-truck>
References: <CA+G9fYuYashEQsCfScoVbVqAxeXC4w6VnenO-5dHDH8OEfFBTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuYashEQsCfScoVbVqAxeXC4w6VnenO-5dHDH8OEfFBTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:17:18PM +0530, Naresh Kamboju wrote:
> LKFT detected arm64 boot regression on today's Linux next-20221121 tag.
> The Kernel boot log did not show anything on the serial console.
> 
> Anders bisected this problem and found the subject commit is the
> first bad commit.
> 
> # first bad commit: [9ed2b4616d4e846ece2a04cb5007ce1d1bd9e3f3]
>         arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
> 
> Later it was found this lore link which was already reported [1].
> 
> ref:
> [1] https://lore.kernel.org/all/Y3pS5fdZ3MdLZ00t@dev-arch.thelio-3990X/

Yup, I've queued a revert locally and will push it out this evening.

Cheers,

Will
