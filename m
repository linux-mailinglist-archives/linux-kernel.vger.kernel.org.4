Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5EC5E7EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiIWPmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiIWPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:41:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91DA1D6B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2ECC5CE254E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1A4C433C1;
        Fri, 23 Sep 2022 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663947654;
        bh=lz9FzHDmqblD1vhPyq+3CHEsnz/cWF+Zbtsjkwh9xDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEJ4e/7C/VuyU5AVMmslLGzGaJlBnDEw8jdVKSE6ltqQUYbAO/A8npWBRCQLQgpqK
         vo4pGzgm1Q0pY8AZ/auzyFQ5YtZYtIz8q44C53/AgtK/4wR6YH51SGNg5u5IReJ+wp
         AEqr+Cy1ht4rjcHbqatd5FBdzyy3Y1Vvud0kTaVAN56j/djpdF8/U9myb5OtWlV++N
         nCNXdZsTjZPk4+S6zwaN6sYebfzPehw0AQBzPFI7xGsL91V9zCnb1BYEzIHzfJgcBw
         FL6IwAWvREL+Ae0rijEZsIRok8/4MOa/SpCTL3aZiJ0FXrlPgc4eBDsnKDk+poQtbL
         meVvdu2Vb+Agw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Mohan Rao .vanimina" <mailtoc.mohanrao@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] vmlinux.lds.h: CFI: Reduce alignment of jump-table to function alignment
Date:   Fri, 23 Sep 2022 16:40:48 +0100
Message-Id: <166393672765.2853144.1045935840794664678.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220922215715.13345-1-will@kernel.org>
References: <20220922215715.13345-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 22:57:15 +0100, Will Deacon wrote:
> Due to undocumented, hysterical raisins on x86, the CFI jump-table
> sections in .text are needlessly aligned to PMD_SIZE in the vmlinux
> linker script. When compiling a CFI-enabled arm64 kernel with a 64KiB
> page-size, a PMD maps 512MiB of virtual memory and so the .text section
> increases to a whopping 940MiB and blows the final Image up to 960MiB.
> Others report a link failure.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] vmlinux.lds.h: CFI: Reduce alignment of jump-table to function alignment
      https://git.kernel.org/arm64/c/13b056696291

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
