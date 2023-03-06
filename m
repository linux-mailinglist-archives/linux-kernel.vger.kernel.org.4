Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF76AB890
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCFIl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCFIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:41:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9521281
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:41:24 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 364BD1EC0554;
        Mon,  6 Mar 2023 09:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678092083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ch2JqcQidKQQw3jxmmjcy3XtJaLHvZg4719TcnfXY28=;
        b=Qx2LNM8GAehIIoRwD6DIBt12Y5dpKRZm+CSgKO+pDq6m4Xe438WsLBNmOQg6NKRA3ywcQ5
        LJE1fX9vDOQbHArJ99nI+xx1I2w/W+UEGxcn4QY6UKQEBvGEq5lZ1JEnIu+MfHiejEZE/z
        aGW6efJMwgYssl+dV21lAbF+6UBau7E=
Date:   Mon, 6 Mar 2023 09:41:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2] x86/paravirt: merge activate_mm and dup_mmap callbacks
Message-ID: <20230306084117.GAZAWnLeGI09VLsXkC@fat_crate.local>
References: <20230207075902.7539-1-jgross@suse.com>
 <dc5fbb2e-6a23-15e5-a451-e069e90a0656@csail.mit.edu>
 <2b4b0590-8327-3567-f4cd-e610d52fbf1c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b4b0590-8327-3567-f4cd-e610d52fbf1c@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 04:05:51PM +0100, Juergen Gross wrote:
> x86 maintainers, I think this patch should be carried via the tip tree.

You missed a spot. I'll whack it.

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index a8b323266179..c3ad8a526378 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -16,13 +16,6 @@
 
 extern atomic64_t last_mm_ctx_id;
 
-#ifndef CONFIG_PARAVIRT_XXL
-static inline void paravirt_activate_mm(struct mm_struct *prev,
-					struct mm_struct *next)
-{
-}
-#endif	/* !CONFIG_PARAVIRT_XXL */
-
 #ifdef CONFIG_PERF_EVENTS
 DECLARE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
