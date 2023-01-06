Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A436605F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjAFRvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjAFRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:51:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA79A9;
        Fri,  6 Jan 2023 09:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E1B0B81E2D;
        Fri,  6 Jan 2023 17:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB78C433EF;
        Fri,  6 Jan 2023 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027443;
        bh=JidnXqA66rXAcyi/iRrqhJqmUx1EvxwCMuqpo/TYVpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8twU22HImJG5xjYm+QOJXh2UBbmAZx35y7kxhadcnMrOGbONYoQ1+zKws1gyct/q
         ti3dkIPOYx956i/rO6uR58WsWoixIXpKXD1M76Gm86ZrBvGc9FMwlXaZybvmaSuT0F
         Ycz+d8plVCYmiQA1ST3K2SY8q4F2+nEHpRqVqIj7ZYE1Riu3hvH3lUhOhTqdp23kb9
         nJTeSUEztB1sHkdSkREfRkHFy+e19sMX5G9D6LmogoKcHDF5orQy542TUDnE6FDM5w
         nlYpVysPqJKkNJUY9y73GRhMrkqGvdVAcjuPgyp2oEtM3D31GocSIxybAVC7tSxhVc
         X6P7oPvvvUhsA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, suzuki.poulose@arm.com,
        linux-doc@vger.kernel.org, lukas.bulwahn@gmail.com,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Subject: Re: [PATCH V4] arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption
Date:   Fri,  6 Jan 2023 17:50:35 +0000
Message-Id: <167302529636.216647.17992487595898822659.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230102061651.34745-1-anshuman.khandual@arm.com>
References: <20230102061651.34745-1-anshuman.khandual@arm.com>
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

On Mon, 2 Jan 2023 11:46:51 +0530, Anshuman Khandual wrote:
> If a Cortex-A715 cpu sees a page mapping permissions change from executable
> to non-executable, it may corrupt the ESR_ELx and FAR_ELx registers, on the
> next instruction abort caused by permission fault.
> 
> Only user-space does executable to non-executable permission transition via
> mprotect() system call which calls ptep_modify_prot_start() and ptep_modify
> _prot_commit() helpers, while changing the page mapping. The platform code
> can override these helpers via __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption
      https://git.kernel.org/arm64/c/5db568e748f6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
