Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4B737382
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFTSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjFTSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:08:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AD5E55
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:08:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ecb21f86so3879494b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687284487; x=1689876487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iiaacy8dR/Z7cvZSosFFtefecDI/FL+fwVPq6hWPcAw=;
        b=XHHKTJmWHb7JZ9BreGD02oW0fUfN69x7Hg0t7ITggQQ/lyQfGdx4/avcaWYGkI/W1w
         Pd+8kYMuXjrOqvH94nc3W02M5Ye9RLintoNCYOJUvXRxFZisbcNy7PmwheSvuiurSGt/
         GpccDg76zoSf7ut7hXRYVdILlPWqv7JG84NHgeTwRruVBd5Mxq2EcIIsLBEl8SX0pqXN
         KLfb2FYkom2piH+kUjoSd9q1QmmPYD58LZOiMibJPhqSL+CsNC6ff+wFMdKJd2NJP23k
         T1ijoDYn1wH/h46Bqg+AS8K9dAWTrygVj6Lm3mJEX6hVYD23PZIw2DElhIZZF5CiZ1Kc
         vVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687284487; x=1689876487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiaacy8dR/Z7cvZSosFFtefecDI/FL+fwVPq6hWPcAw=;
        b=WmEEJqcJhX7uaft4YPy8Mo/z+c8mXTZSG/Issg6xBq8aG6zZaAyLFSSX119Lvl0Q0P
         ybCXmERV2rDGUB31qJkZlAJvdfZ5Ck3KJTNoIpopWv8ahU3aD1nGxvR0PHE+mI+7r2yZ
         rV9hieB+hV28aWbR5PGk0uznc5C9hV2BeS52IUE6sE7BtlCVO2zrBViUZeURnKUQGEB5
         WNjKO0F+cbRIoE2JmlGv6IVCn1lZLTHM/49clln+9W91tYniX+Irnfegwgu/SVPaPQzG
         aoIxfM8LHtgAy+keG0+RS3WAdFTV2QaD7XRSyq5t/jpCuMsO/z+MUoK3EwWuWcGg9Sm4
         i5WQ==
X-Gm-Message-State: AC+VfDz/QxUdyLVncLxXTOv1OFrQ4lgsjbcjf8d+66/0vbEl0cvdB4Un
        tfgPmNRL6mLKTUltboYkdmI=
X-Google-Smtp-Source: ACHHUZ6wJyE9uAHtsdE5qeiyzXecN6CaQmbaVvxhTL7kVp9n6WCVdxURW/S2LOCWBFbBUP2h7be7Ug==
X-Received: by 2002:a05:6a00:991:b0:662:4041:30ba with SMTP id u17-20020a056a00099100b00662404130bamr18575102pfg.0.1687284486766;
        Tue, 20 Jun 2023 11:08:06 -0700 (PDT)
Received: from sumitra.com ([106.207.162.67])
        by smtp.gmail.com with ESMTPSA id t2-20020a62ea02000000b0064cca73d911sm1591371pfh.103.2023.06.20.11.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:08:06 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:07:59 -0700
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
Message-ID: <20230620180759.GA419158@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6491a85a37cc8_28e729425@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 20, 2023 at 06:23:38AM -0700, Ira Weiny wrote:
> Sumitra Sharma wrote:
> > On Sun, Jun 18, 2023 at 11:11:08AM -0700, Ira Weiny wrote:
> > > Sumitra Sharma wrote:
> > > > kmap() has been deprecated in favor of the kmap_local_page()
> > > > due to high cost, restricted mapping space, the overhead of a
> > > > global lock for synchronization, and making the process sleep
> > > > in the absence of free slots.
> > > > 
> > > > kmap_local_page() is faster than kmap() and offers thread-local
> > > > and CPU-local mappings, take pagefaults in a local kmap region
> > > > and preserves preemption by saving the mappings of outgoing tasks
> > > > and restoring those of the incoming one during a context switch.
> > > > 
> > > > The mapping is kept thread local in the function
> > > > “i915_vma_coredump_create” in i915_gpu_error.c
> > > > 
> > > > Therefore, replace kmap() with kmap_local_page().
> > > > 
> > > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > 
> > > NIT: No need for the line break between Suggested-by and your signed off line.
> > > 
> > 
> > Hi Ira,
> > 
> > What does NIT stand for? 
> 
> Shorthand for 'nitpicking'.
> 
> "giving too much attention to details that are not important, especially
> as a way of criticizing: "
> 
> 	- https://dictionary.cambridge.org/dictionary/english/nitpicking
> 
> Via email this is a way for authors of an email to indicate something is
> technically wrong but while nicely acknowledging that it is not very
> significant and could be seen as overly critical.
> 
> For this particular comment I'm showing something to pay attention to next
> time but that was not a big deal this time around.
>

Hi Ira,

Thank for your explanation on NIT. 


> > 
> > Thank you. I will take care about the line breaks.
> > 
> > > > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > > 	- Replace kmap() with kmap_local_page().
> > > 
> > > Generally it is customary to attribute a change like this to those who
> > > suggested it in a V1 review.
> > > 
> > > For example:
> > > 
> > >  	- Tvrtko/Thomas: Use kmap_local_page() instead of page_address()
> > > 
> > > Also I don't see Thomas on the new email list.  Since he took the time to
> > > review V1 he might want to check this version out.  I've added him to the
> > > 'To:' list.
> > > 
> > > Also a link to V1 is nice.  B4 formats it like this:
> > > 
> > > - Link to v1: https://lore.kernel.org/all/20230614123556.GA381200@sumitra.com/
> > > 
> > > All that said the code looks good to me.  So with the above changes.
> > > 
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > 
> > I have noted down the points mentioned above. Thank you again.
> > 
> > I am not supposed to create another version of this patch for 
> > adding the above mentions, as you and Thomas both gave this patch 
> > a reviewed-by tag. Right?
> > 
> 
> Based on this response[*] from Tvrtko I think this version can move
> through without a v3.

Okay!


Thanks & regards
Sumitra

> 
> Thanks!
> Ira
> 
> [*] https://lore.kernel.org/all/bcb0a1d2-cd4d-a56f-1ee6-7ccfdd2f7b38@linux.intel.com/
> 
> <quote>
> Thanks all! I'll just re-send the patch for our CI, since it didn't get
> picked up automatically (stuck in moderation perhaps), with all r-b tags
> added and extra line space removed and merge it if results will be green.
> 
> Regards,
> 
> Tvrtko
> </quote>
> 
> 
> > 
> > Thanks & regards
> > Sumitra
> > 
> > PS: I am new to the open source vocabulary terms.
> > 
> > > > 	- Change commit subject and message.
> > > > 
> > > >  drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> > > > index f020c0086fbc..bc41500eedf5 100644
> > > > --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> > > > +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> > > > @@ -1164,9 +1164,9 @@ i915_vma_coredump_create(const struct intel_gt *gt,
> > > >  
> > > >  			drm_clflush_pages(&page, 1);
> > > >  
> > > > -			s = kmap(page);
> > > > +			s = kmap_local_page(page);
> > > >  			ret = compress_page(compress, s, dst, false);
> > > > -			kunmap(page);
> > > > +			kunmap_local(s);
> > > >  
> > > >  			drm_clflush_pages(&page, 1);
> > > >  
> > > > -- 
> > > > 2.25.1
> > > > 
> > > 
> > > 
> 
> 
