Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD556C82ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjCXRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCXRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:10:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5E3B212BD;
        Fri, 24 Mar 2023 10:10:13 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 301FA20FC447;
        Fri, 24 Mar 2023 10:10:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 301FA20FC447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679677813;
        bh=bgmIaw8wMSWsss3W40BPK0PE6LwvUlJau2CCprtxb5E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ApLRO3o9k0dlJ9d76y1Wc0ezRYgX7lkHSFHT0b0W3AVxDVbYjkE+0L20p6ZqCiAND
         AclxT9+NdVy9U0QBpsJwdUDbIsT9vV2MFj2DmzBIz5nOB/WshsW4k/NdkL9ivJKLii
         8nMzoS7XjfpVUgq4kjpdEKqE6J92EjCBr85yCf5g=
Message-ID: <c8458bfa-0985-f6a5-52a3-ef96c7669fe6@linux.microsoft.com>
Date:   Fri, 24 Mar 2023 18:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
 <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
 <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
 <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
 <105d019c-2249-5dfd-e032-95944ea6dc8c@linux.microsoft.com>
 <20230323163450.GGZBx/qpnclFnMaf7e@fat_crate.local>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230323163450.GGZBx/qpnclFnMaf7e@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2023 5:34 PM, Borislav Petkov wrote:
> On Thu, Mar 23, 2023 at 05:11:26PM +0100, Jeremi Piotrowski wrote:
>> That same interface is exposed by physical hardware+firmware to the underlying
>> Hyper-V.
> 
> Let me see if I understand it correctly: Hyper-V *baremetal* is using
> the same ASPT spec to to talk to the *physical* PSP device?
> 

Yes

> Is that ASPT interface to talk to the PSP used by the L0 hypervisor?
> 

Yes (unless I am mistaken, this is the same statement as above).

> Or does the L0 HV have a normal driver, similar to the Linux one,
> without the functionality this ASPT spec provides?
> 
The L0 HV relies on the ASPT spec/interface to map registers and setup
interrupts and then uses a protocol driver to handle the PSP command set
(like the Linux one).

>> So it wasn't a matter of Microsoft architects coming up with a
>> guest-host interface but rather exposing the virtual hardware in the same
>> way as on a physical server.
> 
> So if you want to expose the same interface to the L1 guest, why isn't
> Hyper-V emulating an ACPI device just like any other functionality? Why
> does it need to reach into the interrupt handling internals?
> 

The primary stack for nested SNP support is Hyper-V-on-Hyper-V. 
By exposing the PSP device to the L1 guest in the same way (as the L0),
everything can done in the exact same way as on bare-metal.

I just really want nested SNP support to work in KVM-on-Hyper-V as well so
that's why I'm adding support for these things.

Also: if Linux were to run bare-metal on that hardware it would need to be
able to handle the PSP through the ASPT interface as well.

> I'd expect that the L0 HV would emulate a PSP device, the L1 would
> simply load the Linux PSP device driver and everything should just work.
> 
> What's the point of that alternate access at all?
> 

So it's actually great that you made me ask around because I learned something that
will help:

Since the AMD PSP is a privileged device, there is a desire to not have to trust the
ACPI stack, and instead rely fully on static ACPI tables for discovery and configuration.
This also applies to the AMD IOMMU. If you look at iommu_setup_intcapxt() in
drivers/iommu/amd/init.c, it does exactly the things that are needed to setup the
PSP interrupt too. Here's a link to the patch that added that:
https://lore.kernel.org/all/20201111144322.1659970-3-dwmw2@infradead.org/#t

So my plan now is to post a v4 with proper irq_domain handling.
Ok Thomas?

Best wishes,
Jeremi
