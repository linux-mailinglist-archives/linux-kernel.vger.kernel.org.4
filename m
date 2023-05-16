Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8C7051C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjEPPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjEPPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466440E6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95FC762A54
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57F2C433A1;
        Tue, 16 May 2023 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684250093;
        bh=a7GjnD9cBzjW1/0/iwpljCUZP6WY2SAzUWpu+dZUMvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuywaGJnETBHsbFqcC5PrZuIwrOo4pKkR6efYSdKcvyM26yEA+RFj3GyPAJ4ZzasO
         Mv0vagGgpeo9eBuiMdGwcE10fEAoahzVZ9I3WcqPozLxFou+5+HBVOIIVkcSpAhwUj
         wW4xFVl/GfugudVnkEs75SwPbQgomtgICS15Ui0aury490AD+Gxhw0B4l9RA0FyORI
         A0kRidYAnXDkeNN1LGzBHbcDtJIYI0/hr/E0pm7ZNIkXPrcu6dESDBy1D9lTHOCDvU
         0KqkxD4zMen9xvCxIgi1DHoeSw8e8eN3jbM2gOUhIPsKJYlDzH5mLZOkFVXvmUCr8J
         J/X4N1yAy9I/g==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: mark private VM_FAULT_X defines as vm_fault_t
Date:   Tue, 16 May 2023 16:14:41 +0100
Message-Id: <168424504378.603922.13211388957168018213.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230502151909.128810-1-minhuadotchen@gmail.com>
References: <20230502151909.128810-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 23:19:06 +0800, Min-Hua Chen wrote:
> This patch fixes several sparse warnings for fault.c:
> 
> arch/arm64/mm/fault.c:493:24: sparse: warning: incorrect type in return expression (different base types)
> arch/arm64/mm/fault.c:493:24: sparse:    expected restricted vm_fault_t
> arch/arm64/mm/fault.c:493:24: sparse:    got int
> arch/arm64/mm/fault.c:501:32: sparse: warning: incorrect type in return expression (different base types)
> arch/arm64/mm/fault.c:501:32: sparse:    expected restricted vm_fault_t
> arch/arm64/mm/fault.c:501:32: sparse:    got int
> arch/arm64/mm/fault.c:503:32: sparse: warning: incorrect type in return expression (different base types)
> arch/arm64/mm/fault.c:503:32: sparse:    expected restricted vm_fault_t
> arch/arm64/mm/fault.c:503:32: sparse:    got int
> arch/arm64/mm/fault.c:511:24: sparse: warning: incorrect type in return expression (different base types)
> arch/arm64/mm/fault.c:511:24: sparse:    expected restricted vm_fault_t
> arch/arm64/mm/fault.c:511:24: sparse:    got int
> arch/arm64/mm/fault.c:670:13: sparse: warning: restricted vm_fault_t degrades to integer
> arch/arm64/mm/fault.c:670:13: sparse: warning: restricted vm_fault_t degrades to integer
> arch/arm64/mm/fault.c:713:39: sparse: warning: restricted vm_fault_t degrades to integer
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: mark private VM_FAULT_X defines as vm_fault_t
      https://git.kernel.org/arm64/c/d91d58087806

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
