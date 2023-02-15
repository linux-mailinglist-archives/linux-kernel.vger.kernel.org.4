Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65B6987FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBOWgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBOWgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:36:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6437556
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:36:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f187-20020a251fc4000000b0087f69905709so54583ybf.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIQXENS2+4sMRi90b513aA2Q153GZQ5k/QlHWLrBT2A=;
        b=ZYNMMFGaenxLALBL2wkoeLLWcRxUq1y7auD4MvNvGfv7MW/Zzc/6OHVvmxXZRo37Ts
         8/VwxU1tz7UOrJDGnVVvI9umeMJ8Mrwf4dkYFiLWNbBJJn2StxZrQIbSnrz91gyzZYYX
         uOyl7AUZuu1wbDe2EHq/mdEBIDBLp/2mfczeovyZsREMzhd2TkaxmVpMygdx0JcoRJuC
         xD++nMj3f6cIhIUyh2bjcr+O3TbIvzS7aLGXeMYY0WcmhH3cm/voZhTh1tK+Rqc9MD0U
         1EA4n4R9MpBLmY7RjZvdOFeVHRRjPNO/C+va5TZ5TJdYdKgR6y0xE6zSfNfGgM8S0/se
         +AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIQXENS2+4sMRi90b513aA2Q153GZQ5k/QlHWLrBT2A=;
        b=CCAbm/cKyjh7mzGxa+/mzQvNWgyR2fVpVnPxJ3CEu2k+e9d8sNxc///6ywQyjQLfK0
         e6LUBGwYdtY+mVV5VLq8nvGREPAsWFKUnmBhQsDsLWEMvE7KRDc+ZAOfK4m0T3ceS9en
         xzrdSjg76mZALhDUaZPHELjt2zQro3LM0bOVouv019wDOvkXtVqA50nOFCXbKXinMv+y
         xXorq26zWWqLKx3bgNSMvzqgKMcuNFWM1q14UjhSCyehQF/hTmJOwVog2o4Wb4ylcAN2
         6v6rtNICkFbTd7N42i1GUAGfjvUUcS8tyu5F233qQm9mkI292VrqtRmCqEiDIeMzSmTq
         HmTw==
X-Gm-Message-State: AO0yUKUOmU6I0a5Ttb8tXBzt8t92MTPBvquzXkTymuKprvMpbDCNOogh
        74cY+7+LUmSdsUwE4vaTt0fTiYrWZ4g=
X-Google-Smtp-Source: AK7set9tYoNoI6QJwihu1gK/MM6fk7qfD/5z/sIGddBwvpoJr9Je1x7HajVcrjAMbO/AaomTOeaybmdzZf4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:dc41:0:b0:52e:cebf:a440 with SMTP id
 f62-20020a0ddc41000000b0052ecebfa440mr444390ywe.242.1676500595047; Wed, 15
 Feb 2023 14:36:35 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:36:33 -0800
In-Reply-To: <4f0d03de-4372-2472-ef59-e80bb3aa7703@gmail.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com> <20230210003148.2646712-6-seanjc@google.com>
 <4f0d03de-4372-2472-ef59-e80bb3aa7703@gmail.com>
Message-ID: <Y+1ecVEQhgEGIqMy@google.com>
Subject: Re: [PATCH v2 05/21] KVM: x86: Disallow writes to immutable feature
 MSRs after KVM_RUN
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023, Like Xu wrote:
> On 10/2/2023 8:31 am, Sean Christopherson wrote:
> > @@ -2168,6 +2187,23 @@ static int do_get_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
> >   static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
> >   {
> > +	u64 val;
> > +
> > +	/*
> > +	 * Disallow writes to immutable feature MSRs after KVM_RUN.  KVM does
> > +	 * not support modifying the guest vCPU model on the fly, e.g. changing
> > +	 * the nVMX capabilities while L2 is running is nonsensical.  Ignore
> > +	 * writes of the same value, e.g. to allow userspace to blindly stuff
> > +	 * all MSRs when emulating RESET.
> > +	 */
> > +	if (vcpu->arch.last_vmentry_cpu != -1 &&
> 
> Three concerns on my mind (to help you think more if any):
> - why not using kvm->created_vcpus;

Because this is a vCPU scoped ioctl().

> - how about different vcpu models of the same guest have different
> feature_msr values;

KVM shouldn't care.  If KVM does care, then that's a completely orthogonal bug
that needs to be fixed separately.

> (although they are not altered after the first run, cases (selftests) may be
> needed to
> show that it is dangerous for KVM);
> 
> - the relative time to set "vcpu->arch.last_vmentry_cpu = vcpu->cpu" is
> still too late,
> since part of the guest code (an attack window) has already been executed on first
> run of kvm_x86_vcpu_run() which may run for a long time;

Again, this is a vCPU scoped ioctl.  The task doing KVM_RUN holds vcpu->mutex so
there is no race.
