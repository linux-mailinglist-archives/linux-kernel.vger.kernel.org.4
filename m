Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA19A6C527F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCVRdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:33:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B6AF21950;
        Wed, 22 Mar 2023 10:33:41 -0700 (PDT)
Received: from [192.168.2.24] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id C619320FB5F9;
        Wed, 22 Mar 2023 10:33:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C619320FB5F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679506420;
        bh=YKj8pBxwtU/riqXskTaWyOA0jZcj9AQzuGvPjJCa4XQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BlJF/6Vdj2pLFuNHbcrc6uACppjvORzIZPX3zgVql2+LketMx0Zkvx+2EPq90aGnK
         1QC2+3/A3+vhY5OkM5FjlJVMyIY8LCcpFxxIDUta0R0ej74sk4LbzSOrXsCIivXGGQ
         dJhABc9XTKKWM4A/LfSI/bt55TJN39vwMUD912uY=
Message-ID: <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
Date:   Wed, 22 Mar 2023 18:33:37 +0100
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
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
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

On 22/03/2023 16:46, Borislav Petkov wrote:
> On Mon, Mar 20, 2023 at 07:19:48PM +0000, Jeremi Piotrowski wrote:
>> This series is a prerequisite for nested SNP-host support on Hyper-V
> 
> I'm curious: what in the *world* is a sensible use case for doing this
> thing at all?
> 

This is actually not as crazy as it sounds.

What this does is it allows a normal (non-SNP) VM to host confidential (SNP)
VMs. I say "normal" but not every VM is going to be able to do this, it needs
to be running on AMD hardware and configured to have access to
VirtualizationExtensions, a "HardwareIsolation" capability, and given a number
of "hardware isolated guests" that it is allowed to spawn. In practice this
will result in the VM seeing a PSP device, SEV-SNP related CPUID leafs, and
have access to additional memory management instructions (rmpadjust/psmash).
This allows the rest of the of KVM-SNP support to work.

So instead of taking a bare-metal AMD server with 128 CPUs to run confidential
workloads you'll be able to provision an Azure VM with say 8 CPUs and run up to
8 SNP guests nested inside it.

It's also useful for development, I participate in the kata-containers project
where we're doing confidential-containers related work, and having access to
test VMs to run SNP guests is going to make things much easier.

If you're interested, I posted the other half of the patches required some time
back: https://lore.kernel.org/lkml/20230213103402.1189285-1-jpiotrowski@linux.microsoft.com/#t

Jeremi
