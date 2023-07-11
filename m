Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463BB74F49F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGKQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:14:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B9E60
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:14:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a36b309524so5100186b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689092090; x=1691684090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vq9YViWYg4uFChvJGSLE3j7fYiOn1S8zzbS7MgZUOXM=;
        b=JnU40aqXrl+cQXJk+/mWGhypL/UL4FW42fibfXNLp4FDHbP6XSKttylnrv712ddyCS
         QQiAkK4VyodEzrwPiYTOu3AnXnDvRdzb3zq1Eb9j/1HiZN1ZbrRv0XaTUkXjQRh/C60X
         aRnapaN/LqPA5iZkV1sZtWXCNBY011f1uE2TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092090; x=1691684090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq9YViWYg4uFChvJGSLE3j7fYiOn1S8zzbS7MgZUOXM=;
        b=JZqKHmT2NzEEMPhwGVmJUyZQPf6iVwmAGAWO2rdJLA4pVIi1cM9DTsOFLzrngOW6/i
         laLm1zYcgoyEUssir7Yy97/Wpg3WbZxY9+LkrMzhlg6tIK4uQovXVPCVJF0shc1osIxb
         cte+zCWZnF9p2dB+MRxRhR6Q+WMklVQI9BSdGgvdJBD7KuJjHuXAOt7rn25Bd/Tin88G
         wxQjaS/x70Bs+NuMcfpXtqCGOqKtmfqbS5o8SYGmbRuTQjyTBS7YcSR52Mf+/xlxzqlE
         gTXAHf3x7+e/Tx6lKIdOhkSnLflY9IVbAm7/TRfBQgmX11UHOEwhvjNGCFZOm8iExSAV
         SJ/g==
X-Gm-Message-State: ABy/qLZQOKcbT0rUvlWqVidQU2QHrCvDse+1MJHcFIm1fbtUNu749TJ4
        RcQYi1HofL3UlFN9IElIvriFpg==
X-Google-Smtp-Source: APBJJlHccKfb9VbDm1W28Cl55SHynKCuE6YH+AftvD/+oHJ7aeij8ZFnaHC/iLkVZXwDULUqM4kjfQ==
X-Received: by 2002:a05:6358:290b:b0:134:e4c4:ebff with SMTP id y11-20020a056358290b00b00134e4c4ebffmr16820772rwb.11.1689092090568;
        Tue, 11 Jul 2023 09:14:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a63724a000000b0055386b1415dsm1802755pgn.51.2023.07.11.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:14:49 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:14:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matteo Rizzo <matteorizzo@google.com>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/slub: remove redundant kasan_reset_tag() from
 freelist_ptr calculations
Message-ID: <202307110914.8D460C7@keescook>
References: <20230711134623.12695-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711134623.12695-3-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:46:24PM +0200, Vlastimil Babka wrote:
> Commit d36a63a943e3 ("kasan, slub: fix more conflicts with
> CONFIG_SLAB_FREELIST_HARDENED") has introduced kasan_reset_tags() to
> freelist_ptr() encoding/decoding when CONFIG_SLAB_FREELIST_HARDENED is
> enabled to resolve issues when passing tagged or untagged pointers
> inconsistently would lead to incorrect calculations.
> 
> Later, commit aa1ef4d7b3f6 ("kasan, mm: reset tags when accessing
> metadata") made sure all pointers have tags reset regardless of
> CONFIG_SLAB_FREELIST_HARDENED, because there was no other way to access
> the freepointer metadata safely with hw tag-based KASAN.
> 
> Therefore the kasan_reset_tag() usage in freelist_ptr_encode()/decode()
> is now redundant, as all callers use kasan_reset_tag() unconditionally
> when constructing ptr_addr. Remove the redundant calls and simplify the
> code and remove obsolete comments.
> 
> Also in freelist_ptr_encode() introduce an 'encoded' variable to make
> the lines shorter and make it similar to the _decode() one.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, this is much more readable!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
