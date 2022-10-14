Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5235FF449
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJNUEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJNUEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:04:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6EC67
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:04:38 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u71so5247108pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbwkanpKDCzBUU6gmctb+QrCeHgMxWi09XjJZDjO5eQ=;
        b=X/8GV42PFEbwb1G42LBdmwiFnIlQkobhhcbf2afrVFAK/kAzcsrOrlGPim+kJih52X
         YEK9xn2aX6LsCZGwuadCycmbegoWPQD/TLpE4JOZDawCpM6yoovy4D+vbxkNNzK2bZ21
         exkd6HtoXl7jie6ASLErpWPPxFqfelw3JeWKiuJjWIXClxMXVe0zl+f5Ob/DcEXoRqQG
         5hrPH8uYnrRbMADhWTWiowZP49+fF6B4VtMJ5drYYBZEBIyiPdB2J+uoQnt/aDCDpxI6
         bwIZmYKOLSn7ZXAHq8nLORAGhHIgfO7G8z0mfZzr9aVgi3FFCikocklfxoLkFTrgrXS7
         vNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbwkanpKDCzBUU6gmctb+QrCeHgMxWi09XjJZDjO5eQ=;
        b=PAS9R8CX7/0MZ34U7vty7qk3u5YxjSGZ1AR7WlLYFzEJfhHvPurHgqoziv4JNlhR6v
         QQG+jJ1VZSj3gO2TQWrL7S2Ujno8LaMNBi5rC6p/Z+2gbdv96Lf0Gzpz0AdXi9EFDrrc
         WHs37xXAiz2l52naUZFhaQDv1OE7N8QQcLqn44GmQrpG7H3uritxyw5yCJgb8DDMwhXi
         vsVZlFTcnwkScWw07kfDaQV0lzfom/F3vDF7hquJnM8lUJ9qWpuAY6fgKr54GKzCj6ys
         j55HFdryFPdwdFIoFLytGdIpBRr9xduEu+3JoK6lmuPjCUfFE0Zo8JSZZgoIQQJAcYn8
         DVUg==
X-Gm-Message-State: ACrzQf10IxOanP+03+V9Da5/cS7g6zAYN/ed6jxiMk+MiVRdTZhjnzWM
        34KeLotzCTXFHJc9NRf6rHSj6w==
X-Google-Smtp-Source: AMsMyM7EBrEJiEtubCYTKLnlZSzu9M+zSixvrqFOxZtlxIoJYG4IoVQpLoMoGVuCpNVtnXuZY+vYvg==
X-Received: by 2002:a62:1482:0:b0:55f:eb9a:38b2 with SMTP id 124-20020a621482000000b0055feb9a38b2mr7003442pfu.29.1665777877646;
        Fri, 14 Oct 2022 13:04:37 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g18-20020aa79dd2000000b0056149203b60sm2136445pfq.46.2022.10.14.13.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:04:37 -0700 (PDT)
Date:   Fri, 14 Oct 2022 20:04:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] KVM: x86: Hyper-V invariant TSC control feature
Message-ID: <Y0nA0DCeh4IPmWMX@google.com>
References: <20221013095849.705943-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013095849.705943-1-vkuznets@redhat.com>
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

On Thu, Oct 13, 2022, Vitaly Kuznetsov wrote:
> Normally, genuine Hyper-V doesn't expose architectural invariant TSC
> (CPUID.80000007H:EDX[8]) to its guests by default. A special PV MSR
> (HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x40000118) and corresponding CPUID
> feature bit (CPUID.0x40000003.EAX[15]) were introduced. When bit 0 of the
> PV MSR is set, invariant TSC bit starts to show up in CPUID. When the 
> feature is exposed to Hyper-V guests, reenlightenment becomes unneeded.
> 
> Note: strictly speaking, KVM doesn't have to have the feature as exposing
> raw invariant TSC bit (CPUID.80000007H:EDX[8]) also seems to work for
> modern Windows versions. The feature is, however, tiny and straitforward
> and gives additional flexibility so why not.
> 
> Vitaly Kuznetsov (7):
>   x86/hyperv: Add HV_EXPOSE_INVARIANT_TSC define
>   KVM: x86: Add a KVM-only leaf for CPUID_8000_0007_EDX
>   KVM: x86: Hyper-V invariant TSC control
>   KVM: selftests: Rename 'msr->available' to 'msr->fault_exepected' in
>     hyperv_features test
>   KVM: selftests: Convert hyperv_features test to using
>     KVM_X86_CPU_FEATURE()
>   KVM: selftests: Test that values written to Hyper-V MSRs are preserved
>   KVM: selftests: Test Hyper-V invariant TSC control

For the series, in case Paolo ends up grabbing this:

Reviewed-by: Sean Christopherson <seanjc@google.com>
