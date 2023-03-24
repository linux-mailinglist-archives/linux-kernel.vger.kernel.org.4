Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5666C895F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCXXiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjCXXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:38:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F1901D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:38:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a188-20020a621ac5000000b00627e6740be6so1689019pfa.21
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679701085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNQHc7+j5k4G3GKWcHuPMRCfr2auT/r3lxLrkI95edk=;
        b=MM0OI7VLCDdSfmtNZQLja50LXOeRA717Ok9X0E+qZTDtW0XF5IkuOArd8+Qbvoclyj
         UY5Dsn5ZioFyW4Bk5KmkRZ03C/QGudsZSf7QO2BYWKNi4ws+ik0QxAKNTxzPFi7jTlNq
         tt/bAjdawvk6fEEnt9qZztqeHN//bLZHunD8NB5LxIauDLNfgohbRECgV9xhMr6V92F1
         8rcuXRjhfH1MeEELm5l0W2IbqEtuQqWXQPVQckizW2S8gTUCb3Gs3HNvnt48W/iwziYw
         2+AC0K6CtArVRyz8hkZMfKzOvItWx/NTHXtBC2rWLc++JWhH0LSZYqxTSbI6hKE48eqO
         dwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNQHc7+j5k4G3GKWcHuPMRCfr2auT/r3lxLrkI95edk=;
        b=F6ektztc03+lL2noWRhvBHhV8TqtctI3tlUrlAPKu34MZ3uCyf4/FHoZJW1cgFLAVp
         KcdXmv0t81pZMdDGD38CA4VnE+omEPDn/EqUp0e/Ob3mDPsXUPDL3La31jCUAM7fYNWh
         H/SJQnH25Xl3r08rPJenEF4lSyKD0tSdLn+H3klZtuNsr00V6f7/dyr888wnvMblvjzk
         mJMZ4kDCG9uSe/Bxu6F+Af+fOrprGQpljilp10mFiPED4KUJtnwcaQQGnOEDtjpMixE/
         U95EL9mkr9iTGmtw2xn7xr9wxuknQVSfde7hqSoyEPhMs8NseYodH9C0fxIlu1UPTPW2
         V0Jw==
X-Gm-Message-State: AAQBX9f/MdTbkN89iMfXtmEsR4duDFMHA+ULuyMztemHwJxpocc2nYuK
        882SBmZEvfxfDBM5NeckfFF4BpOAquY=
X-Google-Smtp-Source: AK7set8W3IA/DOkfvDwAYbgvO1ETvvH8dCfFnzjBjs+aUfGnOVL9irCGhRTZzRZy311AhuOqMrSC+/9iGQI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a0b:b0:625:4ff8:3505 with SMTP id
 g11-20020a056a001a0b00b006254ff83505mr2566161pfv.1.1679701085351; Fri, 24 Mar
 2023 16:38:05 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:37:46 -0700
In-Reply-To: <20230217193336.15278-1-minipli@grsecurity.net>
Mime-Version: 1.0
References: <20230217193336.15278-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167961301405.2556397.3492995846054138772.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: Minor structure layout changes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
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

On Fri, 17 Feb 2023 20:33:34 +0100, Mathias Krause wrote:
> v1: https://lore.kernel.org/kvm/20230213163351.30704-1-minipli@grsecurity.net/
> 
> This used to be a more exhaustive patch set shrinking kvm_vcpu's size.
> But we concluded that this would be too fragile to maintain and would
> require a more radical layout change to group often used members
> together instead of chopping off individual padding bytes.
> 
> [...]

Applied patch 1 to kvm-x86 pmu, and patch 2 to generic, thanks!

[1/2] KVM: x86: Shrink struct kvm_pmu
      https://github.com/kvm-x86/linux/commit/12aad9164763
[2/2] KVM: Shrink struct kvm_mmu_memory_cache
      https://github.com/kvm-x86/linux/commit/f530b531fb9e

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
