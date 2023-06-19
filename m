Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD74735B72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjFSPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjFSPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:46:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C14FE65
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:46:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6687096c6ddso668753b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687189559; x=1689781559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a8Og5h/yKrlm8jSKmkaXbcFetR4mC5v+7J0mPleddkU=;
        b=oXVIR3zkRp+1DEvl2Xpr+KrgGa4LxV1UsxEUr4mLcrgJLsAr+MWWiFusddNr/hTWmB
         qZkkSV1HpK2RomjyTo3KOh3+8BljNY/tXoILXpIAjux6CIGKlzgjMWCXp5XzX50rpG09
         bc6igPPLIjKq2Ixcdv3yjO1iq4iKmaWYZHPAgFRoTxKh82yFxrsgzHjHvEAmLGLs2iEQ
         Igcvc8RLu6JaYLaL67oC2l6ua88dCFUdZV0NRVzHzPDT0xsAzTyN1f4lXSlHrR2eYW9r
         DilnS+23DQrpU5nGBUtqcVnsKnm3vYSkRkc1LGkHbldyA1PyumjypqxcQSDzOxywkpXj
         EouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687189559; x=1689781559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8Og5h/yKrlm8jSKmkaXbcFetR4mC5v+7J0mPleddkU=;
        b=eCvr6O7elzIS5QJK9HsF2V8ReVy+7du/ps/iTEIk+YuVrglh57LZgo/aM8UfbcscYS
         6lbrB3lDrOwjhweLxG9H8TqEK1SaVnkAsSOHRCjCWNJo1PH9Wyz7D1u5Rw8Aqr6QmJmh
         NQDpk/0IV4NXqkWK3TbWEi9s42NeG058/B6JM2Y4llUUXNRAkFCqyjCtvNFTjBfWrb1c
         jGrvptxWWz1N3iFbnLG54kSWnbHrzIuZIad2YPyH8gBXPhFAcL0BaCmEP0Y0Or18Xye+
         p7E5QWXAWMV1lu+gXP616lF1YvomPCPUQ9xhdcfwAkv8kZrTY9D00z3SoZhegZZw97UE
         diug==
X-Gm-Message-State: AC+VfDyA3yaN0ND5osmhYIHMvWSr/b/ouSQHFy0NR7cLM2F7LtW4J+HE
        sMgEoQPn4cyFK4td5EjNCUI=
X-Google-Smtp-Source: ACHHUZ6RWfursTFuGYeRkaJ+t1j5qreI+VxDrRuP7BW+hRuT2EibTVSWdiup8K+UYoRcbIYEQQ2stg==
X-Received: by 2002:a05:6a00:2d82:b0:668:715a:6fcd with SMTP id fb2-20020a056a002d8200b00668715a6fcdmr2868668pfb.5.1687189559451;
        Mon, 19 Jun 2023 08:45:59 -0700 (PDT)
Received: from sumitra.com ([59.95.144.189])
        by smtp.gmail.com with ESMTPSA id fe26-20020a056a002f1a00b006579b062d5dsm3648055pfb.21.2023.06.19.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:45:59 -0700 (PDT)
Date:   Mon, 19 Jun 2023 08:45:50 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH v2] drm/i915: Replace kmap() with kmap_local_page()
Message-ID: <20230619154550.GB412243@sumitra.com>
References: <20230617180420.GA410966@sumitra.com>
 <648f48bc3d3c2_1de3f9294a3@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <648f48bc3d3c2_1de3f9294a3@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 11:11:08AM -0700, Ira Weiny wrote:
> Sumitra Sharma wrote:
> > kmap() has been deprecated in favor of the kmap_local_page()
> > due to high cost, restricted mapping space, the overhead of a
> > global lock for synchronization, and making the process sleep
> > in the absence of free slots.
> > 
> > kmap_local_page() is faster than kmap() and offers thread-local
> > and CPU-local mappings, take pagefaults in a local kmap region
> > and preserves preemption by saving the mappings of outgoing tasks
> > and restoring those of the incoming one during a context switch.
> > 
> > The mapping is kept thread local in the function
> > “i915_vma_coredump_create” in i915_gpu_error.c
> > 
> > Therefore, replace kmap() with kmap_local_page().
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> NIT: No need for the line break between Suggested-by and your signed off line.
> 

Hi Ira,

What does NIT stand for? 

Thank you. I will take care about the line breaks.

> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> > 
> > Changes in v2:
> > 	- Replace kmap() with kmap_local_page().
> 
> Generally it is customary to attribute a change like this to those who
> suggested it in a V1 review.
> 
> For example:
> 
>  	- Tvrtko/Thomas: Use kmap_local_page() instead of page_address()
> 
> Also I don't see Thomas on the new email list.  Since he took the time to
> review V1 he might want to check this version out.  I've added him to the
> 'To:' list.
> 
> Also a link to V1 is nice.  B4 formats it like this:
> 
> - Link to v1: https://lore.kernel.org/all/20230614123556.GA381200@sumitra.com/
> 
> All that said the code looks good to me.  So with the above changes.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 

I have noted down the points mentioned above. Thank you again.

I am not supposed to create another version of this patch for 
adding the above mentions, as you and Thomas both gave this patch 
a reviewed-by tag. Right?


Thanks & regards
Sumitra

PS: I am new to the open source vocabulary terms.

> > 	- Change commit subject and message.
> > 
> >  drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> > index f020c0086fbc..bc41500eedf5 100644
> > --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> > +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> > @@ -1164,9 +1164,9 @@ i915_vma_coredump_create(const struct intel_gt *gt,
> >  
> >  			drm_clflush_pages(&page, 1);
> >  
> > -			s = kmap(page);
> > +			s = kmap_local_page(page);
> >  			ret = compress_page(compress, s, dst, false);
> > -			kunmap(page);
> > +			kunmap_local(s);
> >  
> >  			drm_clflush_pages(&page, 1);
> >  
> > -- 
> > 2.25.1
> > 
> 
> 
