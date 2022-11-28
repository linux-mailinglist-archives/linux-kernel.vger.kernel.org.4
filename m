Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB4A63A5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiK1KLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK1KLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:11:23 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D927A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:11:23 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id l7so7493174pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UFTSOxMLMVmhaB47uYlAotT04cbRejKT+vXyIBeHRo=;
        b=eGaD+ltNrN9qCiuD1IQf8J9bygIydZ0kegg5cMeRI/YuSe+lCc598x3hl1BbSsfbgU
         32T2d4LdcOxgcpHwT5b1PyhNh1E6x55F8V1ICS1vvnw1VZk2sdeV4aajsG83Nx0B7Ddr
         eHkpqdRG4Z33IBfmYU060AFp0MJ59IfxKvvJyIfIyfSt06q1abdRszpSy+rcZbkGhGdH
         wed/yrxKwteTRK6bv7f2bthgM6YtnVPo20vdTGziSlfdC7tBdqSAOtkn3hbz6p6H/TF1
         +HLN7F9WtaobcmzM1rG0dAtinC7iAGGJAcd1YrKE24OtBnVnb5JD1T+6x8BVwHzUdt7B
         R6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7UFTSOxMLMVmhaB47uYlAotT04cbRejKT+vXyIBeHRo=;
        b=2m4ueHtn3aDejB4FnowWgbS8OOqocXVHK0375N+Qq4bjW68Lj37iCESA85rGnyWaVE
         N8obt9UmD8PO94YiT1lzT9uDVFoq9vCjN221gSFIH9xG5N2OSpo27eWGEtYUuAHI9mFY
         hHZLlM33/mxGUApaXlkCWdZ2DkW5seUa1J7lWkCKaONTLr7G7PD3NYhRK2Rvrw76xv4c
         CD2iHcDf8jRD9tdT8J+U04XbwSOlbzf8yJ84llOqAItxpY2kZ+/iEJ/Lp0HJbzpLLWv4
         MWQMTzTHmmT7TmDFI3o14aykdznb8B5i4XFXb9+vIDD7tQhBfTHFKoLNfAcG4RWZzb90
         /RbQ==
X-Gm-Message-State: ANoB5pklkqJuRxujfhu09exzsu2qnOMhWNETLDEnbLU+WmEE+Aka6yBP
        pScZmiiZTEoaLwR3VsgFucA=
X-Google-Smtp-Source: AA0mqf6Wl5NQUYZm5QAfE64zATfHYrIHE8xH15dLyfC8jL2B5SjZhz/B711/+fuEWalvk7rnG7Sumw==
X-Received: by 2002:a05:6a00:4205:b0:56b:a7cd:f47a with SMTP id cd5-20020a056a00420500b0056ba7cdf47amr51868298pfb.22.1669630282429;
        Mon, 28 Nov 2022 02:11:22 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79494000000b0056f0753390csm7836012pfk.96.2022.11.28.02.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:11:22 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     kirill.shutemov@linux.intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        mailhol.vincent@wanadoo.fr, mingo@redhat.com, pbonzini@redhat.com,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        x86@kernel.org
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from asm-offsets.c
Date:   Mon, 28 Nov 2022 19:11:17 +0900
Message-Id: <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
References: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 12:15:06 +0300, Kirill A. Shutemov wrote:
> On Sun, Nov 27, 2022 at 03:23:35PM +0900, Vincent Mailhol wrote:
> > Following [1], the macro COMPILE_OFFSETS becomes unused:
> 
> Really? I see #ifdef COMPILE_OFFSETS in ftrace.h. Hm?
> 
> Have you tested your patch with CONFIG_FTRACE_SYSCALLS=y and
> CONFIG_IA32_EMULATION=y?

Even if I activate those two configurations, the compiler still
tells me it is unused:

  $ grep -E "CONFIG_FTRACE_SYSCALLS|CONFIG_IA32_EMULATION" .config
  CONFIG_IA32_EMULATION=y
  CONFIG_FTRACE_SYSCALLS=y

  $ make W=2 arch/x86/kernel/asm-offsets.o
  <...>
  arch/x86/kernel/asm-offsets.c:7: warning: macro "COMPILE_OFFSETS" is not used [-Wunused-macros]
  <...>

> >   $ make W=2 arch/x86/kernel/asm-offsets.o
> >   <...>
> >   arch/x86/kernel/asm-offsets.c:7: warning: macro "COMPILE_OFFSETS" is not used [-Wunused-macros]
> >   <...>
> > 
> > Remove COMPILE_OFFSETS macro.
> > 
> > [1] commit debc5a1ec0d1 ("KVM: x86: use a separate asm-offsets.c file")
> >     Link: https://git.kernel.org/torvalds/linux/c/debc5a1ec0d1
> > 
> > Fixes: debc5a1ec0d1 ("KVM: x86: use a separate asm-offsets.c file")
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  arch/x86/kernel/asm-offsets.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> > index 437308004ef2..cf2e02bafbef 100644
> > --- a/arch/x86/kernel/asm-offsets.c
> > +++ b/arch/x86/kernel/asm-offsets.c
> > @@ -4,7 +4,6 @@
> >   * This code generates raw asm output which is post-processed to extract
> >   * and format the required data.
> >   */
> > -#define COMPILE_OFFSETS
> >  
> >  #include <linux/crypto.h>
> >  #include <linux/sched.h>
