Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C7563EE5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiLAKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiLAKsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:48:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E76C29341
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:47:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so1632974pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xo8sxjfVuVzhfw/NzBTVahX647N0dVRYPcvU1+ZGpaQ=;
        b=Cf/BzI8ClcCiqUYke1eSohZkHVUCSUWoF+0od+X3Ca4j+q8tR2gHvYpyi0gW3ELnW2
         /uiBEwWj9/jX6fd2rl4rVSqNMhzO/kAalZZW6ZtKehQaU9Bh30LRB6NU+2dL3xD2XM1Y
         8GFJwMCgo2gKVUu5bWuhZou2yW35FRupKRwDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo8sxjfVuVzhfw/NzBTVahX647N0dVRYPcvU1+ZGpaQ=;
        b=He8xiNud6MOGF0G3fJfSI4QEl8DVkdhDVN++6NbnXq2fhYJpzc9x0ZQGHxL3mxJijZ
         8BD0xcI4qrpfBsyTetz70OK8U2FNldHC+vRHm7Sa3ZPvcrLt8AHSP8ty/bOkOKz63gvQ
         7j7VEfeI8rxruZH0t5S2xDC5orqPro6CkkMRF4UT7ppAcDzgq0cyxKocM+LnOhK7QrRb
         RqevHCx7zukMHutL5iCfmWsMHv5AJH2KSoA16wBrBT6OWBP0aJ+psvJRA3T4eoqLY8Ht
         Qmz5zlPLR/gwfp3l6Iy1N8gXOr36Jh7d8AOAGXqlt0xgKO8DH6LzOwy7A8zohUlBKSfU
         Yp2Q==
X-Gm-Message-State: ANoB5plPZp8W6MEndWmGeNgiCSu34sy3dnkC/YYsYGpOj/yeELFc3GY3
        K60p9QJOpogkaMQ32hN62Q1r7AfCfJ9gkg==
X-Google-Smtp-Source: AA0mqf4lcFhNkEV6o9qxOWjsMUDYqJENnXc+l5GiKPEznJ+1LpElfIbap/E1OEyoWNb8ypoeQirzJg==
X-Received: by 2002:a17:902:9a87:b0:189:af68:472f with SMTP id w7-20020a1709029a8700b00189af68472fmr4558129plp.134.1669891647609;
        Thu, 01 Dec 2022 02:47:27 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id w131-20020a628289000000b0056d2317455bsm2968694pfd.7.2022.12.01.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:47:27 -0800 (PST)
Date:   Thu, 1 Dec 2022 19:47:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Aleksey Romanov <AVRomanov@sberdevices.ru>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Message-ID: <Y4iGOTRvAS+WRrtq@google.com>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
 <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
 <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
 <Y32eA93V7w1Wu3VH@google.com>
 <20221123085306.52ozfjimaeikcbof@CAB-WSD-L081021>
 <20221201101417.f6qm4v3m7ibh3l72@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201101417.f6qm4v3m7ibh3l72@CAB-WSD-L081021>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/12/01 13:14), Dmitry Rokosov wrote:
> Hello Sergey,
> 
> Hope you are doing well. Really sorry for the ping.
> 
> Did you get a chance to see the patch series, my questions, and
> thoughts?

Hey,

Not really, sorry. It's a holidays season + pre-merge window week.
I probably will start looking attentively next week or so.

In the meantime time I'll try to reach out to lawyers to get more
clarifications on that patent thingy.
