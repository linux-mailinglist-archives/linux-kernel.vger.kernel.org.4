Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA56D8B53
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDFAAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjDEX7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:59:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052A729F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:59:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-546422bd3ceso198803707b3.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680739187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jxf42gC6VhPGRjwvo8awTKl9BzUHx2xinZ2m33bgrQk=;
        b=nesyRQqqoTy+PoU/LaBv18i8BsnOkWBojTUXKokYIRHcE3ixI1nx0uhvjz5PSsjIDA
         jGdUeBsAm9PFNbne4pg4dCvRtJjPdLysgEkXZ9X6pLiY59z5QafiFNhna+en8DsZfHYd
         OO+YB8sK+eDu0AGQ8k5IcjtIf9VYKFHiB66d4CiMUrT6dfDFXdfGglc0VfUUI3g+okRG
         fDK51qdW27/OQY8zN46yLsyesPZXOtZXo72r9s8kYgpe0eBrL0OoRgtistmKIgEEsFO5
         mG7OYIT9rPLb8TuG+bo/RvnApHIPQQb8euJH2TLZdrLHn4g05HohhceB7LpXTKkyqhMp
         Ua5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jxf42gC6VhPGRjwvo8awTKl9BzUHx2xinZ2m33bgrQk=;
        b=Wo9gvaUTK8P04h7FLdoxD0AzP8DJVEraBGFD886bKnLDMwPzTt3yk1vZpCGLKFk/Q9
         4J6T46xhWUKcnMZ2E0OmeHqv0T0Zqls76kipTD6w6tWMDedNmKCPY7q+CbLFt6YoXAax
         1gtcoxv+vDuVcRJjUy3rmDwjfTQML7Hp6d0v3fI5uHty5LVg1iz7aam80xj0KluTRPUT
         fjcWTKWtvSEkg9dtbp+2ufEGf0hMzbSnnE0iZ5VKUKMtmIb5kJ5B2CS+YkknydRXf1xd
         tQirwzlGFv6sg4keL/8ji04Wej07B5BaNEptZKLaiuXTzwWU8Eksced/TNtpkKUudg+j
         Yj8g==
X-Gm-Message-State: AAQBX9faSiPrPyRP4yg2+4T27hFLnk4i1O50iuVB4P55JkBnmnUdVLT8
        3WSIV431m1qJlDWcSpLlN2F6LfPwfU0=
X-Google-Smtp-Source: AKy350b4cDoXYPsRlMRHohMLckVvU0YVhPrht4uYzWVfTzjIyCRe0ISsCa6DarqChome5te0mu4tegcx3UE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d753:0:b0:b71:f49f:8d22 with SMTP id
 o80-20020a25d753000000b00b71f49f8d22mr688483ybg.3.1680739186875; Wed, 05 Apr
 2023 16:59:46 -0700 (PDT)
Date:   Wed,  5 Apr 2023 16:59:32 -0700
In-Reply-To: <20230404071759.75376-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230404071759.75376-1-likexu@tencent.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <168073781051.657542.2486795284440545503.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Zero out pmu->all_valid_pmc_idx each time
 it's refreshed
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 15:17:59 +0800, Like Xu wrote:
> The kvm_pmu_refresh() may be called repeatedly (e.g. configure guest
> CPUID repeatedly or update MSR_IA32_PERF_CAPABILITIES) and each
> call will use the last pmu->all_valid_pmc_idx value, with the residual
> bits introducing additional overhead later in the vPMU emulation.
> 
> 

Applied to kvm-x86 pmu, thanks!

[1/1] KVM: x86/pmu: Zero out pmu->all_valid_pmc_idx each time it's refreshed
      https://github.com/kvm-x86/linux/commit/7e768ce8278b

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
