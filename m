Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B0674405
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjASVKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASVJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:09:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4737C875
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:02:43 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 201-20020a6300d2000000b004ccf545f44fso1548001pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/nCb6M9YYnG5q59FjSK1/m/H/eNOYXaUrw06G9TEt8=;
        b=Gen9QK/tX9ilYnNa5f4OHUZ8BgeRvkLM7R4PkxAQTfGG+5du6gwRAF4PuFEXb1jxYN
         6z5ZmfwcoXn/g/a+bNzi+RXbr0ZlpyWiiVyYoPMINJsFl3hRVPucoX+jmUc+vTHBifWS
         EgdNg8FSvBavWTeKmHR93xnaEvP3VH6heZeag0yk0gnORtBvxyumzcD8DQ7bUKRx8s+x
         aLY9Ve74gYhCo27f1IRAkvvZn7kq3KHmL8Dnk92NI3uVxxxwyOLiFLTaFfmPTjEBLxv3
         n8y2HxZb4PkIfFI8q9OqF4FYOy/E8ACOpB4SpYvnCsnU+pihmZK3k//Dk6y48tK0rriI
         nwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/nCb6M9YYnG5q59FjSK1/m/H/eNOYXaUrw06G9TEt8=;
        b=iqryoccUtUR+svu/CTCFdcEZDgMsBJ56i/I8Tv+oqMu4RG/VWt415Avfqw1QFQAb+p
         lqTyE4/Sp83varRHzWK2JpcTU0rMpFnScEU0UYoldFkIfVB7EoJ4GDy7gvNLPZcL0efx
         MnjhUi2wkqyWtK2OGXJpvzcQe7jSRFG97uu0eAnR09tZ0dvhEHqa7BzjS7MwNIXqPqli
         t5X74j4E+6tttwolv/Jss7wiLnXRkhQ8fCkGEfhBE3NXJE98A1lE+jL+JxmctC72Ujam
         hO9/tKczL6KXtQ+oOBiSgcqW++gsxaDXCA6UzYqDkXXoZHggvumX/eNtAQJ47CnU3I5H
         9uNg==
X-Gm-Message-State: AFqh2kpPQ0V2ZEMjzd4bK0PYq0omuI+bHa0G+FJxqPWEO03oP3XtXveQ
        QVechmZfHZxLWzHLfRtYT9zP1YwdFGM=
X-Google-Smtp-Source: AMrXdXsXSsGgbcyo2faFpsC272vzzcvyo+yaoJ5KVJCnQbnd+E/g246DY6zPwCVunssV49ktBb+quKpflk0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:289:b0:194:d057:46d0 with SMTP id
 j9-20020a170903028900b00194d05746d0mr281687plr.52.1674162163222; Thu, 19 Jan
 2023 13:02:43 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:01:25 +0000
In-Reply-To: <20230111004445.416840-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20230111004445.416840-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167409102513.2376237.18253375780531585777.b4-ty@google.com>
Subject: Re: [V5 PATCH 0/3] Execute hypercalls according to host cpu
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vishal Annapurve <vannapurve@google.com>
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev,
        Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 00:44:42 +0000, Vishal Annapurve wrote:
> Confidential VMs(CVMs) need to execute hypercall instruction as per the CPU
> type. Normally KVM emulates the vmcall/vmmcall instruction by patching
> the guest code at runtime. Such a guest memory manipulation by KVM is
> not allowed with CVMs and is also undesirable in general.
> 
> This series adds support of executing hypercall as per the host cpu vendor.
> CPU vendor is queried early during selftest setup and guest setup to be
> reused later.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/3] KVM: selftests: x86: Use "this_cpu" prefix for cpu vendor queries
      https://github.com/kvm-x86/linux/commit/093db78b8e6b
[2/3] KVM: selftests: x86: Cache host CPU vendor (AMD vs. Intel)
      https://github.com/kvm-x86/linux/commit/832ffb370183
[3/3] KVM: selftests: x86: Use host's native hypercall instruction in kvm_hypercall()
      https://github.com/kvm-x86/linux/commit/019dfeb31650

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
