Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D78668731
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjALWoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbjALWov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:44:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8012B5E0BF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:44:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g68so12693798pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeqsYbPpxfJWvTt+bhcGbc3dFC6Uvdv57wMBIqHRb9o=;
        b=Sy/u1uw8JnqTqWOwChROVISdeBeRBaaUY/OivQqU1XTV7J28WUkJKdFqN2sCdgkcih
         yk4v7LtmwUNy1+ITlQHTHvnSObkiTyj476fvIBfa0QhdRBCPO62+fX3OP+Md346nJwAr
         Z2Z+XlIx2c2Loru9BU9MmSj4tZJ8FGANiRwRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeqsYbPpxfJWvTt+bhcGbc3dFC6Uvdv57wMBIqHRb9o=;
        b=ntcNUZ15LWkyK2rWT5fOsdVdCZZOFhJVhgoCbXFIk8sV/BXJxG2IH4BpuMymqwXQeV
         r3SaiZLHOF4LHj/Ad379lmf4YWqfv48LGB3w54ZA/peHRd5Duh9vdL7km4esGJ4VIwEM
         Z/FLKNRl1uZY0z5hVDKtFQg8iMia463N+CVkq/rGB6siwnTWME8PM3w3eu1nTvh5n1h/
         vB+12VJuI1723QRSvF2b/Ue5zz+MKUlnn+hREwKFUxvcmPdehrBrHD+8Za24VQJnP6Yj
         8/WbN5EZMAeecnTWd3NwzNEbbxmUuNTMrfGh9LsqqmZnhHrQz/YpH7/IuJzz8tKziV0f
         FXqA==
X-Gm-Message-State: AFqh2kqC6eoZLMu1MS30UmmFzI6+Nb+BJD3xEr6w0MhdwaLKMGf/Cvm3
        IyJ5gQTO1o8JLyeEYFAeyOHNuw==
X-Google-Smtp-Source: AMrXdXuT6rw2c83a5xiZbmvnFGz+zmKFF8iBdpkkGnPrrbiGWwgVglCbXrz8h/CXWglWWgcIVXcaXA==
X-Received: by 2002:a05:6a00:993:b0:581:c2d3:dc5e with SMTP id u19-20020a056a00099300b00581c2d3dc5emr66641575pfg.11.1673563489013;
        Thu, 12 Jan 2023 14:44:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4-20020a620404000000b00576ee69c130sm12308549pfe.4.2023.01.12.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:44:48 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:44:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Replace 0-length arrays with flexible arrays
Message-ID: <202301121444.104E492D@keescook>
References: <20230105190548.never.323-kees@kernel.org>
 <Y7xPSEMOWqz+3kgD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xPSEMOWqz+3kgD@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 05:30:48PM +0000, Sean Christopherson wrote:
> On Thu, Jan 05, 2023, Kees Cook wrote:
> > Zero-length arrays are deprecated[1]. Replace struct kvm_nested_state's
> > "data" union 0-length arrays with flexible arrays. (How are the
> > sizes of these arrays verified?)
> 
> It's not really interpreted as an array, it's a mandatory single-entry "array".
[...]
> >  
> >  	/*
> > -	 * Define data region as 0 bytes to preserve backwards-compatability
> > +	 * Define union of flexible arrays to preserve backwards-compatability
> 
> I think I'd actually prefer the "as 0 bytes" comment.  The important part is that
> the size of "data" be zero, how that happens is immaterial.

Oh, dur, I can read the comment. :)

It has to stay the old size -- this was a way to add an optional extra
struct to the end. Got it!

-- 
Kees Cook
