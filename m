Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3936B12B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCHUL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCHULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:11:22 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788EECF9AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:11:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id lm13-20020a170903298d00b0019a8c8a13dfso9943005plb.16
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678306280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QxLhjK0ZJOGgd7DDHSnJaFz92c9elbOmAV62guSBYHA=;
        b=Y5sqsZH/pAWlBt4OB7meTACFdg3Qt3NG6uPxIIWHJvHsm4a+Q77ndAi+ZE54ag65wC
         jLE3mpiEzrgBuDb3vK0UgvHomSqroP9zfftMzGADIDFDxE6NchXCAFeMgGkCjcYfYfOu
         zmPSU/MZv+sDdVYhm13nY7qspD+ppviu4iJvyJovMNlYdXXVldIu+37RwEfDnyhfgPiw
         ONFHQfKb7lVI6bwSYHB93fs2nY0Cg5sTkjbIAf5ADV3p7YJ9QaB72FEJt+xW5uAQrUjC
         0Nfg9ZKb4/16mCEaieQNn75O5/X1xfSdELOd6/nH53a45KroTDUUWI+l4oKp4kZlefCL
         ZA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678306280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxLhjK0ZJOGgd7DDHSnJaFz92c9elbOmAV62guSBYHA=;
        b=Mg/NhxfNIGysndjVcHOVKYh621EQ/jaT7z4YcVv4slACv+oEYba/fcruTMJyVrpchm
         jearoKhAJXnTUaa8KPBGketWyVrqYrhIwj6r8kSWfJgZuz2mHQkFOuuX30WSLQnOmeT9
         8tDCfEClKL2xAbp6KtH0+NsYn2ZjlWZB+Xn8d/GUqzBc/azBAKRtPPTyQul7/9PJjRwP
         EUIL/WdSpwslnZwOSW4Qup1c+xc6NAJ3iLg8xWD5gTNSul5wuLI5F0/En3nIhetsncdq
         d9LNsEF4aBbfDgUdfMSaWLPyHoBM+gsybu66qQiZPlda6giYpHIThoSAgx4XmeWXg4IF
         fBug==
X-Gm-Message-State: AO0yUKXz/1zuV2VWBrl0mvNYw0m6Ajh4LjIAx7beEVNuM5QbKh1vw5vy
        6kjp4dr1mQkjQY5LYIo6k7sMY0eukzM=
X-Google-Smtp-Source: AK7set+TJJIWvZcJBpPEG5H1fzOcQ4gudXlIJjfOF8LFH3di5CA6/q1moeggKI3uaLRpxsAsEfPVlepkpJo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2c1:b0:19c:b7da:d41f with SMTP id
 s1-20020a17090302c100b0019cb7dad41fmr7326068plk.11.1678306279954; Wed, 08 Mar
 2023 12:11:19 -0800 (PST)
Date:   Wed, 8 Mar 2023 12:11:18 -0800
In-Reply-To: <diqz356guhnx.fsf@ackerleytng-cloudtop.c.googlers.com>
Mime-Version: 1.0
References: <20230307021809.GA2143916@chaop.bj.intel.com> <diqz356guhnx.fsf@ackerleytng-cloudtop.c.googlers.com>
Message-ID: <ZAjr5o2v00YrArcH@google.com>
Subject: Re: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private memory
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, vannapurve@google.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, diviness@google.com,
        maz@kernel.org, dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com, bgardon@google.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023, Ackerley Tng wrote:
> While I was working on the selftests I noticed that this could perhaps
> be improved:
> 
> https://github.com/chao-p/linux/blob/ddd2c92b268a2fdc6158f82a6169ad1a57f2a01d/virt/kvm/kvm_main.c#L1035
> 
> We should use a temporary variable to hold the result of fget(fd).
> 
> As it is now, if the user provides any invalide fd, like -1,
> slot->restrictedmem.file would be overwritten and lost.

Meh, that can happen if and only if KVM has a bug elsehwere.  If
slot->restrictedmem.file is anything but NULL, KVM is hosed.  E.g. waiting to set
slot->restrictedmem.file until the very end wouldn't magically prevent a file
descriptor leak if slot->restrictedmem.file is non-NULL.

> We cannot update slot->restrictedmem.file until after the
> file_is_restrictedmem() check.
> 
> For now there isn't a big problem because kvm_restrictedmem_bind() is
> only called on a new struct kvm_memory_slot, but I think this should be
> changed in case the function is used elsewhere in future.

Nah, if anything we could add

	if (WARN_ON_ONCE(slot->restrictedmem.file))
		return -EIO;

but I don't see the point.  There's exactly one caller and the entire scheme
depends on binding the memslot to restricted memory when the memslot is created,
i.e. this would be but one of many changes if KVM were to allowed re-binding a
memslot.
