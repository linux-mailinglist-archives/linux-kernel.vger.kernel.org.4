Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3DA6867FF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjBAOKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjBAOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:09:59 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCA305CE6B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:09:53 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 0025020B74F7; Wed,  1 Feb 2023 06:09:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0025020B74F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675260593;
        bh=BpHDMeAxSkqr/r5ajATqGfq+lFWwlQzDumLrikNSywc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRd6LZ3QFVwTPKPZj/uygOVXVFsJiFH4xChtXBAtsxvP+ojseL9py+BJ2/fPAKjJL
         Wcr5WL+e/UwLlaJDaqNirQFGoUsFd1xoDnTnRWzrB6BQwS7jqWchHOiIf+U3BR5m51
         dcJS4FC6tqvgrvkcTgCv/8H3XjnBv2bRTD40jMJs=
Date:   Wed, 1 Feb 2023 06:09:52 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v1 3/8] x86/psp: Register PSP platform device when ASP
 table is present
Message-ID: <20230201140952.GA31392@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-4-jpiotrowski@linux.microsoft.com>
 <194d8448-dde2-3452-7ccf-4e88fddbff75@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194d8448-dde2-3452-7ccf-4e88fddbff75@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:49:54PM -0600, Tom Lendacky wrote:
> On 1/23/23 09:22, Jeremi Piotrowski wrote:
> >The ASP table contains the memory location of the register window for
> >communication with the Platform Security Processor. The device is not
> >exposed as an acpi node, so it is necessary to probe for the table and
> >register a platform_device to represent it in the kernel.
> >
> >At least conceptually, the same PSP may be exposed on the PCIe bus as
> >well, in which case it would be necessary to choose whether to use a PCI
> >BAR or the register window defined in ASPT for communication. There is
> >no advantage to using the ACPI and there are no known bare-metal systems
> >that expose the ASP table, so device registration is restricted to the
> >only systems known to provide an ASPT: Hyper-V VMs. Hyper-V VMs also do
> >not expose the PSP over PCIe.
> >
> >This is a skeleton device at this point, as the ccp driver is not yet
> >prepared to correctly probe it. Interrupt configuration will come later
> >on as well.
> >
> >Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> >---
> >  arch/x86/kernel/Makefile |  2 +-
> >  arch/x86/kernel/psp.c    | 39 +++++++++++++++++++++++++++++++++++++++
> 
> Based on comments about other SEV related items, this should
> probably be moved into the arch/x86/coco/sev/ directory.
> 
> Thanks,
> Tom

I'll do that. This will make the code depend on CONFIG_ARCH_HAS_CC_PLATFORM
and CONFIG_AMD_MEM_ENCRYPT, the latter selects the former. This will work
as long as CONFIG_AMD_MEM_ENCRYPT continues to be needed for both SNP guest
and host sides.

Jeremi

> 
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/x86/kernel/psp.c
> >
> >diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> >index f901658d9f7c..e2e19f2d08a7 100644
> >--- a/arch/x86/kernel/Makefile
> >+++ b/arch/x86/kernel/Makefile
> >@@ -139,7 +139,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
> >  obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
> >  obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
> >-obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
> >+obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= psp.o sev.o
> >  obj-$(CONFIG_CFI_CLANG)			+= cfi.o
> >diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
> >new file mode 100644
> >index 000000000000..d404df47cc04
> >--- /dev/null
> >+++ b/arch/x86/kernel/psp.c
> >@@ -0,0 +1,39 @@
> >+// SPDX-License-Identifier: GPL-2.0-only
> >+
> >+#include <linux/platform_data/psp.h>
> >+#include <linux/platform_device.h>
> >+#include <asm/hypervisor.h>
> >+
> >+static struct platform_device psp_device = {
> >+	.name           = "psp",
> >+	.id             = PLATFORM_DEVID_NONE,
> >+};
> >+
> >+static int __init psp_init_platform_device(void)
> >+{
> >+	struct psp_platform_data pdata = {};
> >+	struct resource res[1];
> >+	int err;
> >+
> >+	/*
> >+	 * The ACPI PSP interface is mutually exclusive with the PCIe interface,
> >+	 * but there is no reason to use the ACPI interface over the PCIe one.
> >+	 * Restrict probing ACPI PSP to platforms known to only expose the ACPI
> >+	 * interface, which at this time is SNP-host capable Hyper-V VMs.
> >+	 */
> >+	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> >+		return -ENODEV;
> >+
> >+	err = acpi_parse_aspt(res, &pdata);
> >+	if (err)
> >+		return err;
> >+	err = platform_device_add_resources(&psp_device, res, 1);
> >+	if (err)
> >+		return err;
> >+
> >+	err = platform_device_register(&psp_device);
> >+	if (err)
> >+		return err;
> >+	return 0;
> >+}
> >+device_initcall(psp_init_platform_device);
