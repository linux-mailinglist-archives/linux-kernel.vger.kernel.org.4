Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9450F70CAA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjEVUQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjEVUQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:16:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B95BC4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25372604818so3058184a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786564; x=1687378564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lqoDgNZ9G+pnENJHcgKxrrSDm2QXQ2DN2DVXwRpe84M=;
        b=THb6a7A4+ZDhhztCUfCFsPY/zH0txXyjC+97nEgRFTe1FP6hH7wG4Rx1Ek+S2QkeNF
         rROT12GKEBSriZA/G+nXPcCRbwKUoWabsNyX9y4bwg6gYnpx4jqfuiWo86AeIMljKk3j
         mtLnQUhAfjXjiVaWPWRf4oLQqhq9xk4iIH0sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786564; x=1687378564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqoDgNZ9G+pnENJHcgKxrrSDm2QXQ2DN2DVXwRpe84M=;
        b=biMnS1cn2BK+b1S9X8IkWSywJVheDQt2BnCEnTquuYV/gJBGTJIAUfIDrof9DXoUp+
         bGcDaHiEdtJrLAxdCrvkqrQnDf6bFgOJeNU6NnMvjtu3tTbDwascLOWRYAug9hoRzUXL
         FvhXJW4YM5IXdhm9E+YXVGzoB2PlLvjV3jE1OP0VUSFhLFhXDcAIm1TMOTKN1qde296p
         T8yFRUpforQk+MmHAIS/qfSBng0KJD5M76ItaX+qJQo+08UhAJcHanYg6EE2RWJyagwZ
         ieoHypkfURMM00i3LQT5H/BJi2/Lvm0HDcHzc6Qz+16xEdGoXJCrWbYymsQOhVCKj2Tx
         bn+w==
X-Gm-Message-State: AC+VfDwiwfot9O0oaAVpHxZ7lzUtJMlRk376L2FdYANiocjLtBzjdzmn
        rCueLYfrffNXMB67j052ENtbFw==
X-Google-Smtp-Source: ACHHUZ5SQz5k2SFL2blrf696wn78BpsNXHQRqB45l9/xGKDzmS28pRewvtArfVcejoeUFg//+tPPxA==
X-Received: by 2002:a17:90b:1003:b0:255:5bde:e6cc with SMTP id gm3-20020a17090b100300b002555bdee6ccmr5042944pjb.17.1684786564102;
        Mon, 22 May 2023 13:16:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ei13-20020a17090ae54d00b0024744818bc5sm6340408pjb.9.2023.05.22.13.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:03 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-hardening@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Harrison <John.C.Harrison@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Replace all non-returning strlcpy with strscpy
Message-ID: <202305221316.2817AA4FC@keescook>
References: <20230522155228.2336755-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155228.2336755-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:52:28PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
