Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12887670F21
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjARAwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjARAuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:50:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E43D930
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:39:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 7-20020a17090a098700b002298931e366so597504pjo.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cieqYlPdo1uMWFm7OPSzxr4vtAv43xHg4HwlwY6s/6o=;
        b=nqQE3I29WTuB1rTwY0pbYNlIricDb7eFHBNxiFmsUP4hf5TXOZ5GFeHK+Dc+y19rzX
         vXOAwjPfo5kUNQrn1Uhl9kDcYlzIEgBvtYDIhP5olHCrhliwZ/+7LCZTgfOwpxi9FEzQ
         Z19T+0nFI64YC4Q/e2MbQ92gOYUxsOAMW3/gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cieqYlPdo1uMWFm7OPSzxr4vtAv43xHg4HwlwY6s/6o=;
        b=ckVQRudkHBL76fNNKLusxa6D1aQNHRwxG+sQEGa+ym1sHi5uMfxaGMzSYLjnO4rPPr
         Oinegak+3YgZpsqMOeNSxMMA7oYEPgMPMtVAjGfXCwvSTIz7rrAE12Dfo7/SE3gePHhD
         gTQQNsWyTEdmoEVwI8Nsusln+L2h2kJNWy5qOYI0HGrS+uN8N91TfsXTsorsNuOL/cat
         xr6FlyVB2QMu5zdYN2Oy6GxV0BvvL2kGphYwbJNmTEWTCNjjDRW63e5/g3LpIJ/oc21G
         DZpjoZ0Z49HuDx7PdwbRuVA7s8mLbprzGBbZRLet4reeCmuVtA+zonx6Ndhdeg/utvo6
         F7Tg==
X-Gm-Message-State: AFqh2koWjHqSdnQJTT4LLMb6mWKpx+0vrC35FVeoYbKYqC7wzK7jQjK4
        Zp0QCGJBj3/HC0lg5Blkf7Hkow==
X-Google-Smtp-Source: AMrXdXsxsUh+Q9DUm2Lt/KUAvDoICVDTOfIvhFZwMf74WyXYTToyIVobuxF0eu6ruM5544gvUcn0eg==
X-Received: by 2002:a17:902:ec90:b0:188:6b9c:d17d with SMTP id x16-20020a170902ec9000b001886b9cd17dmr35963362plg.16.1674002356047;
        Tue, 17 Jan 2023 16:39:16 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b0019493c84880sm4589973plb.188.2023.01.17.16.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:39:15 -0800 (PST)
Date:   Wed, 18 Jan 2023 09:39:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zsmalloc: avoid unused-function warning
Message-ID: <Y8c/ryHYsC1DjjbW@google.com>
References: <20230117170507.2651972-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117170507.2651972-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/17 18:04), Arnd Bergmann wrote:
> obj_allocated() can be called from two places that are each
> inside of an #ifdef. When both are disabled, the compiler warns:
> 
> mm/zsmalloc.c:900:13: error: 'obj_allocated' defined but not used [-Werror=unused-function]
> 
> Rather than trying to figure out the correct #ifdef, mark the
> trivial function as 'inline', which implies __maybe_unused and
> shuts up the warning.
> 
> Fixes: 796c71ac728e ("zsmalloc: fix a race with deferred_handles storing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
