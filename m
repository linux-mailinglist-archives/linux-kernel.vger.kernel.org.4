Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56C6C8969
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjCXXjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjCXXjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:39:17 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193161E5D0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:39:11 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k17-20020a170902d59100b0019abcf45d75so1940254plh.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679701150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNhDAlpxjuXbPCJZSvZ4PajBXqlNuqyadAVm1zFR7r8=;
        b=Uh/7QRxBEFuR4HPCZfIEOAEIBGYQT+8JkAe3RrNbkalNMIjKIUla9jK/0r97dj2j6x
         zRRT1PJ5AF/vd4xWVPzD3Iuf/qu0L74zzLvIGp0EtWbd3YiZBCS+X/cXUMNVEV3+02Z9
         ArvhexRMnN7ZYbLneuJvB5f29F1kgKUVT5uD/V7K4yoE6/HR6544H4auQvgXxEabZJgQ
         G6KKk+09Xm4INIEAXLiOTxFvXISOfMdjNnYevvdj/MvY3wZKAvTPutUYQMNzGGERAQw7
         lfgHRkLBcp0iC0MnIzLP6nKI7Rb/cKdi5lQ0w9hT8vduVubWPmpVdq1JhVqSBe4jQPR0
         +11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNhDAlpxjuXbPCJZSvZ4PajBXqlNuqyadAVm1zFR7r8=;
        b=l1Hw1eNx2MRdAtdErZ9C7nWrnTStF2d2Tcti8upG3M1/RN5lZ46Ye4pnrgAC5iCBvM
         BqHqc052f9RXLyo4ANj0NIp4UtVrHh9CVP2f0iaTysys0sBvAVMJFFXHJN3aloQ1ym1x
         8ZNtytex2lDAh3QXaN7+oC+eNULlTBsem8QPKe+ERYlUONJCBIPFLNurdFxsljb+i8an
         FsR9VbWElAgTuXFaaw3IkWST8YFGgdpzpkVpxcpeR0FjSATykqgJZwywB3+yp0X+mcG5
         o8CiEztFSiIPFuteVctj/4JslRcKHtoA8sRMKreabLwIv1vtW2j5ZorngfQ2jcY+o5sC
         jplA==
X-Gm-Message-State: AAQBX9cmpSlcWs2gR5M9YdcwT3DBLRrX2y+W8RIDWteX1k4FutYe+S3U
        wOyxKPudefLSqB/dTV+VyhaWteKqyyU=
X-Google-Smtp-Source: AKy350an5KuJVDFHe55MYVMweRhnEBnwRqtMPoZt6P2d7ajYkx9+eWP68Q1x0j44plHHvaE7OlhWPMj2iHo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1358:b0:19f:3cc1:e3bd with SMTP id
 jl24-20020a170903135800b0019f3cc1e3bdmr1539109plb.4.1679701150430; Fri, 24
 Mar 2023 16:39:10 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:38:14 -0700
In-Reply-To: <20230124194519.2893234-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230124194519.2893234-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167961285281.2555533.5982438178105479790.b4-ty@google.com>
Subject: Re: [PATCH] x86: KVM: Add common feature flag for AMD's PSFD
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
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

On Tue, 24 Jan 2023 19:45:19 +0000, Sean Christopherson wrote:
> Use a common X86_FEATURE_* flag for AMD's PSFD, and suppress it from
> /proc/cpuinfo via the standard method of an empty string instead of
> hacking in a one-off "private" #define in KVM.  The request that led to
> KVM defining its own flag was really just that the feature not show up
> in /proc/cpuinfo, and additional patches+discussions in the interim have
> clarified that defining flags in cpufeatures.h purely so that KVM can
> advertise features to userspace is ok so long as the kernel already uses
> a word to track the associated CPUID leaf.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] x86: KVM: Add common feature flag for AMD's PSFD
      https://github.com/kvm-x86/linux/commit/3d8f61bf8bcd

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
