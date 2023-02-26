Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4977C6A2DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBZDwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBZDw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:52:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9F19F22
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:51:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u10so2887002pjc.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4y311XvzcL4qcpLEKERp48i6Icgj5mKMLUZWjnpXrI=;
        b=OiTnRUDpZ4YIjM2/sq915dvhW8mbZNbYCM3fJcj4eY6ey/xyl0tjd8h8eP2IlN06Vz
         sGVNoH3/7AQxUFUlXxAVRYyBLocEm4uI2nu1aXCYgB7qye8lsY8qxBY3KMoIl1JP9iqb
         fGcJmXFt9XP65T3Kbuw+ClqJAwZ2GjHrWebSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4y311XvzcL4qcpLEKERp48i6Icgj5mKMLUZWjnpXrI=;
        b=WCTB1jE+wLAR6k+djQJNXk8dYfFTAs6d6w1Vhqq6Xi0ktKfANJpfWRCmCJ2cx4clY0
         QeU1oyAbJffaPcN8wfn4fJ3hYsQbvrf72wtgD68rowbJ94KTrPNQ5IInOCdlh00BFumY
         /z6TlqnBdRSNGpoYiQrAENCOvHzTzdD7F1QNbXqmxaJHXCxXhYfqvxUgsWUJ9HoIRvDd
         itJ0nFh6WmbukIa9HcMP2TciUt3TEmiiyuz2SogOVuzlR1VowmPE9s04XCMMlTTcTDIQ
         XjvGgXwjpl/1LAuDpUO/LR+ldYO7IiEVRYEbScVlNMuLpDVkrRq1GB7sDALFozueZDN9
         ObLA==
X-Gm-Message-State: AO0yUKXO9/hqHuBLhpjCo0LKF2xeKKb3aSM35Qkm7zwISKF+Zi0k88fS
        UZKS4xcYvDwBVP8IY44IOrMPYg==
X-Google-Smtp-Source: AK7set/i11X7lphfd5+MPslv0zxE4QFrWYN6+0mbt2yItzGiX93i/bOA95HL6K2M022D8wc9hw8W2w==
X-Received: by 2002:a17:902:dac6:b0:19b:c491:21be with SMTP id q6-20020a170902dac600b0019bc49121bemr24607680plx.64.1677383450004;
        Sat, 25 Feb 2023 19:50:50 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y21-20020a63b515000000b00502e48db9aesm1662256pge.53.2023.02.25.19.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 19:50:49 -0800 (PST)
Date:   Sun, 26 Feb 2023 12:50:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/6] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <Y/rXFc4dI+190uJa@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <Y/f8esHswgLtjkee@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/f8esHswgLtjkee@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/23 15:53), Minchan Kim wrote:
> > TEST
> > ====
> > 
> > It's very challenging to reliably test this series. I ended up
> > developing my own synthetic test that has 100% reproducibility.
> > The test generates significan fragmentation (for each size class)
> > and then performs compaction for each class individually and tracks
> > the number of memcpy() in zs_object_copy(), so that we can compare
> > the amount work compaction does on per-class basis.
> > 
> > Total amount of work (zram mm_stat objs_moved)
> > ----------------------------------------------
> > 
> > Old fullness grouping, old compaction algorithm:
> > 323977 memcpy() in zs_object_copy().
> > 
> > Old fullness grouping, new compaction algorithm:
> > 262944 memcpy() in zs_object_copy().
> > 
> > New fullness grouping, new compaction algorithm:
> > 213978 memcpy() in zs_object_copy().
> > 
> > 
> > Per-class compaction memcpy() comparison (T-test)
> 
> Just curiosity: What's the T-test?

T-test is a statistical method used to compare the means
of two independent groups or samples and determine if the
difference between them is statistically significant.

> > x Old fullness grouping, old compaction algorithm
> > + Old fullness grouping, new compaction algorithm
> > 
> >     N           Min           Max        Median           Avg        Stddev
> > x 140           349          3513          2461     2314.1214     806.03271
> > + 140           289          2778          2006     1878.1714     641.02073
> > Difference at 95.0% confidence
> > 	-435.95 +/- 170.595
> > 	-18.8387% +/- 7.37193%
> > 	(Student's t, pooled s = 728.216)
> > 
> > 
> > x Old fullness grouping, old compaction algorithm
> > + New fullness grouping, new compaction algorithm
> > 
> >     N           Min           Max        Median           Avg        Stddev
> > x 140           349          3513          2461     2314.1214     806.03271
> > + 140           226          2279          1644     1528.4143     524.85268
> > Difference at 95.0% confidence
> > 	-785.707 +/- 159.331
> > 	-33.9527% +/- 6.88516%
> > 	(Student's t, pooled s = 680.132)
> 
> What's the different with result above? Did you just run two times and
> shows they are consistent or this is new result based on different
> testing?

The test is exactly the same, it is designed to have 0 variability, it
creates exactly same fragmentation during each run, so we always compare
apples to apples. What is being changed (and hence tested) are fullness
grouping and compaction algorithm.

The first one tests the effect of new compaction algorithm alone:
old fullness grouping and old compaction algorithm VS old fullness
grouping and new compaction algorithm. The data show that with
sufficient level of confidence (95%) we can claim that new compaction
does make a statstically significant improvement and reduce the number
of memcpy() calls (by 18.3% in this particular case).

The second one tests the effect of new fullness grouping and new
compaction algorithm. The data show that with sufficient level of
confidence we can claim that new fullness grouping and new compaction
do make a statstically significant improvement and reduce the number
of memcpy() calls (by 33.9% in this particular case).
