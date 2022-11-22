Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC963339C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKVDAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiKVDAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:00:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42CF1D0FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:00:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so12728291pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHFDUHtOwvUbApX56IPf0JK3BcogReTYpXne7oiLh6g=;
        b=HsHhTLxPGSX/SOQLa8i0mclVgaAony/uoIqSiNk2F7aUqm3oOvFR4+hqrJeWKeA8kP
         0ev+UlYSci2yUYxBYTcHi/07bQFHH0vf5Pp6rNi78LMk6kGatA4cfPszA84RKTU0O+gA
         xwlHUTY52a76c0t0mqgbv+/6Yc8+9PpHYpKkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHFDUHtOwvUbApX56IPf0JK3BcogReTYpXne7oiLh6g=;
        b=Ms8nkw5y8ftneQKvQjc/pqGCRWEM+E9tIHoDbh+VpQWthueElal2GGbEu3P9Qq60dQ
         Xf0Y1PXOD7YHhUBpJvSNEu/rGZRzc4QSNLwma1De1425PVetopHZ8IYYJ+/iXC5MIUHr
         5KYj9JpEdyCabmFtA3ejcXpF2LNM7PU6LfZRrIvDaHsmnS1v9+FdS8P/MKytFZCwrTjP
         URZXTHs28sUPkKeMqHWturAHYwU6LNHRZvo9x8pIoMC1xg/ziF6H2XaU1pp0GREnZNGe
         QiLrR8YKCtDh3Kuo8B24H4hGr4K68Fcnu/bsK8gbJvhGVvV29edLPwiYRqs+v2omMkpq
         4Jcg==
X-Gm-Message-State: ANoB5pkz3lUl5V9toa9wGKnxuDH53PeM1pON9kLd8/idyia8AWEqlQpn
        UDEnz/orkWdXxDKCFqLwxAwSoA==
X-Google-Smtp-Source: AA0mqf6ssW5PeKYQMBjucgUacUesrALiKSjEBDiNYRmO/H0eoDAdfWODXNQS/1qb7eR9vXjF1Udllg==
X-Received: by 2002:a17:902:6b89:b0:179:eaa8:9113 with SMTP id p9-20020a1709026b8900b00179eaa89113mr1725905plk.55.1669086041198;
        Mon, 21 Nov 2022 19:00:41 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902710e00b0018703bf3ec9sm10525755pll.61.2022.11.21.19.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:00:40 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:00:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>, minchan@kernel.org,
        senozhatsky@chromium.org, ngupta@vflare.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        ddrokosov@sberdevices.ru
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Message-ID: <Y3w7VP5CKvm6XmoJ@google.com>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/21 15:44), Johannes Weiner wrote:
> This looks pretty great.
> 
> However, I'm curious why it's specific to zram, and not part of
> zsmalloc? That way zswap would benefit as well, without having to
> duplicate the implementation. This happened for example with
> page_same_filled() and zswap_is_page_same_filled().
> 
> It's zsmalloc's job to store content efficiently, so couldn't this
> feature (just like the page_same_filled one) be an optimization that
> zsmalloc does transparently for all its users?

Yea, that's a much needed functionality, but things may be "complicated".
We had that KSM-ish thing in the past in zram. Very briefly as we quickly
found out that the idea was patented by some company in China and we couldn't
figure our if it was safe to land that code upstream. So we ended up dropping
the patches.

https://lore.kernel.org/lkml/1494556204-25796-1-git-send-email-iamjoonsoo.kim@lge.com/

> Would it make sense to hook this up to a shrinker?

Hmm, ratelimited perhaps. We most likely don't want to scan the whole pool
every time a shrinker calls us (which can be quite often).
