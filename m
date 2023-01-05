Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03E65F361
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjAESFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjAESEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:04:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD95B143
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30C8BB81BAE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408FC433F1;
        Thu,  5 Jan 2023 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672941850;
        bh=QCi7wtFSc3BwnYLMiq3LfClZGlHul4KVKjN8n+mWdkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jV3l0BppTq4GP8ygsks+r5ktF3poi1JXjT5DAjc76p4iKbeFRxvTzxsujLidElrLl
         YM9xR83D87bdQe0ZKlDpJm40BoGP1/Zf8NMmRdqfbPEJneAyBXzEAQTltULXpxa/GW
         dIAo7zkz1L/3mnPek4L33kFIHG6hv6HopGPPfLARDVa+AQEOetl/mH6Vu8TMIh4tOe
         UgtE0xCdP67ArYQddl9i8at9eLMMfPM3+hNJc5nEGXvEZanTQuG/qbwjFN5p11xUuD
         Y1vkb6G4K0kiiwYbKoIEo1zv3DVtKWcXnm21603KnRF3UI3NKKBYJz/nLFZKzY0TWi
         uBdUyP2yFsI6Q==
From:   Will Deacon <will@kernel.org>
To:     guo.ziliang@zte.com.cn
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, lkp@intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huang.junhua@zte.com.cn
Subject: Re: [PATCH] arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning
Date:   Thu,  5 Jan 2023 18:03:57 +0000
Message-Id: <167293236954.1466313.6328356338655300899.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <202212280954121197626@zte.com.cn>
References: <202212280954121197626@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 09:54:12 +0800 (CST), guo.ziliang@zte.com.cn wrote:
> From: junhua huang <huang.junhua@zte.com.cn>
> 
> After we fixed the uprobe inst endian in aarch_be, the sparse check report
> the following warning info:
> 
> sparse warnings: (new ones prefixed by >>)
> >> kernel/events/uprobes.c:223:25: sparse: sparse: restricted __le32 degrades to integer
> >> kernel/events/uprobes.c:574:56: sparse: sparse: incorrect type in argument 4 (different base types)
> @@     expected unsigned int [addressable] [usertype] opcode @@     got restricted __le32 [usertype] @@
>    kernel/events/uprobes.c:574:56: sparse:     expected unsigned int [addressable] [usertype] opcode
>    kernel/events/uprobes.c:574:56: sparse:     got restricted __le32 [usertype]
> >> kernel/events/uprobes.c:1483:32: sparse: sparse: incorrect type in initializer (different base types)
> @@     expected unsigned int [usertype] insn @@     got restricted __le32 [usertype] @@
>    kernel/events/uprobes.c:1483:32: sparse:     expected unsigned int [usertype] insn
>    kernel/events/uprobes.c:1483:32: sparse:     got restricted __le32 [usertype]
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning
      https://git.kernel.org/arm64/c/ef08c0fadd8a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
