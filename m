Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8357F6743B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjASUvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjASUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:51:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979BD37F04
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:51:01 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 38-20020a630b26000000b004773803dda1so1529541pgl.17
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsNKOZkXicuUiWtCUwXDxRNTwl8e+lP+GlMNu/Zjg6M=;
        b=JF8NAJSFnN55aB49k7/Uv/peGr/u7pSGRAMLm4JpTT83MaFh90yvAduttmZCb6BwHK
         t75bfnPw7ZPhC6ASYCKjOWRQ57+FbZtWIF2D801w/Tw1Wvv4fMdA7cCcz4kNwiu4mTMs
         2HNcfs4P7uP5DgdmSE2yE9v3IE45bVlHqKcEdIFADNd9GYzp3JjRTDUnuij/uHgfTd41
         Gzc7X8fsplVxQmdZxq+nCRZedaGXAaK/SQCAlU50jMepBJtGuNlRfaI78x92soGJLQsg
         Bg5U9I4f/vbZJ7CkoMUc9+Oef9zVN3/w3O/FycYVMRSWmMHAKFz7io7Zxubv9cO0ATvb
         7U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsNKOZkXicuUiWtCUwXDxRNTwl8e+lP+GlMNu/Zjg6M=;
        b=v4ie7F8uDMLUTqAkkkgk+sl69DHMGv7t4p5+o+bihFAjx8nf97+GtOvXBAjYSozJH/
         O7MIYeAd1YjBmAMI1HubbdUQLRyrTptyolWJL3uRvXzVZwaQlZjFkApsZ71JbajqsCTn
         f7PsjL0bgLj4n3fhpFJU3P+uFTktj5MfRv/kpa5nYradSMc+VIFjwBDn/OkKMbQfqKGX
         JPwq34KH8YwqetNdmd+jvZubJ1h7D4NXav1n0QNSfmFUIgqrl+aD2QkyNc2vGozAfByb
         Kl28vKQUFKj1TqCm3jl402RJsos7Y8vAOVgSJuukhT+iBvpQIMsuGKeLu9ZG96Erf+ha
         56qw==
X-Gm-Message-State: AFqh2kpFMI4DwfP/40J/fhs+WNZ+lK9XVSEOLUEfaYBn0G2otSPiF/9i
        yGCsFx2MXyDiv2QGFkD23Y4RAJi4VR0=
X-Google-Smtp-Source: AMrXdXt00r6KEjTmHH+Xwy4v/JD/mxOBK32bvnMYN1yS2pn4RGD9SGTHp9Qit1Etf++FfDA6vUdtwX9BXvk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ab94:b0:194:6417:cd27 with SMTP id
 f20-20020a170902ab9400b001946417cd27mr1100464plr.34.1674161461022; Thu, 19
 Jan 2023 12:51:01 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:48:52 +0000
In-Reply-To: <20230118195905.gonna.693-kees@kernel.org>
Mime-Version: 1.0
References: <20230118195905.gonna.693-kees@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167409066308.2374724.17477861672467900544.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Replace 0-length arrays with flexible arrays
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 11:59:09 -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct kvm_nested_state's
> "data" union 0-length arrays with flexible arrays. (How are the
> sizes of these arrays verified?) Detected with GCC 13, using
> -fstrict-flex-arrays=3:
> 
> arch/x86/kvm/svm/nested.c: In function 'svm_get_nested_state':
> arch/x86/kvm/svm/nested.c:1536:17: error: array subscript 0 is outside array bounds of 'struct kvm_svm_nested_state_data[0]' [-Werror=array-bounds=]
>  1536 |                 &user_kvm_nested_state->data.svm[0];
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/uapi/linux/kvm.h:15,
>                  from include/linux/kvm_host.h:40,
>                  from arch/x86/kvm/svm/nested.c:18:
> arch/x86/include/uapi/asm/kvm.h:511:50: note: while referencing 'svm'
>   511 |                 struct kvm_svm_nested_state_data svm[0];
>       |                                                  ^~~
> 
> [...]

Applied to kvm-x86 misc, thanks!  Based on the linux-next complaint, I assume
you (temporarily?) applied this to your tree as well.  Holler if I've confused
you :-)

[1/1] KVM: x86: Replace 0-length arrays with flexible arrays
      https://github.com/kvm-x86/linux/commit/2a8c2de0544e

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
