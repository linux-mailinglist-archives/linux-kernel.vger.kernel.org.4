Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB7736F16
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjFTOtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjFTOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:49:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C81717
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:49:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so45605815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687272544; x=1689864544;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFBJCFv89ibLGDxP64+KT5RKVRcJ4ABThqZOUh/7S8U=;
        b=u/nNunrJJa6/pTEdqFGYPAhtOAsS9D0F0Anp3vZDPkfxNCw2tMiHHZcg6GSyR8nblh
         CNboKm+SxYJjYaFoXBPLi7zB10yrVnRTrlx+KejPLgk9SlKVgzkg9MlbIvtSsvURzXlf
         6/8H1AsUpPrUWvtYsLb6Uz3IQ0FqOD8+Nvyk8FempvIx7zVA5tMD4XJ0wQvB/ziNDViK
         vyZISyFCCkt5AC9InX2i8JjC6kDmpphGiiaJN8blfT9IYQCbL4eeQ38tTNKebViEPuo+
         D9mJkOCfxfhU0sjTaiw1603JgWXxKT5DGz77RpQVXdGXeUm8h6ALOhXtetH/FNZCT4ZZ
         zMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272544; x=1689864544;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFBJCFv89ibLGDxP64+KT5RKVRcJ4ABThqZOUh/7S8U=;
        b=dWXm2L3pv7na6oumNe1Q8nMMSdoA6TMIgvIL1C3ONRoZ+BK/XdSGvxc/VjW3opuxhv
         7FvxFQeTC0ZLfa3FzklbiLwEsJnDJacdN7gV6AmJGJJov0ypRqeyajXBkLms7pIiakvZ
         PuN2CX9m2+nSR8yBXeMtGgC6eKb6tg2c8CLCsNjuZe2gibaMwjguSEGhPWkEpeyE9Fbw
         XVB0waqcbzMJegJAMiddmXoBQL+EQyZaIcBE2mEzTvkQBfC0vhLYfuEKiTwWEv7iraXU
         8dJSN16lXFGoeOFUJkytAIGLSapnb5UOMjEXmT9/P3Rqc+JWo4/AcAsi4YbC52GUYL2S
         epeg==
X-Gm-Message-State: AC+VfDxuZHV9KzpLByP2HdGUkRtu2g4PJT4n3hyN2c/wtBl2E1oeLC6M
        rpjmNXdviwuZ8x1pBY82vuCr7Q==
X-Google-Smtp-Source: ACHHUZ7LDr1h7a0YR+y1QSbkuQ+nwXK7muhEZDUzjJ87F1Pyf+gCx4EV1rE49ZD6t+JhlLe/MGCHXQ==
X-Received: by 2002:a05:600c:231a:b0:3f9:b430:199b with SMTP id 26-20020a05600c231a00b003f9b430199bmr3194468wmo.15.1687272543652;
        Tue, 20 Jun 2023 07:49:03 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:8530:a6a3:373f:683c])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003f42d8dd7d1sm13668387wmd.7.2023.06.20.07.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:49:03 -0700 (PDT)
Date:   Tue, 20 Jun 2023 16:48:58 +0200
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kasan: add support for kasan.fault=panic_on_write
Message-ID: <ZJG8WiamZvEJJKUc@elver.google.com>
References: <20230614095158.1133673-1-elver@google.com>
 <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
 <CANpmjNOSnVNy14xAVe6UHD0eHuMpxweg86+mYLQHpLM1k0H_cg@mail.gmail.com>
 <CA+fCnZccdLNqtxubVVtGPTOXcSoYfpM9CHk-nrYsZK7csC77Eg@mail.gmail.com>
 <ZJGSqdDQPs0sRQTb@elver.google.com>
 <CA+fCnZdZ0=kKN6hE_OF7jV_r_FjTh3FZtkGHBD57ZfqCXStKHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZdZ0=kKN6hE_OF7jV_r_FjTh3FZtkGHBD57ZfqCXStKHg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:56PM +0200, Andrey Konovalov wrote:
...
> Could you move this to the section that describes the kasan.fault
> flag? This seems more consistent.

Like this?


diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 7f37a46af574..f4acf9c2e90f 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -110,7 +110,9 @@ parameter can be used to control panic and reporting behaviour:
 - ``kasan.fault=report``, ``=panic``, or ``=panic_on_write`` controls whether
   to only print a KASAN report, panic the kernel, or panic the kernel on
   invalid writes only (default: ``report``). The panic happens even if
-  ``kasan_multi_shot`` is enabled.
+  ``kasan_multi_shot`` is enabled. Note that when using asynchronous mode of
+  Hardware Tag-Based KASAN, ``kasan.fault=panic_on_write`` always panics on
+  asynchronously checked accesses (including reads).
 
 Software and Hardware Tag-Based KASAN modes (see the section about various
 modes below) support altering stack trace collection behavior:
