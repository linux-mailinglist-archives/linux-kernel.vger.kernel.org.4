Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D7A6C6D08
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjCWQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCWQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:11:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF2D734315;
        Thu, 23 Mar 2023 09:11:31 -0700 (PDT)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6CDBB20FBE82;
        Thu, 23 Mar 2023 09:11:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CDBB20FBE82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679587891;
        bh=tx2cEB9GJm5+/OdRlhz52+qKRfsxPBtxTkKK5gBk9rY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D0fDDhKbyTZ1n0mKv4XsiPv/YNR7QQQ41GxJ2NKkoXjynXP03g+x+g1vuCONT4Nfv
         Eu6L8TvTykhJNyY3rB1zGs5yT6TC2iJJSBFgOgOMLc3Ti2vciP+G4BGaDAjlqyDdXF
         SbZx4gfuY/G6dIN/nUvhIkuomFZ47Qjh7n6FsN3k=
Message-ID: <105d019c-2249-5dfd-e032-95944ea6dc8c@linux.microsoft.com>
Date:   Thu, 23 Mar 2023 17:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
Content-Language: en-US
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
 <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
 <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
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

On 3/23/2023 4:23 PM, Borislav Petkov wrote:
> On Thu, Mar 23, 2023 at 03:46:22PM +0100, Jeremi Piotrowski wrote:
>> Not at all. Just to be clear: this lights up all the same bits of SNP
>> as it does on bare-metal, none of it is emulated away. On bare-metal the
>> hypervisor underneath the SNP guest is unencrypted as well. Here the stack
>> is: L0 (Hyper-V), L1 (KVM) and L2 (SNP guest).
> 
> Yeah, I talked to folks after sending that email yesterday. Apparently
> it is ok to do that without compromising SNP guest security but I, in my
> eternal paranoia, somehow don't have the warm and fuzzy feeling about
> it.
> 
>> ... The communication channel between L2 guest and PSP is secured
>> using keys that the PSP injects into the SNP guest's address space at
>> launch time.
> 
> Yeah, all the levels below L2 are required to do it set up env properly
> so that L2 SNP guests can run.
> 
>> Honestly, I find it pretty cool that you can stuff a whole extra hypervisor
>> underneath the SNP guest,
> 
> Whatever floats your boat. :-)
> 
> As long as it doesn't mess up my interrupt setup code with crazy hacks.
> 
>> Not sure I follow you here. The quoted paragraph talks about what the L1
>> VM (KVM) sees. The L1 VM needs to issue PSP commands to bring up an L2 SNP
>> guest, and later the L1 VM relays SNP guest commands to the PSP. The
>> PSP commands are multiplexed to the physical PSP by the L0 hypervisor
>> (Hyper-V).
>>
>> So Hyper-V exposes a PSP to the L1 VM because it is needed and it is
>> compatible with the existing Linux driver that handles the PSP. The way
>> it is exposed (ACPI table) follows how it was specified by AMD.
> 
> No no, it was specified by Microsoft architects.
> > So, that same interface to the PSP can be done by L0 emulating
> a standard ACPI device for the KVM L1 HV and then L1 can use the normal
> ACPI interrupt #9.
> 

That same interface is exposed by physical hardware+firmware to the underlying
Hyper-V. So it wasn't a matter of Microsoft architects coming up with a
guest-host interface but rather exposing the virtual hardware in the same
way as on a physical server.

> What's the need for supplying all that other gunk like destination ID,
> interrupt vector and so on?

I'm not sure what drove the design decisions that led to the interface looking
the way it does.
What I can do is put in the work to map it into kernel constructs in the most
native way possible and in a way that doesn't look or feel like a crazy hack.

> 
> Thx.
> 

