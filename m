Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C9617345
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKCAQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCAQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:16:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B5643C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 17:16:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 78so233496pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TR/FLylgxK/I2non4Jcf5b91bwewrJCEbBz2Bvyvykg=;
        b=HRZzWurJviswOwCIuleU2CRo/EB/i55cyyR98DFQreiGR0GS+89KbAaHR/wXCsiP5h
         2E++LYWoq8Cb6Ymfh/0q59vY2eP+RHit8bT5+LFUT+UwuzXT4vIxWBekPBzIWyS32L1n
         5GL75O3A8GNzFYJJWN5nvDk8xkXTSPG+TkTdbMx/l5Ymd4U0nBfwog0TgmMIwXpq98GQ
         j17QwhXuxnbeMMMjJSEj1BDVNtdJNjYz4tzSMLOyxXBj0mZRRlBuFlD3vbMUJeLE4G2c
         XufcrsccL1NXvao0pnF2ib6CSK1Z82iHKoiVvevJE1PNpQ+Pf8B141voAMDjBZZ9eOj6
         dzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR/FLylgxK/I2non4Jcf5b91bwewrJCEbBz2Bvyvykg=;
        b=XumQm7I1QbEpQRHIyNzw1PXHL7rDJn7JeI2JxtvEd5bGkOaprv37bLVVD+3VHWUgP/
         i7vcKbWCUaaJrxM9sQ0zc7rRIVZ+/xyPFVVeWhohvVkEC8ZF+1QjuGXQW2G7H3FOEs1t
         aTW1VIjSGrL9AW6ZZdGeSdkJNuEuDN06CiQP72CljNfwttbIFCjTMemNgZjYqAkxGlyJ
         0xqFxyxUn4DqOMLttNd8n1efqa7CtdTI0ELc2D0LKeAWnK1umF1XK+SOxSX0u/uncBG4
         by+CxVWq9mBpmHwcVaeyO1aHfFBLhmPAzTbISZCbIOo9E1/PNpoSdxZt1rIimC/40LjU
         5iZg==
X-Gm-Message-State: ACrzQf0/obR8K8S3tLfjUdvUC08dUL4W+F08q68dWu/bU6JgqejUj/3P
        TJmCiIwuNp0EH7UjnPixO+2l0g==
X-Google-Smtp-Source: AMsMyM4kr45aBsDg4MYIjRgBgEk/i43diLEB5A7b7VkwpCYKL3i7jT4esyPQcoOxhLuTJDQip0SB/Q==
X-Received: by 2002:a05:6a00:1489:b0:56d:642b:585f with SMTP id v9-20020a056a00148900b0056d642b585fmr19246631pfu.31.1667434586857;
        Wed, 02 Nov 2022 17:16:26 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g16-20020aa79dd0000000b0056cd54ac8a0sm8975341pfq.197.2022.11.02.17.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:16:26 -0700 (PDT)
Date:   Thu, 3 Nov 2022 00:16:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] KVM: selftests: Shorten the test args in
 memslot_modification_stress_test.c
Message-ID: <Y2MIVxzVQkGcEwlL@google.com>
References: <20221102232737.1351745-1-vipinsh@google.com>
 <20221102232737.1351745-6-vipinsh@google.com>
 <Y2MBNA7pLIb6ugU2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2MBNA7pLIb6ugU2@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022, Sean Christopherson wrote:
> On Wed, Nov 02, 2022, Vipin Sharma wrote:
> > Change test args memslot_modification_delay and nr_memslot_modifications
> > to delay and nr_iterations for simplicity.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> 
> I don't care about the credit so much as I don't want you getting yelled at for
> one of my random ideas :-)
> 
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> >  .../kvm/memslot_modification_stress_test.c     | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> > index d7ddc8a105a2..d6089ccaa484 100644
> > --- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> > +++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> > @@ -87,8 +87,8 @@ static void add_remove_memslot(struct kvm_vm *vm, useconds_t delay,
> >  }
> >  
> >  struct test_params {
> > -	useconds_t memslot_modification_delay;
> > -	uint64_t nr_memslot_modifications;
> > +	useconds_t delay;
> > +	uint64_t nr_iterations;
> >  	bool partition_vcpu_memory_access;
> >  };
> >  
> > @@ -107,8 +107,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> >  
> >  	pr_info("Started all vCPUs\n");
> >  
> > -	add_remove_memslot(vm, p->memslot_modification_delay,
> > -			   p->nr_memslot_modifications);
> > +	add_remove_memslot(vm, p->delay,
> > +			   p->nr_iterations);
> 
> This wrap is no longer necessary (which was part of the motivation for the
> rename).

Almost forgot.  Nit aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>
