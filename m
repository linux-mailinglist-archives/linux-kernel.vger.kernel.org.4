Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85E5E5C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiIVHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiIVHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:46:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9574A1A67;
        Thu, 22 Sep 2022 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z5Aggbtq5kMtL8XN85SGvbnyW2DMGF8v8qUQXZTPlNw=; b=hO83lSHdePal2uyPxP9ch3fVoL
        G5dEMSI16YoDEv9LitDKb0ieAx9+e4+Eb6WX9ZQ6DB/dcmRgtV8C0iMskKxd8IfueMP/rQ5ASDcUc
        x2+yOGVnMMdGAp8kRiB421HDfvoIvZumVlscHdO7L5jFM6GDXPY9ysUz4w5l30dLtIR/L0Er5AlNa
        28NtDTTY0AmkiO9uio+v66lI5Ga2Mx+3oP/EYARGkK0SvQIa1yHADrgbiNno/503NPpTYBYOl9LHv
        hiptV1dm46+zF0mgCZpOzOR3jxfDisu1DAWuy9XRuTotMzHAM/0wHaGx1L1eXmKiVJu9iLh0pYyHl
        YBkOb9gQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obGuk-006qzA-5F; Thu, 22 Sep 2022 07:46:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65F1F300169;
        Thu, 22 Sep 2022 09:46:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B6B92BB95D95; Thu, 22 Sep 2022 09:46:26 +0200 (CEST)
Date:   Thu, 22 Sep 2022 09:46:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Message-ID: <YywS0keUorHwJJPt@hirez.programming.kicks-ass.net>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
 <20220921200726.GA3094503@roeck-us.net>
 <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
 <1a6e7165-cdae-6c8c-f57d-159fdb68897b@roeck-us.net>
 <d8cd7c7e-24c1-7f70-24a9-91c77aa634af@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8cd7c7e-24c1-7f70-24a9-91c77aa634af@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:09:13PM -0700, Guenter Roeck wrote:

> Oh well, that "helped" to hide one of the crashes. Here is another one.
> This is with PAE enabled and booting through efi32.

> [    1.086592]  efi_runtime_update_mappings+0x36/0x42
> [    1.086717]  efi_enter_virtual_mode+0x351/0x36e
> [    1.086860]  start_kernel+0x57d/0x60f
> [    1.086956]  ? set_intr_gate+0x42/0x55
> [    1.087079]  i386_start_kernel+0x43/0x45
> [    1.087272]  startup_32_smp+0x161/0x164

Does this help? Dave; perhaps we should just let i386 be i386 and let it
bitrot :/

diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index e06a199423c0..d81e379fcd43 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -136,6 +136,7 @@ void __init efi_runtime_update_mappings(void)
 			if (md->type != EFI_RUNTIME_SERVICES_CODE)
 				continue;
 
+			set_memory_ro(md->virt_addr, md->num_pages);
 			set_memory_x(md->virt_addr, md->num_pages);
 		}
 	}
