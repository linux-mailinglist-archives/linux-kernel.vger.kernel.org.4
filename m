Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDA263340F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiKVDmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiKVDm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:42:28 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65213D93
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:42:26 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d192so13227313pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AptSfaygHWZ6DJuwqcME0BS6j60WJD3D2GSMZmjS0iI=;
        b=DpSgZ5Mms4nVtop5BPuClMCwDJZqnFZrxxGyEjuUGMUeayLoFaOrapYYFcDWKUV7W+
         LH8VlUgWhA/u/nF6uiIixkqv1+i6rp9E54GPOHhM7h3uuZ+fpV2qb+q6luUSeyBl3cgF
         KvgqZMk9WQa6fk8SluhrHqtcvxxRBY4ObaOoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AptSfaygHWZ6DJuwqcME0BS6j60WJD3D2GSMZmjS0iI=;
        b=lD6ea8c1ya66uNfe7ba6O7EiMk9DYmI13x2WCStSqNgTfpEbrZsDZI10zzHwkb1YZC
         1fYQzUrflZvm/k8vGDcpZt0C0teXBYYFEBv6mg5PXQKLTRBZYLtra/se6uagBeigy3ii
         eQ14LY5QsNYke2rYWjIm+D9FoG/hNhHVqN8IS14BqlO21TaPO69CpXA5+6/AMzyFUhb4
         Y/32+DwsnjCFaGnrF/rsVEoKDtnkldhaBUU4tZorS5cJPTmPlsk4SE+oxDFiH5gAxcbX
         k3KMTS+OdiaUcrlsrQG9t4uv0OJawXQGyMQP12VAhV2G+VEaey8sFJn5K9BhLn/bk/fm
         6JAw==
X-Gm-Message-State: ANoB5pmY9KBdBxVcvYx2PhmvaTwQHHz5Ou6fb4qZQONEPiTPGwB74a67
        EAb5zRpuSnsSUp44i/K5q0P0FQ==
X-Google-Smtp-Source: AA0mqf6h3Trq07ulGD7Jl9vpfTiBEXj+K33xYktk0xDOZmwxPrg2Y4mBXv5YfbRMIyHR9QLoNq70Ww==
X-Received: by 2002:a05:6a00:338c:b0:56b:a319:7b52 with SMTP id cm12-20020a056a00338c00b0056ba3197b52mr3135785pfb.21.1669088545928;
        Mon, 21 Nov 2022 19:42:25 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b0017f5ba1fffasm6051055pln.297.2022.11.21.19.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:42:25 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:42:20 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3xFHIgkiZNYCbHi@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
 <Y3wwuMSy8YC86QAi@google.com>
 <Y3w+C8ClzP6VbqrA@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3w+C8ClzP6VbqrA@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/21 22:12), Johannes Weiner wrote:
> On Tue, Nov 22, 2022 at 11:15:20AM +0900, Sergey Senozhatsky wrote:
> > On (22/11/18 16:15), Nhat Pham wrote:
> > > +
> > > +static int zs_zpool_shrink(void *pool, unsigned int pages,
> > > +			unsigned int *reclaimed)
> > > +{
> > > +	unsigned int total = 0;
> > > +	int ret = -EINVAL;
> > > +
> > > +	while (total < pages) {
> > > +		ret = zs_reclaim_page(pool, 8);
> > > +		if (ret < 0)
> > > +			break;
> > > +		total++;
> > > +	}
> > > +
> > > +	if (reclaimed)
> > > +		*reclaimed = total;
> > > +
> > > +	return ret;
> > > +}
> > 
> > A silly question: why do we need a retry loop in zs_reclaim_page()?
> 
> Individual objects in a zspage can be busy (swapped in simultaneously
> for example), which will prevent the zspage from being freed. Zswap
> currently requests reclaim of one backend page at a time (another
> project...), so if we don't retry we're not meeting the reclaim goal
> and cause rejections for new stores.

What I meant was: if zs_reclaim_page() makes only partial progress
with the current LRU tail zspage and returns -EAGAIN, then we just
don't increment `total` and continue looping in zs_zpool_shrink().
On each iteration zs_reclaim_page() picks the new LRU tail (if any)
and tries to write it back.

> The number 8 is cribbed from zbud and z3fold.

OK.
