Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483E163FAED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiLAWuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiLAWtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:49:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF2C7261
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:49:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so6594500pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mKF7ACqUicTgwRFQrz4oBsMFvmn+mRrenbI3VwK9VtA=;
        b=Lo1VVBU0quIBqwSjUL/IX6jsQ3Rcbq3kNXFx1b09LmjnR9bQqqs8Qnjl452IWYkBSY
         P1KTyvwrHEdLgoshrms0r4SI8z1ngo83OqCHRxrURyBE+yArcM+Cs5TCeq44GobVkF0m
         IuDj+iWRP2zVVwjI1HJslgwJO64iafu01Owc+4A3/mvkEjyzFr8iFAR19fNs0LBLJTf3
         Kg1ZIMc5fZ0ipGhmHdhLOXnD8uVTRyQX02DQttBjsyjAKjRvEJFav2gCuZ5FSQ6cpVhK
         zD3GLCkmoDFgDHZV7t7XBqH0jElTPRdTcydGeJqtHoccQFH5HqfiAwKx6tg04wXmDFCc
         QADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKF7ACqUicTgwRFQrz4oBsMFvmn+mRrenbI3VwK9VtA=;
        b=Eft+n45KZBSzyNOlJ+fraRAM+LemmE4oRmzt3YitBqj8wePx3k2CGSbUTp+Xh9hkGt
         lMtsQzPaMVENgII4GQs7SaqFrNOZe2Q0lGgL8XtAbrAXJVRIgmMWwHC7vv/KcwWjVtJh
         TJwf2TRtma0Zu5cO+hzLoeBa5ZUEWA6k+xIBp5l37CHrv0kfWNVGewotTiNhArLJUYXm
         vMJEp4gQzplOQjXXpZoDd8EodXD+MnVh0O2/Adn0WY3yKIibKV477P4jUEv8rvjrdZ5b
         LpdKbXAwk5F1dgKM6Qp4hs2E9nlb9N5TnG5gG9mfFZDtztizHWwK6DICdCevl2sVGCiN
         OQ/w==
X-Gm-Message-State: ANoB5pkC4TleKw6jKhIrzu8YMit639Ve8rYMiXzRhYJ990jIDmEVegXG
        5bUHny7Rz5l8zFeAx5KvEZ/VLA==
X-Google-Smtp-Source: AA0mqf4Wt8uYV/bEa16p+0WrrISPwxZH3fHAX4g+Oh8a2UKzOEMh4LEyPBB3ZTgiAtA3/myS/mdVQA==
X-Received: by 2002:a17:903:32ce:b0:189:a0eb:4a26 with SMTP id i14-20020a17090332ce00b00189a0eb4a26mr13829305plr.162.1669934951343;
        Thu, 01 Dec 2022 14:49:11 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c73-20020a624e4c000000b0056bc742d21esm3854175pfb.176.2022.12.01.14.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:49:10 -0800 (PST)
Date:   Thu, 1 Dec 2022 22:49:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 21/50] KVM: MIPS: Hardcode callbacks to hardware
 virtualization extensions
Message-ID: <Y4kvYlCbhj87rceF@google.com>
References: <20221130230934.1014142-1-seanjc@google.com>
 <20221130230934.1014142-22-seanjc@google.com>
 <beb697c2-dfad-780e-4638-76b229f28731@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beb697c2-dfad-780e-4638-76b229f28731@linaro.org>
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

On Thu, Dec 01, 2022, Philippe Mathieu-Daudé wrote:
> On 1/12/22 00:09, Sean Christopherson wrote:
> > Now that KVM no longer supports trap-and-emulate (see commit 45c7e8af4a5e
> > "MIPS: Remove KVM_TE support"), hardcode the MIPS callbacks to the
> > virtualization callbacks.
> > 
> > Harcoding the callbacks eliminates the technically-unnecessary check on
> > non-NULL kvm_mips_callbacks in kvm_arch_init().  MIPS has never supported
> > multiple in-tree modules, i.e. barring an out-of-tree module, where
> > copying and renaming kvm.ko counts as "out-of-tree", KVM could never
> > encounter a non-NULL set of callbacks during module init.
> > 
> > The callback check is also subtly broken, as it is not thread safe,
> > i.e. if there were multiple modules, loading both concurrently would
> > create a race between checking and setting kvm_mips_callbacks.
> > 
> > Given that out-of-tree shenanigans are not the kernel's responsibility,
> > hardcode the callbacks to simplify the code.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/mips/include/asm/kvm_host.h |  2 +-
> >   arch/mips/kvm/Makefile           |  2 +-
> >   arch/mips/kvm/callback.c         | 14 --------------
> >   arch/mips/kvm/mips.c             |  9 ++-------
> >   arch/mips/kvm/vz.c               |  7 ++++---
> >   5 files changed, 8 insertions(+), 26 deletions(-)
> >   delete mode 100644 arch/mips/kvm/callback.c
> > 
> > diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> > index 28f0ba97db71..2803c9c21ef9 100644
> > --- a/arch/mips/include/asm/kvm_host.h
> > +++ b/arch/mips/include/asm/kvm_host.h
> > @@ -758,7 +758,7 @@ struct kvm_mips_callbacks {
> >   	void (*vcpu_reenter)(struct kvm_vcpu *vcpu);
> >   };
> >   extern struct kvm_mips_callbacks *kvm_mips_callbacks;
> 
> IIUC we could even constify this pointer.

Good point.  Protecting the pointer itself is a bit gross, but it is a nice
stopgap until the callbacks are gone.  I'll fold this in.  Thanks!

  extern const struct kvm_mips_callbacks * const kvm_mips_callbacks;
