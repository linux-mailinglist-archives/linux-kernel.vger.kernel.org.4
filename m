Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A006640CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjAJMrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjAJMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:47:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240550073
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:47:00 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BD741EC04AD;
        Tue, 10 Jan 2023 13:46:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673354819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+qCA61EYXSSNxi5ZBZXCZg8LKYcT9qooS68AQpd9P0c=;
        b=DVWsX0CA1RZd+U1t5fLznD9n1QK+SjUCVQrybtSi8lpb3buFaMO3mlfrC1xQEhutxN6C/U
        BrPQ3kDIPBwJDBOpjrHF3cGy7Og5QzkU5/7rFyZOx/DPoFGZA+ORC0NG8lFiiJxLyLS6mz
        hMgEdwPF2/TSxWWl6G639k1jXANPFoY=
Date:   Tue, 10 Jan 2023 13:46:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Zeng Heng <zengheng4@huawei.com>, michael.roth@amd.com,
        hpa@zytor.com, tglx@linutronix.de,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, liwei391@huawei.com,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Message-ID: <Y71eP8qwLKg7eLXF@zn.tnic>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com>
 <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic>
 <Y71XPl8br2QU2L8E@zn.tnic>
 <Y71bW/8XZCackPLh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y71bW/8XZCackPLh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:34:35PM +0100, Ingo Molnar wrote:
> So your suggestion was to exit MC context 'before' the panic() call - but 
> the patch calls it 'after' - was that intentional?

Bah, you're right - it should be:

	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
	panic();

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
