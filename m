Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413EA6C21C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCTTnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCTTnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:43:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E36DBEFB3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:38:10 -0700 (PDT)
Received: from [192.168.2.1] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9660F20FAEF5;
        Mon, 20 Mar 2023 12:37:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9660F20FAEF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679341080;
        bh=fKYHLZKDd2H0Ge/PKn5UpCU3kuN64uksgf6mWsqrbhs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f32C7TvaLrWAgaHlIhLPPD/lGE7X2qAunoZ0su/8GPJME607I1T3IrvhECd9z7qLs
         Q9d5I29c0Q+9LPmMagWEYkzzu8j1q+yrtevbjy5mo3hHSmQU75B0UTj7vw16OTwmfK
         GewRG2DMf34ipDZzx+vA5yrFbhLGucwOwIz1k5+M=
Message-ID: <6d3d512b-55e9-8205-461c-02f1e71f2b63@linux.microsoft.com>
Date:   Mon, 20 Mar 2023 20:37:56 +0100
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
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230320192504.GCZBizEGDjVtGWpNP3@fat_crate.local>
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

On 20/03/2023 20:25, Borislav Petkov wrote:
> On Mon, Mar 20, 2023 at 07:19:51PM +0000, Jeremi Piotrowski wrote:
>> The ASP table contains the memory location of the register window for
>> communication with the Platform Security Processor. The device is not
>> exposed as an acpi node, so it is necessary to probe for the table and
>> register a platform_device to represent it in the kernel.
>>
>> At least conceptually, the same PSP may be exposed on the PCIe bus as
>> well, in which case it would be necessary to choose whether to use a PCI
>> BAR or the register window defined in ASPT for communication. There is
>> no advantage to using the ACPI and there are no known bare-metal systems
>> that expose the ASP table, so device registration is restricted to the
>> only systems known to provide an ASPT: Hyper-V VMs. Hyper-V VMs also do
>> not expose the PSP over PCIe.
>>
>> This is a skeleton device at this point, as the ccp driver is not yet
>> prepared to correctly probe it. Interrupt configuration will come later
>> on as well.
>>
>> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>> ---
>>  arch/x86/kernel/Makefile |  1 +
>>  arch/x86/kernel/psp.c    | 42 ++++++++++++++++++++++++++++++++++++++++
> 
> If this is a platform device (driver), why isn't it part of
> the drivers/platform/x86/ lineup?
> 

Because of patch 4. My thinking was that the irq setup requires poking
at intimate architectural details (init_irq_alloc_info etc.) so it seems
like it fits in arch/x86.

I also drew inspiration from the sev-guest device in the arch/x86/kernel/sev.c,
which is used in a similar context (the PSP device I am registering here is
for SNP-host support).

Would you prefer it in drivers/platform/x86?

Jeremi
