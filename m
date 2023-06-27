Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F021F73F8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjF0Jq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF0Jq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:46:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27900E54;
        Tue, 27 Jun 2023 02:46:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E429D2F4;
        Tue, 27 Jun 2023 02:47:38 -0700 (PDT)
Received: from [10.1.30.74] (C02Z41KALVDN.cambridge.arm.com [10.1.30.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EA303F64C;
        Tue, 27 Jun 2023 02:46:51 -0700 (PDT)
Message-ID: <b247e32a-03f0-1dbf-59e5-d7cbf90a5500@arm.com>
Date:   Tue, 27 Jun 2023 10:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 07/10] mm: Batch-zap large anonymous folio PTE mappings
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-8-ryan.roberts@arm.com>
 <CAOUHufbhVM-+zMUvHy0zeTb1ZFnDWnvD+=f6v9YxNJ_h5bjaRw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufbhVM-+zMUvHy0zeTb1ZFnDWnvD+=f6v9YxNJ_h5bjaRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 04:04, Yu Zhao wrote:
> On Mon, Jun 26, 2023 at 11:15 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> This allows batching the rmap removal with folio_remove_rmap_range(),
>> which means we avoid spuriously adding a partially unmapped folio to the
>> deferrred split queue in the common case, which reduces split queue lock
>> contention.
>>
>> Previously each page was removed from the rmap individually with
>> page_remove_rmap(). If the first page belonged to a large folio, this
>> would cause page_remove_rmap() to conclude that the folio was now
>> partially mapped and add the folio to the deferred split queue. But
>> subsequent calls would cause the folio to become fully unmapped, meaning
>> there is no value to adding it to the split queue.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/memory.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 119 insertions(+)
> 
> We don't really need this patch for the series to work. So again, I'd
> split it out.

The reason I included it in the MVP was that without it I was seeing high lock
contention for the split queue lock, which was significantly eating the
performance gains. But since then Yin Fengwei's patch to make this more
efficient has been accepted so perhaps that solves the problem and in that case
we can drop this as you suggest. If I still see a reasonable perf improvement
without it, I'll drop for v2.
