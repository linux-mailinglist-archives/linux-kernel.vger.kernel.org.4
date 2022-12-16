Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176E964F1E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiLPTkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiLPTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:40:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483718B00
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:40:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t17so3473147pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvVKBxmjyc40Aovy4uKIkd/GsUUTIzX8idkZXVS4G6E=;
        b=DncFDm87BS/3OUuqmSyzK5JwSvzMfn4ygYxeWWmaFLbxgZlXUA3/XT+oc7z0lUO8qv
         vYn9PzeWffXEYpdm3wcvWkjwsq4E5hIUSYUyOftb8WXxxTtyXYeI2hIVCA/hkTJ1BajZ
         eoWGheONzsAJqxeAZzkSdcC2fcIr03Tage84EOrLL5wrM3hbYVanRPRovBUVJhXOBPPQ
         t9v4k1Rc/u79q5i3p1z7UwvET4PyMc/1Elb//1x4oJxxzqpprdMoV+3Ero4pSqAuPNYa
         3l5zW+Mjbk/IADnNRarBwme9dTW510+M/klAmUBjL0rkfSAAAx9cECzyT+MqDmYDNIyO
         4e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvVKBxmjyc40Aovy4uKIkd/GsUUTIzX8idkZXVS4G6E=;
        b=uTH1YrFv42kasQOGuCH9THbLS/ZuwPhsw2AvOMe8aTmAIJJ/vJhsOwuNwjbCz4P24+
         YBqlj1H67KH312Nfv5o9rk3pBuSW6VwN/Mzuo8P2kYslFEjKiQV8gXjoekUCFOlnwz6W
         UquYGkU1R34z48MJbPxbsJBpeUz/IU7TEI/YcCTYwfvJkItA1ltD5FEf8V9XAZ0ro7Bk
         sUlLw1sOQcZejhLzofxtQ5X8+obVv24vF6g3npH2l22x06n/5McfQN+FxgKH9jA+xerH
         J3KG0azU31U9fTfiBgTB/ZqLbQ0me0VoGYp8CfGw/NSyEbeKRW/pG4vPWMznE9aedK5G
         xziw==
X-Gm-Message-State: AFqh2kpenLs/BMCU92X61bIXTCylHS+Qq8+KFzmsJt7mhhOH/D1wXdpF
        J3eeqp9PIYUDLo8854Jk5DZaow==
X-Google-Smtp-Source: AMrXdXtOxIsKz7LMW0io6hRDovz6UAfRfn8xRV2LKCX3QTFqqW4USuRmVMB7QYP/4CaY/2Tnv96HFA==
X-Received: by 2002:a05:6a21:151b:b0:a7:891b:3601 with SMTP id nq27-20020a056a21151b00b000a7891b3601mr712797pzb.1.1671219634188;
        Fri, 16 Dec 2022 11:40:34 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l10-20020a63f30a000000b00470275c8d6dsm1826573pgh.10.2022.12.16.11.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:40:33 -0800 (PST)
Date:   Fri, 16 Dec 2022 19:40:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v4 11/32] KVM: x86: Inhibit APIC memslot if x2APIC and
 AVIC are enabled
Message-ID: <Y5zJraa0ddooauXB@google.com>
References: <20221001005915.2041642-1-seanjc@google.com>
 <20221001005915.2041642-12-seanjc@google.com>
 <90d4a2a1733cdb21e7c00843ddafee78ce52bbdc.camel@redhat.com>
 <Y5zBH+2VuPJi4yYV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5zBH+2VuPJi4yYV@google.com>
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

On Fri, Dec 16, 2022, Sean Christopherson wrote:
> On Thu, Dec 08, 2022, Maxim Levitsky wrote:
> > I prefer to just have a boolean 'is_avic' or,
> > '.needs_x2apic_memslot_inhibition' in the vendor ops, and check it in
> > 'kvm_vcpu_update_apicv' with the above comment on top of it.
> > 
> > need_x2apic_memslot_inhibition can even be set to false when x2avic is
> > supported at the initalization time, because then AVIC behaves just like
> > APICv (when x2avic bit is enabled, AVIC mmio is no longer decoded).
> 
> Oh, so SVM does effectively have independent controls, it's only the "hybrid" mode
> that's affected?  In that case, how about this?
> 
> 	/*
> 	 * Due to sharing page tables across vCPUs, the xAPIC memslot must be
> 	 * deleted if any vCPU has x2APIC enabled and hardware doesn't support
> 	 * x2APIC virtualization.  E.g. some AMD CPUs support AVIC but not
> 	 * x2AVIC.  KVM still allows enabling AVIC in this case so that KVM can
> 	 * the AVIC doorbell to inject interrupts to running vCPUs, but KVM
> 	 * mustn't create SPTEs for the APIC base as the vCPU would incorrectly
> 	 * be able to access the vAPIC page via MMIO despite being in x2APIC
> 	 * mode.  For simplicity, inhibiting the APIC access page is sticky.
> 	 */
> 	if (apic_x2apic_mode(vcpu->arch.apic) &&
> 	    !kvm_x86_ops.has_hardware_x2apic_virtualization)

Hrm, that's not quite right either since it's obviously possible to have an Intel
CPU that supports APICv but not x2APIC virtualization.  And in that case KVM
doesn't need to inhibit the memslot, e.g. if not all vCPUs are in x2APIC.

I was hoping to have a name that communicate _why_ the memslot needs to be
inhibited, but it's turning out to be really hard to come up with a name that's
descriptive without being ridiculously verbose.  The best I've come up with is:

	allow_apicv_in_x2apic_without_x2apic_virtualization

It's heinous, but I'm inclined to go with it unless someone has a better idea.
