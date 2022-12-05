Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E576F642510
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiLEIwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiLEIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:48:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE35111170
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670230048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfvEnKIf4mHuvu3yIVqxv1Te1T4eVbeJMHjj7Ep8ikc=;
        b=GlGOVnuhDe1FXGBrQdHHHUJMafMneVn02+QyMP/2k3SkQmoTiuGkG6OtJXK3neRgHepJUe
        h1YJW3usYZUId9uzrM4kjXHMAi5A2At1CfATTe123kkDRvhxVADTvE+NLwnkfa3urLJYJl
        n59Pb7nUh/UhKlrPKKNRbVHepBU+WcU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-uzQUDl7TOU6bhUIsf2WjsA-1; Mon, 05 Dec 2022 03:47:26 -0500
X-MC-Unique: uzQUDl7TOU6bhUIsf2WjsA-1
Received: by mail-ed1-f69.google.com with SMTP id dz11-20020a0564021d4b00b0046cc3f565e5so1273173edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfvEnKIf4mHuvu3yIVqxv1Te1T4eVbeJMHjj7Ep8ikc=;
        b=cE31ElyG4NBZFsqTrqT3l7suGjxyJnCAheJRLTtZTtOts/Abb949POyhTVf4PAa4ym
         yl3CVlJ9Yiyq5Mx167Y0zUhFHiaBUHKa/QTQYW/tV46BPQBcXb9ebSiClMhRakxExcgW
         wLqv4K+0CIDcb+BNObvBSj0RiiJsWscIkKpkg4xfJL43/2CWYmcsnzLttb7+N4X34rBz
         CpyPA8QXqc9gv9n8hjt30Bc7ljLj4sb73Q8DY7yihtcFdbPR2KMv1TU3ayTisXzzCRNK
         +aIDR1C0wh2rN00HcW26UywsGSN1ABx9iyFZOMgSrKC5bROJu2/XlYLcgmKDCeOboYqy
         ZGPg==
X-Gm-Message-State: ANoB5pkQYPKr8vvsStRqRJ5e77DVWBK5Gfg9IkBkGtJ93NjIzSMxCx+n
        BoXGoPkzgXuX2nmS/vLoE1elxv7B7Jur/FVzsmTZeifY5YTTvvItTB0UIVI2RUeoo2VEGGxQ3bv
        2cp93DC6NXN0dhV3uueDvxUt8
X-Received: by 2002:a17:907:986c:b0:7a0:b505:e8f9 with SMTP id ko12-20020a170907986c00b007a0b505e8f9mr57399302ejc.216.1670230045719;
        Mon, 05 Dec 2022 00:47:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4akIQi8ZxTBNZtjIUUOko4vMClvta2bAqlLxc8Vd0sNOyBb3DMgM9yf+Lei9GFyOV6jqe66g==
X-Received: by 2002:a17:907:986c:b0:7a0:b505:e8f9 with SMTP id ko12-20020a170907986c00b007a0b505e8f9mr57399290ejc.216.1670230045506;
        Mon, 05 Dec 2022 00:47:25 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b007aec1b39478sm5997193ejg.188.2022.12.05.00.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:47:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust entry after renaming the vmx hyperv
 files
In-Reply-To: <20221205082044.10141-1-lukas.bulwahn@gmail.com>
References: <20221205082044.10141-1-lukas.bulwahn@gmail.com>
Date:   Mon, 05 Dec 2022 09:47:23 +0100
Message-ID: <87pmcydyp0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Commit a789aeba4196 ("KVM: VMX: Rename "vmx/evmcs.{ch}" to
> "vmx/hyperv.{ch}"") renames the VMX specific Hyper-V files, but does not
> adjust the entry in MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
>
> Repair this file reference in KVM X86 HYPER-V (KVM/hyper-v).
>

Fixes: a789aeba4196 ("KVM: VMX: Rename "vmx/evmcs.{ch}" to "vmx/hyperv.{ch}"")

maybe?

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ceda8a0abffa..8fda3844b55b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11457,7 +11457,7 @@ F:	arch/x86/kvm/hyperv.*
>  F:	arch/x86/kvm/kvm_onhyperv.*
>  F:	arch/x86/kvm/svm/hyperv.*
>  F:	arch/x86/kvm/svm/svm_onhyperv.*
> -F:	arch/x86/kvm/vmx/evmcs.*
> +F:	arch/x86/kvm/vmx/hyperv.*
>  
>  KVM X86 Xen (KVM/Xen)
>  M:	David Woodhouse <dwmw2@infradead.org>

Reviewed-by: 

-- 
Vitaly

