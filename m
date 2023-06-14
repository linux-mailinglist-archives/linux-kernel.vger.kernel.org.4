Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92472F46D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbjFNGKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjFNGKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:10:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19DC9E55
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:10:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E571FB;
        Tue, 13 Jun 2023 23:11:01 -0700 (PDT)
Received: from [10.162.42.149] (a077209.arm.com [10.162.42.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9093F71E;
        Tue, 13 Jun 2023 23:10:14 -0700 (PDT)
Message-ID: <7364a4fd-e1ad-9003-2a89-deb0c23c0edf@arm.com>
Date:   Wed, 14 Jun 2023 11:40:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Documentation/arm64: Add ptdump documentation
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
References: <20230613064845.1882177-1-chaitanyas.prakash@arm.com>
 <5e003504-8224-8441-c1d5-a4e3327bdcc8@infradead.org>
Content-Language: en-US
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
In-Reply-To: <5e003504-8224-8441-c1d5-a4e3327bdcc8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/23 04:34, Randy Dunlap wrote:
> Hi--
> 
> On 6/12/23 23:48, Chaitanya S Prakash wrote:
>> ptdump is a debugfs interface used to dump the kernel page tables. It
>> provides a comprehensive overview about the kernel's virtual memory
>> layout, page table entries and associated page attributes. A document
>> detailing how to enable ptdump in the kernel and analyse its output has
>> been added.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> CC: linux-arm-kernel@lists.infradead.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>> ---
>>   Documentation/arm64/index.rst  |  1 +
>>   Documentation/arm64/ptdump.rst | 94 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 95 insertions(+)
>>   create mode 100644 Documentation/arm64/ptdump.rst
>>
>> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
>> index ae21f8118830..e0bda3ec2090 100644
>> --- a/Documentation/arm64/index.rst
>> +++ b/Documentation/arm64/index.rst
>> @@ -15,6 +15,7 @@ ARM64 Architecture
>>       cpu-feature-registers
>>       elf_hwcaps
>>       hugetlbpage
>> +    ptdump
>>       legacy_instructions
>>       memory
>>       memory-tagging-extension
>> diff --git a/Documentation/arm64/ptdump.rst b/Documentation/arm64/ptdump.rst
>> new file mode 100644
>> index 000000000000..296a5fe217b0
>> --- /dev/null
>> +++ b/Documentation/arm64/ptdump.rst
>> @@ -0,0 +1,94 @@
>> +======================
>> +Kernel page table dump
>> +======================
>> +
>> +ptdump is a debugfs interface that provides a detailed dump of the kernel's
>> +page tables. It offers a comprehensive overview of the kernel’s virtual
>> +memory layout as well as the attributes associated with the various regions
>> +in a human-readable format. It is useful to dump the kernel page tables to
>> +verify permissions and memory types. Examining the page table entries and
>> +permissions helps identify potential security vulnerabilities such as
>> +mappings with overly permissive access rights or improper memory
>> +protections.
>> +
>> +Memory hotplug allows dynamic expansion or contraction of available memory
>> +without requiring a system reboot. To maintain consistency and integrity of
>> +memory management data structures, arm64 makes use of mem_hotplug_lock in
>> +write mode. Additionally, in read mode mem_hotplug_lock supports efficient
>> +implementation of get_online_mems and put_online_mems. This protects the
>> +offlining of memory being accessed by code.
>> +
>> +In order to dump the kernel page tables you will need to have the following
>> +configurations enabled and follow it up by mounting debugfs.::
>> +
>> + CONFIG_GENERIC_PTDUMP=y
>> + CONFIG_PTDUMP_CORE=y
>> + CONFIG_PTDUMP_DEBUGFS=y
>> +
>> + mount -t debugfs nodev /sys/kernel/debug
>> + cat /sys/kernel/debug/kernel_page_tables
>> +
>> +On analysing the output of cat /sys/kernel/debug/kernel_page_tables you can
> 
> Preferably quote the command.
> This says kernel_page_tables but below it is 'kernel_page_table'.
> Which is correct?

The correct command is cat /sys/kernel/debug/kernel_page_tables. Sorry 
for the confusion! I'll correct the one below.
> 
>> +derive information about the virtual address range of the entry, followed
>> +by size of the memory region covered by this entry, the hierarchical
>> +structure of the page tables and finally the attributes associated with
>> +each page. The page attributes provide information about access permissions,
>> +execution capability, type of mapping such as leaf level PTE or block level
>> +PGD, PMD and PUD, and access status of a page within the kernel memory.
>> +Assessing these attributes can assist in understanding the memory layout,
>> +access patterns, and security characteristics of the kernel pages.
>> +
>> +Kernel virtual memory layout::
>> +
> 
> Is this memory layout arm64-specific or generic?

Yes, it's arm64-specific
> 
>> + start address        end address         size             attributes
>> + +---------------------------------------------------------------------------------------+
>> + | ---[ Linear Mapping start ]---------------------------------------------------------- |
>> + | ..................                                                                    |
>> + | 0xfff0000000000000-0xfff0000000210000  2112K PTE RW NX SHD AF  UXN  MEM/NORMAL-TAGGED |
>> + | 0xfff0000000210000-0xfff0000001c00000 26560K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
>> + | ..................                                                                    |
>> + | ---[ Linear Mapping end ]------------------------------------------------------------ |
>> + +---------------------------------------------------------------------------------------+
>> + | ---[ Modules start ]----------------------------------------------------------------- |
>> + | ..................                                                                    |
>> + | 0xffff800000000000-0xffff800008000000   128M PTE                                      |
>> + | ..................                                                                    |
>> + | ---[ Modules end ]------------------------------------------------------------------- |
>> + +---------------------------------------------------------------------------------------+
>> + | ---[ vmalloc() area ]---------------------------------------------------------------- |
>> + | ..................                                                                    |
>> + | 0xffff800008010000-0xffff800008200000  1984K PTE ro x  SHD AF       UXN  MEM/NORMAL   |
>> + | 0xffff800008200000-0xffff800008e00000    12M PTE ro x  SHD AF  CON  UXN  MEM/NORMAL   |
>> + | ..................                                                                    |
>> + | ---[ vmalloc() end ]----------------------------------------------------------------- |
>> + +---------------------------------------------------------------------------------------+
>> + | ---[ Fixmap start ]------------------------------------------------------------------ |
>> + | ..................                                                                    |
>> + | 0xfffffbfffdb80000-0xfffffbfffdb90000    64K PTE ro x  SHD AF  UXN  MEM/NORMAL        |
>> + | 0xfffffbfffdb90000-0xfffffbfffdba0000    64K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
>> + | ..................                                                                    |
>> + | ---[ Fixmap end ]-------------------------------------------------------------------- |
>> + +---------------------------------------------------------------------------------------+
>> + | ---[ PCI I/O start ]----------------------------------------------------------------- |
>> + | ..................                                                                    |
>> + | 0xfffffbfffe800000-0xfffffbffff800000    16M PTE                                      |
>> + | ..................                                                                    |
>> + | ---[ PCI I/O end ]------------------------------------------------------------------- |
>> + +---------------------------------------------------------------------------------------+
>> + | ---[ vmemmap start ]----------------------------------------------------------------- |
>> + | ..................                                                                    |
>> + | 0xfffffc0002000000-0xfffffc0002200000     2M PTE RW NX SHD AF  UXN  MEM/NORMAL        |
>> + | 0xfffffc0002200000-0xfffffc0020000000   478M PTE                                      |
>> + | ..................                                                                    |
>> + | ---[ vmemmap end ]------------------------------------------------------------------- |
>> + +---------------------------------------------------------------------------------------+
>> +
>> +cat /sys/kernel/debug/kernel_page_table::
>> +
>> + 0xfff0000001c00000-0xfff0000080000000     2020M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
>> + 0xfff0000080000000-0xfff0000800000000       30G PMD
>> + 0xfff0000800000000-0xfff0000800700000        7M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
>> + 0xfff0000800700000-0xfff0000800710000       64K PTE  ro NX SHD AF   UXN    MEM/NORMAL-TAGGED
>> + 0xfff0000800710000-0xfff0000880000000  2089920K PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
>> + 0xfff0000880000000-0xfff0040000000000     4062G PMD
>> + 0xfff0040000000000-0xffff800000000000     3964T PGD
> 
> thanks.
