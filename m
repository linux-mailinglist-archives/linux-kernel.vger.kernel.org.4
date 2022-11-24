Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592F5636E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKWXSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiKWXSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:18:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F061114BAD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:18:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b4so71308pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FsfR9yi785BtGGSVwV+zwwFDYAOlG2z5wKIfOUjvejk=;
        b=eJo7pE5mpeh9IGoBDw/Ld4X77ZhvDqBSGJFGeiKlXjFaOMQqKwb6A9ZHA2TiC7fIhA
         dCmnvavKmtwGZSOR2BFCb2Du8muvmjnjA69CefzsP+Lc9ul8ppdETcWXZQ8lEVaY1PAA
         J1n9VdtU9SCxNX65O14tyT6aYADTFAVI2S/Y9/2mHuq6XNW+nctXUlrenppJiHVW1yG9
         U0RBjVCB9oFsuZpUCc8HSXsXWaAMsZlYXHaLH7DCY3zAfYPdE3ehFQLykdnZ2c8/HwLh
         Uu356puteWG8Ww8AsRGKaVVSRnofUV5LpYGg3fj4WgdN034AcwwCQq/pytDyM1H5ugHi
         3K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsfR9yi785BtGGSVwV+zwwFDYAOlG2z5wKIfOUjvejk=;
        b=MZI1Y4e967bRnCxtxsZGfcxWIOZVa50VqpYVqSnZjgDbkksuS5HzGVsiS93nwmsnOg
         4dcfjMSqnoGzsWb1MagZV6KGK8A0Uk94GFDrq2EpZ13DkdSIqXpCUYRszu9rqSH/ZqRY
         lfWqbisuoJYzNgRR3e8Fwaz5QIqvg+GwYV3I5eWI5ATRNgTNKCg6DuX9ecJ8qK2x+IN/
         Ic7WeFfMEdQYz74YhGtSC/PZxWMHAKpObxxR8gsQ6/e7CsGjClzFipRjyNQuzwI0lZy4
         CrPaSAvyb7odEzEkQBn+60LtI0Mf3TB8KWRR6UZTgM4V/Kk8k33Uy8aVIk3DwZS5gjsU
         ynVA==
X-Gm-Message-State: ANoB5pkAJSL3/scwVvNVMYsnKzqmolhi+D7qXw4AgAUpugmlXQJx1wK3
        FbXtbqNVTztD3eQ6KEzwfQR8dw==
X-Google-Smtp-Source: AA0mqf7FM0xg/oQ5G6HHhO0sFJT90RFNI09VskgLnQ8XoxQbAahGHweiwMRxN1TNy4NjiISv+9jGTA==
X-Received: by 2002:a05:6a00:a88:b0:574:2c5e:b18c with SMTP id b8-20020a056a000a8800b005742c5eb18cmr7950686pfl.10.1669245496670;
        Wed, 23 Nov 2022 15:18:16 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b00188b63f0782sm13367878plh.288.2022.11.23.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 15:18:16 -0800 (PST)
Date:   Wed, 23 Nov 2022 23:18:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>
Subject: Re: [RFC PATCH] KVM: x86/mmu: replace BUG() with KVM_BUG() in shadow
 mmu
Message-ID: <Y36qNDBxlOslo7no@google.com>
References: <20221123231206.274392-1-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123231206.274392-1-mizhang@google.com>
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

On Wed, Nov 23, 2022, Mingwei Zhang wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4736d7849c60..075d31b0db9c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -955,12 +955,12 @@ static void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
>  
>  	if (!rmap_head->val) {
>  		pr_err("%s: %p 0->BUG\n", __func__, spte);
> -		BUG();
> +		KVM_BUG();

This won't compile.  KVM_BUG() isn't a direct replacement for BUG(), it's more
akin to WARN().

And that's why I suggested this be RFC: @kvm needs to be plumbed down here in order
to use KVM_BUG().  I don't mind that too much, it's just a little unfortunate.
