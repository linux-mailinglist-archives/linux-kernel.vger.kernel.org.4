Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A678720CC5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbjFCA4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbjFCA4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:56:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50079E52
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:56:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5693861875fso31113467b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685753761; x=1688345761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VF+jKVtUKuSL3+orDX/BcKSQvxplFjfV2+ACVF3p9k=;
        b=cLPwDVeiAtS5QwHY8obE07T+sL+yvyk5p8+xaU12Rw7dw3ucLcmet3zm8HcUALWjwg
         M08BKohRRYkeoXNNtmnfwBVWe33pEGhMYEwX8kR63BPFThkNLfl0SY4biwvlSAZ1yef8
         BEzD1evaKUb8EBSo41PirhmgWI59dO9WZ/xBKkstDZIkgEigs/L1PtNFnepUNdg2Z3QE
         Ese+Oc6f5Un41Gvc8N3pQIhN397i5V301KrZngquHEg3SamqGQg5H5Wyq812wBKdiajp
         WGya5VPjYX6lE1xmdqaIbr3CJlAJavMiS4LluG/rur/+9UabubAVkCgusC1Vc7NtvmmO
         FNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685753761; x=1688345761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VF+jKVtUKuSL3+orDX/BcKSQvxplFjfV2+ACVF3p9k=;
        b=R0dJ4WLJNhHyU6/UFShr/g2EjzkYwUS+9X26qRjAM0Wi6IJOnF9WFljM7SO810C7jI
         gMjQjguidY3STKWaxDtYJiswJR/UQAUCFex4YebJUF0vE5bnJDYIyogHYWNv7+20qpOX
         bZi5Ov0rUYLfTraCxzg3QxAiV7cuTMFFxqQAs2LYqz4ukbm4d2K5dVvlSFuyonMHe4bl
         +LvzFqdi0D9FxxBYjEp7H5fNmPvq98GqL52+JtuLCrehQfAlHAwZ5j4nzgMj60wCgUf6
         ZOSTqXFA7vS7ZXGpDMHbh6jTp+mqfT5Xc58x+w+7Jj9ZDqlbeIOKZed0hPNR1VgGJoG5
         SXLQ==
X-Gm-Message-State: AC+VfDzVh/zgi6qjBC3L4cw8qyAol/5UTaLoKUGmf7G4BePidVb00myu
        MldiapEO24+L1G+wyT9gz5SFTZypPyc=
X-Google-Smtp-Source: ACHHUZ6orSVIYJauSsopxLKnrPsP3ebTt9rUpkuUXRc6oqb9uRP/8VP4uXCj20GsBVoJYkZNGBljHuoMyhU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b512:0:b0:568:a244:d8e5 with SMTP id
 t18-20020a81b512000000b00568a244d8e5mr801228ywh.9.1685753761663; Fri, 02 Jun
 2023 17:56:01 -0700 (PDT)
Date:   Fri,  2 Jun 2023 17:55:43 -0700
In-Reply-To: <20230405234556.696927-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230405234556.696927-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168574934456.1017711.18398419709804116165.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: VMX: Fixes for faults on ENCLS emulation
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Binbin Wu <binbin.wu@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 16:45:54 -0700, Sean Christopherson wrote:
> Found-by-inspection (when reviewing Binbin's patch) fixes for incorrect
> emulation of faults when KVMintercepts and emulates (sort of) ENCLS.
> 
> Very much compile tested only.  Ideally, someone with SGX hardware can
> confirm that these patches are correct, e.g. my assessment that KVM needs
> to manually check CR0.PG is based purely of SDM pseudocode.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/2] KVM: VMX: Inject #GP on ENCLS if vCPU has paging disabled (CR0.PG==0)
      https://github.com/kvm-x86/linux/commit/5e50082c8c21
[2/2] KVM: VMX: Inject #GP, not #UD, if SGX2 ENCLS leafs are unsupported
      https://github.com/kvm-x86/linux/commit/c3a1e119a343

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
