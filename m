Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9A5B5BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiILOAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiILN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:59:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C72A190
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:59:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so12396924pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CBw2jRLKePbG0d1bevJk7MojLNgMrFNThWg3tV1196s=;
        b=ONa5FFh+7XdNOXJqog7pCFfGV1y84lnz1Bkx6emd+txO8rpTILAI28016lHiyvT1ZZ
         aZYXR7bV3a36XUkNV3C5SRic1rjL2m0pTdKZsutxFKpkBy2baFOqCSevxpsKiUezETXb
         ODtXSzSOWNLi7Yp7hhqVV0Hm+r4rKY0U0ISj5TkQu9h3GENiQ4D+fNWKChD+t440KFij
         ZvRHreX4JM89Yqt9MTMDR3y9df00KCTY7leDKkmoaVfFcnx3DzLlRNTDVLOJd1ub0Dnb
         zXm0goI9PrWGlLPx+OeLhC3ARgsYafctfiV8/qSzMzTKyLxzqSecULcpnEHxxwUg82Sf
         wqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CBw2jRLKePbG0d1bevJk7MojLNgMrFNThWg3tV1196s=;
        b=hav/8eOOtgK8A7RkE6ZNwIFCZzkIo4Gt3RAQzqgrbp8qUNYBgS+oNTl4TrM2f57UYQ
         9Y1Q/ItsJIT0ytm76Fy+1nma2JMFUjne9ZhRTiyRAq8ZnmibQ7Qw03dxMklEPCtAvyUl
         9WQsvP92/X+hiOVuIm4EBfhCfOJbmYKh8N9YWAsIqkwCzA+8UEcdncdCcMn7mK6CdjFQ
         jffnG4fGG7mRU1ZzGblzjpj8K4FV8llCwWfAm97PCXyWy2PksDObe0zDuJ1oYUNDyZOv
         3eNf90yGFXhoEBexgZnaHkGp2mbFxUu4to+41W7CipFCOS8zC1+IQJ5oD1HGobzGGFWz
         OS1A==
X-Gm-Message-State: ACgBeo1yQZJj+7Ozzu+T5k6+DQExL6DsAd9EleymIyiVlXHC0VazDkZI
        Cvno9KYxZzTgutix2YDjje3IvQ==
X-Google-Smtp-Source: AA6agR445HG3r3qBDDzaVsSrHcRQkMnu4zhhjpAsfoxku52mXAIvKOxgtmC0dcX8Fqi2BnRGVrb9Cg==
X-Received: by 2002:a17:902:b20a:b0:172:7385:ea63 with SMTP id t10-20020a170902b20a00b001727385ea63mr27092536plr.54.1662991196920;
        Mon, 12 Sep 2022 06:59:56 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 72-20020a62174b000000b0053eec4bb1b1sm5513780pfx.64.2022.09.12.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 06:59:56 -0700 (PDT)
Date:   Mon, 12 Sep 2022 13:59:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: selftests: Rename 'msr->availble' to
 'msr->should_not_gp' in hyperv_features test
Message-ID: <Yx87WXMXGzLxrT0f@google.com>
References: <20220831085009.1627523-1-vkuznets@redhat.com>
 <20220831085009.1627523-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831085009.1627523-3-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022, Vitaly Kuznetsov wrote:
> It may not be clear what 'msr->availble' means. The test actually
> checks that accessing the particular MSR doesn't cause #GP, rename
> the varialble accordingly.
> 
> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../selftests/kvm/x86_64/hyperv_features.c    | 92 +++++++++----------
>  1 file changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> index 79ab0152d281..4ec4776662a4 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> @@ -33,7 +33,7 @@ static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
>  
>  struct msr_data {
>  	uint32_t idx;
> -	bool available;
> +	bool should_not_gp;

I agree that "available" is a bit inscrutable, but "should_not_gp" is also odd.

What about inverting it to?

	bool gp_expected;

or maybe even just

	bool fault_expected;

and letting the assert define which vector is expected.
