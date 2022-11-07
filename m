Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE4B61F68A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiKGOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:49:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843861BEB8;
        Mon,  7 Nov 2022 06:49:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 155D561143;
        Mon,  7 Nov 2022 14:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F677C433D6;
        Mon,  7 Nov 2022 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667832578;
        bh=3WK9Jq/Qe/BgudIXrjjalPxMr2bjl68Gs+psLSmfhcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWGGMUUeRPCsiDwZofNcQpiJuk6DroMw24HvO46ZQ5KbOwVn2En6Ex4K/E/3Ny3ZS
         Rmt1UCF4RMrQst0hl4lW2S89wcz1bOzLlOkLDbRTu4SqJ05E+qXrTndRkKW1CiHpyP
         mK6eRUMpIwGo5r73WpfyjC4+Vxo7NoC/yMr5bOUi0Gmg/d63Quw54+O3dLndMC4OUK
         ruFvx0YL33X4+GDxk0dpoOUaebskl1oCl+LhOjs6W2fQv9FQZe9VLD0tuWab3tE5O3
         4zxX7XmeN3tVXT1JlgjRf+xaE4rVtWC3Sn35j+hsWnc6VjGBYbobr4jwQqHwfOaWT2
         UKkOIZXwaGuZQ==
Date:   Mon, 7 Nov 2022 14:49:31 +0000
From:   Will Deacon <will@kernel.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, rostedt@goodmis.org,
        mingo@redhat.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, arnd@arndb.de, zhengzengkai@huawei.com,
        jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] arm64/kprobes: Add support for KPROBES_ON_FTRACE
Message-ID: <20221107144931.GA20793@willie-the-truck>
References: <20220728020250.1699-1-iecedge@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728020250.1699-1-iecedge@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Mark R]

On Thu, Jul 28, 2022 at 02:02:50AM +0000, Jianlin Lv wrote:
> This is the arm64 version of ftrace-based kprobes to avoid the overhead
> with regular kprobes, by using the ftrace infrastructure.
> 
> Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> ---
>  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/kernel/probes/Makefile             |  1 +
>  arch/arm64/kernel/probes/kprobes-ftrace.c     | 81 +++++++++++++++++++
>  include/linux/kprobes.h                       |  2 +
>  kernel/kprobes.c                              |  4 +-
>  6 files changed, 88 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/kernel/probes/kprobes-ftrace.c

Sorry for the slow reply on this, but I think this deserved to be split
into two patches: the first one reworking the core check_ftrace_location()
logic to work properly with branch-and-link style architectures, and the
second one adding support for arm64.

I'd also prefer that we don't just punt the whole of check_ftrace_location()
to the arch code using weak symbols. I'd have thought it would be cleaner
for architectures to specify the offset which needs to be applied to the
PC instead.

Having said that, how do architectures such as PowerPC and Risc-V handle
this today without changing the core code?

Will
