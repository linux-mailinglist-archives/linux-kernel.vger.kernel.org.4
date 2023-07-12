Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE074FE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGLEBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLEBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:01:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DE5110EF;
        Tue, 11 Jul 2023 21:01:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F5B32F4;
        Tue, 11 Jul 2023 21:02:27 -0700 (PDT)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22DE73F740;
        Tue, 11 Jul 2023 21:01:41 -0700 (PDT)
Message-ID: <8a7416df-1656-8380-9a42-1af3cd940f97@arm.com>
Date:   Wed, 12 Jul 2023 09:31:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 0/4] arm64/mm: Clean up pte_dirty() state management
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
 <ZKvqjrpyLZVB3R2z@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZKvqjrpyLZVB3R2z@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 16:55, Mark Rutland wrote:
> On Fri, Jul 07, 2023 at 11:03:27AM +0530, Anshuman Khandual wrote:
>> These pte_dirty() changes make things explicitly clear, while improving the
>> code readability. This optimizes HW dirty state transfer into SW dirty bit.
>> This also adds a new arm64 documentation explaining overall pte dirty state
>> management in detail. This series applies on the latest mainline kernel.
> TBH, I think this is all swings and roundabouts, and I'm not sure this is
> worthwhile. I appreciate that as-is some people find this confusing, but I

Current situation for pte_dirty() management is confusing when there are two
distinct mechanisms to track PTE dirty states, but both are forced to work
together because

- HW DBM cannot track non-writable dirty state (PTE_DBM == PTE_WRITE)
- Runtime check for HW DBM is avoided

> don't think the end result of this series is actually better, and it adds more
> code/documentation to maintain.

Agreed, it does add more code and documentation but still trying to understand
why it is not worthwhile. Regardless, following patch does optimize a situation
where we dont need to call pte_mkdirty() knowing it will be cleared afterwards.

[RFC 2/4] arm64/mm: Call pte_sw_mkdirty() while preserving the HW dirty state

> 
> In particular, I don't think that we should add Documentation/ files for this,
> as it's very likely that won't be updated together with the code, and I think
> it's more of a maintenance burden than a help. If we want some introductory

There are many documentation files such as Documentation/arm64/memory.rst which
needs to be updated when kernel virtual address layout changes again. I am just
wondering - should not there be any documentation for internal implementation
details, just because they need updating with code changes.

> text to explain how the HW/SW dirty bits work, I think that should be a comment
> block in <asm/pgtable.h>, clearly associated with the code.

Sure, will add that.

> 
> Overall, I'd prefer to leave the code as-is.
Even if we discount individual dirty clearing functions, why should not HW dirty
bit transfer to SW dirty be optimized and wrapped around in a helper.
