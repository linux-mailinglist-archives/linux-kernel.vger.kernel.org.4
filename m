Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E640E74D48B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjGJLZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGJLZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:25:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFA30E6;
        Mon, 10 Jul 2023 04:25:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DE3D2B;
        Mon, 10 Jul 2023 04:25:49 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.29.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D4783F67D;
        Mon, 10 Jul 2023 04:25:05 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:25:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 0/4] arm64/mm: Clean up pte_dirty() state management
Message-ID: <ZKvqjrpyLZVB3R2z@FVFF77S0Q05N>
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707053331.510041-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 11:03:27AM +0530, Anshuman Khandual wrote:
> These pte_dirty() changes make things explicitly clear, while improving the
> code readability. This optimizes HW dirty state transfer into SW dirty bit.
> This also adds a new arm64 documentation explaining overall pte dirty state
> management in detail. This series applies on the latest mainline kernel.

TBH, I think this is all swings and roundabouts, and I'm not sure this is
worthwhile. I appreciate that as-is some people find this confusing, but I
don't think the end result of this series is actually better, and it adds more
code/documentation to maintain.

In particular, I don't think that we should add Documentation/ files for this,
as it's very likely that won't be updated together with the code, and I think
it's more of a maintenance burden than a help. If we want some introductory
text to explain how the HW/SW dirty bits work, I think that should be a comment
block in <asm/pgtable.h>, clearly associated with the code.

Overall, I'd prefer to leave the code as-is.

Thanks,
Mark.

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> 
> Anshuman Khandual (4):
>   arm64/mm: Add SW and HW dirty state helpers
>   arm64/mm: Call pte_sw_mkdirty() while preserving the HW dirty state
>   arm64/mm: Add pte_preserve_hw_dirty()
>   docs: arm64: Add help document for pte dirty state management
> 
>  Documentation/arch/arm64/index.rst     |  1 +
>  Documentation/arch/arm64/pte-dirty.rst | 95 ++++++++++++++++++++++++++
>  arch/arm64/include/asm/pgtable.h       | 66 ++++++++++++++----
>  3 files changed, 147 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/arch/arm64/pte-dirty.rst
> 
> -- 
> 2.30.2
> 
