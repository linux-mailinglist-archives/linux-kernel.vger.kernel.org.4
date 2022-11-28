Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D863B118
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiK1SUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiK1STm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:19:42 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F42ED4F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:06:23 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 62so10605884pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LR/R7F4a5BTbcaj2KYjcb+1IqAlm9qXCSz8C+xQup0=;
        b=LBHNKAvribLzIS35cY/hBvF/+dGWRqa72gAqVfakLP8finS4t62fRt9xXLkVeJJpZ/
         OkLgA9P+ATYyHa68ItAzkyRBIfTH4NsQ6wMC1yoPvhgf0To1hyyNSMo52MTJTRz3W9JB
         ZiOD2PQWylH3keNmyQX/lrzLY31w4DoBQvvu0BWygNz63bbJ2Jj6H0/QdAHqNafHsVFb
         Mi46kVBJaA8klqzx+qSRtwA8msNFdXSaQm7s/dxQAwO6blI+aVsVu5gETjKyf395ib3c
         aPuC6kksD3yRugtLtnL0R5aMWe0sEpBfTIgSsLwX+yePUzwpc14OQvdizqigtQe4C9hc
         3N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LR/R7F4a5BTbcaj2KYjcb+1IqAlm9qXCSz8C+xQup0=;
        b=W2AqQiHemT1I4eN2SCOsKHktosZijj03Zu/gUdfnMHWCfXxoBNaDfMmYjP4wROlEnS
         Q6R0F+ed2EfJUVo41j26hmUXXGM2siMA81LxnOhCLgWtbocq6FlzWBpnWaevABk0qD2m
         O7snHehFGBHUHpZEGcYs1ThdzhMq4orrqoysDCgjYH3+GdPOpjN5a55ULnNZcYN6agDB
         wswQoXzLCxVWtWHNKDE/mvBgUwib60NTx+6eTeM7j72pcD9EjSFiA6gCbNHcaKrz6cww
         xbhe+6y5wUYWbcpj4gWWzxROqrikhKTeFMOJxyNS3WNn9K55IZHzPS14CgpFCZXmEt21
         y5TQ==
X-Gm-Message-State: ANoB5pmjSZQzwJd44b3BmUdprmHy/HgGXbRHyvWfKqSdmLfi8tngn1Ve
        hsjwO7g0T618DbzpRDJGSsUC4w==
X-Google-Smtp-Source: AA0mqf4g5D/cK7hMObATal5Bm0ptzPg8SvlOpkxNbxanH5Ae/sDESo9pVJlhIBUoXj8KgLgzYD8xsw==
X-Received: by 2002:a63:ef50:0:b0:476:e813:1ae9 with SMTP id c16-20020a63ef50000000b00476e8131ae9mr31988019pgk.305.1669658782570;
        Mon, 28 Nov 2022 10:06:22 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00172fad607b3sm9152172pla.207.2022.11.28.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:06:22 -0800 (PST)
Date:   Mon, 28 Nov 2022 18:06:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        kirill.shutemov@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from
 asm-offsets.c
Message-ID: <Y4T4msSXCNnfPCMG@google.com>
References: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
 <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr>
 <20221128111112.dzavip4eqqgpyrai@box.shutemov.name>
 <CAMZ6RqJ0EgbLcz97ujqEzF1MBsH045W0Cu8mMuR0WCx_cTemCQ@mail.gmail.com>
 <20221128124513.76392c3d@gandalf.local.home>
 <b98429d8-6d18-cf0b-6ca0-d9d6472d21f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b98429d8-6d18-cf0b-6ca0-d9d6472d21f9@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022, Paolo Bonzini wrote:
> On 11/28/22 18:45, Steven Rostedt wrote:
> > 
> > > > If you are sure <asm/ftrace.h> is never included from asm-offsets.c,
> > > > remove #ifndef COMPILE_OFFSETS too.
> > > It is never included from asm-offsets.c but it is still used by
> > > kvm-asm-offsets.c:
> > > https://elixir.bootlin.com/linux/v6.1-rc7/source/arch/x86/kvm/kvm-asm-offsets.c#L7
> > IIRC, the reason for adding that was because that logic was screwing up
> > asm-offsets.c. I'm not sure it screws up kvm-asm-offsets.c though.
> > 
> > This is one of those cases I wish I commented that code better :-/
> 
> I don't think KVM includes linux/ftrace.h or asm/ftrace.h at all.

From include/linux/kvm_host.h

  #include <linux/ftrace.h>

Even if that didn't exist, saying that XYZ never includes a header is a dangerous
business, it's all too easy to indirectly include headers in the kernel, now or
in the future.
