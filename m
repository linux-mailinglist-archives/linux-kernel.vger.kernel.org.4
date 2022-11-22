Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D77634837
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiKVUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiKVUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:31:29 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969ED1AD83
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:31:28 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so7296545pjs.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=69rSZ63M6bvdurO6ReZqna5Eg4302HwbxHNt+kII3Jg=;
        b=Q46NNpk9InqyUfydIxb2dyrqakqUN+EABqgVTzVreHp/y0i2APHTc6Fd9cLwvxuJX4
         FLSTqubR0OZfdDG58bZ/JjTA8RdOKeIL1lxCEpLRwcEb36JQrRnhwgG95x05jFUNDUQs
         NFJhaq1JEgM3smykDYSzo7XglWel2ub0iIl9wdKXk0Lb+pIQN8z6uQwndjYSDvsTmS2v
         QlujGx67zCoCUb5WKK9ebvyOcog8oFhWp15MLMOKU/CCU8ZYjAr1g+g+RsA3tf98LXA3
         Yly+p/1zNgadfkq42iKAJoxridIXYm+hdt75qm+qlhW621A74qRuDcu6XeW46R48aG4W
         Hdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69rSZ63M6bvdurO6ReZqna5Eg4302HwbxHNt+kII3Jg=;
        b=syribOoK9+4+HClfPcWEoj27uvbHfN31/AjPHZk/jrUT42CIOWssCzIxdB+Ot9QHLA
         CfHXVD0F8PcjH2XThs8KDMAE3mUrAzX2PEXJaxQG+GdnTNWFujNIZL/COvB7C1UXou0+
         JMZG6pRXXyv9njBwB2Q3Gi4TwK5ZoT00XQGb7ftuKTN9WWX4EinRhnCBAaFyJXdz8px2
         khjeHV7Cgo0Z6xAqD8D8hWR7fvMMHlVNoTX6tiMsck9RMuwe8oGkYFaHkBPXjC8MfZqM
         cB0ORpqLmS9DjOlDMhanMvRblqG4OpHbcwdKxNejWB3DwQY59yO2AyKY5pXM736lmjhg
         sK5Q==
X-Gm-Message-State: ANoB5pnK2Mk27+UbOv+QxcSmg88LxHIKQjQ+kax62TSb5lyohL9T7Dh/
        7Zi75mj9Utwv63LPV5qnF0OXIA==
X-Google-Smtp-Source: AA0mqf4EQkMFOdr46C/mIx2/Hbs45Mm/rJgGsIENZl9WFeYvbhsXQdTg/E28lb4oH0cQbV7YTTqnzg==
X-Received: by 2002:a17:90b:8d:b0:218:c14b:4e6e with SMTP id bb13-20020a17090b008d00b00218c14b4e6emr8536348pjb.171.1669149087938;
        Tue, 22 Nov 2022 12:31:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00168dadc7354sm7874449pln.78.2022.11.22.12.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:31:27 -0800 (PST)
Date:   Tue, 22 Nov 2022 20:31:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH] KVM: x86/xen: Make number of event channels defines less
 magical
Message-ID: <Y30xm/y2CKPchObi@google.com>
References: <20221114181632.3279119-1-seanjc@google.com>
 <629d6d90ce95b9db74f0101a4428be1119c4bfc7.camel@infradead.org>
 <Y3KZVUCCH+YQDbqu@google.com>
 <fde14caa0cf774b2b46f1124644a3b326a0a8f09.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fde14caa0cf774b2b46f1124644a3b326a0a8f09.camel@infradead.org>
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

EVTCHN_2L_NR_CHANNELSOn Mon, Nov 14, 2022, David Woodhouse wrote:
> On Mon, 2022-11-14 at 19:39 +0000, Sean Christopherson wrote:
> > Ugh.  I worried that might be the case.  An alternative approach to help document
> > things from a KVM perspective would be something like:
> > 
> > diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> > index 93c628d3e3a9..7769f3b98af0 100644
> > --- a/arch/x86/kvm/xen.c
> > +++ b/arch/x86/kvm/xen.c
> > @@ -1300,6 +1300,9 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
> >  
> >  static inline int max_evtchn_port(struct kvm *kvm)
> >  {
> > +       BUILD_BUG_ON(EVTCHN_2L_NR_CHANNELS !=
> > +                    (sizeof_field(struct shared_info, evtchn_pending) * BITS_PER_BYTE));
> > +
> >         if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode)
> >                 return EVTCHN_2L_NR_CHANNELS;
> >         else
> 
> Not really sure I see the point of that.
> 
> There are two main reasons for that kind of BUILD_BUG_ON(). I've added
> a few of them asserting that the size of the structure and its compat
> variant are identical, and thus documenting *why* the code lacks compat
> handling. For example...
> 
> 	/*
> 	 * Next, write the new runstate. This is in the *same* place
> 	 * for 32-bit and 64-bit guests, asserted here for paranoia.
> 	 */
> 	BUILD_BUG_ON(offsetof(struct vcpu_runstate_info, state) !=
> 		     offsetof(struct compat_vcpu_runstate_info, state));
> 
> The second reason is to prevent accidental screwups where our local
> definition of a structure varies from the official ABI. Like these:
> 
> 	/* Paranoia checks on the 32-bit struct layout */
> 	BUILD_BUG_ON(offsetof(struct compat_shared_info, wc) != 0x900);
> 	BUILD_BUG_ON(offsetof(struct compat_shared_info, arch.wc_sec_hi) != 0x924);
> 	BUILD_BUG_ON(offsetof(struct pvclock_vcpu_time_info, version) != 0);
> 
> I don't really see the above fulfilling either of those use cases.
>
> Given that the definition of the evtchn_pending field is:
> 
>         xen_ulong_t evtchn_pending[sizeof(xen_ulong_t) * 8];
> 
> It's fairly tautological that the number of event channels supported is
> BITS_PER_ULONG * BITS_PER_ULONG. Which is sizeof(xen_ulong_t)² * 64 as
> defined in the official Xen headers.
> 
> I don't know that we really need to add our own sanity check on the
> headers we imported from Xen. It doesn't seem to add much.

The goal isn't to add a sanity check, it's to document what EVTCHN_2L_NR_CHANNELS
actually represents.  My frustration with 

  sizeof(xen_ulong_t) * sizeof(xen_ulong_t) * 64

is that there's nothing there that connects it back to evtchn_pending or evtchn_mask.

E.g. ideally the code would be something like

  #define COMPAT_EVTCHN_2L_NR_CHANNELS	256

  #ifdef CONFIG_X86_64
  #define EVTCHN_2L_NR_CHANNELS		512
  #else
  #define EVTCHN_2L_NR_CHANNELS		COMPAT_EVTCHN_2L_NR_CHANNELS


  DECLARE_BITMAP(evtchn_pending, EVTCHN_2L_NR_CHANNELS);
  DECLARE_BITMAP(evtchn_mask, EVTCHN_2L_NR_CHANNELS);

which is much more self-documenting and doesn't require the reader to do math to
grok the basics.

Anyways, we can drop this patch, it was written mostly out of frustration with
how long it took me to understand what is actually a very simple concept that's
written in an unnecessarily obscure way.
