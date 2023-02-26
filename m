Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C122E6A2D49
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBZDiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZDiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:38:14 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECC8683
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:38:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e5so3481425plg.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w5Rg6I1cmXAeRDJOuxnp8t4y5fBQt8rslGX6AycVTYk=;
        b=obvxZQfuGGnnl0eWnSNpRy8gi2zG6/icUwEZTew7bdim4vM02+Fg6mJccssdsiDCWI
         63zm2EG8p7Z6jWDA/0NrSMWHmtqZWOwEYzJ08Tn0UbGmQl+EcZNQEUlBf47n9bw1CQvt
         IVfL9pJ8jl8m2Yy0Z8+D/DjGMnhYt7hZoHf14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5Rg6I1cmXAeRDJOuxnp8t4y5fBQt8rslGX6AycVTYk=;
        b=MCRAO6Nhyms3jVqGaYcXAkmIV8m7Yo+8lN6+21/liPzasna94Vrq1mBM3ByjVfAjVq
         9m9v5pjDFMEZ8rRyDcRYG+O4r60PlYFxRCd9d+I3HYLqm64TyQMLjFWgH2rUvywlEkiV
         OFhvhVMOzSOvbE4+FDTvFTN1DCnh72Bx8uLdRZTZlR/3O+BsAUvrpA9gp6lYtGjPc+Rw
         ZIO+lawUVA3UfWCBQSa3/HeqOXxAVuujxjZYOJd4MHc3wDvdabcnSTAKNCs6YsPMsfZD
         gtBZAqmeKxHjEkbIooMUwHHmub7aaw+KrWOPgGDnxKCF3sNY9CmeiZaOWWbDH6Uf4/iK
         aAnw==
X-Gm-Message-State: AO0yUKXZhaRP5D9eSDcEAY8leIQAebYRStE+FOO37UDT9ORRcRhmaeNx
        FpnWJ4kCyqz0oanG7ombV30OSw==
X-Google-Smtp-Source: AK7set9j6WCf61CgO8Sw1yGGWG+IoM9Cunn4SttlHzt4ea/KDHgO9cUcUw7eLdT15DrEniMbPKl4Lg==
X-Received: by 2002:a17:902:7292:b0:196:56ae:ed1d with SMTP id d18-20020a170902729200b0019656aeed1dmr15761934pll.69.1677382693024;
        Sat, 25 Feb 2023 19:38:13 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709026b4300b00198e346c35dsm1937190plt.9.2023.02.25.19.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 19:38:12 -0800 (PST)
Date:   Sun, 26 Feb 2023 12:38:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: Use atomic_long_read() to read atomic_long_t
Message-ID: <Y/rUIF9Tc97GC6Ue@google.com>
References: <20230225121523.3288544-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230225121523.3288544-1-geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/25 13:15), Geert Uytterhoeven wrote:
> On 32-bit:
> 
>     drivers/block/zram/zram_drv.c: In function ‘mm_stat_show’:
>     drivers/block/zram/zram_drv.c:1234:23: error: passing argument 1 of ‘atomic64_read’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>      1234 |    (u64)atomic64_read(&pool_stats.objs_moved));
> 	  |                       ^~~~~~~~~~~~~~~~~~~~~~
> 	  |                       |
> 	  |                       atomic_long_t * {aka struct <anonymous> *}
>     In file included from ./include/linux/atomic.h:82,
> 		     from ./include/linux/mm_types_task.h:13,
> 		     from ./include/linux/mm_types.h:5,
> 		     from ./include/linux/buildid.h:5,
> 		     from ./include/linux/module.h:14,
> 		     from drivers/block/zram/zram_drv.c:18:
>     ./include/linux/atomic/atomic-instrumented.h:644:33: note: expected ‘const atomic64_t *’ {aka ‘const struct <anonymous> *’} but argument is of type ‘atomic_long_t *’ {aka ‘struct <anonymous> *’}
>       644 | atomic64_read(const atomic64_t *v)
> 	  |               ~~~~~~~~~~~~~~~~~~^
> 
> Fix this by using atomic_long_read() instead.

Hi Geert,
The patch that cause the warning probably will be droppped from
the series in v3.
