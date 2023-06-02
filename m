Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95D971F7B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjFBBVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjFBBVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:21:34 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF1A3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:21:33 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-652d4d0eab6so276351b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685668893; x=1688260893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7oHcRenT/YTHZUEM4P1IoEgI4BeKNHUxXafu00GRMoM=;
        b=GYnt1Q7g8+i6e2dBCWqUnvswPw80VHoTPW/GcR1wpOsX9TnMC3a184hoT1cD+d/5CI
         s/1O1b6WCSgwpO6Bw86HA4XkbkhX5RHhXnL7ryeFlaBdOqtlAqGAasdNXMfAc5ARxEqa
         D9Vt8PkQdLC2YXio1Qqrqt+wZHojnGtyfEG7r3K6rsmJBTh/uBkQ5gM7t+wTc3GEvbrr
         jvC3PapO51upjAPHcxIgBXpwDHWugJAbeKseHaCYky27Zk0jeSbpTVt+oeNgwV4pltrp
         Pup/V/dX9LlPaUH/PcJL7gvL8sz+RU7AbA3gLT3ZYkmYp+SVCHAMg1qV7c1lbWJHu2jq
         +s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668893; x=1688260893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oHcRenT/YTHZUEM4P1IoEgI4BeKNHUxXafu00GRMoM=;
        b=dzhjzoL/YiO+KiPIFyto7C8ak0VMv6V3H1StKtw8YEjkisNIijOBTS551iV6OADcJX
         DBoM8EfMKMvwyat+guf+RIuRmsWQ8EelgYLJCiP9gVUm9l8ad6IhvZOSTMluHvy9SrRW
         ex5q1vnEx9p67f+sCGFHFfsAP4PzX5D4be50jiBB4nZLdzioIeW10e7xgRHk/MXu7yFW
         C3uEVqctP4CNcQ0wvK619OOFsh1M+amox+9txEh0ARqADOrUURyVAbqi8cvk/F3SYSUl
         5dFaioLseEv5wM7m+kP92qXm9L279bZomHmzxAAoFINXYDLus3OCmhRexviBVs9bgXIe
         /yow==
X-Gm-Message-State: AC+VfDzZOY4UqljGr1NODlInss5Kisbwch/AyKM0zxstKb5DoqSrEXby
        Bf3vT98vDgykxuOJwYqYWBZLzonNdQM=
X-Google-Smtp-Source: ACHHUZ5pWN+M5zUmbXbMK36rftHt4pDvTNo257oBiJ4HdRyMxqotW4v0EUzvdaKTIqPpnb1cdhCM1zLN+vw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:148f:b0:64f:c0b1:6967 with SMTP id
 v15-20020a056a00148f00b0064fc0b16967mr4081528pfu.1.1685668893417; Thu, 01 Jun
 2023 18:21:33 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:20:56 -0700
In-Reply-To: <20230211010719.982919-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230211010719.982919-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168512525398.2749591.3621689713936978562.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Protect vcpu->pid dereference via debugfs with RCU
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2023 01:07:19 +0000, Sean Christopherson wrote:
> Wrap the vcpu->pid dereference in the debugfs hook vcpu_get_pid() with
> proper RCU read (un)lock.  Unlike the code in kvm_vcpu_ioctl(),
> vcpu_get_pid() is not a simple access; the pid pointer is passed to
> pid_nr() and fully dereferenced if the pointer is non-NULL.
> 
> Failure to acquire RCU could result in use-after-free of the old pid if
> a different task invokes KVM_RUN and puts the last reference to the old
> vcpu->pid between vcpu_get_pid() reading the pointer and dereferencing it
> in pid_nr().
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: Protect vcpu->pid dereference via debugfs with RCU
      https://github.com/kvm-x86/linux/commit/76021e96d781

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
