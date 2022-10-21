Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9E607632
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJULcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJULcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D07E265C6E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666351951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aKiNS+PFO+LUs42q31q2DUx3RXThHyGeIrjmWFGSKE=;
        b=iymJLxWHfTADXwLBRxT731Y8Vv5EqzYr1Ad328Ry5/X6OV4IPnGnl16x1Q/c0s9+eCFNCU
        UBtWt87zoVr1pnqXixxRiMTVfrRUm+czhVairT/DE8pZ71g91l3SpfxpqVH8/2rPyGSeL7
        T/0YVGSWrO9S9MJBn5qDHEkpxP7yh0k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-lKPxQx6CPziFFq-XGq8rrA-1; Fri, 21 Oct 2022 07:32:30 -0400
X-MC-Unique: lKPxQx6CPziFFq-XGq8rrA-1
Received: by mail-ed1-f71.google.com with SMTP id l18-20020a056402255200b0045d2674d1a0so2139799edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aKiNS+PFO+LUs42q31q2DUx3RXThHyGeIrjmWFGSKE=;
        b=JdtT+mBOXUp/92APgiDLU8cRjbWUoAafmN0FaRq4eOnKEXii8XKvgDnCQaB8aYJd+Q
         AlUZ1XCzcLdpj6TxFfX1C2vb6Obab92BorhnnVjNBXTthn7+JD6ij35YLL/QGCg7rMqF
         x8ScCQVkbBFWebxItdvlPwGPuCzV9SHy6/9ycGLTCLKlJgxzI1uAAoTZEFJoX3BvI6iq
         YxPRf7PLAk8vreFHojI+Jgb9XEaVFRKnsUTvLbo3MfbREFP4hDScWVMOuCoNuk3Q2rkp
         iZgJJ1bL1jIhSsnrNi/cGHGSlGk1lAzkgknXXiEsxxzLvXJOLqk8m52cqtN8jQ6ts13+
         3WLg==
X-Gm-Message-State: ACrzQf13Qhn/XGkCW2VdrICLIxnAMuOAgd5H6qmLLCKFIyMXdPKeSiN6
        zB9/8YnTrxfanf6LNDnsWzbdACsF0k3szD33QmdO5/J6srJfOBnnJbb0JRjWilcLstfh9TIrRw/
        zZ7ZAlOVlAfVPox122Vazg0nb
X-Received: by 2002:a17:907:3e01:b0:730:a690:a211 with SMTP id hp1-20020a1709073e0100b00730a690a211mr15000193ejc.596.1666351949545;
        Fri, 21 Oct 2022 04:32:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4fNKZLeu6sK4jJOdmyXbz7sPVNJg8ujyVUeSLl4EPNu68g9a+RTBbGB5tIv51YI+o8hF9x4Q==
X-Received: by 2002:a17:907:3e01:b0:730:a690:a211 with SMTP id hp1-20020a1709073e0100b00730a690a211mr15000180ejc.596.1666351949359;
        Fri, 21 Oct 2022 04:32:29 -0700 (PDT)
Received: from ovpn-192-65.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906360100b00773c60c2129sm11698144ejb.141.2022.10.21.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 04:32:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/kvm: Remove unused virt to phys translation in
 kvm_guest_cpu_init()
In-Reply-To: <20221021020113.922027-1-rafaelmendsr@gmail.com>
References: <20221021020113.922027-1-rafaelmendsr@gmail.com>
Date:   Fri, 21 Oct 2022 13:32:27 +0200
Message-ID: <87a65pcsz8.fsf@ovpn-192-65.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Mendonca <rafaelmendsr@gmail.com> writes:

> Presumably, this was introduced due to a conflict resolution with
> commit ef68017eb570 ("x86/kvm: Handle async page faults directly through
> do_page_fault()"), given that the last posted version [1] of the blamed
> commit was not based on the aforementioned commit.
>
> [1] https://lore.kernel.org/kvm/20200525144125.143875-9-vkuznets@redhat.com/
>
> Fixes: b1d405751cd5 ("KVM: x86: Switch KVM guest to using interrupts for page ready APF delivery")

Indeed, this looks like a mid-air collision happened upon commit/merge.

> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  arch/x86/kernel/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index d4e48b4a438b..cf886f86038a 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -349,7 +349,7 @@ static notrace void kvm_guest_apic_eoi_write(u32 reg, u32 val)
>  static void kvm_guest_cpu_init(void)
>  {
>  	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
> -		u64 pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
> +		u64 pa;
>  
>  		WARN_ON_ONCE(!static_branch_likely(&kvm_async_pf_enabled));

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

