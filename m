Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF96223F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKIGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKIGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:24:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B522BCAB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 22:24:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so994384pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 22:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJIuejy98upFVLWaGrCilYHDRGS/X2QdZaTtWgg1XNY=;
        b=lTLdEW/9VYc65JIWfkkP4NkWTDF7NOu8pQEOStuO5QmwlXtM1Ozla18+Lz+N+93MjN
         XdQO/g5/dvaZp1JwBwePZba9Fts4qp2hRWppZQua3eEZz6UEP9dCW8nPs6qNvCHJyQ2T
         xtrHddXjGHZ1/F0cxiLu6efRDTty4AkoHAPBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJIuejy98upFVLWaGrCilYHDRGS/X2QdZaTtWgg1XNY=;
        b=bZDrBJRY24fTqm2lxldJAvE6vks2XT8a5DXSxk23L79mxqHfe4KirFnjiR5GMOCaR9
         3B4DjpySWNYpcGD82UFecrIcDEz+LCffyJAh+hnY02C6NuBMvov+ieK5xhxQaLt9i5xJ
         HXK7u4vhZlHnFXJD336h6tHzZ373a6VrKp6FEmp/H66mPFVB9fIt8brbHLvSTO43xZVh
         kJ6WVmVZXAfJnTNXZE/oZbrzqQxR6+Lo4BEsATnMVtM/zQf9iDyLm08ryaezoWpfPyGR
         uG/l61oPL4lrAm1c4VnZEoX29yBCDT91WGJNevwrLJVqeawAfLJXtUsT3QiyFpOalGt0
         JKzg==
X-Gm-Message-State: ACrzQf0xCLAk7LW8cKXVr5U/0e6/q2F/xWmYcMoEboBj9Ac3DoV7iB0q
        l+9DEc3r8PF1V0BHKEryL8ASPw==
X-Google-Smtp-Source: AMsMyM6TgRtFsZ6s4EHJtAlqgyNkskgXlkuaBbJi8t0LKrZfDkpo+6i7reSXshaPCTuqKji5aA7+NA==
X-Received: by 2002:a17:903:2014:b0:186:8937:28a6 with SMTP id s20-20020a170903201400b00186893728a6mr57666414pla.39.1667975088106;
        Tue, 08 Nov 2022 22:24:48 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e98a:ab9b:7583:cb8a])
        by smtp.gmail.com with ESMTPSA id y15-20020aa793cf000000b0056d7cc80ea4sm7416895pff.110.2022.11.08.22.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 22:24:47 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:24:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 6/9] zsmalloc: pass limit on pages per-zspage to
 zs_create_pool()
Message-ID: <Y2tHq6O9IA3g8Xt7@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-7-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031054108.541190-7-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/31 14:41), Sergey Senozhatsky wrote:
[..]
> -struct zs_pool *zs_create_pool(const char *name)
> +struct zs_pool *zs_create_pool(const char *name, unsigned long num_pages)
>  {
>  	int i;
>  	struct zs_pool *pool;
>  	struct size_class *prev_class = NULL;
> -	unsigned long num_pages;
> +
> +	if (WARN_ON(num_pages < ZS_MIN_PAGES_PER_ZSPAGE ||
> +		    num_pages > ZS_MAX_PAGES_PER_ZSPAGE))
> +		return NULL;

I tend to think that creating `struct zs_tunables` would be better. For
the time being zs_tunables will contain only one member max_zspage_len,
but it can be extended in the future.
