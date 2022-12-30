Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A1659BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiL3UHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3UHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:07:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29D21A83E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:07:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3061261B9C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 20:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D650C433EF;
        Fri, 30 Dec 2022 20:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672430819;
        bh=yMfmMH1jzs1567jiXoyHPShvjpYvp6CVpm66CnnU34A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKq3zOov0qD+YUgVczWfQ1BNVXT8J4sx/9YqbGUsvUMXlFwA1HogL/MJbSgrxh1Ck
         kMotFLlxfKRFPjyNgtLtOAux9ZF0R0H0LYx8FH4GSgJsXQUiMLeQZMhdUXSjMBoygp
         24k2pAb69BS11fACrLc2dJG315rOLRnEyYI0rRjUdtFxplbF6AXz/eYQEDdomthGrc
         o4wZRWQiezzPdWyN8KQwDGVoRxi62FPCOYpygQo8mcahqZOOskrXZVC0Hu7SaWlMGs
         SRmpCprNjpDffA5Me726P8EcDQ/mvXMiUeRtpRi+el9bhG9RslTkuc4EYbTPrtMtQ4
         5V9VBxicUl31g==
Date:   Fri, 30 Dec 2022 22:06:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, x86@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: [PATCH] scripts/gdb: add mm introspection utils
Message-ID: <Y69E0diWostgY2pj@kernel.org>
References: <20221230163512.23736-1-dmitrii.bundin.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230163512.23736-1-dmitrii.bundin.a@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 07:35:12PM +0300, Dmitrii Bundin wrote:
> This command provides a way to traverse the entire page hierarchy by a
> given virtual address. In addition to qemu's commands info tlb/info mem
> it provides the complete information about the paging structure for an
> arbitrary virtual address. It supports 4Kb/2MB/1GB and 5 level paging.

The commit message does not mention it's x86-specific.
Not sure how gdb scripts handle per-arch functionality, but at the very
least this should be stated in the commit message.
 
> Here is an example output for 2MB success translation:
> 
> CR3:
>     CR3 BINARY DATA: 0x10c1d2002
>     NEXT ENTRY PHYSICALL ADDRESS: 0x10c1d2000
>     ---
>     PAGE LEVEL WRITE THROUGH(bit 3): False
>     PAGE LEVEL CACHE DISABLED(bit 4): False

Any particular reason to make it ALL CAPS?

> LEVEL 4:
>     ENTRY ADDRESS: 0xffff88810c1d27f0
>     PAGE ENTRY BINARY DATA: 0x8000000105dca067
>     NEXT ENTRY PHYSICALL ADDRESS: 0x105dca000
>     ---
>     ENTRY PRESENT(bit 0):      True
>     READ/WRITE ACCESS ALLOWED(bit 1): True
>     USER ACCESS ALLOWED(bit 2): True
>     PAGE LEVEL WRITE THROUGH(bit 3): False
>     PAGE LEVEL CACHE DISABLED(bit 4): False
>     ENTRY HAS BEEN ACCESSED(bit 5): True
>     PAGE SIZE(bit 7): False
>     RESTART TO ORDINARY(bit 11): False
>     EXECUTE DISABLE(bit 63): True
> LEVEL 3:
>     ENTRY ADDRESS: 0xffff888105dca9d0
>     PAGE ENTRY BINARY DATA: 0x105c87067
>     NEXT ENTRY PHYSICALL ADDRESS: 0x105c87000
>     ---
>     ENTRY PRESENT(bit 0):      True
>     READ/WRITE ACCESS ALLOWED(bit 1): True
>     USER ACCESS ALLOWED(bit 2): True
>     PAGE LEVEL WRITE THROUGH(bit 3): False
>     PAGE LEVEL CACHE DISABLED(bit 4): False
>     ENTRY HAS BEEN ACCESSED(bit 5): True
>     PAGE SIZE(bit 7): False
>     RESTART TO ORDINARY(bit 11): False
>     EXECUTE DISABLE(bit 63): False
> LEVEL 2:
>     ENTRY ADDRESS: 0xffff888105c87698
>     PAGE ENTRY BINARY DATA: 0x80000001622008e7
>     PAGE SIZE: 2MB
>     PAGE PHYSICALL ADDRESS: 0x162200000
>     ---
>     ENTRY PRESENT(bit 0):      True
>     READ/WRITE ACCESS ALLOWED(bit 1): True
>     USER ACCESS ALLOWED(bit 2): True
>     PAGE LEVEL WRITE THROUGH(bit 3): False
>     PAGE LEVEL CACHE DISABLED(bit 4): False
>     ENTRY HAS BEEN ACCESSED(bit 5): True
>     PAGE DIRTY(bit 6): True
>     PAGE SIZE(bit 7): True
>     GLOBAL TRANSLATION(bit 8): False
>     RESTART TO ORDINARY(bit 11): True
>     PAT(bit 12): False
>     PROTECTION KEY(bits (62, 59)): 0
>     EXECUTE DISABLE(bit 63): True
> 
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> ---
>  scripts/gdb/linux/mm.py    | 220 +++++++++++++++++++++++++++++++++++++
>  scripts/gdb/vmlinux-gdb.py |   1 +
>  2 files changed, 221 insertions(+)
>  create mode 100644 scripts/gdb/linux/mm.py
> 
> diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
> new file mode 100644
> index 000000000000..c6f04e74edbd
> --- /dev/null
> +++ b/scripts/gdb/linux/mm.py
> @@ -0,0 +1,220 @@
> +#
> +# gdb helper commands and functions for Linux kernel debugging
> +#
> +#  routines to introspect virtual memory

