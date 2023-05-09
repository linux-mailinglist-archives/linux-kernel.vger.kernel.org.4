Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1956FC29F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjEIJUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjEIJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:20:24 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CCE100C0;
        Tue,  9 May 2023 02:20:17 -0700 (PDT)
Received: from [192.168.1.103] (178.176.73.203) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 9 May 2023
 12:20:06 +0300
Subject: Re: [patch v3 33/36] x86/apic: Save the APIC virtual base address
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <xen-devel@lists.xenproject.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        <linux-csky@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <20230508181633.089804905@linutronix.de>
 <20230508185219.070274100@linutronix.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a6f48a7b-484c-31af-f568-cb1de0d766d4@omp.ru>
Date:   Tue, 9 May 2023 12:20:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230508185219.070274100@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.73.203]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 05/09/2023 08:58:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 177218 [May 07 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 510 510 bc345371020d3ce827abc4c710f5f0ecf15eaf2e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.203 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.203 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 178.176.73.203:7.4.1,7.7.3;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.203
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/09/2023 09:07:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 5/9/2023 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/8/23 10:44 PM, Thomas Gleixner wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> For parallel CPU brinugp it's required to read the APIC ID in the low level
> startup code. The virtual APIC base address is a constant because its a
> fix-mapped address. Exposing that constant which is composed via macros to
> assembly code is non-trivial dues to header inclusion hell.

   s/dues/due/?

> Aside of that it's constant only because of the vsyscall ABI
> requirement. Once vsyscall is out of the picture the fixmap can be placed
> at runtime.
> 
> Avoid header hell, stay flexible and store the address in a variable which
> can be exposed to the low level startup code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Michael Kelley <mikelley@microsoft.com>

[...]

MBR, Sergey
