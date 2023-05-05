Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F246F86F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjEEQo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEEQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:44:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB715EE1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:44:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24e33239357so1041245a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683305094; x=1685897094;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+i6WgJAJzJlKXvdjrc4sB18Bds1WwkbYsWdLgSqVp4=;
        b=5NLcQWofuV/YkKQ6oScIEQc8lVhhA2L4HU7CAnLH03mX0Px3HVPbbRo2D6swL6bYVC
         DUB3fcT4XujkVxCNaKYJ+P/Z7sNnX421VReM55ms1qzD5WRQCvJ/Kix0mSSaYy6Vuguo
         DWnNHQWNURLtT+6bY0K/Qi8QSq5fb73IsidEyosi5bDvhPv4lQKLP/WCp19+1EjcQYkT
         2ZZ09LoscjMPBSeU10UZCNvLYrLZpvQ7Vt2oUZW3pPlG97XC7fwgw982zXDkvUJKrQ1i
         ngUKTQDZ0x71ie0DU+LnkH+jsC1SnJHoK6gBPF+WpYtjUSRSNwRS6UiypPvCgognd0bl
         qZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305094; x=1685897094;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9+i6WgJAJzJlKXvdjrc4sB18Bds1WwkbYsWdLgSqVp4=;
        b=anzK6lzCOnhJW35khHfE1l3bU13RWYsH4urCdO7SH9Zh8wCQliyV78tx10JVAZ3pRQ
         y//jwsWbf1mhjTyWKwxU8/ogKZK/0QLzOu9bn1q3FgyCeMVHVRy+0DsPK6gSzyN4OSS3
         1ifLTYJBKuuar360EnVWOeq75rUajkJRMVbyQxbuQ7ksyTuuD3DbxBj20ZielmV3UDV/
         sxn20SKztn47EPRnYW94/jrZrDZpcLmSUMY8GJqd2o3gE5ykGITSiqMpMgNVr8szdEm+
         xvg7qYpdOTObQguFZx/SqLTmr+YQu814VlWZQELcch2rERGU8nS2i3ag6HOQSBfhYypd
         0i7A==
X-Gm-Message-State: AC+VfDzWI8Pdy/2gSEk3xkpGbg/4EsLxGySCf9bEooXdjT+UxpvybEVi
        7cRKf/s2x/KZlf94U/zq7VPKppLHbog=
X-Google-Smtp-Source: ACHHUZ6aankmXvB8085gNTlbF2PCEyPixSX1tutA3Hp2uz+l8puQYKdMvvxlOn7gLaJGVxpHKJ9HgVKK2Lk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ea0b:b0:24e:2787:405d with SMTP id
 w11-20020a17090aea0b00b0024e2787405dmr607921pjy.5.1683305093970; Fri, 05 May
 2023 09:44:53 -0700 (PDT)
Date:   Fri, 5 May 2023 09:44:52 -0700
In-Reply-To: <20230505152046.6575-5-mic@digikod.net>
Mime-Version: 1.0
References: <20230505152046.6575-1-mic@digikod.net> <20230505152046.6575-5-mic@digikod.net>
Message-ID: <ZFUyhPuhtMbYdJ76@google.com>
Subject: Re: [PATCH v1 4/9] KVM: x86: Add new hypercall to set EPT permissions
From:   Sean Christopherson <seanjc@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Alexander Graf <graf@amazon.com>,
        Forrest Yuan Yu <yuanyu@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        John Andersen <john.s.andersen@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Marian Rotariu <marian.c.rotariu@gmail.com>,
        "Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>,
        "=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thara Gopinath <tgopinath@microsoft.com>,
        Will Deacon <will@kernel.org>,
        Zahra Tarkhani <ztarkhani@microsoft.com>,
        "=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>,
        dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023, Micka=EF=BF=BDl Sala=EF=BF=BDn wrote:
> Add a new KVM_HC_LOCK_MEM_PAGE_RANGES hypercall that enables a guest to
> set EPT permissions on a set of page ranges.

IMO, manipulation of protections, both for memory (this patch) and CPU stat=
e
(control registers in the next patch) should come from userspace.  I have n=
o
objection to KVM providing plumbing if necessary, but I think userspace nee=
ds to
to have full control over the actual state.

One of the things that caused Intel's control register pinning series to st=
all
out was how to handle edge cases like kexec() and reboot.  Deferring to use=
rspace
means the kernel doesn't need to define policy, e.g. when to unprotect memo=
ry,
and avoids questions like "should userspace be able to overwrite pinned con=
trol
registers".

And like the confidential VM use case, keeping userspace in the loop is a b=
ig
beneifit, e.g. the guest can't circumvent protections by coercing userspace=
 into
writing to protected memory .
