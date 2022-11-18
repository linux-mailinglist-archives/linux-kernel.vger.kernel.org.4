Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1489562FB44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbiKRRLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbiKRRLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:11:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCD8C491
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:11:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id v28so5434604pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDyeQiupLB9oqNpxPK4jyqPn5HRNeTYV3/chespM10E=;
        b=mmBzH89Hj2Bxse1fbp/MklJ4r7OTki1zNjRRRoNQFmICn2xKHkYyz+YKjcBjiei1rV
         8aGlrsSZjZwe06eqH7BaCdtc1W69Hm0vttGjaN7A1SZITtFdzA5ZWyCsvO9CFMjt7TIV
         HXgVsNpwjx4s42njacRq4K+S9PszEvbNPTV08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDyeQiupLB9oqNpxPK4jyqPn5HRNeTYV3/chespM10E=;
        b=AyoqL00G1eNXam7siWeXNhSp+RK4LW4r8wt5xwjIhl8Ga+/UeIvuWdWAyG35B49t0E
         G3dI9gWQ0GEG+rDgBKpN3yIKOZ3LExdCWOpdk6MIPXHeX4ds1/xS3JnigDlZhWqCreR2
         hPRBVtUN3N1wEZ/AnfzWnpZi1z5fq5Qs6b76bxas+J3p1vpmY8urllfccmVYPl/UhIBc
         aKHr4XCSVObe8a527zt8z7NP1wckhDqMWQCN85SO8Izgpn1Jo6gPuCxGc87zl4LaM1DA
         3UjWW6bTvctEasq/zfz0iPyLzJrknd9ZA2YVctbgMLSjZ4zDbEe4RugSJIEKXYqGEqbI
         vg/Q==
X-Gm-Message-State: ANoB5pmV5jiJSeUhzHOhGO+yhyqKtM3hj50rWL34xFbWGmicNaokZBtN
        z1b22EbmNCoQt9AmdMo5uyUp3Q==
X-Google-Smtp-Source: AA0mqf4ZnmEE8OLUxPyWmX6DtdMNs26euLf7TggL/hADBnpVlbL4hqcSzhOLXCBe0EvSz9uq5N2EHw==
X-Received: by 2002:a63:ec11:0:b0:470:5b0d:b50e with SMTP id j17-20020a63ec11000000b004705b0db50emr7217183pgh.488.1668791468487;
        Fri, 18 Nov 2022 09:11:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b00186881688f2sm3884671pla.220.2022.11.18.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:11:08 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:11:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
Message-ID: <202211180907.A4C218F@keescook>
References: <20221118035656.gonna.698-kees@kernel.org>
 <230127af-6c71-e51e-41a4-aa9547c2c847@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230127af-6c71-e51e-41a4-aa9547c2c847@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:32:36AM +0100, Vlastimil Babka wrote:
> On 11/18/22 04:56, Kees Cook wrote:
> > With all "silently resizing" callers of ksize() refactored, remove the
> 
> At cursory look seems it's true now in -next (but not mainline?) can you
> confirm?

Almost, yes. I realized there is 1 case in the BPF verifier that
remains. (I thought it was picked up, but only a prereq patch was.) I'm
going to resend that one today, but I would expect it to be picked
up soon. (But, yes, definitely not for mainline.)

> That would probably be safe enough to have slab.git expose this to -next now
> and time a PR appropriately in the next merge window?

Possibly. I suspect syzkaller might trip KASAN on any larger BPF tests
until I get the last one landed. And if you don't want to do the timing
of the PR, I can carry this patch in my hardening tree, since I already
have to do a two-part early/late-merge-window PR there.

-- 
Kees Cook
