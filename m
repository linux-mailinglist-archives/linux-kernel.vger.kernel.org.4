Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24A61057A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiJ0WOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiJ0WOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:14:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F2A5715
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:14:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k22so3132716pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xa0F8qgJ/XT5i9ZprCu/QXLKvweAlKXJv8Fq2HmtIk=;
        b=n7xeD3rv2I1oxiz8y434ljm2W4kUXy1IZeL0QRTw7VgLVKRhCHoRYKW2Soxvd6TmkR
         uKqugoxuQVWFkHMzSCZnpxEtFKHIr3eTpBnKRUup9a9utVkYtSIfIraKEGPnWtkJgLRF
         97hQSY5C5qRn7moAthqVyCKJVfminUx0z+rI/ucjMwTFaL1ZALWN5gAZ6f0k42yFZrK6
         AjXyXq4FQOkyxnUAExBuWu+BgKlf7i/AOzCTAdWfcesNF0k5Bpklj6IiYzbQB1fUfvtT
         Q4dui1HnSnPAGm2n7ye8r/desdGEVZq8YP2D4rQWgZBEXAD0uff8iQHTK2OZIDrVV3+m
         rXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Xa0F8qgJ/XT5i9ZprCu/QXLKvweAlKXJv8Fq2HmtIk=;
        b=g/Zce6qz0A9vjv6xXMjYIWInYdoSgPH8rwPNgh9eYEktrO9qYFY4KUw6hISjne8vbZ
         CS50h8vAydSZyI+/JZSa/KXTQ+Zpcxf0Uajs77N7kQJmvkd2Hvx8s1OcJmr4xonDVVyW
         FbNlWUtEhaF1NaRBC0jee2WupggspAqeoFujQAPGvwDltIyos96WMz1k5qM4+vNWk446
         kKCNAOg/GjoGaalL0dA+19DP+UVkizk3DbXR6RT4knKn7o0mVzz5YXIEon10OYeeZZYW
         Q27VqQxZsAYFI3SBNeov3t7bQJAhaI264p03OJSFvCBIG+cV4sBXJbcLeZKJJW4kGIcz
         B3Eg==
X-Gm-Message-State: ACrzQf2aypA7sq+E2ulbky8K6QVU0fjs98EmvzaavlecIILcAYRYrE/i
        olPbaAnqZfmBlvVT2xmsVjhKxg==
X-Google-Smtp-Source: AMsMyM5HcewplEwiZgZ1lxCb4X0WugaOkwaYG8PbaEvuFAAVxc08bBFDNJL9bmBaX/tD8Ncrcns9gg==
X-Received: by 2002:a65:5583:0:b0:461:25fe:e982 with SMTP id j3-20020a655583000000b0046125fee982mr43490428pgs.4.1666908856011;
        Thu, 27 Oct 2022 15:14:16 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c21300b0017f7628cbddsm1676863pll.30.2022.10.27.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:14:15 -0700 (PDT)
Date:   Thu, 27 Oct 2022 22:14:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: x86/pmu: Make part of the Intel v2 PMU MSRs
 handling x86 generic
Message-ID: <Y1sCtGvXKi3wY0vp@google.com>
References: <20220919093453.71737-1-likexu@tencent.com>
 <20220919093453.71737-2-likexu@tencent.com>
 <CALMp9eRPEFHFfW+MnMkcTBFB+vjcEe3ekg8JMrKJaRQuq7=-8Q@mail.gmail.com>
 <856e3332-9f6b-a5f7-c3ec-afe89003cb84@gmail.com>
 <6525670b-eb27-d0a5-2d03-cfa2006d0579@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6525670b-eb27-d0a5-2d03-cfa2006d0579@gmail.com>
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

On Thu, Sep 22, 2022, Like Xu wrote:
> Subject: [PATCH] KVM: x86/pmu: Rewrite reprogram_counters() to improve
>  performance
> 
> Before using pmu->reprogram_pmi, the test for a valid pmc is always
> applied. This part of the redundancy could be removed by setting the
> counters' bitmask directly, and furthermore triggering KVM_REQ_PMU
> only once to save more cycles.

Assuming you plan on posting this, please explicitly state what the patch does.
"This part of the redundancy could" only says what _could_ be done, not what is
actually done.  Oftentimes, a changelog will say something "could" be done when
talking about alternative solutions.  So when I see "could", I think "this is
what the patch _isn't_ doing".