These routines introspect page tables rather than virtual memory

> +#
> +# Authors:
> +#  Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL version 2.
> +#
> +
> +import gdb
> +
> +from linux import utils
> +
> +PHYSICAL_ADDRESS_MASK = gdb.parse_and_eval('0xfffffffffffff')
> +
> +
> +def page_mask(level=1):
> +    # 4KB
> +    if level == 1:
> +        return gdb.parse_and_eval('(u64) ~0xfff')
> +    # 2MB
> +    elif level == 2:
> +        return gdb.parse_and_eval('(u64) ~0x1fffff')
> +    # 1GB
> +    elif level == 3:
> +        return gdb.parse_and_eval('(u64) ~0x3fffffff')

What will happen here with 5-level paging?

> +    else:
> +        raise Exception(f'Unknown page level: {level}')
> +
> +
> +def _page_offset_base():
> +    pob_symbol = gdb.lookup_global_symbol('page_offset_base')
> +    pob = pob_symbol.name if pob_symbol else '0xffff888000000000'

Please don't use magic numbers.

> +    return gdb.parse_and_eval(pob)
> +
> +
> +def is_bit_defined_tupled(data, offset):
> +    return offset, bool(data >> offset & 1)
> +
> +def content_tupled(data, bit_start, bit_end):
> +    return (bit_end, bit_start), data >> bit_start & ((1 << (1 + bit_end - bit_start)) - 1)
> +
> +def entry_va(level, phys_addr, translating_va):
> +        def start_bit(level):
> +            if level == 5:
> +                return 48
> +            elif level == 4:
> +                return 39
> +            elif level == 3:
> +                return 30
> +            elif level == 2:
> +                return 21
> +            elif level == 1:
> +                return 12
> +            else:
> +                raise Exception(f'Unknown level {level}')
> +
> +        entry_offset =  ((translating_va >> start_bit(level)) & 511) * 8
> +        entry_va = _page_offset_base() + phys_addr + entry_offset
> +        return entry_va
> +
> +class Cr3():
> +    def __init__(self, cr3, page_levels):
> +        self.cr3 = cr3
> +        self.page_levels = page_levels
> +        self.page_level_write_through = is_bit_defined_tupled(cr3, 3)
> +        self.page_level_cache_disabled = is_bit_defined_tupled(cr3, 4)
> +        self.next_entry_physical_address = cr3 & PHYSICAL_ADDRESS_MASK & page_mask()
> +
> +    def next_entry(self, va):
> +        next_level = self.page_levels
> +        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
> +
> +    def mk_string(self):
> +            return f"""\
> +CR3:
> +    CR3 BINARY DATA: {hex(self.cr3)}
> +    NEXT ENTRY PHYSICALL ADDRESS: {hex(self.next_entry_physical_address)}
> +    ---
> +    PAGE LEVEL WRITE THROUGH(bit {self.page_level_write_through[0]}): {self.page_level_write_through[1]}
> +    PAGE LEVEL CACHE DISABLED(bit {self.page_level_cache_disabled[0]}): {self.page_level_cache_disabled[1]}
> +"""
> +
> +
> +class PageHierarchyEntry():
> +    def __init__(self, address, level):
> +        data = int.from_bytes(
> +            memoryview(gdb.selected_inferior().read_memory(address, 8)),
> +            "little"
> +        )
> +        if level == 1:
> +            self.is_page = True
> +            self.entry_present = is_bit_defined_tupled(data, 0)
> +            self.read_write = is_bit_defined_tupled(data, 1)
> +            self.user_access_allowed = is_bit_defined_tupled(data, 2)
> +            self.page_level_write_through = is_bit_defined_tupled(data, 3)
> +            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
> +            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
> +            self.dirty = is_bit_defined_tupled(data, 6)
> +            self.pat = is_bit_defined_tupled(data, 7)
> +            self.global_translation = is_bit_defined_tupled(data, 8)
> +            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level)
> +            self.next_entry_physical_address = None
> +            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
> +            self.protection_key = content_tupled(data, 59, 62)
> +            self.executed_disable = is_bit_defined_tupled(data, 63)
> +        else:
> +            page_size = is_bit_defined_tupled(data, 7)
> +            page_size_bit = page_size[1]
> +            self.is_page = page_size_bit
> +            self.entry_present = is_bit_defined_tupled(data, 0)
> +            self.read_write = is_bit_defined_tupled(data, 1)
> +            self.user_access_allowed = is_bit_defined_tupled(data, 2)
> +            self.page_level_write_through = is_bit_defined_tupled(data, 3)
> +            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
> +            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
> +            self.page_size = page_size
> +            self.dirty = is_bit_defined_tupled(
> +                data, 6) if page_size_bit else None
> +            self.global_translation = is_bit_defined_tupled(
> +                data, 8) if page_size_bit else None
> +            self.pat = is_bit_defined_tupled(
> +                data, 12) if page_size_bit else None
> +            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level) if page_size_bit else None
> +            self.next_entry_physical_address = None if page_size_bit else data & PHYSICAL_ADDRESS_MASK & page_mask()
> +            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
> +            self.protection_key = content_tupled(data, 59, 62) if page_size_bit else None
> +            self.executed_disable = is_bit_defined_tupled(data, 63)
> +        self.address = address
> +        self.page_entry_binary_data = data
> +        self.page_hierarchy_level = level
> +
> +    def next_entry(self, va):
> +        if self.is_page or not self.entry_present[1]:
> +            return None
> +
> +        next_level = self.page_hierarchy_level - 1
> +        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
> +
> +
> +    def mk_string(self):
> +        if not self.entry_present[1]:
> +            return f"""\
> +LEVEL {self.page_hierarchy_level}:
> +    ENTRY ADDRESS: {hex(self.address)}
> +    PAGE ENTRY BINARY DATA: {hex(self.page_entry_binary_data)}
> +    ---
> +    PAGE ENTRY IS NOT PRESENT!
> +"""
> +        elif self.is_page:
> +            return f"""\
> +LEVEL {self.page_hierarchy_level}:
> +    ENTRY ADDRESS: {hex(self.address)}
> +    PAGE ENTRY BINARY DATA: {hex(self.page_entry_binary_data)}
> +    PAGE SIZE: {'1GB' if self.page_hierarchy_level == 3 else '2MB' if self.page_hierarchy_level == 2 else '4KB' if self.page_hierarchy_level == 1 else 'Unknown page size for level:' + self.page_hierarchy_level}
> +    PAGE PHYSICALL ADDRESS: {hex(self.page_physical_address)}
> +    ---
> +    ENTRY PRESENT(bit {self.entry_present[0]}):      {self.entry_present[1]}
> +    READ/WRITE ACCESS ALLOWED(bit {self.read_write[0]}): {self.read_write[1]}
> +    USER ACCESS ALLOWED(bit {self.user_access_allowed[0]}): {self.user_access_allowed[1]}
> +    PAGE LEVEL WRITE THROUGH(bit {self.page_level_write_through[0]}): {self.page_level_write_through[1]}
> +    PAGE LEVEL CACHE DISABLED(bit {self.page_level_cache_disabled[0]}): {self.page_level_cache_disabled[1]}
> +    ENTRY HAS BEEN ACCESSED(bit {self.entry_was_accessed[0]}): {self.entry_was_accessed[1]}
> +    PAGE DIRTY(bit {self.dirty[0]}): {self.dirty[1]}
> +    """ + \
> +    ("" if self.page_hierarchy_level == 1 else f"""PAGE SIZE(bit {self.page_size[0]}): {self.page_size[1]}
> +    """) + \
> +    f"""GLOBAL TRANSLATION(bit {self.global_translation[0]}): {self.global_translation[1]}
> +    RESTART TO ORDINARY(bit {self.hlat_restart_with_ordinary[0]}): {self.hlat_restart_with_ordinary[1]}
> +    PAT(bit {self.pat[0]}): {self.pat[1]}
> +    PROTECTION KEY(bits {self.protection_key[0]}): {self.protection_key[1]}
> +    EXECUTE DISABLE(bit {self.executed_disable[0]}): {self.executed_disable[1]}
> +"""
> +        else:
> +            return f"""\
> +LEVEL {self.page_hierarchy_level}:
> +    ENTRY ADDRESS: {hex(self.address)}
> +    PAGE ENTRY BINARY DATA: {hex(self.page_entry_binary_data)}
> +    NEXT ENTRY PHYSICALL ADDRESS: {hex(self.next_entry_physical_address)}
> +    ---
> +    ENTRY PRESENT(bit {self.entry_present[0]}):      {self.entry_present[1]}
> +    READ/WRITE ACCESS ALLOWED(bit {self.read_write[0]}): {self.read_write[1]}
> +    USER ACCESS ALLOWED(bit {self.user_access_allowed[0]}): {self.user_access_allowed[1]}
> +    PAGE LEVEL WRITE THROUGH(bit {self.page_level_write_through[0]}): {self.page_level_write_through[1]}
> +    PAGE LEVEL CACHE DISABLED(bit {self.page_level_cache_disabled[0]}): {self.page_level_cache_disabled[1]}
> +    ENTRY HAS BEEN ACCESSED(bit {self.entry_was_accessed[0]}): {self.entry_was_accessed[1]}
> +    PAGE SIZE(bit {self.page_size[0]}): {self.page_size[1]}
> +    RESTART TO ORDINARY(bit {self.hlat_restart_with_ordinary[0]}): {self.hlat_restart_with_ordinary[1]}
> +    EXECUTE DISABLE(bit {self.executed_disable[0]}): {self.executed_disable[1]}
> +"""
> +
> +
> +class TranslateVM(gdb.Command):
> +    """Prints the entire paging structure used to translate a given virtual address.
> +
> +Having an address space of the currently executed process translates the virtual address
> +and prints detailed information of all paging structure levels used for the transaltion."""
> +
> +    def __init__(self):
> +        super(TranslateVM, self).__init__('translate-vm', gdb.COMMAND_USER)
> +
> +    def invoke(self, arg, from_tty):
> +        if utils.is_target_arch("x86"):
> +            vm_address = gdb.parse_and_eval(f'{arg}')
> +            cr3_data = gdb.parse_and_eval('$cr3')
> +            cr4 = gdb.parse_and_eval('$cr4')
> +            page_levels = 5 if cr4 & (1 << 12) else 4
> +            page_entry = Cr3(cr3_data, page_levels)
> +            while page_entry:
> +                gdb.write(page_entry.mk_string())
> +                page_entry = page_entry.next_entry(vm_address)
> +        else:
> +            gdb.GdbError("Virtual address translation is not"
> +                         "supported for this arch")
> +
> +
> +
> +TranslateVM()
> diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> index 4136dc2c59df..27bd7339bccc 100644
> --- a/scripts/gdb/vmlinux-gdb.py
> +++ b/scripts/gdb/vmlinux-gdb.py
> @@ -37,3 +37,4 @@ else:
>      import linux.clk
>      import linux.genpd
>      import linux.device
> +    import linux.mm
> -- 
> 2.17.1
> 
> 

-- 
Sincerely yours,
Mike.
