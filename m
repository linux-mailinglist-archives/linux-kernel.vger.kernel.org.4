Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AAF640994
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiLBPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiLBPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:53:06 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7081327FDE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:53:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vv4so12480821ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQQIwkkfpShhaXutSwKcHrJlLuTk4R5sSbebZoDIpW4=;
        b=ZVUCYUR2kY+r9WYFmnJ/4gwG88fFiimRLHw9jtI3aWYRP2Bl8oCZoZlb3SdU9wEzdF
         Fus+ldzdCBzNZQ7rlzevVFYpy20FS66m3hh12FIWnDDBuBfZgV5Xo0qAr3OUZyYc7Tg3
         0+Z9f9oKcWf80fB60O/lMzAR4pDVcw17YaUinwGAWLS8HIv7maKD+O6LO7O0yA5NJNER
         UBJvjtbTrqI9n0TzZA/wLyUs697euNkfFhFPQ/qFQM+MnMm8/gCluWstf+yWRbcQUr+b
         y2BbrCmrr1pt3ARTh7QOEcuFoaZ3VXkPii9560ZTfFZaLZMNZoYPJZwsWBHkcF3lbsDJ
         W/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQQIwkkfpShhaXutSwKcHrJlLuTk4R5sSbebZoDIpW4=;
        b=iGol/RPqYp6bHuoUzanNuacAc8qALOmtpbSMgPn1TzcuCaTQ8sSF3GQMBYHhnrFV0/
         2mLi/6q74TxHp83700YfhgzmcGYH1PXpBOMXlFfDdyULd81aEtKTXafY1JjHJJj1IWF3
         K0ZrJwvbQhN90TCRhfQVOhrjqDFyujj2vYpFPuZUn8dy99tkZ5HbLjEVmpHi9dC3M8xA
         8p9B0iikgMESOa8gCQxCbvN/qGPOSy9z+rOwc7ED1wqvQL5J8lnlTzyZ0Z7e7O29wnNA
         nxoUmwaQxbwlGlMC4hVvBa58rOe4a6S1Ixyur3xTpYQWv9376bMU5YPDykbcB6H0lYbJ
         GPag==
X-Gm-Message-State: ANoB5pnmERVlca/FmM5j+4SpI7oufxl11jfW5/WTL3hriDc9d9qZX65z
        Cfxr5wNjt1yg64q2xo0JqEqecOkZp1+hj2l6MDfNfA==
X-Google-Smtp-Source: AA0mqf77if6An70nzCZZinqSqZR+fCHoSbWxalmI5uutnm+MTPqaZcN1xtw03FXGUhlOkdqIOFhGp1mz6jbYrhCNz9w=
X-Received: by 2002:a17:906:4c92:b0:78d:ad29:396f with SMTP id
 q18-20020a1709064c9200b0078dad29396fmr61074156eju.165.1669996383770; Fri, 02
 Dec 2022 07:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20221130161946.3254953-1-spm@google.com> <CABgObfby+9JNwrJnjPRp6pty05CqRUfKBA3AB=TNwq4q0KjBTg@mail.gmail.com>
In-Reply-To: <CABgObfby+9JNwrJnjPRp6pty05CqRUfKBA3AB=TNwq4q0KjBTg@mail.gmail.com>
From:   Space Meyer <spm@google.com>
Date:   Fri, 2 Dec 2022 16:52:27 +0100
Message-ID: <CAOLenvZm4aPJAv5O+iybMxJoD-ZeytbJ=9o1nLVSh+84uj2U8g@mail.gmail.com>
Subject: Re: [PATCH] KVM: Deal with nested sleeps in kvm_vcpu_block()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 5:49 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Wed, Nov 30, 2022 at 5:20 PM Space Meyer <spm@google.com> wrote:
> > Previously this code assumed nothing would mess with current->state
> > between the set_current_state() and schedule(). However the call to
> > kvm_vcpu_check_block() in between might end up requiring locks or other
> > actions, which would change current->state
>
> This would be a bug (in particular kvm_arch_vcpu_runnable() and
> kvm_cpu_has_pending_timer() should not need any lock). Do you
> have a specific call stack in mind?

You already fixed the specific call stack in 26844fe upstream. Syzkaller was
able to exercise the call stack you outlined in that commit on a 5.10 based
branch via:

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at
[<00000000f941c5dd>] kvm_vcpu_block+0x330/0xaf0
WARNING: CPU: 1 PID: 2513 at kernel/sched/core.c:12350 __might_sleep+0xd7/0xe0
[...]
Call Trace:
__might_fault+0x6c/0x120
__kvm_read_guest_page+0x163/0x230
kvm_vcpu_read_guest+0xc3/0x150
read_and_check_msr_entry+0x3f/0x310
nested_vmx_store_msr+0x12c/0x360
prepare_vmcs12+0x5f2/0xd90
nested_vmx_vmexit+0x663/0x17e0
vmx_check_nested_events+0xfd8/0x1c60
kvm_arch_vcpu_runnable+0xda/0x6c0
kvm_vcpu_check_block+0x63/0x250
kvm_vcpu_block+0x3b7/0xaf0
[...]

The bug doesn't seem to be easily reproducible, but looking at the code this
should also be applicable for the upstream 6.0, 5.15, 5.10, 5.4, 4.19 and 4.14
branches, which have not received a backport of 26844fe.

Do you think this is all we should do? My conclusion from the LWN article was,
that we should avoid the set_current_state -> conditional -> schedule pattern
when possible as well.
