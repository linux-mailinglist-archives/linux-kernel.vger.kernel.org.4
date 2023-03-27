Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35486CAA93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjC0QaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0QaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B31BF8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A521361345
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E01C433EF;
        Mon, 27 Mar 2023 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679934601;
        bh=z8Axy2jhFhvVh2ZiGMT1gqklNpyGzWm7cQGzH79T/pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N37FXh2bg8zB5q2/YscYnl0ciPlS+M31qRFBW2Bed7S5crJMhAPZdRcpHFaFXxQvF
         EurYSxT/i5zJwLxjWK0ubb9/SCBBJF3nsX3mvRJFuS5S8JzRJUtKNENud6OpToEjjz
         tr/KDT50zcawFxqemU1PHFEbzLFWTNAnq/L5b71/5w58UHTw3FjjJhVhm0163wtRA5
         tIIoTYXNDdJkE1Gp1jsnzuTvs0BOjT+8ld4xRhZTY0a5jmd+Ffvz2JnEmwM3x853Qp
         0lWuw76mTn3laFa4nHOvjXywXRRtsuhyu96BA7CpLMAH7dqy7b03nw7iqHrByv+g8s
         srrBxqIrnlRQA==
From:   Will Deacon <will@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ira Weiny <ira.weiny@intel.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] COVER: Remove memcpy_page_flushcache()
Date:   Mon, 27 Mar 2023 17:29:52 +0100
Message-Id: <167993078034.2286694.14271528066937024301.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
References: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 16:20:53 -0700, Ira Weiny wrote:
> Commit 21b56c847753 ("iov_iter: get rid of separate bvec and xarray
> callbacks") removed the calls to memcpy_page_flushcache().
> 
> kmap_atomic() is deprecated and used in the x86 version of
> memcpy_page_flushcache().
> 
> Remove the unnecessary memcpy_page_flushcache() call from all arch's.
> 
> [...]

Applied arm64 patch to arm64 (for-next/mm), thanks!

[3/3] arm: uaccess: Remove memcpy_page_flushcache()
      https://git.kernel.org/arm64/c/7cae569e6209

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
