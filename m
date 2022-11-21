Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D99632000
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiKULNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiKULNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B59B963B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669028863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNuyVgSMX/ajeMNmF/4b1DUvMDeMPy/4E3AU3e3kKQU=;
        b=ipX7dfVkQrNyHIZyPJzsl1OXhNhqM79cDuu/CTySlamfW1JNNBwHn2JWxbwtJLEUmX5Yg6
        dUzaeRO8NhNZgywmCWKaVAch3q1zo3wkcsUU608UF3QjeQACuOy8PdPPvCHtfzqOmPAWWH
        WXg6Ry0wEtsU/N9uYW27D49KEilOBmo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-nHLK6ttdPFeWrZQUSyc9gA-1; Mon, 21 Nov 2022 06:07:42 -0500
X-MC-Unique: nHLK6ttdPFeWrZQUSyc9gA-1
Received: by mail-wr1-f71.google.com with SMTP id k7-20020adfc707000000b002416f2e9ad5so3090389wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNuyVgSMX/ajeMNmF/4b1DUvMDeMPy/4E3AU3e3kKQU=;
        b=y9G7GW6tiKiyI7EhbNIZpHZGe0szplS/2sVwFWQmQ2ClW2K2O5tYzOMF2AxrJgwGVM
         tI5vxlQN/K4vhU9MnUV1V0ogozIHA4Dsc3+u+JQ3YJF2K7bIXh7KzeLGUjITHK0dkN/+
         i9GeGSjo2bAtSVBIZCWLJuNzry0VEa4Qfe7b3B78W8c4cpYSJIHd+6XHPGucAu0l12ng
         Uv6Q97HDpLqBbJZCVOUG87kiscfszxudlcNo9UTIYnxsl8Gcqk1xwEBbXAk92JdeN/r4
         qIsuVfjfmC7533rmEOrF6nQ7OA4vy6Extr++2DpW6OAcISsLKHEbEcaiTNh+cMWRUOQV
         B4xw==
X-Gm-Message-State: ANoB5plMScVt/nysL1bPnaK7RFRiYc27qrWu6o9UthznbDUXXY4GE5mu
        rW25cvIgMbojGnFy2Tl9KXb7Fjuroo/rmjF7DBZUurs5L1RKzTPIMz0OqRtpnoemOM0GKP201nr
        3pztBeYTyQPJqliZOMhMt1Wpr
X-Received: by 2002:adf:fb12:0:b0:236:60e8:3cca with SMTP id c18-20020adffb12000000b0023660e83ccamr4505603wrr.471.1669028861413;
        Mon, 21 Nov 2022 03:07:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Tx2y2Y1smXnHRhOhJ81J74U3+HhoNnCAbQfBkdFVjvc7NuYnBWQPVlTYlY79K73/EmsGh9Q==
X-Received: by 2002:adf:fb12:0:b0:236:60e8:3cca with SMTP id c18-20020adffb12000000b0023660e83ccamr4505590wrr.471.1669028861101;
        Mon, 21 Nov 2022 03:07:41 -0800 (PST)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm10878550wrw.59.2022.11.21.03.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:07:40 -0800 (PST)
Message-ID: <3829b20beeeed8ec2480eada30b2639b07bc579e.camel@redhat.com>
Subject: Re: [PATCH 02/13] KVM: nSVM: don't call
 nested_sync_control_from_vmcb02 on each VM exit
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sandipan Das <sandipan.das@amd.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jing Liu <jing2.liu@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Babu Moger <babu.moger@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org
Date:   Mon, 21 Nov 2022 13:07:38 +0200
In-Reply-To: <Y3aT5qBgOuwsOeS/@google.com>
References: <20221117143242.102721-1-mlevitsk@redhat.com>
         <20221117143242.102721-3-mlevitsk@redhat.com> <Y3aT5qBgOuwsOeS/@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-17 at 20:04 +0000, Sean Christopherson wrote:
> On Thu, Nov 17, 2022, Maxim Levitsky wrote:
> > Calling nested_sync_control_from_vmcb02 on each VM exit (nested or not),
> > was an attempt to keep the int_ctl field in the vmcb12 cache
> > up to date on each VM exit.
> 
> This doesn't mesh with the reasoning in commit 2d8a42be0e2b ("KVM: nSVM: synchronize
> VMCB controls updated by the processor on every vmexit"), which states that the
> goal is to keep svm->nested.ctl.* synchronized, not vmcb12.  Or is nested.ctl the
> cache you are referring to?

Thanks for digging that commit out.

My reasoning was that cache contains both control and 'save' fields, and
we don't update 'save' fields on each VM exit.

For control it indeed looks like int_ctl and eventinj are the only fields
that are updated by the CPU, although IMHO they don't *need* to be updated
until we do a nested VM exit, because the VM isn't supposed to look at vmcb while it
is in use by the CPU, its state is undefined.

For migration though, this does look like a problem. It can be fixed during
reading the nested state but it is a hack as well.

My idea was as you had seen in the patches it to unify int_ctl handling,
since some bits might need to be copied to vmcb12 but some to vmcb01,
and we happened to have none of these so far, and it "happened" to work.

Do you have an idea on how to do this cleanly? I can just leave this as is
and only sync the bits of int_ctl from vmcb02 to vmcb01 on nested VM exit.
Ugly but would work.




> 
> > However all other fields in the vmcb12 cache are not kept up to  date,
> 
> IIUC, this isn't technically true.  They are up-to-date because they're never
> modified by hardware.

In both save and control cache. In control cache indeed looks like the
fields are kept up to date.

Best regards,
	Maxim Levitsky

> 
> > therefore for consistency it is better to do this on a nested VM exit only.
> 
> Again, IIUC, this actually introduces an inconsistency because it leaves stale
> state in svm->nested.ctl, whereas the existing code ensures all state in
> svm->nested.ctl is fresh immediately after non-nested VM-Exit.
> 


