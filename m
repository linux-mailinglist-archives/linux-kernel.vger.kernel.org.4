Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2678D624E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKJXRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKJXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:17:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 018345F87B;
        Thu, 10 Nov 2022 15:17:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF8923A;
        Thu, 10 Nov 2022 15:17:58 -0800 (PST)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14CB53F73D;
        Thu, 10 Nov 2022 15:17:50 -0800 (PST)
Message-ID: <285274e0-51bd-3334-1cb2-3af1b1aa1ba2@arm.com>
Date:   Thu, 10 Nov 2022 17:17:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/5] ACPI: PPTT: Remove acpi_find_cache_levels()
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        Peter Chen <peter.chen@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221108110424.166896-1-pierre.gondois@arm.com>
 <20221108110424.166896-4-pierre.gondois@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20221108110424.166896-4-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 05:04, Pierre Gondois wrote:
> acpi_find_cache_levels() is used at a single place and is short
> enough to be merged into the calling function. The removal allows
> an easier renaming of the calling function in the next patch.
> 
> Also reorder the parameters in the 'reversed Christmas tree' order.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

This bit looks fine too:

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>


> ---
>   drivers/acpi/pptt.c | 21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index c91342dcbcd6..97c1d33822d1 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -281,19 +281,6 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
>   	return NULL;
>   }
>   
> -static int acpi_find_cache_levels(struct acpi_table_header *table_hdr,
> -				  u32 acpi_cpu_id)
> -{
> -	int number_of_levels = 0;
> -	struct acpi_pptt_processor *cpu;
> -
> -	cpu = acpi_find_processor_node(table_hdr, acpi_cpu_id);
> -	if (cpu)
> -		number_of_levels = acpi_count_levels(table_hdr, cpu);
> -
> -	return number_of_levels;
> -}
> -
>   static u8 acpi_cache_type(enum cache_type type)
>   {
>   	switch (type) {
> @@ -613,9 +600,10 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>    */
>   int acpi_find_last_cache_level(unsigned int cpu)
>   {
> -	u32 acpi_cpu_id;
> +	struct acpi_pptt_processor *cpu_node;
>   	struct acpi_table_header *table;
>   	int number_of_levels = 0;
> +	u32 acpi_cpu_id;
>   
>   	table = acpi_get_pptt();
>   	if (!table)
> @@ -624,7 +612,10 @@ int acpi_find_last_cache_level(unsigned int cpu)
>   	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
>   
>   	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> -	number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
> +	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +	if (cpu_node)
> +		number_of_levels = acpi_count_levels(table, cpu_node);
> +
>   	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
>   
>   	return number_of_levels;

