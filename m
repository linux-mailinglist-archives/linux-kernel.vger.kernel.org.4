Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D445B60614F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJTNQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiJTNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:16:26 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B732E52F2;
        Thu, 20 Oct 2022 06:16:09 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 89CA3419E9CC;
        Thu, 20 Oct 2022 13:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 89CA3419E9CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666271581;
        bh=pAZAxFClnNu/Y3kZQAKw/60dmxh4WamF+LHzKbwPL38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=btD3CHu4rWZ14kMdho4Is5pcoID+y4gF/EK7nmMYqbHBLtLYW5gTLTElcZW5uBpl6
         Go1vS4+2oCm55+YRWBcsJ3nO3ZNOqP2DJ6JYZ54sGzeLJ0vLOvulw/8aWVYg9rLSFt
         TNi860eZdazuq5d0riaUAm6AYWOdMVb37cB3/9Ng=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 16:13:01 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 16/16] efi/libstub: Use memory attribute protocol
In-Reply-To: <CAMj1kXFvT4kTyMWhb-Qvwq88VuuvCDE94FCDsnAd4JqQEmPWPA@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <5de2d80398986b81b6cfcdd35436bba8bf62c0e7.1662459668.git.baskov@ispras.ru>
 <CAMj1kXFvT4kTyMWhb-Qvwq88VuuvCDE94FCDsnAd4JqQEmPWPA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <555e46a9d135218ea0a9d62fc7a74871@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-19 10:42, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Add EFI_MEMORY_ATTRIBUTE_PROTOCOL as preferred alternative to DXE
