Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269076645A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjAJQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbjAJQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:09:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49385A8B4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:09:11 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 733361EC0681;
        Tue, 10 Jan 2023 17:09:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673366950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lg+fQAFZxkXmod7R2rOhRD2WOqnnug0uBiQnTXubwvM=;
        b=J11uyv7shHn036i99XzaaUR+756sAHdejhtYrkqeHLTlDx/0ut0mxB+JgItQIyDdkVxmjX
        qlnkfNDt+tIA3IN8j2pIYcb2A8C+rWpAALypwliN5XfXyCKaJ/FzPRALc9QzK/QUfuqTvN
        ktFcuUpmLTo1Hh24/1VS0KV6191wYGM=
Date:   Tue, 10 Jan 2023 17:09:10 +0100
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
Message-ID: <Y72NphKcBMQho02u@zn.tnic>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com>
 <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic>
 <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
 <Y71goW5qTW5dZKcv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y71goW5qTW5dZKcv@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:57:05PM +0100, Borislav Petkov wrote:
> I'm doubtful now as you're injecting errors so you're not really in #MC context
> but in this contrived context which is actually an NMI one. So we need to think
> about how to fix this case.

I did some more thinking:

*if* this really is a real issue - and not some silly qemu games - then
native_machine_crash_shutdown() does all the cleanup before the kdump kernel is
started.

Any NMI clearing, maybe using iret_to_self() etc, #MC resetting etc should
happen there and not anywhere else.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
