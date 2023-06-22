Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796B973A41C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjFVPCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjFVPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:02:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79807268C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:02:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b52132181aso39459205ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687446079; x=1690038079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRdkBzWvxfxb0w3VbAj/JjLYqdb5vKvNBOzrMjbvnZ4=;
        b=R/z8invRF3TFjDD5ZndbOtRxmhsqjYybp/CiyK7JWC4Fet52AywMb/9DklgK+EzcFM
         GZX1r2D35pYTtFshs5Iiyad4K8tZmvsRjkesTz5gOb01qU+7scWRXEqyr+TjsoSisMh7
         O0UQodu1lH5F2Xx3h1NZmd+n/SPriz5HOn/uZvsN+DYNVYn/YDEoteOSNilo5hmywMfA
         qwxhVDNrVNbI3se6guRRXDutEmkLoup1n4+VD7fuEjfP28esDW4VEfUKuYD3KzEyKips
         kMG+ezU3TY98nzCb8uKqe9QLp0CiWU2VFncTAKzFvJUna7k6H37qj2DKpFkq5R8zZ2Ml
         YNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446079; x=1690038079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRdkBzWvxfxb0w3VbAj/JjLYqdb5vKvNBOzrMjbvnZ4=;
        b=i1A+9Y8k9v5o39A4inbxs4oeoKHfPyzwj+iP98IF0X9CoMCyAIE/uyZeSSLRHr5lcY
         YJvmzSIQTtISzR70wffTU4RFDWcXvA8t7SZQxifr91+lFNipUE4kBrG3QMkvL6xKLcLg
         umaEYHIX4CEf3amrNO1H15C6sxQcXi9Fo3DYvjIBiSXL+uK9GTwUqlLkul9GDrW3ew/p
         rmQejWKh9lAQJC95bqgTKkRyo0+Xv4nTcv6B62gZfBlvxKixC2YFwQsDIC2i5kVvAAgP
         GIz9QAbiEKK2+g3bHuvusOCULcd5m/xyqrf7A2/UQPOHBFkINHsgPlLy01T5aCkNkN+h
         HABQ==
X-Gm-Message-State: AC+VfDyNjcuGcbZp2HYDW8euFFYrrhWouO/T3Adf67GAc3Ckwd6iVTbX
        VMzJamPYsuUKBskepqgDfcP0VtRAWpd7cg==
X-Google-Smtp-Source: ACHHUZ7N8KQZGqYQF1FWIcaXUvTIe8GPbWvAVGZGWeKR6BMLl6zU9OMZ/+A2hwmX75wR2qeBRE7w/A==
X-Received: by 2002:a17:902:d905:b0:1b5:4859:ef36 with SMTP id c5-20020a170902d90500b001b54859ef36mr8976230plz.57.1687446078566;
        Thu, 22 Jun 2023 08:01:18 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902b41100b001b3ec39f40asm5475739plr.270.2023.06.22.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:01:18 -0700 (PDT)
Date:   Thu, 22 Jun 2023 07:59:05 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK and BIT macros
Message-ID: <ZJRhuaebZC+y7B37@yury-ThinkPad>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZJOwC5LIEySpduQJ@yury-ThinkPad>
 <alzfewo3jado7ezyaibq52ep3vuxbyfism4ablchmvmioio3jb@3gyx6vaoscbf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alzfewo3jado7ezyaibq52ep3vuxbyfism4ablchmvmioio3jb@3gyx6vaoscbf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rasmus Villemoes <linux@rasmusvillemoes.dk>

> > -#define __GENMASK(h, l) \
> > -	(((~UL(0)) - (UL(1) << (l)) + 1) & \
> > -	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > -#define GENMASK(h, l) \
> > -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > +#define __GENMASK(t, h, l) \
> > +	(GENMASK_INPUT_CHECK(h, l) + \
> > +	 (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> > +	 ((t)~0ULL >> (BITS_PER_TYPE(t) - 1 - (h)))))
> 
> yeah... forcing the use of ull and then casting to the type is simpler
> and does the job. Checked that it does not break the build if h is
> greater than the type and it works
> 
> ../include/linux/bits.h:40:20: error: right shift count >= width of type [-Werror=shift-count-overflow]
>    40 |          ((t)~0ULL >> (BITS_PER_TYPE(t) - 1 - (h)))))
>       |                    ^~
> 
> However this new version does increase the size. Using i915 module
> to test:
> 
> $ size build64/drivers/gpu/drm/i915/i915.ko*
>    text    data     bss     dec     hex filename
> 4355676  213473    7048 4576197  45d3c5 build64/drivers/gpu/drm/i915/i915.ko
> 4361052  213505    7048 4581605  45e8e5 build64/drivers/gpu/drm/i915/i915.ko.new

It sounds weird because all that should anyways boil down at compile
time...

I enabled DRM_I915 in config and ran bloat-o-meter against today's
master, and I don't see that much difference.

  $ size vmlinux vmlinux.new
     text	   data	    bss	    dec	    hex	filename
  44978613	23962202	3026948	71967763	44a2413	vmlinux
  44978653	23966298	3026948	71971899	44a343b	vmlinux.new
  $ scripts/bloat-o-meter vmlinux vmlinux.new 
  add/remove: 0/0 grow/shrink: 3/2 up/down: 28/-5 (23)
  Function                                     old     new   delta
  kvm_mmu_reset_all_pte_masks                  623     639     +16
  intel_psr_invalidate                        1112    1119      +7
  intel_drrs_activate                          624     629      +5
  intel_psr_flush                             1410    1409      -1
  clk_fractional_divider_general_approximation     207     203      -4
  Total: Before=35398799, After=35398822, chg +0.00%

Can you please check your numbers?

Interestingly, the kvm_mmu_reset_all_pte_masks() uses GENMASK_ULL(),
which should generate the same code across versions. Maybe it's just
a noise? Rasmus, can you please take a look?

Thanks,
Yury

