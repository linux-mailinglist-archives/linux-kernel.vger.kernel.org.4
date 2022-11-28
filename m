Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782AF63ADA0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiK1Q2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiK1Q2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51335F0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669652779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmi6nu13LvIMZPGeEKhN8HR77ePLAWZk9LLnEOa9nLg=;
        b=byaEnzyPuTyXr0EW6PCHTn1P3ne9x/e5ItC2jCx1aztMyKduS3wtr3lpgU67+2asunOnmO
        tRDlQAkvkpDTK+SE95+ASIRkc7H35J7YtYVPVvrMuwGvUeoYK8aMWyH/Ga9UiyQp8hOATW
        9sOKgw6jpClThqxf3Y9MI/ZqBItIgPQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-IcSZ-ChMPKu07buzF2jI-Q-1; Mon, 28 Nov 2022 11:26:17 -0500
X-MC-Unique: IcSZ-ChMPKu07buzF2jI-Q-1
Received: by mail-ej1-f69.google.com with SMTP id hs42-20020a1709073eaa00b007c00fb5a509so1387946ejc.17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmi6nu13LvIMZPGeEKhN8HR77ePLAWZk9LLnEOa9nLg=;
        b=0llRAuV+bAAodZb4XGU+o6D3v0Y4+GUwUNb/OvQJdKE8HTZ12lxUi6OEn2H7+6+hDE
         dMVAcx/m+extaE8zZPTmnPBR4vae5QPIvDk207TCPwpifmfwQs50f08u3ErcRZtAbwLh
         RRKyp37NOX5Slpxt1J+Vtv3ih2RC8pS5wkRJrM+t5RpUUDJPOFnvfgppnaAGNRPPuCe3
         egaPgE39EyVniUHsD5StJF+KVajzjUGZsAnavfK42xUmsOvQS6BLJ49YA7vZzDTPbDnp
         h4pGdhvBn8Qc6xG1a8Lb6GLebJ0ra2YfRsMju0MXbZAVQrJ9BuD8BxgIiceQ8ni6wRaD
         huew==
X-Gm-Message-State: ANoB5pnHFd7CdMRkL5u2IO14NrcRWRo8VRV7FQNMQvnZF84DwlcJAMMf
        yfGBZIV24sGKUqwtq5+wOvPTxSkTr4BXaTuYLBO26KmU+AxlzS4OuSwbQ5zMMrllS87Um5gX5tV
        Rftm2qB/J+T44V2I15lc8hJAa
X-Received: by 2002:a17:906:2c5b:b0:7ae:180f:e6e with SMTP id f27-20020a1709062c5b00b007ae180f0e6emr27200674ejh.498.1669652776263;
        Mon, 28 Nov 2022 08:26:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5fARdmGR0M4Kx0ikqaSIgCg0Co5JgcwBsLnFNgAlrNAFv3JuZDz4zVMtAvZrDKn1Q2uobqFw==
X-Received: by 2002:a17:906:2c5b:b0:7ae:180f:e6e with SMTP id f27-20020a1709062c5b00b007ae180f0e6emr27200650ejh.498.1669652775980;
        Mon, 28 Nov 2022 08:26:15 -0800 (PST)
Received: from [10.43.17.4] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id la20-20020a170907781400b00782fbb7f5f7sm5106270ejc.113.2022.11.28.08.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 08:26:15 -0800 (PST)
Message-ID: <954658fd-dc20-e5f1-78b1-a70b064f7993@redhat.com>
Date:   Mon, 28 Nov 2022 17:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] arm64/mm: fix incorrect file_map_count for invalid pmd
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, Liu Shixin <liushixin2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221121073608.4183459-1-liushixin2@huawei.com>
 <20221121181859.GE7645@willie-the-truck>
From:   Denys Vlasenko <dvlasenk@redhat.com>
In-Reply-To: <20221121181859.GE7645@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 19:18, Will Deacon wrote:
> On Mon, Nov 21, 2022 at 03:36:08PM +0800, Liu Shixin wrote:
>> The page table check trigger BUG_ON() unexpectedly when split hugepage:
>>
>>   ------------[ cut here ]------------
>>   kernel BUG at mm/page_table_check.c:119!
>>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>   Dumping ftrace buffer:
>>      (ftrace buffer empty)
>>   Modules linked in:
>>   CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>>   Hardware name: linux,dummy-virt (DT)
>>   pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>   pc : page_table_check_set.isra.0+0x398/0x468
>>   lr : page_table_check_set.isra.0+0x1c0/0x468
>> [...]
>>   Call trace:
>>    page_table_check_set.isra.0+0x398/0x468
>>    __page_table_check_pte_set+0x160/0x1c0
>>    __split_huge_pmd_locked+0x900/0x1648
>>    __split_huge_pmd+0x28c/0x3b8
>>    unmap_page_range+0x428/0x858
>>    unmap_single_vma+0xf4/0x1c8
>>    zap_page_range+0x2b0/0x410
>>    madvise_vma_behavior+0xc44/0xe78
>>    do_madvise+0x280/0x698
>>    __arm64_sys_madvise+0x90/0xe8
>>    invoke_syscall.constprop.0+0xdc/0x1d8
>>    do_el0_svc+0xf4/0x3f8
>>    el0_svc+0x58/0x120
>>    el0t_64_sync_handler+0xb8/0xc0
>>    el0t_64_sync+0x19c/0x1a0
>> [...]
>>
>> On arm64, pmd_leaf() will return true even if the pmd is invalid due to
>> pmd_present_invalid() check. So in pmdp_invalidate() the file_map_count
>> will not only decrease once but also increase once. Then in set_pte_at(),
>> the file_map_count increase again, and so trigger BUG_ON() unexpectedly.
>>
>> Add !pmd_present_invalid() check in pmd_user_accessible_page() to fix the
>> problem.
>>
>> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
>> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> v1->v2: Update comment and optimize the code by moving p?d_valid() at
>> 	first place suggested by Mark.
>> v2->v3: Replace pmd_valid() with pmd_present_invalid() suggested by Will.
>>
>>   arch/arm64/include/asm/pgtable.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index edf6625ce965..17afb09f386f 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -863,7 +863,7 @@ static inline bool pte_user_accessible_page(pte_t pte)
>>   
>>   static inline bool pmd_user_accessible_page(pmd_t pmd)
>>   {
>> -	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>> +	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>>   }
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> But please see my comment on v2 about pud_user_exec() for the PUD case.

Can you be more specific? Do you ask for pud_user_exec() to be defined
and used here? Or something else?

Until this patch lands, amd64 PAGE_TABLE_CHECK + THP remains broken...

