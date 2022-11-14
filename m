Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE476276D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiKNHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiKNHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:55:23 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67CC68
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:55:22 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i3so10250262pfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3q+0J39HH+ytN1oOmq1JKm/33rMfJPN2f5MEE5zjj+w=;
        b=mOMrIe+oMpoZtsEfDZ0RiCiYFgKvpv2VSqMUqireZknNwEKIttWutLuNLxzecmgWae
         rq6EtYWIr5R1a6F/ojaNuPFhex9//yHqQQYtOQ1Fd/chA2YhcO6v5e+KGOXJZa1ADIMO
         lCTk6eDRXv9y3OfQDSmEyRUA3NPi7vkPvRbeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q+0J39HH+ytN1oOmq1JKm/33rMfJPN2f5MEE5zjj+w=;
        b=odO95mW8DTzah4SwLLAggCI9k+9kBs7c4FGS5UlM43hTHfnZ2b/pRdMEC4XV7fFqRj
         rB7kEOj/WZQuCrP8pMrgsS10Abup7K3eNy54++y+32zL8o45IanJgilTS2hfnTvWGM4g
         Yn06saD6sKhUyt9daVco+Vc1qGFgaLtkaLZuW56clvQrxdDxarIBf7mcXMmh1ZSh+FPU
         mi7t4DBrV8C6xQ0dzDOH0Skq2FD5HBgQ8QoFPFNt0leX+GXY1YCe1o8o7vX7PLUdFF2o
         E1jHujRGwYImzOdzLh/HO/Ug4/e/b5OHwSN4f34lBgxOPlELYoNLFXTalVpWwnFOZ5Ns
         qmzA==
X-Gm-Message-State: ANoB5pkYEmETKzJsOJtj3I1SLr98YhzAtvQekisjxqZm7AmWF8+Dx/nb
        a9PvH+DCbsVQM//vG3flvpdT4g==
X-Google-Smtp-Source: AA0mqf4YxTh/xYOlUXo67ZXKNk7pj9B0HN8PrdY9PUsfMyqnm6flyLevq8T66F6CQMKjMYdE4IS5QQ==
X-Received: by 2002:a63:fc04:0:b0:476:7fb0:916f with SMTP id j4-20020a63fc04000000b004767fb0916fmr3476096pgi.209.1668412522204;
        Sun, 13 Nov 2022 23:55:22 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:68f5:86c0:dcaa:df5])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b00186b6a04636sm6650689plg.255.2022.11.13.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 23:55:21 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:55:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y3H0ZWQKPsbPrB85@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
 <Y22dxEcs2g5mjuQ7@google.com>
 <Y26AbHxhPBJdWZQE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26AbHxhPBJdWZQE@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/11 09:03), Minchan Kim wrote:
[..]
> Only concern with bigger pages_per_zspage(e.g., 8 or 16) is exhausting memory
> when zram is used for swap. The use case aims to help memory pressure but the
> worst case, the bigger pages_per_zspage, more chance to out of memory.

It's hard to speak in concrete terms here. What locally may look
like a less optimal configuration, can result in a more optimal configuration
globally.

Yes, some zspage_chains get longer, but in return we have very different
clustering and zspool performance/configuration.

Example, a synthetic test on my host.

zspage_chain_size 4
-------------------

zsmalloc classes
 class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
 ...
 Total                13           51        413836     412973     159955                         3

zram mm_stat
1691783168 628083717 655175680        0 655175680       60        0    34048    34049

zspage_chain_size 8
-------------------

zsmalloc classes
 class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
 ...
 Total                18           87        414852     412978     156666                         0

zram mm_stat
1691803648 627793930 641703936        0 641703936       60        0    33591    33591


Note that we have lower "pages_used" value for the same amount of stored
data. Down to 156666 from 159955 pages.

So it *could be* that longer zspage_chains can be beneficial even in
memory sensitive cases, but we need more data on this, so that we can
speak "statistically".
