Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02A673FF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjF0PBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjF0PBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:01:41 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B51F1A2;
        Tue, 27 Jun 2023 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lGeT9Q1hZp1Pp+nDLfafFTMSPTidjRCyExZX72xxIXU=;
  b=q4A3Ye7dDFmv+0SczxOGi4EeUMabIemXeR0MMHQr78sl8AJCJmSy7UgN
   PLhQnDYIDLq6mKecYvl3aSPIwI1ZQ6kh3pnSunZj3JJnDj5ot7laIDzwR
   9mqYudkM2e9AGxaVaiUdWuPOOhDB7NrZ/P6wyKg+YQjLsVJnUw5wN7ySD
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="59959619"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 17:01:36 +0200
Date:   Tue, 27 Jun 2023 17:01:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/24] x86/sgx: use vmalloc_array and vcalloc
In-Reply-To: <004bc553-4dca-070b-c203-adcb50d4112d@intel.com>
Message-ID: <896979d6-7365-e75-52fe-ad929e3e8620@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr> <20230627144339.144478-22-Julia.Lawall@inria.fr> <004bc553-4dca-070b-c203-adcb50d4112d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2023, Dave Hansen wrote:

> On 6/27/23 07:43, Julia Lawall wrote:
> > Use vmalloc_array and vcalloc to protect against
> > multiplication overflows.
> ...
> > diff -u -p a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -628,7 +628,7 @@ static bool __init sgx_setup_epc_section
> >  	if (!section->virt_addr)
> >  		return false;
> >
> > -	section->pages = vmalloc(nr_pages * sizeof(struct sgx_epc_page));
> > +	section->pages = vmalloc_array(nr_pages, sizeof(struct sgx_epc_page));
> >  	if (!section->pages) {
>
> I'm not sure that changelog matches the code.
>
> 'nr_pages' here is an 'unsigned long' and The sizeof()==32.  In
> practice, the multiplication can be done with a shift, and the ulong is
> a *LONG* way from overflowing.
>
> I'll accept that, as a general rule, vmalloc_array() is the preferred
> form.  It's totally possible that someone could copy and paste the
> nr_foo*sizeof(struct bar) code over to a place where nr_foo is a more
> troublesome type.
>
> But, if that's the true motivation, could we please say that in the
> changelog?  As it stands, it's a bit silly to be talking about
> multiplication overflows, unless I'm missing something totally obvious.

If it is certain that no overflow is possible, then perhaps it is fine to
drop the patch?  I didn't change cases where both arguments are constants
nor where the result of the sizeof is 1.  But I also didn't do a careful
analysis to see if an overflow is possible given the possible values
involved.

Or if it seems better to keep the change, I can also change the log
message.

julia
