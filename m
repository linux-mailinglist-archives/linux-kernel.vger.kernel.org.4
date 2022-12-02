Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD77640806
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiLBNzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiLBNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:55:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0E4B0A36
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:55:13 -0800 (PST)
Received: from zn.tnic (p200300ea9733e73a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e73a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4DA31EC0832;
        Fri,  2 Dec 2022 14:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669989311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TjKFn4vwGx5Waf76qIyOWDxn+nMaDMY+/Aq7LR5D9WE=;
        b=k6UCYIKQDF9aWWSgN7l3/xuYux+IkwgwpMn28NP/CG3B7KiesyDEKGkE1NVX/lXrrRIfX1
        C1YGNzes4DxOCry0IFXZrX38QjVO3nouS/4bkjfzY/Ucd7NSzXTBVEbZjW3KymvUzZCWtr
        Jo4zb5GzENBe4W3L8GFdlVS0X9X6fgQ=
Date:   Fri, 2 Dec 2022 14:55:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
Message-ID: <Y4oDvBHt7VZwnoGd@zn.tnic>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 06:56:47AM +0100, Juergen Gross wrote:
> Instead of X86_FEATURE_XENPV we could introduce something like
> X86_FEATURE_PAT_READONLY, which could be set for Xen PV guests and for
> TDX guests.

Until a third type comes which wants its pony to be pink and to dance.
:-\

Nah, we already have X86_FEATURE_TDX_GUEST - let's use that in
pat_bp_init() and exit there early and be done with it. This way it is
also self-documenting who can and cannot deal with that code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
