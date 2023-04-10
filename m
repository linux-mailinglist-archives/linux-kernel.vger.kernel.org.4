Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1646DCE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjDJXb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDJXb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:31:27 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340032100
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:31:24 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n11-20020a170902d2cb00b001a64cdd8210so1008451plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681169483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rr1CIFtVTdjqLI7dwqPzvS7cU0W17pkXfsKjFMd7v0k=;
        b=n2uZem2EWeXRVBaq9BmZVKAbxgj92XeXqw0FPrD7wqb9ZhQV2Rqyb/c/gRBpbmDN5P
         DfgvFer+5dE6yvaRTw7NdShhLqC27wDTIbsceGUDGFSBTCWuYm/G654Mq09LjV/EzIZT
         XVjDQqUJ29kb5vufr+Bn/nurajsLo5RwEJ1AuA9l/Gqb4zfOEd61rJ1WINL69sYdVfHa
         sEzhq7MFL/TNyxOwAN+L+kazRTThaxn3XyUXTZ1SkOHRUCyDVRiKAP2S0HNuJOdRN59q
         3kGIazWVRFEZkNPE6PjCL2Dlp44mfvhkWIsiZNKpCMb4JOzRDgyxA3ayTL2kMK3fQ2Jo
         EAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr1CIFtVTdjqLI7dwqPzvS7cU0W17pkXfsKjFMd7v0k=;
        b=pIvvPnMmKixPGhErkPDKqVo1zh2uNkgyArmt0Tig+dqrhwQySnQLi4P3JTELZsH272
         ovQ7U0epukLEmQLfIBYqKJ/u9roUBmogORfTjswetLRBBsnzD9wLwj1iOg0xPwsxD5wf
         Coe/d40o767cSAdZ0k8xpuhEaVfrwS8/VpfQDctBYsdszThmh0e87+YWvdEUs+/tXCQH
         6L7tRrL3bKkB/sYZz12w4z4a+DuMS74iegyXnmA/pfgsnxGX6sG/+RGK9OIZiPQtLtGN
         /aHErHp86o4lONaUJI1DT7vCv4geuB+k3YVBDJ3+4G+EM1oED/DEWuS7dWV1e2JTeLe6
         /joQ==
X-Gm-Message-State: AAQBX9esO8EzH8svJKd7dIyq4Fm0xoyFS5K2biahq7bpyfq/hUJOoqJY
        cPMg+RznhSDoiCWeGAvfHrxBuV/lOiI=
X-Google-Smtp-Source: AKy350bdb0W1qwW783P0cLVSX3bBBaS+dWUsv+q2/D31Nq7LesVUBlQvOVteNoKHAR40lbgtWYbznUs7JmU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:445:b0:1a0:5402:b17b with SMTP id
 iw5-20020a170903044500b001a05402b17bmr2823543plb.0.1681169483722; Mon, 10 Apr
 2023 16:31:23 -0700 (PDT)
Date:   Mon, 10 Apr 2023 16:31:05 -0700
In-Reply-To: <20230405002359.418138-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230405002359.418138-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <168116572088.1038076.7789958735569045426.b4-ty@google.com>
Subject: Re: [PATCH] KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
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

On Tue, 04 Apr 2023 17:23:59 -0700, Sean Christopherson wrote:
> Extend VMX's nested intercept logic for emulated instructions to handle
> "pause" interception, in quotes because KVM's emulator doesn't filter out
> NOPs when checking for nested intercepts.  Failure to allow emulation of
> NOPs results in KVM injecting a #UD into L2 on any NOP that collides with
> the emulator's definition of PAUSE, i.e. on all single-byte NOPs.
> 
> For PAUSE itself, honor L1's PAUSE-exiting control, but ignore PLE to
> avoid unnecessarily injecting a #UD into L2.  Per the SDM, the first
> execution of PAUSE after VM-Entry is treated as the beginning of a new
> loop, i.e. will never trigger a PLE VM-Exit, and so L1 can't expect any
> given execution of PAUSE to deterministically exit.
> 
> [...]

Applied to kvm-x86 vmx.  I haven't gotten any reviews, but the FEP changes
in KUT will cause the nVMX test to fail, so I want to get kvm-x86/next fixed
sooner than later.  I'm not expecting anything else for "vmx", so unwinding
should be easy if it turns out this is busted/flawed.

[1/1] KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted
      https://github.com/kvm-x86/linux/commit/84f481315b10

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
