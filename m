Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B296739D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjASNTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjASNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:18:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546521BCE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:18:54 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2B871EC0691;
        Thu, 19 Jan 2023 14:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674134333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KQnyLQfK7qJC86oYK37cAQ7hek4siDxOAmRxTyQrFa0=;
        b=PZtimvQkqlW/cJilj6IlzV376vPd6z0Ph1rqtUb3ByHCk/BeQkmicHqrBF+DY+kYjExKTd
        WSM2lsHs//3WaJrIcjFy2fnI+Sc3ZkLWm9cCgQBuq1ytKkWulN3q2Fnry/oCuZunWxvxgd
        HNIOXbeTbVZCwhjTV29fcAxtjneo6X0=
Date:   Thu, 19 Jan 2023 14:18:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/7] x86/boot: Delay sev_verify_cbit() a bit
Message-ID: <Y8lDN73cNOmNuciV@zn.tnic>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.649204101@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230116143645.649204101@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:25:35PM +0100, Peter Zijlstra wrote:
> Per the comment it is important to call sev_verify_cbit() before the
> first RET instruction, this means we can delay calling this until more

Make that "... this means that this can be delayed until... "

And I believe this is not about the first RET insn but about the *next* RET
which will pop poisoned crap from the unencrypted stack and do shits with it.

Also, there's this over sev_verify_cbit():

 * sev_verify_cbit() is called before switching to a new long-mode page-table
 * at boot.

so you can't move it under the

	movq    %rax, %cr3

Looking at this more, there's a sme_enable() call on the BSP which is already in
C.

So, can we do that C-bit verification once on the BSP, *in C* which would be a
lot easier, and be done with it?

Once it is verified there, the bit is the same on all APs so all good.

Right?

joro?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
