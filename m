Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2032F60D76B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiJYWzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiJYWzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:55:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCE47539B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:55:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso515828pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ra6g/OJlkYVneeWayx4/X1tGU61tNPtmZeLJALiKlsg=;
        b=OdfBlk3ohwk4OPGswlL77glZyOEhkpZ9paxEg4UCiRkb5yVtyDSa+yHjdwg4rCAr3W
         yz2OIF4v85vVqzXNMMmsc885oRRYXYJKN3jNWWJ2GA5k2+EM/4MOz0vSg+4c0Ite27nj
         4D2Ycx9FAwYnUQbGwEWLvzR5J94/ofXVY65Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra6g/OJlkYVneeWayx4/X1tGU61tNPtmZeLJALiKlsg=;
        b=AL2lsM2VJeeWEQlHPUVzei7YntbW8s6+/LLbWwtimy6vVvLOolBzxyORAyzoNLBOLE
         U318rAtryszKE/3oDJZoNQRQuaKvyvHX/kCVRBtH9cV4dSEPH6f9rLVHj3JBVoIbNlOa
         wjqBHlBttPl5KXD4YhBqX5jPXUgzQsuwfUv7hv8jjI2UfluPx7rJLbdX4tPPY3edII6F
         LAmwDNQc55CwKBcEtslKh9HgnwATLprOM4/2kqqZZF8Nhk57PkQvbDDke8nzpMdVniiR
         210Q8bfgMGg9NDDPpxvby0O8z2x75ZxjhnMU8NbSaVW5Bh2TuDg7WpC4ggnU99Verk4l
         PNTA==
X-Gm-Message-State: ACrzQf3rNgUSoKmwXMmvxO8O/5x44oV7wrcwThfzQCnEwvZT33zQWowp
        5XPJzg6ZiSsfQ1VwesEH3FvazT9E5VcVug==
X-Google-Smtp-Source: AMsMyM44mRwoe5IWqac/2v8N0xaf9xGSEr4+1fALOhdzTO3Jh2wF+APz+24QcWl4IO/1AQPTfrJywQ==
X-Received: by 2002:a17:902:d2c1:b0:186:9e90:6ad with SMTP id n1-20020a170902d2c100b001869e9006admr15087411plc.2.1666738505517;
        Tue, 25 Oct 2022 15:55:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b65-20020a62cf44000000b00562784609fbsm1851645pfg.209.2022.10.25.15.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:55:04 -0700 (PDT)
Date:   Tue, 25 Oct 2022 15:55:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mempool: Use kmalloc_size_roundup() to match ksize()
 usage
Message-ID: <202210251554.11FA130@keescook>
References: <20221018090323.never.897-kees@kernel.org>
 <20221018155137.f6898d165aade2e3a5f0b2d3@linux-foundation.org>
 <202210182235.3B19DFCB28@keescook>
 <a9c6c111-d92f-f76f-1b7a-f6220d755eeb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c6c111-d92f-f76f-1b7a-f6220d755eeb@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:03:34PM +0200, Vlastimil Babka (SUSE) wrote:
> On 10/19/22 07:37, Kees Cook wrote:
> > On Tue, Oct 18, 2022 at 03:51:37PM -0700, Andrew Morton wrote:
> >> On Tue, 18 Oct 2022 02:03:29 -0700 Kees Cook <keescook@chromium.org> wrote:
> >> 
> >> > Round up allocations with kmalloc_size_roundup() so that mempool's use
> >> > of ksize() is always accurate and no special handling of the memory is
> >> > needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
> >> 
> >> Confused.  If the special handling is not needed, why doesn't the patch
> >> removed the no longer needed special handling?
> > 
> > The special handling is in the ksize() implementation, so it can't be
> > removed[1] until all the ksize()-affected users are updated to see their
> > true allocation sizes first.
> > 
> > [1] https://lore.kernel.org/lkml/20220923202822.2667581-16-keescook@chromium.org/
> 
> But in the previous version I was wondering if we can just stop doing
> ksize()-like poison handling in mempool completely, if no mempool consumers
> call ksize() to expand their use of the allocated objects. You seemed to
> agree but this version is uncahnged?
> 
> https://lore.kernel.org/all/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/

Oops, yes. This failed to get on my TODO list. New version coming!

-- 
Kees Cook