>> services for changing memory attributes in the EFISTUB.
>> 
>> Use DXE services only as a fallback in case aforementioned protocol
>> is not supported by UEFI implementation.
>> 
>> Move DXE services initialization code closer to the place they are 
>> used
>> to match EFI_MEMORY_ATTRIBUTE_PROTOCOL initialization code.
>> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  drivers/firmware/efi/libstub/mem.c      | 166 
>> ++++++++++++++++++------
>>  drivers/firmware/efi/libstub/x86-stub.c |  17 ---
>>  2 files changed, 127 insertions(+), 56 deletions(-)
>> 
>> diff --git a/drivers/firmware/efi/libstub/mem.c 
>> b/drivers/firmware/efi/libstub/mem.c
>> index 89ebc8ad2c22..8c8782993b30 100644
>> --- a/drivers/firmware/efi/libstub/mem.c
>> +++ b/drivers/firmware/efi/libstub/mem.c
>> @@ -5,6 +5,9 @@
>> 
>>  #include "efistub.h"
>> 
>> +const efi_dxe_services_table_t *efi_dxe_table;
>> +efi_memory_attribute_protocol_t *efi_mem_attrib_proto;
>> +
>>  static inline bool mmap_has_headroom(unsigned long buff_size,
>>                                      unsigned long map_size,
>>                                      unsigned long desc_size)
>> @@ -131,50 +134,32 @@ void efi_free(unsigned long size, unsigned long 
>> addr)
>>         efi_bs_call(free_pages, addr, nr_pages);
>>  }
>> 
>> -/**
>> - * efi_adjust_memory_range_protection() - change memory range 
>> protection attributes
>> - * @start:     memory range start address
>> - * @size:      memory range size
>> - *
>> - * Actual memory range for which memory attributes are modified is
>> - * the smallest ranged with start address and size aligned to 
>> EFI_PAGE_SIZE
>> - * that includes [start, start + size].
>> - *
>> - * @return: status code
>> - */
>> -efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>> -                                               unsigned long size,
>> -                                               unsigned long 
>> attributes)
>> +static void retrive_dxe_table(void)
> 
> retrieve
> 
>> +{
>> +       efi_dxe_table = 
>> get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
>> +       if (efi_dxe_table &&
>> +           efi_dxe_table->hdr.signature != 
>> EFI_DXE_SERVICES_TABLE_SIGNATURE) {
>> +               efi_warn("Ignoring DXE services table: invalid 
>> signature\n");
>> +               efi_dxe_table = NULL;
>> +       }
>> +}
>> +
>> +static efi_status_t adjust_mem_attrib_dxe(efi_physical_addr_t 
>> rounded_start,
>> +                                         efi_physical_addr_t 
>> rounded_end,
>> +                                         unsigned long attributes)
>>  {
>>         efi_status_t status;
>>         efi_gcd_memory_space_desc_t desc;
>> -       efi_physical_addr_t end, next;
>> -       efi_physical_addr_t rounded_start, rounded_end;
>> +       efi_physical_addr_t end, next, start;
>>         efi_physical_addr_t unprotect_start, unprotect_size;
>>         int has_system_memory = 0;
>> 
>> -       if (efi_dxe_table == NULL)
>> -               return EFI_UNSUPPORTED;
>> +       if (!efi_dxe_table) {
>> +               retrive_dxe_table();
> 
> Same here
> 
>> 
>> -       /*
>> -        * This function should not be used to modify attributes
>> -        * other than writable/executable.
>> -        */
>> -
>> -       if ((attributes & ~(EFI_MEMORY_RO | EFI_MEMORY_XP)) != 0)
>> -               return EFI_INVALID_PARAMETER;
>> -
>> -       /*
>> -        * Disallow simultaniously executable and writable memory
>> -        * to inforce W^X policy if direct extraction code is enabled.
>> -        */
>> -
>> -       if ((attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0 &&
>> -           IS_ENABLED(CONFIG_EFI_STUB_EXTRACT_DIRECT))
>> -               return EFI_INVALID_PARAMETER;
>> -
>> -       rounded_start = rounddown(start, EFI_PAGE_SIZE);
>> -       rounded_end = roundup(start + size, EFI_PAGE_SIZE);
>> +               if (!efi_dxe_table)
>> +                       return EFI_UNSUPPORTED;
>> +       }
>> 
>>         /*
>>          * Don't modify memory region attributes, they are
>> @@ -182,14 +167,15 @@ efi_status_t 
>> efi_adjust_memory_range_protection(unsigned long start,
>>          * encounter firmware bugs.
>>          */
>> 
>> -       for (end = start + size; start < end; start = next) {
>> +
>> +       for (start = rounded_start, end = rounded_end; start < end; 
>> start = next) {
>> 
>>                 status = efi_dxe_call(get_memory_space_descriptor,
>>                                       start, &desc);
>> 
>>                 if (status != EFI_SUCCESS) {
>>                         efi_warn("Unable to get memory descriptor at 
>> %lx\n",
>> -                                start);
>> +                                (unsigned long)start);
>>                         return status;
>>                 }
>> 
>> @@ -231,3 +217,105 @@ efi_status_t 
>> efi_adjust_memory_range_protection(unsigned long start,
>> 
>>         return EFI_SUCCESS;
>>  }
>> +
>> +static void retrive_memory_attributes_proto(void)
> 
> and here
> 
>> +{
>> +       efi_status_t status;
>> +       efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
>> +
>> +       status = efi_bs_call(locate_protocol, &guid, NULL,
>> +                            (void **)&efi_mem_attrib_proto);
>> +       if (status != EFI_SUCCESS)
>> +               efi_mem_attrib_proto = NULL;
>> +}
>> +
>> +/**
>> + * efi_adjust_memory_range_protection() - change memory range 
>> protection attributes
>> + * @start:     memory range start address
>> + * @size:      memory range size
>> + *
>> + * Actual memory range for which memory attributes are modified is
>> + * the smallest ranged with start address and size aligned to 
>> EFI_PAGE_SIZE
>> + * that includes [start, start + size].
>> + *
>> + * This function first attempts to use EFI_MEMORY_ATTRIBUTE_PROTOCOL,
>> + * that is a part of UEFI Specification since version 2.10.
>> + * If the protocol is unavailable it falls back to DXE services 
>> functions.
>> + *
>> + * @return: status code
>> + */
>> +efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>> +                                               unsigned long size,
>> +                                               unsigned long 
>> attributes)
>> +{
>> +       efi_status_t status;
>> +       efi_physical_addr_t rounded_start, rounded_end;
>> +       unsigned long attr_clear;
>> +
>> +       /*
>> +        * This function should not be used to modify attributes
>> +        * other than writable/executable.
>> +        */
>> +
>> +       if ((attributes & ~(EFI_MEMORY_RO | EFI_MEMORY_XP)) != 0)
>> +               return EFI_INVALID_PARAMETER;
>> +
>> +       /*
>> +        * Disallow simultaniously executable and writable memory
> 
> simultaneously
> 
>> +        * to inforce W^X policy if direct extraction code is enabled.
> 
> enforce
> 
>> +        */
>> +
>> +       if ((attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0 &&
>> +           IS_ENABLED(CONFIG_EFI_STUB_EXTRACT_DIRECT))
> 
> efi_adjust_memory_range_protection() is a generic routine, but here it
> depends on a x86-specific Kconfig symbol. Is that really necessary?

Since, I will make direct extraction unconditional, I will remove this 
as
well, since it will be always true.

> 
>> +               return EFI_INVALID_PARAMETER;
>> +
>> +       rounded_start = rounddown(start, EFI_PAGE_SIZE);
>> +       rounded_end = roundup(start + size, EFI_PAGE_SIZE);
>> +
>> +       if (!efi_mem_attrib_proto) {
>> +               retrive_memory_attributes_proto();
> 
> retrieve
> 
>> +
>> +               /* Fall back to DXE services if unsupported */
>> +               if (!efi_mem_attrib_proto) {
>> +                       return adjust_mem_attrib_dxe(rounded_start,
>> +                                                    rounded_end,
>> +                                                    attributes);
>> +               }
>> +       }
>> +
>> +       /*
>> +        * Unlike DXE services functions, 
>> EFI_MEMORY_ATTRIBUTE_PROTOCOL
>> +        * does not clear unset protection bit, so it needs to be 
>> cleared
>> +        * explcitly
>> +        */
>> +
>> +       attr_clear = ~attributes &
>> +                    (EFI_MEMORY_RO | EFI_MEMORY_XP | EFI_MEMORY_RP);
>> +
>> +       status = efi_call_proto(efi_mem_attrib_proto,
>> +                               clear_memory_attributes,
>> +                               rounded_start,
>> +                               rounded_end - rounded_start,
>> +                               attr_clear);
>> +       if (status != EFI_SUCCESS) {
>> +               efi_warn("Failed to clear memory attributes at 
>> [%08lx,%08lx]: %lx",
> 
> Need \n at the end here
> 
>> +                        (unsigned long)rounded_start,
>> +                        (unsigned long)rounded_end,
>> +                        status);
>> +               return status;
>> +       }
>> +
>> +       status = efi_call_proto(efi_mem_attrib_proto,
>> +                               set_memory_attributes,
>> +                               rounded_start,
>> +                               rounded_end - rounded_start,
>> +                               attributes);
>> +       if (status != EFI_SUCCESS) {
>> +               efi_warn("Failed to set memory attributes at 
>> [%08lx,%08lx]: %lx",
> 
> and here
> 
>> +                        (unsigned long)rounded_start,
>> +                        (unsigned long)rounded_end,
>> +                        status);
>> +       }
>> +
>> +       return status;
>> +}
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c 
>> b/drivers/firmware/efi/libstub/x86-stub.c
>> index 914106d547a6..dd1e1e663072 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -22,7 +22,6 @@
>>  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
>> 
>>  const efi_system_table_t *efi_system_table;
>> -const efi_dxe_services_table_t *efi_dxe_table;
>>  extern u32 image_offset;
>>  static efi_loaded_image_t *image = NULL;
>> 
>> @@ -401,15 +400,6 @@ static void setup_sections_memory_protection(void 
>> *image_base,
>>                                              unsigned long init_size)
>>  {
>>  #ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
>> -       efi_dxe_table = 
>> get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
>> -
>> -       if (!efi_dxe_table ||
>> -           efi_dxe_table->hdr.signature != 
>> EFI_DXE_SERVICES_TABLE_SIGNATURE) {
>> -               efi_warn("Unable to locate EFI DXE services table\n");
>> -               efi_dxe_table = NULL;
>> -               return;
>> -       }
>> -
>>         extern char _head[], _ehead[];
>>         extern char _compressed[], _ecompressed[];
>>         extern char _text[], _etext[];
>> @@ -791,13 +781,6 @@ unsigned long efi_main(efi_handle_t handle,
>>         if (efi_system_table->hdr.signature != 
>> EFI_SYSTEM_TABLE_SIGNATURE)
>>                 efi_exit(handle, EFI_INVALID_PARAMETER);
>> 
>> -       efi_dxe_table = 
>> get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
>> -       if (efi_dxe_table &&
>> -           efi_dxe_table->hdr.signature != 
>> EFI_DXE_SERVICES_TABLE_SIGNATURE) {
>> -               efi_warn("Ignoring DXE services table: invalid 
>> signature\n");
>> -               efi_dxe_table = NULL;
>> -       }
>> -
>>  #ifndef CONFIG_EFI_STUB_EXTRACT_DIRECT
>>         /*
>>          * If the kernel isn't already loaded at a suitable address,
>> --
>> 2.35.1
>> 

Thanks, for nitpicks, I will fix all the typos. \n's are fixed by 
Peter's patch,
so I will rely on it.
