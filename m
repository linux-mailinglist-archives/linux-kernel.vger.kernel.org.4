Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951756DFB69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDLQcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:32:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784354228
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:32:46 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C7F231EC053F;
        Wed, 12 Apr 2023 18:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681317164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpWXZ+mv7YkcX+3A9xr3Q6aXomGSfAuTXdWkffnu7og=;
        b=MRQkreMo4lyPHhNYinJZJukj99St0Pz9ZneL3TwQ/onR0p/ScfQRFwpA+SA+toaqIEXaXh
        fPB9VES7n7zkIzTst2MSVeBMvTGOk6Jx0sHNFXIE8Aa48xbyUeRvJnA9CeGtbu5c+I7gn9
        nSYc7g3jDP7VopgoCRvCfyRdZ0NDeHM=
Date:   Wed, 12 Apr 2023 18:32:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: AMD EPYC 25 (19h): Hardware Error: Machine Check: 0 Bank 17:
 d42040000000011b
Message-ID: <20230412163240.GAZDbdKHjmQcxqkeDQ@fat_crate.local>
References: <21a09968-296b-5b21-8079-6d9d4e0769d4@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21a09968-296b-5b21-8079-6d9d4e0769d4@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 05:11:26PM +0200, Paul Menzel wrote:
> On a Dell PowerEdge R7525 with AMD EPYC 7763 64-Core Processor, Linux
> 5.15.94 logs the machine check exceptions (MCE) below:
> 
> ```
> [5154053.127240] mce: [Hardware Error]: Machine check events logged
> [5154053.133711] mce: [Hardware Error]: CPU 3: Machine Check: 0 Bank 17:
> d42040000000011b
> [5154053.141948] mce: [Hardware Error]: TSC 0 ADDR b3cbdbbc0 PPIN
> 2b615bef7f48098 SYND 6bd210000a801002 IPID 9600650f00

Build the latest kernel with CONFIG_X86_MCE_INJECT and
CONFIG_EDAC_DECODE_MCE enabled and CONFIG_RAS_CEC *disabled*. Then boot
it on that machine with and do the following below.

The files are in debugfs:

/sys/kernel/debug/mce-inject/
├── addr
├── bank
├── cpu
├── flags
├── ipid
├── misc
├── README
├── status
└── synd

so you go and do

echo 0xd42040000000011b > status
echo 0xb3cbdbbc0 > addr
echo 3 > cpu
echo "sw" > flags
echo 0x6bd210000a801002 > synd
echo 0x9600650f00 > ipid
echo 17 > bank

Remember to keep the bank write last because this one injects the error.

It should dump the decoded error in dmesg.

Alternatively, if you have CONFIG_EDAC_DECODE_MCE enabled on the
machine and you boot with "ras=cec_disable", it would decode it
automatically so you don't have to do it yourself.

Below's the full help text how to do the injection.

And yeah, I know, this is not a very user-friendly way how to decode
those but we're working on one...

HTH.

static const char readme_msg[] =
"Description of the files and their usages:\n"
"\n"
"Note1: i refers to the bank number below.\n"
"Note2: See respective BKDGs for the exact bit definitions of the files below\n"
"as they mirror the hardware registers.\n"
"\n"
"status:\t Set MCi_STATUS: the bits in that MSR control the error type and\n"
"\t attributes of the error which caused the MCE.\n"
"\n"
"misc:\t Set MCi_MISC: provide auxiliary info about the error. It is mostly\n"
"\t used for error thresholding purposes and its validity is indicated by\n"
"\t MCi_STATUS[MiscV].\n"
"\n"
"synd:\t Set MCi_SYND: provide syndrome info about the error. Only valid on\n"
"\t Scalable MCA systems, and its validity is indicated by MCi_STATUS[SyndV].\n"
"\n"
"addr:\t Error address value to be written to MCi_ADDR. Log address information\n"
"\t associated with the error.\n"
"\n"
"cpu:\t The CPU to inject the error on.\n"
"\n"
"bank:\t Specify the bank you want to inject the error into: the number of\n"
"\t banks in a processor varies and is family/model-specific, therefore, the\n"
"\t supplied value is sanity-checked. Setting the bank value also triggers the\n"
"\t injection.\n"
"\n"
"flags:\t Injection type to be performed. Writing to this file will trigger a\n"
"\t real machine check, an APIC interrupt or invoke the error decoder routines\n"
"\t for AMD processors.\n"
"\n"
"\t Allowed error injection types:\n"
"\t  - \"sw\": Software error injection. Decode error to a human-readable \n"
"\t    format only. Safe to use.\n"
"\t  - \"hw\": Hardware error injection. Causes the #MC exception handler to \n"
"\t    handle the error. Be warned: might cause system panic if MCi_STATUS[PCC] \n"
"\t    is set. Therefore, consider setting (debugfs_mountpoint)/mce/fake_panic \n"
"\t    before injecting.\n"
"\t  - \"df\": Trigger APIC interrupt for Deferred error. Causes deferred \n"
"\t    error APIC interrupt handler to handle the error if the feature is \n"
"\t    is present in hardware. \n"
"\t  - \"th\": Trigger APIC interrupt for Threshold errors. Causes threshold \n"
"\t    APIC interrupt handler to handle the error. \n"
"\n"
"ipid:\t IPID (AMD-specific)\n"
"\n";

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
