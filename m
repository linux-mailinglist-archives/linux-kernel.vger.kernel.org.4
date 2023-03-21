Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0F6C33DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCUOQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjCUOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:16:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB5863FBA6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:15:44 -0700 (PDT)
Received: from [192.168.2.24] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2BA8820FB43F;
        Tue, 21 Mar 2023 07:15:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BA8820FB43F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679408144;
        bh=Nr87Vua9VkNv3gisRBH+jpbFzanrwR4a/aR7MlCRrNo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k3a9xnoz8aR+0CgqquUOO/8+fObM7YRIVdajbV09dNBYguaDwV2wQIQgL4hNOr4SX
         GYsYINpfn8/ysU61J2OVVTtvjMee87Vg6vnSdfrf88ihFSWhKl8qNOcRhBbKvIJ+0s
         ZrrXa7wpe1JlodpErHUa7VVGCdcJn5Wz1oRbi8fo=
Message-ID: <8ab5804c-86b9-fe7a-3879-df231531a7a2@linux.microsoft.com>
Date:   Tue, 21 Mar 2023 15:15:40 +0100
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
 <9b86ac2a-4ef9-1e98-ae5d-94b2655fbe6f@linux.microsoft.com>
 <20230320210302.GEZBjKBj+5CLCm1+Tl@fat_crate.local>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230320210302.GEZBjKBj+5CLCm1+Tl@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 22:03, Borislav Petkov wrote:
> On Mon, Mar 20, 2023 at 09:18:19PM +0100, Jeremi Piotrowski wrote:
>> I agree with you here. The irq config of this thing requires specifying
>> passing a CPU vector, this follows the hardware spec which I linked in the
>> first 2 commits, pages 13-15 here:
> 
> You mean the interrupt vector in table 19?
> 

Yes - this thing wants to receive an interrupt vector and APIC id which it will
then use to target its interrupt at.

>> https://www.amd.com/system/files/TechDocs/58028_1.00-PUB.pdf
>>
>> The only way I found to get this to work was going through x86_vector_domain
>> or statically defining a system vector (the latter felt worse).
> 
> Hmm. Why is that thing special and can't use devm_request_irq() like the
> rest of the drivers out there?
> 

Because the device is not exposed through AML (with ACPI managed irq routing)
and needs to be discovered manually and the interrupt programmed by hand.
I don't know the reasoning behind it being specified this way.

But essentially I am doing all this nasty stuff so that I get a simple irq number.
This is then passed to the actual driver that binds to the platform_device
(drivers/crypto/ccp/sp-platform.c) which uses it with devm_request_irq.

