Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D1E74C9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGJCUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJCUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:20:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86486103;
        Sun,  9 Jul 2023 19:20:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 304891FB;
        Sun,  9 Jul 2023 19:21:19 -0700 (PDT)
Received: from [10.162.40.20] (a077893.blr.arm.com [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E335A3F740;
        Sun,  9 Jul 2023 19:20:33 -0700 (PDT)
Message-ID: <60732ee3-f1c5-3534-29fc-783ec48f2c92@arm.com>
Date:   Mon, 10 Jul 2023 07:50:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 0/4] arm64/mm: Clean up pte_dirty() state management
To:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
 <b8bf72f4-f590-a159-ca94-526153b73216@redhat.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b8bf72f4-f590-a159-ca94-526153b73216@redhat.com>
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



On 7/7/23 17:41, David Hildenbrand wrote:
> On 07.07.23 07:33, Anshuman Khandual wrote:
>> These pte_dirty() changes make things explicitly clear, while improving the
>> code readability. This optimizes HW dirty state transfer into SW dirty bit.
>> This also adds a new arm64 documentation explaining overall pte dirty state
>> management in detail. This series applies on the latest mainline kernel.
>>
>>
> 
> I skimmed over most of the series, and I am not convinced that this is actually a cleanup. If we cannot really always differentiate between sw/hw clearing, why have separate primitives that give one the illusion that it could be done and that they are two different concepts?

These are indeed two different concepts working together, the current code just
obscures that. Without these primitives it's even hard to follow how the SW and
HW dirty parts are intertwined in implementing the generic pte_dirty() state.

The current code acknowledges these two different concepts in identifying them
i.e via pte_hw_dirty() and pte_sw_dirty().

#define pte_hw_dirty(pte)       (pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
#define pte_sw_dirty(pte)       (!!(pte_val(pte) & PTE_DIRTY))

But then falls short in demonstrating how these two states are being managed i.e
created and cleared. The first patch tries to clear the situation to some extent.

> 
> Maybe there are other opinions, but at least for me this made the code harder to grasp.
> 
> I do appreciate a doc update, though :)
These two changes also streamline HW dirty bit saving in SW dirty bit efficiently,
skipping the re-doing of HW dirty bits setting which might be cleared off. That is
the primary reason for saving it off in SW dirty bit in the first place.

  arm64/mm: Call pte_sw_mkdirty() while preserving the HW dirty state
  arm64/mm: Add pte_preserve_hw_dirty(

Regardless, I am still trying to understand how the first patch does not improve
the clarity in modifying the PTE dirty state.
