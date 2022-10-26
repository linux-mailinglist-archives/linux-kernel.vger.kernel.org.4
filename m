Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C860EBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiJZWvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiJZWvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:51:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E266C743
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:51:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e4so13081868pfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nx9X2AqXx9kL9mqmehn81a2HA6pr+SJoh7OoN2qbwyg=;
        b=nTy1bgcyfdBnKCEA1LTRIjdKcEPy77U2IWejK1U4ZU8Mwb3Wif+sWjP7DCYH3DEsqc
         92vqfo7DKXhusqba9tOHKyHhBMByqRefuKOmhO4wW+3IT2VjeetQqsvshPZL4XKNhz3t
         tvLLK0Um2V8i0V4Xf0wPtynXDJ537WODNoSgOl4mw2TnGarMtVWL/4pSAxmFMCzzkoGw
         4K036WnrhymXaCoJMPNjtp4+3IHjSDw0k8TVKA1W5zfbgx914pUwJIhN+lbr7VLugXVZ
         k2WmuFUKsQlcItNkjvoEMXu4GF98OZxVE4cTUovqyAS7R7r60SnEBF4m8MG1GVGTAz89
         BY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx9X2AqXx9kL9mqmehn81a2HA6pr+SJoh7OoN2qbwyg=;
        b=jX65aMkPZ9r/aDB6vNUiAWRNnpJ/cieEdB9te2XphZLCNqGebpJhifIcCihcpt/O+q
         lCgfjNoVWmLCoeY5i33utK65EWCv9Pa1tyK0pYDOOeakI68Ph5lXIvanmUEN5s6uWq7C
         G3ZSJqvnnYqwWCMwmE2vNuw3dsciQLtFPJgfIYb46WmDqoxnn0kOJdIedJHiRA1N87Br
         Z3uZo6N2mYVpW13BuBrFptRAM8SbekdPVGhTl1T8vkDEqMKnyj55SgT6UvSJXT4mHKey
         LLqlLCMYF21lNxvQhu1y6u2rqA33ZS5QksO4/zHcg38K35IgTt7dmS5T9a6ihUsKrR90
         WLkg==
X-Gm-Message-State: ACrzQf0EZ9ueHMfgHpBYKGMWRT6vWx3s8LLtAtdI0Hb62i2rB5Sn0za2
        JUaZvSrckODOy42rBbbiASFLrQ==
X-Google-Smtp-Source: AMsMyM5uDq5gVub7K6AXTfD48w2JCLbepkn5cs6Jmiy268Ba9Ircho3cVoNYIgMVXu023dtlOil2+w==
X-Received: by 2002:a63:de0e:0:b0:46f:23c6:e7d9 with SMTP id f14-20020a63de0e000000b0046f23c6e7d9mr12115216pgg.68.1666824668124;
        Wed, 26 Oct 2022 15:51:08 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b00178b06fea7asm3409669plh.148.2022.10.26.15.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 15:51:07 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:51:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 4/4] kvm: x86: Allow to respond to generic signals
 during slow PF
Message-ID: <Y1m52MUZm9m3s17K@google.com>
References: <20221011195809.557016-1-peterx@redhat.com>
 <20221011195947.557281-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011195947.557281-1-peterx@redhat.com>
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

"KVM: x86/mmu:" for the shortlog.

On Tue, Oct 11, 2022, Peter Xu wrote:
> Enable x86 slow page faults to be able to respond to non-fatal signals,
> returning -EINTR properly when it happens.

Probably worth adding:

  Opportunistically rename kvm_handle_bad_page() to kvm_handle_error_pfn()
  as an error pfn doesn't necessarily mean the page is "bad".

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
