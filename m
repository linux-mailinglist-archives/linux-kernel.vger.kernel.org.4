Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313E46F4377
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjEBMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjEBMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE7310CE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FD406239C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 12:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF28C4339E;
        Tue,  2 May 2023 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683029667;
        bh=eW8ke/Mn63RwEWiRtAK4MYQo9cCYrdx9UJrJoCRyfio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUr2TB5A4aCRJCzXL676+jAIODvVN675E6ZSu/S7GHis9y/p8lARt0qFy+I2Dly7r
         n6WObxQprjldtEt1Yq1dgVJSj3rXO1XpdWGAWKQwNDrTiYZOCv+tVLnglYQVo9lWIG
         bE2JZtlgAequYMnsplhzbriuFBeh5mN+6UHJcI77jtq98ff8IhFuemBEnhEvPN2mRE
         8ick2wurBRKX6xgRDQninOVYiVPQ0x0RdlvM1fbgaIq6f1Axf4Qjo1Kxi2eFvN0Swx
         R4vpJjLNKHij1rqvLKDte+Ahtd9JUf39VKgBpO8+24GSu/uG2NW0MgBxNxt5KXnwqL
         zT5lAfSTwbcYw==
From:   Will Deacon <will@kernel.org>
To:     Fangrui Song <maskray@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: lds: move .got section out of .text
Date:   Tue,  2 May 2023 13:14:16 +0100
Message-Id: <168302779125.294142.11817759835961907319.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230502074105.1541926-1-maskray@google.com>
References: <20230502074105.1541926-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 07:41:05 +0000, Fangrui Song wrote:
> Currently, the .got section is placed within the output section .text.
> However, when .got is non-empty, the SHF_WRITE flag is set for .text
> when linked by lld. GNU ld recognizes .text as a special section and
> ignores the SHF_WRITE flag. By renaming .text, we can also get the
> SHF_WRITE flag.
> 
> The kernel has performed R_AARCH64_RELATIVE resolving very early, and can
> then assume that .got is read-only. Let's move .got to the vmlinux_rodata
> pseudo-segment.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: lds: move .got section out of .text
      https://git.kernel.org/arm64/c/0fddb79bf283

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
