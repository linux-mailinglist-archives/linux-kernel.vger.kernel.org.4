Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E65864BBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiLMSJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiLMSIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:08:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC852495A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:08:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m18so38501554eji.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVv2lGS1QtPOv9VnNMYzD4yPosTBNSmpDviAz4kDLPY=;
        b=peLCiPoJN8N8Tb1p6aW0ZcLLW9eQVYFHieGIH+/soE2mJmhBOAE8pgEhFeJerRRajT
         V87AYez/AJLPfiPnujhTZ6JT06R8VkU/8lZyIjK6d9NDWFT3lpIGHW2TCsE3ze/vTjLu
         pMiH3eIoOVedW9v4FHFVP4gg2sTTF+UooGVpFrzyGYMok6+ySeT5WjIQUw2VHAZTUuEH
         waXdjO1JuWmBiMIvNz7yf/SCMzj7UMx6Qom2F3K6hY8D/6ayk5k5aYT4K0CMGnXoWvsK
         96A3S5HXcN/MM3KDlycAfKI09fQ44Ht7hZnUNSOse/gKkpXLXhypMfMbM0q7yESWnyj8
         FxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVv2lGS1QtPOv9VnNMYzD4yPosTBNSmpDviAz4kDLPY=;
        b=QtU8ifFHcS+v5luKvL/PbPuzQJFnYiST/2kwOaNPSkMGSJZiY4hoSUCI9mHY7lEJ0F
         lIXCfbIMFF2ZZfv8n1iciE01IG6eiOIwawIjt/y93XRlv1LhUtWVpprwbFlTwj6Hpoqj
         rZcfxgoB5g+MLpQSz+9holUjgtE5JHObfn+7HlxVmXiYN7LmpsmRAu9iTvz+spRDUTsX
         nNEtTmffEdp7dz8hwGQo50uTNk6WSQvcIwgV6tnfx2C6ipsYHl/wY3J3NZ3Iyj4+8Rbx
         ShGTgwriDVC/jDE206R1VyJbsCWgugou/Jo3DFlQ9FPMLoQHN2LfSs5kn06RCaVDh+2/
         alQA==
X-Gm-Message-State: ANoB5plBk0Mk9v+P7nW/DKk6I5ykoRxsNCB6nPvb1wO7WhZX33ZjE7z8
        unnPaszv4VZvqAo6rj1c10YquIsc0w+l281r702prg==
X-Google-Smtp-Source: AA0mqf7EIHynCnOgfqnf8iFQCVyDpM+L9k0NdgVvyfQgxnXZJP8tCzxnleMIyAWGCKcW/91EzMvI3XSvdxT9NvSR9rQ=
X-Received: by 2002:a17:906:c250:b0:7c0:9bc2:a7f0 with SMTP id
 bl16-20020a170906c25000b007c09bc2a7f0mr31409306ejb.59.1670954924310; Tue, 13
 Dec 2022 10:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20221213062306.667649-1-seanjc@google.com> <20221213062306.667649-2-seanjc@google.com>
In-Reply-To: <20221213062306.667649-2-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 13 Dec 2022 10:08:33 -0800
Message-ID: <CALMp9eSsH5UO4=NXOwEWzyqswBQacX7K13X+Tzy6bTQDBatc-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: nVMX: Properly expose ENABLE_USR_WAIT_PAUSE
 control to L1
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aaron Lewis <aaronlewis@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

On Mon, Dec 12, 2022 at 10:23 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Set ENABLE_USR_WAIT_PAUSE in KVM's supported VMX MSR configuration if the
> feature is supported in hardware and enabled in KVM's base, non-nested
> configuration, i.e. expose ENABLE_USR_WAIT_PAUSE to L1 if it's supported.
> This fixes a bug where saving/restoring, i.e. migrating, a vCPU will fail
> if WAITPKG (the associated CPUID feature) is enabled for the vCPU, and
> obviously allows L1 to enable the feature for L2.
>
> KVM already effectively exposes ENABLE_USR_WAIT_PAUSE to L1 by stuffing
> the allowed-1 control ina vCPU's virtual MSR_IA32_VMX_PROCBASED_CTLS2 when
> updating secondary controls in response to KVM_SET_CPUID(2), but (a) that
> depends on flawed code (KVM shouldn't touch VMX MSRs in response to CPUID
> updates) and (b) runs afoul of vmx_restore_control_msr()'s restriction
> that the guest value must be a strict subset of the supported host value.
>
> Although no past commit explicitly enabled nested support for WAITPKG,
> doing so is safe and functionally correct from an architectural
> perspective as no additional KVM support is needed to virtualize TPAUSE,
> UMONITOR, and UMWAIT for L2 relative to L1, and KVM already forwards
> VM-Exits to L1 as necessary (commit bf653b78f960, "KVM: vmx: Introduce
> handle_unexpected_vmexit and handle WAITPKG vmexit").
>
> Note, KVM always keeps the hosts MSR_IA32_UMWAIT_CONTROL resident in
> hardware, i.e. always runs both L1 and L2 with the host's power management
> settings for TPAUSE and UMWAIT.  See commit bf09fb6cba4f ("KVM: VMX: Stop
> context switching MSR_IA32_UMWAIT_CONTROL") for more details.
>
> Fixes: e69e72faa3a0 ("KVM: x86: Add support for user wait instructions")
> Cc: stable@vger.kernel.org
> Reported-by: Aaron Lewis <aaronlewis@google.com>
> Reported-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
