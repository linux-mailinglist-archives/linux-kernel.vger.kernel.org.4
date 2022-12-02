Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336F96410E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiLBWtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiLBWtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:49:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4FE5F5F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:49:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so6422902pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 14:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zf9FQYPb7IhTgwhWHe3ZzCAFF6zYBHHq7kdqxOUK6iE=;
        b=oNLuBgJV9pADQi48wDLKc0aHYvcSFy+n64QtfRVE9Qvx5jIC11Gt51rOMETOQtkv03
         Z0DdLrYHUrjE6AdeCCYWYFCYeMIsQ72e9HoEC8r38Zbxx0WaQrTx24PhhcISBUgIm7zN
         xy/lbDoWZw2Rid+3mwGaiU9YQSqJYu0o0Sda8PTfuMr1O5MOm0ZY/LZIaU83W223zhlz
         H7bzOPrBMii4m5EvjoJLYdUryrPyA3YUDEVofre1+SCmjewkhBlw2C2QOruYvYJnO4u2
         Q46PLNHcHnErGYNtJXbMc11k8/1mcmB9/epIn99dnC8IssY4IA6QGx+WDnN/X6U0phEw
         9WBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf9FQYPb7IhTgwhWHe3ZzCAFF6zYBHHq7kdqxOUK6iE=;
        b=KpoL4uWmHZgJXD/vy645Sdp42/imokMLlM+mzVh9QCS2s6wPaGlAopIaX9OKQucUNY
         7aEvkDpVWym/BQ7T7IRQ/HAzTT1E6FwANX9A7KE0Qx+ZsOmtJmrSQplKieGW8TbguIad
         0defzHsKpC/Y66kRwjXtPXjsBJnLK7FNHEhVp8ElBOI6hGC/p+Xrp5nFyjKZ/7AYjB0/
         OcG54aqsEj9D6JBs/RBCpf+1yLvwT9JT8X5YGonlR0MQRkTZbcAb265ulXsRp/SIGhNu
         xHIlUm9++rwQBwLP90AXavmDyIpZPPYhBS5tXXyydlimdF5WGVFneD0aKcSLQAArM7IJ
         18cw==
X-Gm-Message-State: ANoB5plnA33uMK5OkjJvnDIdcvQJ+TU/1bFIsugNLdqUteAorpnaJWmR
        Fr5TfCsGfSi2yJVVkta+E+4qxg==
X-Google-Smtp-Source: AA0mqf7bcC4dgwWH6fO/6WJldthGYwV2FTzug9FwO8c8DulPwpdohjmh82LGoirS6sFCjQDGBOYl2g==
X-Received: by 2002:a17:902:ecd1:b0:189:90b9:2500 with SMTP id a17-20020a170902ecd100b0018990b92500mr25315753plh.0.1670021390123;
        Fri, 02 Dec 2022 14:49:50 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g81-20020a625254000000b00561d79f1064sm5585756pfb.57.2022.12.02.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:49:49 -0800 (PST)
Date:   Fri, 2 Dec 2022 22:49:46 +0000
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
Message-ID: <Y4qBCjTcMdBLUNEB@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-3-kristen@linux.intel.com>
 <3a789b1c-4c70-158b-d764-daec141a5816@intel.com>
 <abfc00a2ab1d97f8081c696f78e2d0ced23902b4.camel@linux.intel.com>
 <2015ae96-5459-1f82-596b-f46af08ef766@intel.com>
 <Y4p9nKV+jpLnOVwD@google.com>
 <8b7f6993-2135-a9f9-63c5-c9c6112ef676@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7f6993-2135-a9f9-63c5-c9c6112ef676@intel.com>
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

On Fri, Dec 02, 2022, Dave Hansen wrote:
> On 12/2/22 14:35, Sean Christopherson wrote:
> >> That seems like it's going the other direction from what an OOM-kill
> >> would need to do.
> > Providing a backpointer from a VA page to its enclave allows OOM-killing the enclave
> > if its cgroup is over the limit but there are no reclaimable pages for said cgroup
> > (for SGX's definition of "reclaimable").  I.e. if all of an enclave's "regular"
> > pages have been swapped out, the only thing left resident in the EPC will be the
> > enclave's VA pages, which are not reclaimable in the kernel's current SGX
> > implementation.
> 
> Ooooooooooooooooooooh.  I'm a dummy.
> 
> 
> So, we've got a cgroup.  It's in OOM-kill mode and we're looking at the
> *cgroup* LRU lists.  We've done everything we can to the enclave and
> swapped everything out that we can.  All we're left with are these
> crummy VA pages on the LRU (or equally crummy pages).  We want to
> reclaim them but can't swap VA pages.  Our only recourse is to go to the
> enclave and kill *it*.
> 
> Right now, we can easily find an enclave's VA pages and free them.  We
> do that all the time when freeing whole enclaves.  But, what we can't
> easily do is find an enclave given a VA page.
> 
> A reverse pointer from VA page back to enclave allows the VA page's
> enclave to be located and efficiently killed.
> 
> Right?

Yep, exactly.
