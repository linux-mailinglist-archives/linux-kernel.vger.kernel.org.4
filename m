Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA7A6C8911
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCXXNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjCXXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:13:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1A15CB8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:13:39 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o89-20020a17090a0a6200b0023b3d3acdd6so2853805pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679699619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcyHkCN+ppZSMBTdximdTt+L7x4aLTNRaJDAdNPZ4ng=;
        b=odSJ3ACgQqEJX3WSsVrtBVvR1cKZSOG86JAwa9zIOtfifrGXyxzSrkZIWbTOzMbu7+
         kNrnCnvLyIzEiZIn+Wloa9/qENdDRtszbDrcIpQcQzom1LgeABvbxo07uQGQt+XZ8fNe
         OM5pCRDA0AFxNh2TTh+oN9UEukp7X5/2PISXhBT0MVP9nolVA3gYAah4zbA+J3PytKWm
         QfUCKQjSK8lDzkeS6+o23xNKzRBp0/1nkwX4g4QCDJ6Ot2Pda7aTMu1/Mzwr4+ztFbdE
         pRwQQApJ27OMld307ob6SYfmLDyo4e94r6/tb/WueOovi0nSl2KY5GIfNyEQTDCXsjZL
         4gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679699619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcyHkCN+ppZSMBTdximdTt+L7x4aLTNRaJDAdNPZ4ng=;
        b=0yVb12E/s+EufnbNXfB3R0npWo5kzTsylKLoF0pyjn5nDiVK6trdChCmEyP+jLFlsT
         1j0yPebR5pSqsQfY+C2QgLbU1ODHAdZu08OOUPI6ys+g/v3kZe8vMbPHQYgXLOXkQft3
         CVCQgSMcBFmows96WYH/5o3Z2yR/FBttULWwwNfpCHDRpzlI77IzU0BM4WgosVIO5R54
         usuvCPA78UZ3Jh7LU6On73hBf7RWsDZRra/JnhWHwY76DC88H8+JHBQhQaU7vS8yFDZm
         D3nMyWBbtIyULEWxqnblq1NnCSRvsyhgM7+wMqYRILnL/WxvWBSJ7quKWEh/1jGiQrt9
         aMSQ==
X-Gm-Message-State: AAQBX9ecuIZLLwTnig5FRcBNnoLIlW2zc0mEBmoYTQbxHhFCRgvoy4bn
        UMo7auCp880S30VQbuxcsoHj0F9Cd8A=
X-Google-Smtp-Source: AK7set9poMEJJGCyeA2Pj8j7Kdn85X08yTBcBCvExVQxc0PKno5Jvma2+GhBaotZP4G93ZVxxwOcGaUPX90=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2313:b0:626:23a1:7b9d with SMTP id
 h19-20020a056a00231300b0062623a17b9dmr2342573pfh.6.1679699618843; Fri, 24 Mar
 2023 16:13:38 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:13:37 -0700
In-Reply-To: <20230313111022.13793-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230313111022.13793-1-yan.y.zhao@intel.com>
Message-ID: <ZB4uoe9WBzhG9ddU@google.com>
Subject: Re: [PATCH v3] KVM: VMX: fix lockdep warning on posted intr wakeup
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com
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

On Mon, Mar 13, 2023, Yan Zhao wrote:
> The lock ordering after this patch are:
> - &p->pi_lock --> &rq->__lock -->
>   &per_cpu(wakeup_vcpus_on_cpu_lock_out, cpu)
> - &per_cpu(wakeup_vcpus_on_cpu_lock_in, cpu) -->
>   &per_cpu(wakeup_vcpus_on_cpu_lock_out, cpu)
> - &per_cpu(wakeup_vcpus_on_cpu_lock_in, cpu) --> &p->pi_lock
> 
> Currently, &rq->__lock is not held in "path sched_in".
> However, if in future "path sched_in" takes &p->pi_lock or &rq->__lock,
> lockdep is able to detect and warn in that case.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> [sean: path sched_out and path irq does not race, path sched_in does not
> take &rq->__lock]

But there's no actual deadlock, right?  I have zero interest in fixing a lockdep
false positive by making functional changes to KVM.  I am definitely open to making
changes to somehow let lockdep know what's going on, but complicating KVM's actual
functionality is too much.
