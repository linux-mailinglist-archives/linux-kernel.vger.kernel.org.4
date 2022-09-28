Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0D5EE3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiI1SDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiI1SDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:03:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858EFE659
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:03:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e68so13224618pfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6XAUjyy8dM+memUfQW8WuFfjcJaprUOz9KHY1fZCoGw=;
        b=P53UuYSAwxYFHB9LgLaojInB13oBd+shR1QK8QLrkhdso+QUkcvjVqDWM2vJ4I63kw
         KlCzcL9FiEhkuBJBlwC5PJlL9NJ34wFLMuQTnDxwUThgzhPimvSVcnI2rpqOb0hCLKhd
         viB50mL+V/HuT13gD0dJc/Pi0j5DCwUUH+qEBhzfY6h/Cjg0rRA6+jFK6bnveqS0rNDO
         lHsQ4KZqzindpP+UZjeeiz2+fKswe/2zJNN5BTZsphgu/FUDjADeIkiOE7ICBKwO/31j
         +8UoENl/RTohakihwLsm0RBwwn++jrGrmTGREk6RWUrUdyze6btBvJeXL6HSD+26vNEv
         p04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6XAUjyy8dM+memUfQW8WuFfjcJaprUOz9KHY1fZCoGw=;
        b=LaCCVetFB71ZEjAGbRC5RFiXtwHikdg0Y0czDsHflscqLSUTBCZS5BIv0LLwPDsvNx
         5vmpvlSegUM8ORXHuhARIvfsokOGIO42I0jiTcbLogDNT7O6IXGj9CpttspyG6f1Fo48
         vqKzgoa/EbXpdE8J/cA2d8moOXVyIKZBgxkZ8XRTNwEEu6lUjvXuCIP04kt46I5lerY2
         nKLQJ11LVejEqxxuZf9MclLAhV1rcJjSFSN6runICsVN4+O82QSls4st0iga2tYC9rnp
         hWC5kmpOXECfwd9ZbehigeS6pyfsVaG9xsaD0hPPcjtmxleOrC0LTBVQTzRlonug5/c7
         mg5w==
X-Gm-Message-State: ACrzQf31wCRwKCopRFu93TrzH2bBy3m+Hl1bH5v+zzRMqnt7C98D34TB
        MlDLC9LYBfcwM8Mm3eue9ovGew==
X-Google-Smtp-Source: AMsMyM7JqeZAVXgNGynCXgynjXwAyFE7hjSnnBDGmaNtLpXl6XjEgEHwd4IDXyVuMlRfZxPvwlNagg==
X-Received: by 2002:a63:1606:0:b0:43c:b5e1:5c52 with SMTP id w6-20020a631606000000b0043cb5e15c52mr15584384pgl.250.1664388209513;
        Wed, 28 Sep 2022 11:03:29 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j3-20020a63ec03000000b0043057fe66c0sm3864080pgh.48.2022.09.28.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:03:28 -0700 (PDT)
Date:   Wed, 28 Sep 2022 18:03:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v3 05/28] KVM: x86: Don't inhibit APICv/AVIC if xAPIC ID
 mismatch is due to 32-bit ID
Message-ID: <YzSMbSXQXyUY7M7G@google.com>
References: <20220920233134.940511-1-seanjc@google.com>
 <20220920233134.940511-6-seanjc@google.com>
 <d02d0b30-f29b-0ff6-98c7-89ddcd091c60@oracle.com>
 <e5d54876b233dc71a69249c3d02d649da5040a14.camel@redhat.com>
 <YzR7ezt67i1lH1/b@google.com>
 <1aea43e831cd7ed90c325b2c90bc6f3f9a1805b5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aea43e831cd7ed90c325b2c90bc6f3f9a1805b5.camel@redhat.com>
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

On Wed, Sep 28, 2022, Maxim Levitsky wrote:
> On Wed, 2022-09-28 at 16:51 +0000, Sean Christopherson wrote:
> > > > It happens regardless of vCPU count (tested with 2, 32, 255, 380, and 
> > > > 512 vCPUs). This state persists for all subsequent reboots, until the VM 
> > > > is terminated. For vCPU counts < 256, when x2apic is disabled the 
> > > > problem does not occur, and AVIC continues to work properly after reboots.
> > 
> > Bit of a shot in the dark, but does the below fix the issue?  There are two
> > issues with calling kvm_lapic_xapic_id_updated() from kvm_apic_state_fixup():
> > 
> >   1. The xAPIC ID should only be refreshed on "set".
> True - I didn't bother to fix it yet because it shouldn't cause harm, but
> sure this needs to be fixed.

It's probably benign on its own, but with the missing "hardware enabled" check,
it could be problematic if userspace does KVM_GET_LAPIC while the APIC is hardware
disabled, after the APIC was previously in x2APIC mode.  I'm guessing QEMU does
KVM_GET_LAPIC state when emulating reboot, hence the potential for being involved
in the bug Alejandro is seeing.

> >   2. The refresh needs to be noted after memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s));
> Are you sure? The check is first because if it fails, then error is returned to userspace
> and the KVM's state left unchanged.
> 
> I assume you are talking about 
> 
>         ....
> 	r = kvm_apic_state_fixup(vcpu, s, true);
> 	if (r) {
> 		kvm_recalculate_apic_map(vcpu->kvm);
> 		return r;
> 	}
> 	memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s));

This isn't a failure path though, it's purely a "take note of the update", and
KVM needs to do that processing _after_ the actual update.  Specifically,
kvm_lapic_xapic_id_updated() consumes the internal APIC state:

	if (kvm_xapic_id(apic) == apic->vcpu->vcpu_id)
		return;

Calling that before the internal state has been set with the incoming state from
userspace is simply wrong.

The check that the x2APIC ID is "correct" stays where it is, this is purely the
"is the xAPIC ID different" path.
