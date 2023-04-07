Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4E6DA7A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbjDGCSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbjDGCSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:18:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9C19A2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:18:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e22-20020a25e716000000b00b8c0264c7bdso2478787ybh.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 19:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680833920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NM3Z7cWxI8VgV2XX878CM3uoNsycYkoMYtaVz8/N1I0=;
        b=JGWnVDonFr7VmZ2kaJUOTe//CwQ+BYZhctxv/nQh12y8X44DdQq2iVCQBI9tqZxGd/
         0KquaLo1cvhtPAH0IlRjD8MPKMTxKugwlzhjJP2l1LtcDbDXPBESuAwf1d1+k6MrnOHU
         D1XiV1c3GqNobn2XqB1fnwGqP+9WYk7lHBPMfRDUR3kfJHOu91BelcC7JfjOFGDm/A3o
         C9PGz6pf30pvdw5FFLM9QtCO5jfks1FeMiId2MdQjteS3SzYbfqIIgbFPiiX/egFsNX7
         TuNT7xBKg7Vc99HIbCdDmBVlh/qyL3u20GMRE4UEsQjjDjnc/z1mWtAi+K2eBEF8WjNX
         Wr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680833920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NM3Z7cWxI8VgV2XX878CM3uoNsycYkoMYtaVz8/N1I0=;
        b=D6ltNKfu1yWCuGKdmmfgkxOsk/q9vNdrhN5PgKorVwr6PmHfwAxjeQAHGNgmLxixUz
         RZ0U0DZUw7D+W0iHg9EJYxOyOp1BExSz6XpE1VW4exWn9XtWZdV8aDQMq/xOX2/CNmx1
         zYsiZG2PB8GebkO6K42Jz878UyQaKRG8BpwZlevcr+tZhkXOz2lMwpuPGeVRHggt/JH7
         +LBrQ/WIVrdlC4kHP9jb2RDTMNTVa5tOzg469EbJwRiID+IJsjHRmESXrJJ7S2J/gKZe
         ofFfFAg8qXMr8dawHQ4FRWoiA/BujHCKnG7ALuJgRfLAMUpkDqAmtMc+mYMnA2vyCqD1
         qY4Q==
X-Gm-Message-State: AAQBX9cru/+nQEE0Hutxxb3JEwtmPu8/uiYne1/Uo3zMl9ADcfGGWHvD
        g4PrHcK3SNf/m5Hpz6oty8D+X9s6b1w=
X-Google-Smtp-Source: AKy350a1NCLn+tgVEdl3G2usrimBWUcS0wPCR6h6zv+GoZPIROVYSl/Vegjn8xVBwAMs0hFntEsvbq4xRuw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:909:b0:a27:3ecc:ffe7 with SMTP id
 bu9-20020a056902090900b00a273eccffe7mr3536502ybb.3.1680833920841; Thu, 06 Apr
 2023 19:18:40 -0700 (PDT)
Date:   Thu, 6 Apr 2023 19:18:39 -0700
In-Reply-To: <20230310105346.12302-6-likexu@tencent.com>
Mime-Version: 1.0
References: <20230310105346.12302-1-likexu@tencent.com> <20230310105346.12302-6-likexu@tencent.com>
Message-ID: <ZC99f+AO1tZguu1I@google.com>
Subject: Re: [PATCH 5/5] KVM: x86/pmu: Hide guest counter updates from the
 VMRUN instruction
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> When AMD guest is counting (branch) instructions event, its vPMU should
> first subtract one for any relevant (branch)-instructions enabled counter
> (when it precedes VMRUN and cannot be preempted) to offset the inevitable
> plus-one effect of the VMRUN instruction immediately follows.
> 
> Based on a number of micro observations (also the reason why x86_64/
> pmu_event_filter_test fails on AMD Zen platforms), each VMRUN will
> increment all hw-(branch)-instructions counters by 1, even if they are
> only enabled for guest code. This issue seriously affects the performance
> understanding of guest developers based on (branch) instruction events.
> 
> If the current physical register value on the hardware is ~0x0, it triggers
> an overflow in the guest world right after running VMRUN. Although this
> cannot be avoided on mainstream released hardware, the resulting PMI
> (if configured) will not be incorrectly injected into the guest by vPMU,
> since the delayed injection mechanism for a normal counter overflow
> depends only on the change of pmc->counter values.

IIUC, this is saying that KVM may get a spurious PMI, but otherwise nothing bad
will happen?

> +static inline bool event_is_branch_instruction(struct kvm_pmc *pmc)
> +{
> +	return eventsel_match_perf_hw_id(pmc, PERF_COUNT_HW_INSTRUCTIONS) ||
> +		eventsel_match_perf_hw_id(pmc,
> +					  PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
> +}
> +
> +static inline bool quirky_pmc_will_count_vmrun(struct kvm_pmc *pmc)
> +{
> +	return event_is_branch_instruction(pmc) && event_is_allowed(pmc) &&
> +		!static_call(kvm_x86_get_cpl)(pmc->vcpu);

Wait, really?  VMRUN is counted if and only if it enters to a CPL0 guest?  Can
someone from AMD confirm this?  I was going to say we should just treat this as
"normal" behavior, but counting CPL0 but not CPL>0 is definitely quirky.
