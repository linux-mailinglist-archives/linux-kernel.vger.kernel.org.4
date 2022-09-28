Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979345EE1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiI1QjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiI1QjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:39:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0A4B6D66
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:39:02 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 766591EC058B;
        Wed, 28 Sep 2022 18:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664383137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WaGpA9Je9H07sCeEfaw6oqmp71ONkeh2idDIs+QiNXw=;
        b=DZcvbNRXx2Ancght4ZlZ/Tft8TaDUM8B3ldBqhHG86Hy1epnLbUlFhhQ+Ht9AiojDkivYp
        wXGnXOeGZRdXLMUzyXRJMK1gZIdERaWXQWvJykGQum66YWiFkgdPDcrZZJ58ZMQKgOAc1O
        OJfJQTVogRRVqJLW2rlenyDqNyZZmw0=
Date:   Wed, 28 Sep 2022 18:38:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <YzR4neYLNB8tByNa@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzRxPAoN+XmOfJzV@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 06:07:24PM +0200, Borislav Petkov wrote:
>  #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>  	/* Ensure elfcorehdr segment large enough for hotplug changes */
> @@ -407,9 +408,8 @@ int crash_load_segments(struct kimage *image)
>  	image->elf_headers_sz = kbuf.memsz;
>  	image->elfcorehdr_index = image->nr_segments;
>  	image->elfcorehdr_index_valid = true;

And that ifdeffery above can be made more readable too:

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a526c893abe8..7aab6e942761 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -399,16 +399,15 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers_sz	= kbuf.bufsz;
 	kbuf.memsz		= kbuf.bufsz;
 
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
 	/* Ensure elfcorehdr segment large enough for hotplug changes */
-	kbuf.memsz =
-		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
-			sizeof(Elf64_Phdr);
-	/* Mark as usable to crash kernel, else crash kernel fails on boot */
-	image->elf_headers_sz = kbuf.memsz;
-	image->elfcorehdr_index = image->nr_segments;
-	image->elfcorehdr_index_valid = true;
-#endif
+	if (IS_ENABLED(CONFIG_CRASH_MAX_MEMORY_RANGES)) {
+		kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+		image->elfcorehdr_index = image->nr_segments;
+		image->elfcorehdr_index_valid = true;
+	}
 
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
