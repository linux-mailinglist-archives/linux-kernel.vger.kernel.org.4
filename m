Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C486C6B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCWOqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjCWOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:46:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C23E24730;
        Thu, 23 Mar 2023 07:46:26 -0700 (PDT)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id B267820FC068;
        Thu, 23 Mar 2023 07:46:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B267820FC068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679582785;
        bh=M39nxlqXkoyUrlklh46rqj7I8AqHEUzbGTrOkDu6MUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BbR54qJcpPIqdDFc8GoIEc90FLeMzU9Oh0pqv/i4xyh8yJ6QkWZTuEy147ludwpQ7
         5g5QRFSpSBDtGNwdl4MSky+N1wnYeFFQEgyvRll8xjLawuGFP8qUM7+EagaX7rHOet
         keqnY1InTIWg+M2CrfepNr84M8wMxaKsWROyJ/C0=
Message-ID: <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
Date:   Thu, 23 Mar 2023 15:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
 <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
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

On 3/22/2023 7:15 PM, Borislav Petkov wrote:
> On Wed, Mar 22, 2023 at 06:33:37PM +0100, Jeremi Piotrowski wrote:
>> What this does is it allows a normal (non-SNP) VM to host confidential (SNP)
>> VMs. I say "normal" but not every VM is going to be able to do this, it needs
> 
> If you say "non-SNP" VM then this sounds like purely for development.
> Because I cannot see how you're going to give the confidentiality
> guarantee to the SNP guests if the lower level is unencrypted, non-SNP
> and so on...

Not at all. Just to be clear: this lights up all the same bits of SNP
as it does on bare-metal, none of it is emulated away. On bare-metal the
hypervisor underneath the SNP guest is unencrypted as well. Here the stack
is: L0 (Hyper-V), L1 (KVM) and L2 (SNP guest).

Starting an SNP guest is the same and involves sending commands to the PSP:
* SNP_GCTX_CREATE
* SNP_LAUNCH_START
* SNP_LAUNCH_UPDATE
* SNP_LAUNCH_FINISH

Pages need to be assigned to a specific L2 SNP guest in the system-wide
"reverse map table", at which point neither L0 nor L1 hypervisor can touch
them. Every L2 SNP guests memory is encrypted with a different key, and the
SNP guest can fetch a hardware signed attestation report from the PSP that
includes a hash of all the pages that were loaded (and encrypted) into the
VM address space at the time the VM was launched. The communication channel
between L2 guest and PSP is secured using keys that the PSP injects into the
SNP guest's address space at launch time.

Honestly, I find it pretty cool that you can stuff a whole extra hypervisor
underneath the SNP guest, and the hardware will still ensure and attest to
the fact that neither hypervisor is able to compromise the integrity and
confidentiality of the VM enclave. And you can verify this claim independently.

> 
>> to be running on AMD hardware and configured to have access to
>> VirtualizationExtensions, a "HardwareIsolation" capability, and given a number
>> of "hardware isolated guests" that it is allowed to spawn. In practice this
>> will result in the VM seeing a PSP device, SEV-SNP related CPUID
>> leafs, and have access to additional memory management instructions
>> (rmpadjust/psmash).  This allows the rest of the of KVM-SNP support to
>> work.
> 
> So why don't you emulate the PSP in KVM instead of doing some BIOS hack?
> And multiplex the access to it between all the parties needing it?
> 

Not sure I follow you here. The quoted paragraph talks about what the L1
VM (KVM) sees. The L1 VM needs to issue PSP commands to bring up an L2 SNP
guest, and later the L1 VM relays SNP guest commands to the PSP. The
PSP commands are multiplexed to the physical PSP by the L0 hypervisor
(Hyper-V).

So Hyper-V exposes a PSP to the L1 VM because it is needed and it is
compatible with the existing Linux driver that handles the PSP. The way
it is exposed (ACPI table) follows how it was specified by AMD.

