Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF2610482
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiJ0VfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiJ0VfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:35:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446744D82D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:35:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j12so2996458plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZuaGAdrg4Zn30PXTyZCS8qx4FnpSCInWNY0DH7XPtE=;
        b=M4b4iw6Pkw/LQx43MykJaL78g7GlCHpRIbBIQjYSokoF44EFh8ZaKShvOX35BjdLA7
         Htdx4oHHTt1dFs6mKdPetaGpJRwlgjjxBjMYmV4YTVbIMjhTkANqYI8LVzXXR/ARlCRn
         wZvRMVFPAvk/kB2ozSGrMXRdmnfrRWqf8GIlcDg9np2DhK8jagxGpuqUn1uvyLLljDjY
         Y7wtPE55klwPKsBF8iC2ycLJZU2zEvURThUmZzrz//3e4KJGTU/FLKSXutnbh0XvOUp1
         BI2ITt5jZjVCrcmbmHXwd75100Qfie0xxz/yNUEKd/ZHHCvxjJfXAniCw0jTUUYhpjTI
         E5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZuaGAdrg4Zn30PXTyZCS8qx4FnpSCInWNY0DH7XPtE=;
        b=v78OdtCIC7Y6TQVGAvMC1Tp3VVmnCDWFtrXmWPZ5xdhLoTy0gxzeEuXZfBjKTJOf1P
         uSH/JZ/i/3rmsB7FdytOVJxlh2MRoZZeNe593sOu0hfYytVC8ZmcOFeF4bcEgrT8dDEt
         9L60cIx961NFHsLSjkAl/4Pn7jVtfszM4FocmKQgvtPyxc2xwiA4qzRavfmxJzs+lJlJ
         72xuSsgaBC9lRxZ90HMmeXwew48Tia3lXVMkTOspOArDpu5ja4ym/mFjq/nCVFLW4Dzz
         2LOBANQHi+RAxldU7DIli7qm7du8P37qCHQLoiFc6qpcekxNsKqQBtyt7r2XvHjt+UGd
         l0ig==
X-Gm-Message-State: ACrzQf3SzJz/h40XM+BkDRj0yjoXXZ/+ZHO4wg6dmdrDf8Rrt8KGDIo0
        n1Q8GrlRUHjcJwanCTkkOkC+qop05LmJMQ==
X-Google-Smtp-Source: AMsMyM5rNnDPjF75/c8CBp5jT4380C7pR7Xnv9l6XJvr0WmH2sVYgmiIXY+UmtJg8/4kbOnTWiZWGA==
X-Received: by 2002:a17:90b:110c:b0:205:cfeb:cfb with SMTP id gi12-20020a17090b110c00b00205cfeb0cfbmr12531822pjb.75.1666906514595;
        Thu, 27 Oct 2022 14:35:14 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090a0ac900b0020d48bc6661sm3059076pje.31.2022.10.27.14.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:35:14 -0700 (PDT)
Date:   Thu, 27 Oct 2022 21:35:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: nVMX: Invert 'unsupported by eVMCSv1' check
Message-ID: <Y1r5jpRxJeDMac6T@google.com>
References: <20221018101000.934413-1-vkuznets@redhat.com>
 <20221018101000.934413-3-vkuznets@redhat.com>
 <Y1nAThjeMlMFFrAi@google.com>
 <87a65htt6m.fsf@ovpn-194-52.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a65htt6m.fsf@ovpn-194-52.brq.redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Tue, Oct 18, 2022, Vitaly Kuznetsov wrote:
> >> When a new feature gets implemented in KVM, EVMCS1_UNSUPPORTED_* defines
> >> need to be adjusted to avoid the situation when the feature is exposed
> >> to the guest but there's no corresponding eVMCS field[s] for it. This
> >> is not obvious and fragile.
> >
> > Eh, either way is fragile, the only difference is what goes wrong when it breaks.
> >
> > At the risk of making this overly verbose, what about requiring developers to
> > explicitly define whether or not a new control is support?  E.g. keep the
> > EVMCS1_UNSUPPORTED_* and then add compile-time assertions to verify that every
> > feature that is REQUIRED | OPTIONAL is SUPPORTED | UNSUPPORTED.
> >
> > That way the eVMCS "supported" controls don't need to include the ALWAYSON
> > controls, and anytime someone adds a new control, they'll have to stop and think
> > about eVMCS.
> 
> Is this a good thing or a bad one? :-) I'm not against being extra
> verbose but adding a new feature to EVMCS1_SUPPORTED_* (even when there
> is a corresponding field) requires testing or a
> evmcs_has_perf_global_ctrl()-like story may happen and such testing
> would require access to Windows/Hyper-V images. This sounds like an
> extra burden for contributors. IMO it's OK if new features are
> mechanically added to EVMCS1_UNSUPPORTED_* on the grounds that it
> wasn't tested but then it's not much different from "unsupported by
> default" (my approach). So I'm on the fence here.

Yeah, I was hoping the compile-time asserts would buy us full protection, i.e. I
was hoping to avoid the sanitization, but I don't see a way to handle the case
where Hyper-V starts advertising a feature that was previously unsupported :-(

I'm a-ok going with SUPPORTED only, I'm on the fence too.
