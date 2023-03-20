Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E576C226A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCTUSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCTUSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:18:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B037E2A98D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:18:24 -0700 (PDT)
Received: from [192.168.2.1] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id B420B20FAEF9;
        Mon, 20 Mar 2023 13:18:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B420B20FAEF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679343503;
        bh=19cxAa5JropGxFJ2QMy34nCRCKBRgMKBM8Me8JoU5nA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=koW0O41c1Ths+6WM7MFXNFuxwap8MXNW22UZFUOGtskJdfu4gtZiVRwxF+PEjqaYx
         TYZQ/qkv1jO0QSpZ4jEhLxs3e/2UCsBlWrVe+RAEsI0hEPRW1YFRYZvTlgV4UTHUHG
         00z+MKZ6GW4FEgedSwWiLshj2Ohpl1t7L57ASltc=
Message-ID: <9b86ac2a-4ef9-1e98-ae5d-94b2655fbe6f@linux.microsoft.com>
Date:   Mon, 20 Mar 2023 21:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/8] x86/psp: Register PSP platform device when ASP
 table is present
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230320191956.1354602-4-jpiotrowski@linux.microsoft.com>
 <20230320192504.GCZBizEGDjVtGWpNP3@fat_crate.local>
 <6d3d512b-55e9-8205-461c-02f1e71f2b63@linux.microsoft.com>
 <20230320200321.GDZBi8CXCyE6kD7qSN@fat_crate.local>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230320200321.GDZBi8CXCyE6kD7qSN@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 21:03, Borislav Petkov wrote:
> On Mon, Mar 20, 2023 at 08:37:56PM +0100, Jeremi Piotrowski wrote:
>> Because of patch 4. My thinking was that the irq setup requires poking
>> at intimate architectural details (init_irq_alloc_info etc.) so it seems
>> like it fits in arch/x86.
> 
> arch/x86/platform/uv/uv_irq.c:193:      init_irq_alloc_info(&info, cpumask_of(cpu));
> drivers/iommu/amd/init.c:2391:  init_irq_alloc_info(&info, NULL);
> 
> Also, what patch 4's commit message says, sounds hacky to me. A simple
> driver should not need the x86_vector_domain. Especially if it is some
> ACPI wrapper around the PSP hw.
 
I agree with you here. The irq config of this thing requires specifying
passing a CPU vector, this follows the hardware spec which I linked in the
first 2 commits, pages 13-15 here:

https://www.amd.com/system/files/TechDocs/58028_1.00-PUB.pdf

The only way I found to get this to work was going through x86_vector_domain
or statically defining a system vector (the latter felt worse).

> 
> But I'd leave that to tglx.
>>> I also drew inspiration from the sev-guest device in the arch/x86/kernel/sev.c,
> 
> Yeah, we've designed another mess there considering we already have
> 
> drivers/virt/coco/sev-guest/sev-guest.c
> 
> That sev guest thing has no place in sev.c and it should go away from
> there.
> 
>> which is used in a similar context (the PSP device I am registering here is
>> for SNP-host support).
>>
>> Would you prefer it in drivers/platform/x86?
> 
> drivers/hv/?
> 
> Seeing how hyperv is the only thing that's going to use it, AFAICT.
> 
 
That could work, let me try that.
