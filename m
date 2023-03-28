Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFAD6CC1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjC1OBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjC1OBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:01:12 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7867AF30
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:59:58 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 32SDx6ae157134
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 28 Mar 2023 06:59:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 32SDx6ae157134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023030901; t=1680011948;
        bh=gP28gv/jCy9wsN4Hf9bS93nfHODn1Dw2HQPpKUNAs0I=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=LaFl1cmFAWdJVBpapKZDpR9M0uz7bpSDpc/y9BTyNT+/jIz7rekDG9Ltan9KNBtwP
         OHEexQRfDgwCzaMPq6kjQdgV4PKe28ZaXrWVQnk7t2ON/hzc4Lc2qGfiRg6NYVmn9d
         0HCahYNPkZrzPcJDJv+NEQ62lPkOb/v54eRGcpcHY3EcmSNRf9Ea5MLnA+pEBmS7as
         J+eRBqju4bDreOPUB7x/v5QrAOpJl/LwzoPIn4pQO+QAMSBllkzed6e+Xjw+B94150
         LCA0ijgjy6r3TO8u7T9tlKJskykcdNhP0Xqh8rZlXQ/SQNltM+OidAGcxGfCHuynVf
         +4reDUuJBA5lQ==
Date:   Tue, 28 Mar 2023 06:59:04 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, johan+linaro@kernel.org, isaku.yamahata@intel.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, ssengar@linux.microsoft.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/ioapic=3A_Don=27t_ret?= =?US-ASCII?Q?urn_0_from_arch=5Fdynirq=5Flower=5Fbound=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com>
References: <1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com>
Message-ID: <3D028B51-35D7-435F-B912-DC5C0D6C36C6@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 28, 2023 12:30:04 AM PDT, Saurabh Sengar <ssengar@linux=2Emicrosof=
t=2Ecom> wrote:
>arch_dynirq_lower_bound() is invoked by the core interrupt code to
>retrieve the lowest possible Linux interrupt number for dynamically
>allocated interrupts like MSI=2E
>
>The x86 implementation uses this to exclude the IO/APIC GSI space=2E
>This works correctly as long as there is an IO/APIC registered, but
>returns 0 if not=2E This has been observed in VMs where the BIOS does
>not advertise an IO/APIC=2E
>
>0 is an invalid interrupt number except for the legacy timer interrupt
>on x86=2E The return value is unchecked in the core code, so it ends up
>to allocate interrupt number 0 which is subsequently considered to be
>invalid by the caller, e=2Eg=2E the MSI allocation code=2E
>
>The function has already a check for 0 in the case that an IO/APIC is
>registered, but ioapic_dynirq_base is 0 in case of device tree setups=2E
>
>Consolidate this and zero check for both ioapic_dynirq_base and gsi_top,
>which is used in the case that no IO/APIC is registered=2E
>
>Fixes: 3e5bedc2c258 ("x86/apic: Fix arch_dynirq_lower_bound() bug for DT =
enabled machines")
>Co-developed-by: Thomas Gleixner <tglx@linutronix=2Ede>
>Signed-off-by: Thomas Gleixner <tglx@linutronix=2Ede>
>Signed-off-by: Saurabh Sengar <ssengar@linux=2Emicrosoft=2Ecom>
>Cc: Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>---
>[V2]
>- Edit commit message
>- Consolidated the 0 check for ioapic_dynirq_base as well
>
> arch/x86/kernel/apic/io_apic=2Ec | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/arch/x86/kernel/apic/io_apic=2Ec b/arch/x86/kernel/apic/io_a=
pic=2Ec
>index 1f83b052bb74=2E=2Ef980b38b0227 100644
>--- a/arch/x86/kernel/apic/io_apic=2Ec
>+++ b/arch/x86/kernel/apic/io_apic=2Ec
>@@ -2477,17 +2477,21 @@ static int io_apic_get_redir_entries(int ioapic)
>=20
> unsigned int arch_dynirq_lower_bound(unsigned int from)
> {
>+	unsigned int ret;
>+
> 	/*
> 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
> 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet=2E
> 	 */
>-	if (!ioapic_initialized)
>-		return gsi_top;
>+	ret =3D ioapic_dynirq_base ? : gsi_top;
>+
> 	/*
>-	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
>-	 * updated=2E So simply return @from if ioapic_dynirq_base =3D=3D 0=2E
>+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and
>+	 * always 0=2E gsi_top can be 0 if there is no IO/APIC registered=2E
>+	 * 0 is an invalid interrupt number for dynamic allocations=2E Return
>+	 * @from instead=2E
> 	 */
>-	return ioapic_dynirq_base ? : from;
>+	return ret ? : from;
> }
>=20
> #ifdef CONFIG_X86_32

Is there any reason why this variable can't be initialized to a fixed nonz=
ero number, like 16?
