Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8925E6A08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiIVR4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIVR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:56:02 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A37EC542
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:56:00 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11eab59db71so14926774fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=t9sywruqcuKyY9MOVDQxFF5A99e42M9asDqWWcnjP1g=;
        b=f8iOwOZDaGvsk1kJiLcpnxW5pf3fBnQTVD4woOnEBJl8xrz9zaeBzsYIIXyAyd16SS
         Gpr1A/Ix7iTMV3G0SuFqbxyIN6X3AbRMV8WZ8TPSNcEvHOx6vqLgITW6IRFsaglvo4LR
         y6XNHmxAqOnQZWFs/nr0MC3Xo8xfGqRQQIdG1GwKZPLX7HqHuarB21OBhZQL+5v4/9Z8
         hRXy4HFv6pSrQWpcrBHlx5yFCmEW3n75JLHwCkW1twjNgvmutCpYituv1dpM9FFQlsMZ
         wbDvvT6OcIxkZBd3EkwdDiMmolcKMmtSGp83g0J/nNba7d8eGkFXOooP5OZC5KdwOywo
         cRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t9sywruqcuKyY9MOVDQxFF5A99e42M9asDqWWcnjP1g=;
        b=mOnr5CEgPFSCO02chI21myIQZmj/QG6NXDH0w+IjXT8JAAk8h4aMK/zBY3t+gYKTfJ
         vld3J6DPMdHkxBbbMlvAAE/sf3g/7yGjRGtah1ZOSMegEME3B7/XJ3eeJlIvYL97ZOAD
         //NvJAbgSbhDWYv6ngl3EeA8NGI9S1cPIvbFWvCWVSHg0TL3NjVyBBrqwFdBkLwhq9jn
         8xB+8hLt+rx2YDol9yRRRgWfQpnc3fMKIRBIRVVSI5rqXGFD4Z95H/GW/Jv081MwGoS8
         gLTk/LQN26UCzBeIE0sH26irBYdzNkLQypN2moL64WlVQfrMiWAyuPU0ZNbuqzZDX+S0
         KDGQ==
X-Gm-Message-State: ACrzQf1ajy7vIsBm+8+o27u5kRTz+h9WvzZugcLCju3BSpNKzGRmJWWM
        +xPGKlslUllzh3M3aYYetUqxhGbToh1QJT9X+vc+wA==
X-Google-Smtp-Source: AMsMyM4f7HZsorZh9Oc9dnMigbdijdeZCWk/IN1jZJHRpTNiH4MjQiAYgzR8hOZ6mUUDLZ/VbEGM6NB97xPlvZUhZs8=
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id
 r12-20020a056870580c00b0012af136a8f5mr8779885oap.269.1663869359794; Thu, 22
 Sep 2022 10:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220922143655.3721218-1-vkuznets@redhat.com> <20220922143655.3721218-3-vkuznets@redhat.com>
 <CALMp9eSVQSMKbYKr0n-t3JP58hLGA8ZHJZAX34-E4YWUa+VYHA@mail.gmail.com> <YyyhBTXdj96crwbZ@google.com>
In-Reply-To: <YyyhBTXdj96crwbZ@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 22 Sep 2022 10:55:49 -0700
Message-ID: <CALMp9eSwFYX67OL3rTNR4-nDT1i5cD36B4KcPh-RHM2UmXBMNw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] KVM: x86: Introduce CPUID_8000_0007_EDX
 'scattered' leaf
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Sep 22, 2022 at 10:53 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Sep 22, 2022, Jim Mattson wrote:
> > Why do we need a new 'scattered' leaf? We are only using two bits in
> > the first one, right? And now we're only going to use one bit in the
> > second one?
> >
> > I thought the point of the 'scattered' leaves was to collect a bunch
> > of feature bits from different CPUID leaves in a single feature word.
> >
> > Allocating a new feature word for one or two bits seems extravagant.
>
> Ah, these leafs aren't scattered from KVM's perspective.
>
> The scattered terminology comes from the kernel side, where the KVM-only leafs
> _may_ be used to deal with features that are scattered by the kernel.  But there
> is no requirement that KVM-only leafs _must_ be scattered by the kernel, e.g. we
> can and should use this for leafs that KVM wants to expose to the guest, but are
> completely ignored by the kernel.  Intel's PSFD feature flag is a good example.
>
> A better shortlog would be:
>
>   KVM: x86: Add a KVM-only leaf for CPUID_8000_0007_EDX

Thanks. The 'scattered' terminology seems more confusing than enlightening.
