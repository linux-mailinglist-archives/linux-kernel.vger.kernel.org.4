Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0106C86F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCXUjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjCXUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:39:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E721EBED
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:39:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a5a0b6e3so30036487b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679690376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWNApcsVqs6b8iyHjgouP8WjDbrbEDYT6YEA+91Iaa0=;
        b=Wkk8GoBMBfAaO8icCREFAmzcGXiN4+5z5fgoxnmaFd/mRFjAqra6kFilc9+/P2Qw4I
         4lEXB8v9R7Dq8iR4IbzrGXtwP0KHP6ErspCQ8wPGgksbkxb3g+Zkqy7VoSMrSeuuZR7u
         33Zrs+DmbpgyjaZa+lufLbAbv/Nr4P/Nh11ixJRvOmPLcGGVFjYRcieZ0Q+bygPlqCfx
         O28jcMtLnxqeSaELNfF7gYOupZwHuDvSbzEXLMN8SCosbtO4hxVQ7uvwyKsljVG2GJfu
         AW+sg+oTbGR9JWn9XoB0BAXxQ2VTXp1RR92nPgmBgOp+gmPSYNDeacU02bOjWr4nP8lL
         2iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWNApcsVqs6b8iyHjgouP8WjDbrbEDYT6YEA+91Iaa0=;
        b=STnOgdyCdpKsnAdO5xTUAavV7EhllhoLVpy6CBNvHy6xej4EUgzv78jxNeBrqawMZ7
         rjV7v84ud3RaiwV56gPsXTO9QhMXORdXwPfqMg8YYgQTgxFP26hvSAcjkKDESVrZ9Se4
         JrT9kTZMPk0Svs7IpNydqGoZREnMbfOMz2ajFK4c7RrogXDX30/ou0zqMG0FrnggS7PX
         DljJVXueL/tpwkaeA0x5rPM+xx2lhGB+B8XJVAsR+8Nm6Y0CfV+JfpOTLspQzVOLZdkH
         audk048WGiE4td7bOCcxvEIMAABFwgHdAuwgnB/EtQaWkdK+4Kora7O7Sdc0nIVTqttV
         Oy4w==
X-Gm-Message-State: AAQBX9fMIBJKTMQyezPq1C1eziQOajPcAvvohFwnpPZ92CmQneRLuiuU
        MSZJ/H+Tvj2v4rv8pr36rOVWN9maa2U=
X-Google-Smtp-Source: AKy350Y6SEOlHkFCPWC9itRys/kTTth6Cx5cpdUd5JwKTc5t6cutcKsk4wv32TGpACgnm9ef/9QbZ1rGhmI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:b75:9519:dbcd with SMTP id
 w3-20020a05690210c300b00b759519dbcdmr2229922ybu.12.1679690375846; Fri, 24 Mar
 2023 13:39:35 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:39:34 -0700
In-Reply-To: <20230221163655.920289-7-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <20230221163655.920289-7-mizhang@google.com>
Message-ID: <ZB4Khv8PLs7aDOks@google.com>
Subject: Re: [PATCH v3 06/13] KVM: selftests: x86: Add the XFD check to
 IA32_XFD in #NM handler
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
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

On Tue, Feb 21, 2023, Mingwei Zhang wrote:
> Add an extra check to IA32_XFD to ensure the behavior is consistent with
> the AMX archtecture. In addition, repeat the checks across context switch
> to ensure the values of IA32_XFD and IA32_XFD_ERR are well preserved.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index ac49b14460b6..296c954dfd6d 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -218,8 +218,10 @@ void guest_nm_handler(struct ex_regs *regs)
>  	GUEST_SYNC(7);
>  	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
>  	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
> +	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);

These should use ==, not &.  The test explicitly writes MSR_IA32_XFD, i.e. if
there are extra bits set then something is buggy.
