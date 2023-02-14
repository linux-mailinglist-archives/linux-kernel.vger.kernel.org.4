Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C82696D52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjBNSvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjBNSvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:51:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EF24224
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:51:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c11ae6ab25so168326117b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBABwlFNTWMj+OjkJm26ysoCCOBdecl6mEpKIPGdoU0=;
        b=dJ82eLB/kuIvWdVkC/59SzpMuWdofWypOJfKy8sZBOyhrEZA+PC0dJ9W3iEddR3aMc
         Lqd3Py6GYkRG/iI63g90bJs3wLGPib4ROQc5/t19/kWUZ48XCVSXUJAWn8xC0SZYh8M0
         zGClqScCLvwyoxW0XwL2UE6DghdhJfdPxJ+iiXcYl9v2ubWyPnQD1DvIvGqLv9g12NKZ
         muTvwj5ixhqxrBP7IyqorCFppNQ/iqfP/pYjsVdBj+A3R+PBKL6MGm3gWV+FVPSmhpyL
         pI5bizntZQpmJEpoP20IraPbBOBL9+OZbFf6BF2az54lI1G1lCqXkOfxlbaoi2j8nNtC
         UmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBABwlFNTWMj+OjkJm26ysoCCOBdecl6mEpKIPGdoU0=;
        b=YmF9kPf0EHI//CYuJF+1cjOtNXxu896Z69mDA9g3gB2xuACOSA0bGnu+QUzD51lgOt
         c65QFUP4g+cuD9lCPBtbPklRYL41OyARBblNxcp1VB0/SwpNOP6zWgj5X0fbCVYgr5rJ
         e4XKEa3ek3cMh/xyF/xL5WFjAb11fw7RVqkaJuInDERXpQM/TSHx5KJYPkL3A+Y2m3nb
         m9pJOL+zYgZDASs8XyrWROu3y2FkyXe0ugmJnYgen/+dvOjXikHyqSLL0MnnWFpAzcfI
         Xs0L3+kBTx+uWSKvK3OpMYApGdrjXu/2Yv0xNIoxLbi481J18YSxJcXVFG7ZwsZF3IBi
         zcRw==
X-Gm-Message-State: AO0yUKVt+NlqRVmeGApxrvq2bmgvcvZ9/oapF0EXindsrOHN1oaSpCY4
        LagcuUsNmDMJqllDmGFkHE4mNrC1SY4=
X-Google-Smtp-Source: AK7set/SNZbRFHqvZ7ACMxDYON677YCI5I8pZlgQQujkfw+QOIWB6rggnifY3rIXZOpKoomJfrYdkIGlxWU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:6804:0:b0:527:1a01:964c with SMTP id
 d4-20020a816804000000b005271a01964cmr411317ywc.480.1676400702514; Tue, 14 Feb
 2023 10:51:42 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:51:40 -0800
In-Reply-To: <5771a4cb-4df7-e9a0-9e7e-9a116a40a411@gmail.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com> <20230210003148.2646712-4-seanjc@google.com>
 <5771a4cb-4df7-e9a0-9e7e-9a116a40a411@gmail.com>
Message-ID: <Y+vYPDY82Z/7VBal@google.com>
Subject: Re: [PATCH v2 03/21] KVM: x86: Add macros to track first...last VMX
 feature MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
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
> > +/*
> > + * The first...last VMX feature MSRs that are emulated by KVM.  This may or may
> > + * not cover all known VMX MSRs, as KVM doesn't emulate an MSR until there's an
> > + * associated feature that KVM supports for nested virtualization.
> > + */
> > +#define KVM_FIRST_EMULATED_VMX_MSR	MSR_IA32_VMX_BASIC
> > +#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_VMFUNC
> 
> Off-topic, we now have "#define MSR_IA32_VMX_PROCBASED_CTLS3 0x00000492",
> any further changes needed here if L2 guest needs IPI virtualization or why not ?

If KVM exposes IPI virtualization, or any other feature that depends on tertiary
controls, to L1, then yes this will need to be extended.  But that will naturally
happen as part of any such enabling, otherwise userspace won't be able to do
anything with L1's tertiary controls.

As for supporting IPI virtualization for nested VMs, that's definitely future work.
I haven't though about it too much, but I assume it's a similar story to AVIC where
KVM would need to shadow L1's PID table.
