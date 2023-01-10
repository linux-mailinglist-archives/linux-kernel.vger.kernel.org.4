Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454216643B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbjAJOxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjAJOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:53:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E31E7A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:53:27 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B87F1EC0662;
        Tue, 10 Jan 2023 15:53:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673362406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUL1dn4RyxJxiJ//85KytHyBDWGRi9UQ1RORHdHuPhg=;
        b=kxrPFd75cGU5QWab+adk43/76ZcEMHVjmetASqP4jowMRPgTGHThts4Yr0OtOi+br26gLk
        4lW1ZDDHnwk6+2y19gESFtmdBYmH22ZVuTdEwX0xHsoGH5NllGTVN7j2zbfgCNZCgD5/Rv
        5b+qYOgQoyzwQUtOIjj+jwbYvouAYk4=
Date:   Tue, 10 Jan 2023 15:53:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     Ingo Molnar <mingo@kernel.org>, michael.roth@amd.com,
        hpa@zytor.com, tglx@linutronix.de,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, brijesh.singh@amd.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, liwei391@huawei.com
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Message-ID: <Y7174pEWZ8IzCdQ9@zn.tnic>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com>
 <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic>
 <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:32:07PM +0800, Zeng Heng wrote:
> And here is the context of mce-inject:
> 
> #0  relocate_kernel () at arch/x86/kernel/relocate_kernel_64.S:55
> #1  0xffffffff81a57fc2 in machine_kexec (image=0xffff888101ef8400)
>     at arch/x86/kernel/machine_kexec_64.c:391

Before we continue with this any further: are you doing this "exercise" in
qemu/kvm and nothing of that is happening on real hardware?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
