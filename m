Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE91367294E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjARUaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjARU3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:29:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71125FD7D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:29:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k13so294989plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXOSWAReYucR19S1OU3Yoq6A6gTmoZqc8Dluh59S8BQ=;
        b=mukBoX+ZmOHwz1GdbITvLqhLgOdtOeYj7Ov0W/eAJIiHeCO2tKKszQHMjLICW0Adj5
         SrMqlHIt+J1H4ku4Estm0UInNfnw/WXzdiSiIG6VWS+4sJJC3OnsEYT8vGbqfg+VYf9k
         /pM/eeXHrGovFwOJjTVBDUt28iN9JvUHWnJaQ4c7zkKndklSRMVtezuzyLhkCRhhPTiN
         Vfnp3BS/pbqUg79tTuZPHQeNAFxD2CJQIBygHhsFlugQKPdbJvlWIJ+R5zjCOKwVvMMq
         wlku+18A9nk9GCNLEi2TNWXcVKHvuujyT2rdriqpI1qFeC2mePjzBR4d7/qjY2YGcw/8
         IV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXOSWAReYucR19S1OU3Yoq6A6gTmoZqc8Dluh59S8BQ=;
        b=QCWIkOQP0duTnYLwZvq9LZ8bJ9C7BVABnXWmzcDAz65YjsZ2+e2S3cXRJ4TiGxWVSf
         iLc5c9/oJrWD1NMfqmO9+slan6kI7iKdIVire17Z8NuuCqSSgOwfyOVeNFsFbYcT/S0U
         DuUJKyTVcwwGTKX64/9tpuB55B50zBM9J1SFEazTu8PhbKWCxzGRxviKuGx2Ubv4Heom
         TL79j2g+00VcH2U9piGIYG1UgX+d5J20/9MLXAEy117+dlP2GGOk7RX1xgv8oWkooWBa
         0id9LzHpnnBqLFpDgqeaeIXcauG6rS0vsu+aYViPcv7Ef2Ugmw0FrpEEq1+hTaEfr853
         ux/w==
X-Gm-Message-State: AFqh2kqyv6mrecbsMOcqnR5IODI2IfvrWM3jrRENC9eSAY29ECii4qAF
        2Ez7wLT61tTXfJzA+Jz75CWumQ==
X-Google-Smtp-Source: AMrXdXvv1QZnG5GH8beg3UBtbNn503yBV6DudT9SaLqXSjlnRfaWruWK6KiPfQN/Ehm5V13xF2ZrcA==
X-Received: by 2002:a17:902:c189:b0:191:1543:6b2f with SMTP id d9-20020a170902c18900b0019115436b2fmr3502689pld.3.1674073775280;
        Wed, 18 Jan 2023 12:29:35 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b0017854cee6ebsm9667593plg.72.2023.01.18.12.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:29:34 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:29:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     zhang.songyi@zte.com.cn
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] KVM: x86: remove redundant ret variable
Message-ID: <Y8hWqgF6ZQdVF5pP@google.com>
References: <202211231704457807160@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211231704457807160@zte.com.cn>
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

On Wed, Nov 23, 2022, zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Return value from apic_get_tmcct() directly instead of taking
> this in another redundant variable.
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  arch/x86/kvm/lapic.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index d7639d126e6c..707970804502 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1363,7 +1363,6 @@ static u32 apic_get_tmcct(struct kvm_lapic *apic)
>  {
>         ktime_t remaining, now;
>         s64 ns;
> -       u32 tmcct;
> 
>         ASSERT(apic != NULL);
> 
> @@ -1378,10 +1377,9 @@ static u32 apic_get_tmcct(struct kvm_lapic *apic)
>                 remaining = 0;
> 
>         ns = mod_64(ktime_to_ns(remaining), apic->lapic_timer.period);
> -       tmcct = div64_u64(ns,
> -                        (APIC_BUS_CYCLE_NS * apic->divide_count));
> 
> -       return tmcct;
> +       return div64_u64(ns,
> +                       (APIC_BUS_CYCLE_NS * apic->divide_count));

No need to wrap here, this fits comfortably on a single line (so does the
existing code, i.e. not your "bug").  No need for v2, I'll fix up when applying.
