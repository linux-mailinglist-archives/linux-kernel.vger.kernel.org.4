Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3848F63F591
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLAQqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLAQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB1EAE4DC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669913119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0j7iDCqKcud61bnCVouYTAjXYx/lMBjTVmeuK6IwiIs=;
        b=NCBOe8Y+pheTUfOsgWlqkMEwefdvxMOaYnVDzMc/7pEvdZpPQ03apRGblsSMbc9olUhFv0
        TsNzJSVC18hYJPMhFz7eSPOKaph9c1gd84vWzP31pdqgKEqxJ593IVgXJZMU7E5Fe5Np1v
        69oNMzxQxmbCHp4tqUIchS7NHUqmlcg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-zOm-sR2FMF20B9Yjm372Ew-1; Thu, 01 Dec 2022 11:45:18 -0500
X-MC-Unique: zOm-sR2FMF20B9Yjm372Ew-1
Received: by mail-ej1-f70.google.com with SMTP id gb8-20020a170907960800b007bef177dddeso1691436ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0j7iDCqKcud61bnCVouYTAjXYx/lMBjTVmeuK6IwiIs=;
        b=AoXimrHitiCBCkJ3CIAcU7mIxaA4hMR/G/QZ9STSKv7lNOAYl2gNitjNC9BgRnS3El
         1EngfUI6IkpxO450pUzDGQSGK7/DulW84F8zsOqipdIcJl/wqXme3VYxkP8bPp/wP2Nq
         ZapAh+R38QsQJ87MV15im69SnXJBdPa8dFcI/P6S/G7JUouJtuxhL6TQE0D2SKLG0u6t
         TA2YrFh15yNYOCIoQO6WxAxaIyE5sUBp6olRwgkfjqUD4GFfUoEuIZM933iTiIh9nkN0
         jBvNw71h8ZHpyW8DZ1fKLOdLY8Lsfdsrpb/jlu0tCJhcUXh/4K8l3mdXfLQMtiIx4xy5
         SsPA==
X-Gm-Message-State: ANoB5pkhpNPbK2RGccoLn+GJAdqYbOAmdhxdeonK/M5h1fvEO3cYDqe1
        aK2tn+GsVxC6bbesBR2poOSbHzpviAxCJ59QGPvioPh2aaqalqtS6TINYKsOxGy1V8azCnf8r6r
        OK1KeF4pxAkHIdHsFzW3/mbV8
X-Received: by 2002:a17:906:6c7:b0:78d:4061:5e1b with SMTP id v7-20020a17090606c700b0078d40615e1bmr47970145ejb.47.1669913117079;
        Thu, 01 Dec 2022 08:45:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4eaU/O5iQxd1YPRfrkTQE4uquPar9KRJcIbFIa3jXZVSj/nGj010qrX05SJquNTJ1RK03UPA==
X-Received: by 2002:a17:906:6c7:b0:78d:4061:5e1b with SMTP id v7-20020a17090606c700b0078d40615e1bmr47970132ejb.47.1669913116866;
        Thu, 01 Dec 2022 08:45:16 -0800 (PST)
Received: from ovpn-194-141.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m11-20020a056402050b00b00467cc919072sm1917760edv.17.2022.12.01.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:45:15 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     coverity-bot <keescook@chromium.org>
Cc:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: kvm_hv_flush_tlb(): Uninitialized variables
In-Reply-To: <202212010825.9FB75F1F@keescook>
References: <202212010825.9FB75F1F@keescook>
Date:   Thu, 01 Dec 2022 17:45:14 +0100
Message-ID: <87edtjf4yt.fsf@ovpn-194-141.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coverity-bot <keescook@chromium.org> writes:

> Hello!
>
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221201 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>
>   Fri Nov 18 12:59:05 2022 -0500
>     260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")
>
> Coverity reported the following:
>
> *** CID 1527764:  Uninitialized variables  (UNINIT)
> arch/x86/kvm/hyperv.c:2024 in kvm_hv_flush_tlb()
> 2018     		 * Hyper-V TLFS doesn't explicitly forbid non-empty sparse vCPU
> 2019     		 * banks (and, thus, non-zero 'var_cnt') for the 'all vCPUs'
> 2020     		 * case (HV_GENERIC_SET_ALL).  Always adjust data_offset and
> 2021     		 * consumed_xmm_halves to make sure TLB flush entries are read
> 2022     		 * from the correct offset.
> 2023     		 */
> vvv     CID 1527764:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "data_offset".
> 2024     		data_offset += hc->var_cnt * sizeof(sparse_banks[0]);
> 2025     		consumed_xmm_halves += hc->var_cnt;
> 2026     	}
> 2027
> 2028     	if (hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE ||
> 2029     	    hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX ||
>
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):

Looks half legit) 'data_offset' can only be uninitialized here in
'hc->fast' case but this also means that the only user of 'data_offset'
(kvm_hv_get_tlb_flush_entries()) below will not use it. So yes, we do
increment an uninitialized variable but we won't use the result. I think
we're better off fixing this, even if there's no real issue. I'll send a
patch, hopefully tomorrow.

Thanks!

>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527764 ("Uninitialized variables")
> Fixes: 260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")
>
> Thanks for your attention!

-- 
Vitaly

