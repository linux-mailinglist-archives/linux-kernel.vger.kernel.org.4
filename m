Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613136C1E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjCTRlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjCTRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:40:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F4B298D4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:36:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so13258649pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679333785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hpUGiYeox1kWl4OfAxGx9LTy4s9lwzAPEC2LintUMTc=;
        b=BtCwXN29zeO1Y2JubkxnqAj2y9r5ppxzyhIYMyUQ+7kjvqpqF6WoKT4KRHH7v86VmB
         cmGLns+Rn5mdrrdVa8FbMLj4dwKKemEB/I3XQ3Dg2L5CNV/jfELfU6YlYE1BR0yw8z0K
         lVe9NTGAOFCpmqwTdASeFMuSLzz2DXBQENOss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpUGiYeox1kWl4OfAxGx9LTy4s9lwzAPEC2LintUMTc=;
        b=16ZlaXUGuygCkc1AX+nmX2l5kFUXjWzCyQy4J52L6NfTFS9UuRujff9XdosKZlvuw5
         A4dBwcx0haa0LF0f8cFuerrjdBorcb4C3tBw7eFTeBZxv96SBkxhugnfevR1kS8k3cu2
         B1wZGWTG1etMtlr2cV1SUP2ysEIoxx8ruMnT4XquCgidoOUGgtb2VqVZ7yBTURGqqi1f
         QTRwTx9/DL0YE79PtS03DnaVRJcyaakXclSS/cNgTb48EDTrnFReAQvAwRIB4f4B9tBc
         U31rI8hxPuEDgK2kqcoiYDhy71fF1H8Ulen2B8hoW6ha0PBDLCXj4qEMpeFvlu7HopB9
         FO8g==
X-Gm-Message-State: AO0yUKUOMjMyDekGbyTL2jt4PPrQ3zh1zaeFqw7bIYc9ucTDRoW964kY
        8EHqAkKV46F6NWeVN8twplsYhg==
X-Google-Smtp-Source: AK7set9t390bG2K3Xo5adX8F8Bk16FfVLogcMGAN0o6Fz61VzJapYPhoEvZSKsa75t3/lr7IoM3W2g==
X-Received: by 2002:a17:903:120f:b0:1a0:549d:39a1 with SMTP id l15-20020a170903120f00b001a0549d39a1mr20418380plh.32.1679333785667;
        Mon, 20 Mar 2023 10:36:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b0019a95baaaa6sm6979664pls.222.2023.03.20.10.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:36:25 -0700 (PDT)
Message-ID: <64189999.170a0220.fa1d9.c3f5@mx.google.com>
X-Google-Original-Message-ID: <202303201036.@keescook>
Date:   Mon, 20 Mar 2023 10:36:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/uapi: Replace fake flex-array with
 flexible-array member
References: <ZBSu2QsUJy31kjSE@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBSu2QsUJy31kjSE@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:18:01PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Address the following warning found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> drivers/gpu/drm/i915/gem/i915_gem_context.c: In function ‘set_proto_ctx_engines.isra’:
> drivers/gpu/drm/i915/gem/i915_gem_context.c:769:41: warning: array subscript n is outside array bounds of ‘struct i915_engine_class_instance[0]’ [-Warray-bounds=]
>   769 |                 if (copy_from_user(&ci, &user->engines[n], sizeof(ci))) {
>       |                                         ^~~~~~~~~~~~~~~~~
> ./include/uapi/drm/i915_drm.h:2494:43: note: while referencing ‘engines’
>  2494 |         struct i915_engine_class_instance engines[0];
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/271
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
