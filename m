Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63406410BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiLBWg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiLBWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:36:03 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F614FA459
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:35:13 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c7so2804073pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 14:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3AsPBlStxM5I2Ol3fQv4IigRWmDsbShzT0tHCkMWpc=;
        b=ODGW++iHa9F+rS6SwwuY93cCe2n+w1WZcRsza8S7XVaW4m0QTCHPGuWrWU0YbABHDT
         jjKouQfhsXnhHWR7hV/UnqPxP9JQMq4+wyMM6M7Q1stGl6Lo7/thVMCPwtolJsk+yNa0
         pIo7PPrDZdwNXrX9sAb3/rR9JFpaHOlctjjyBx8Z0e8LCsX+z3syP4TZPf23YmiDuat8
         ls3MGIOXTJeSlwXRetecOnRzC1pZ7DogR0v9Uqrfi7XJrJBiKPNpyqWviLmix5yedLMa
         +2FHfJgGbV85dhz2J0zpsbsaVGOWLil1D7qyI1wnnC6fTKpwqdv1L2GL79hx2FfYZn6N
         sTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3AsPBlStxM5I2Ol3fQv4IigRWmDsbShzT0tHCkMWpc=;
        b=jofxjZTYRuLwDVTnvSYIq3NAUCywCU40kmayEujdYNOzk3/UQ1DVTiRwbhPWtKLWwE
         mIIpdXlDfrBvLJfT7b1DsmyrcZgRn0vOaDW4zKQCHkLTOtNCLrUe/jiy3srHIyWR+Ll2
         3ol8GlqPK4SxqSCkx45AODZ0ls8Cw2woK2ivSVwgl4JUfJqj1NiZMzQr4VQUycVggiSb
         v3MD8sCwWbaf8c5inxEAAcMWqlaOjMOboAAoCnmoJpQXc3f6dWq9/AfT92t5tEKNv/RR
         D4VVa4F1L8sIr4qrdAwUhYbgmJWg9jvwTz04d05Nq5HO6GhzVxNEstGl37OhWgvPaLoi
         Mcjw==
X-Gm-Message-State: ANoB5pl1eowtfuF/CU1wKTM7VXjRkFeWBzC987rj4Yw0c8cJG9YZj8Gn
        9JyMWfyMUhBGKvekw7dFxaJOGg==
X-Google-Smtp-Source: AA0mqf7nH73xcxVT1coc+0CqH8zWWPgkL4uiAQR/zMxNI0Rnz4QS+6fzpb85FA1LUptLIDNgDK9eBg==
X-Received: by 2002:aa7:954e:0:b0:574:36b6:f91b with SMTP id w14-20020aa7954e000000b0057436b6f91bmr50736002pfq.55.1670020512590;
        Fri, 02 Dec 2022 14:35:12 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 3-20020a631543000000b0044ed37dbca8sm4573520pgv.2.2022.12.02.14.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:35:12 -0800 (PST)
Date:   Fri, 2 Dec 2022 22:35:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com
Subject: Re: [PATCH v2 02/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Message-ID: <Y4p9nKV+jpLnOVwD@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-3-kristen@linux.intel.com>
 <3a789b1c-4c70-158b-d764-daec141a5816@intel.com>
 <abfc00a2ab1d97f8081c696f78e2d0ced23902b4.camel@linux.intel.com>
 <2015ae96-5459-1f82-596b-f46af08ef766@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2015ae96-5459-1f82-596b-f46af08ef766@intel.com>
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

On Fri, Dec 02, 2022, Dave Hansen wrote:
> On 12/2/22 13:40, Kristen Carlson Accardi wrote:
> > On Fri, 2022-12-02 at 13:35 -0800, Dave Hansen wrote:
> >> On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> >>> When allocating new Version Array (VA) pages, pass the struct
> >>> sgx_encl
> >>> of the enclave that is allocating the page. sgx_alloc_epc_page()
> >>> will
> >>> store this value in the encl_owner field of the struct
> >>> sgx_epc_page. In
> >>> a later patch, VA pages will be placed in an unreclaimable queue,
> >>> and then when the cgroup max limit is reached and there are no more
> >>> reclaimable pages and the enclave must be oom killed, all the
> >>> VA pages associated with that enclave can be uncharged and freed.
> >> What does this have to do with the 'encl' that is being passed,
> >> though?
> >>
> >> In other words, why is this new sgx_epc_page-to-encl mapping needed
> >> for
> >> VA pages now, but it wasn't before?
> > When we OOM kill an enclave, we want to get rid of all the associated
> > VA pages too. Prior to this patch, there wasn't a way to easily get the
> > VA pages associated with an enclave.
> 
> Given an enclave, we have encl->va_pages to look up all the VA pages.
> Also, this patch's code allows you to go from a va page to an enclave.

Yep.

> That seems like it's going the other direction from what an OOM-kill
> would need to do.

Providing a backpointer from a VA page to its enclave allows OOM-killing the enclave
if its cgroup is over the limit but there are no reclaimable pages for said cgroup
(for SGX's definition of "reclaimable").  I.e. if all of an enclave's "regular"
pages have been swapped out, the only thing left resident in the EPC will be the
enclave's VA pages, which are not reclaimable in the kernel's current SGX
implementation.
