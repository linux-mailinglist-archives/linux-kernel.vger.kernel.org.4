Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2C66A963
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 06:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjANF1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 00:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjANF1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 00:27:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F526B6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 21:27:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k12so3345640plk.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 21:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi6SpGutrYkialV9PtuSHrkLtH3EwVjUiZj+JV18HOU=;
        b=AOvLMulYqiLdTSzTT+e9jUZEthaYWtfhs46a1EKVU3Uwb+06h44K25V+0mKVO4YmLl
         FQKlYMuEAAWCCX4CiPEKKIds9fom3gxOui+g2KjkLgh6vctl+W4rwYUWnJh1usm9WW5k
         ZhyT1p0EnD5LOTuKbmhmo3qrZvSGfAYnpAxl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi6SpGutrYkialV9PtuSHrkLtH3EwVjUiZj+JV18HOU=;
        b=VVmEacC7PS3zxqHZx0p4TVCol0EImM+2Y3Q0bhc4XIqCM5txZ6JTsiCfhbIaxl5+w9
         L357fwS6X+/fmjYhoccPuZbEcHUtTXJ1HCk3MszUGqLBn1aRC4leSKKebN275uj8KRe9
         wp7UUnONVXa8Wq4VajVXSnTcBzVSHsXCimmDzsEtrXSiLjhS/e6HTlnHds/TeGHdP66W
         owGhXrZD47Ao3apOWnK+oBYmae38BH4qIcHLmLS0c9dxOkdnUFGKFIbdegqDG2U/3Ivf
         OTgdyVC5Id7dQIO7PoSZ8tTrjxQS4IrinhTyV9MA/Unat3ai9vk6oKgBOxsoQEe88RAT
         aQUg==
X-Gm-Message-State: AFqh2kqWo0GBKyuhJMbuf0CuMxvmTsqUaJ1jrI9Z1jLnngsQX3nDskc3
        tt/QNXx7oB8n4dHDBfyvIM05zw==
X-Google-Smtp-Source: AMrXdXtN10GPHVzK1LFg3aIeZT7yW6CksfZNv/xVmMqQdGuu0DR9yrvzw5WgzYj2vtLRtsISoIc6nQ==
X-Received: by 2002:a17:902:b613:b0:18f:98bb:c08e with SMTP id b19-20020a170902b61300b0018f98bbc08emr80267513pls.36.1673674036887;
        Fri, 13 Jan 2023 21:27:16 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b0018725c2fc46sm14910927plx.303.2023.01.13.21.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 21:27:16 -0800 (PST)
Date:   Sat, 14 Jan 2023 14:27:12 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8I9MAd0zjvR0sQe@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8G3nJ9+k2lB0kas@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/13 11:57), Mike Kravetz wrote:
> > 	This turns hard coded limit on maximum number of physical
> > pages per-zspage into a config option. It also increases the default
> > limit from 4 to 8.
> > 
> > Sergey Senozhatsky (4):
> >   zsmalloc: rework zspage chain size selection
> >   zsmalloc: skip chain size calculation for pow_of_2 classes
> >   zsmalloc: make zspage chain size configurable
> >   zsmalloc: set default zspage chain size to 8
> > 
> >  Documentation/mm/zsmalloc.rst | 168 ++++++++++++++++++++++++++++++++++
> >  mm/Kconfig                    |  19 ++++
> >  mm/zsmalloc.c                 |  72 +++++----------
> >  3 files changed, 212 insertions(+), 47 deletions(-)
> 
> Hi Sergey,

Hi Mike,

> The following BUG shows up after this series in linux-next.  I can easily
> recreate by doing the following:
>
> # echo large_value > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> where 'large_value' is a so big that there could never possibly be that
> many 2MB huge pages in the system.

Hmm... Are we sure this is related? I really cannot see how chain-size
can have an effect on zspage ->isolate counter. What chain-size value
do you use? You don't see problems with chain size of 4?
