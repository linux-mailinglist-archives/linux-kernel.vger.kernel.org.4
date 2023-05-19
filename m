Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE14970A31E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjESXDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESXDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:03:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFEB1B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:03:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2535d86a41bso1829817a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684537387; x=1687129387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXiJMfeWxrmzGbo3dbGDA/6XHhEVmw8me36PTnrqlPA=;
        b=B2rgC7AviNMubQIsfiWVRi79RFMgbGTWsv6EKVho0SjgI8eTAYOwnPANufFLsQuXek
         bn6hQbNamlMoBmg5/sN+7vycxmfZLmrvbetJL1UzPXE9YAOhNhxaxcxQGDTtEIjBDdSU
         /FhpAdqrJm7gj+U7QDuQRgWA+AHUI0EKNb+5L0kLV4TIjjVFBrnH3Nc66gW1TgmloO/m
         CxQvXiOmoeuRM84pD8ckyGufM1muJZdiF3fiJkZutqxE/g8ICC1eFVrAeujGW0xfFhq/
         bjGo1QUKBJzaHu3Tpzn7azN+PBo6hWUhrIQ5AqnUPPdI7RUQECvYbuJh8ERVBL8RCJi9
         zpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684537387; x=1687129387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXiJMfeWxrmzGbo3dbGDA/6XHhEVmw8me36PTnrqlPA=;
        b=k5/NdyL8Di9Eu1X0CHAykEMWfISlp7r/sSlKAqYfEu48wurPoYJ1PaKxcFq0ASSSMW
         kPz8f56sO5cck5FCbTqLZSjpMdaoHquO8PlSn5tTJy2+eZ6TTEuPhiLNSGHeyA1cE6mi
         4TFEcdwCDs/vPKRiFlLhaCWbmxfOHyS9r9u0Eq3jdTenhFFs2nUdhxN9X+S9vv7TMfqc
         zgSJJzk2RGNE0JQIcCGYEMV0Nym3oRiSt7q4W+349SS+5iZgBs9vmIPHRkyXb2UwSnHM
         KokMgNdTRQFC/cPYytNzkrq1SVEk9RXvypJVDODB9OlPnCrd9e8TFrbe2rXU+CrDtJjI
         yvBg==
X-Gm-Message-State: AC+VfDwbtQ+uC9sKZxCHVXPzGuRGMWeA3Tv1I5iUYug0V7yIDg7BQ5kz
        s3ZHbkoYmueqR7PndaajlgE=
X-Google-Smtp-Source: ACHHUZ6Vf/Lyh3tQgFjylaNinB6X8ABMwFUw+xKmysrjikhw0BinZ4zBcypnwbQ3pCh4MhwzwznONQ==
X-Received: by 2002:a17:90b:690:b0:24d:f816:7952 with SMTP id m16-20020a17090b069000b0024df8167952mr3722997pjz.5.1684537386644;
        Fri, 19 May 2023 16:03:06 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090a128f00b002477dda66d2sm1914195pja.37.2023.05.19.16.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 16:03:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 19 May 2023 13:03:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jiangshanlai@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZGgAKK-c_DZpvNJB@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
 <ZGf5rfESYhKYzPSY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGf5rfESYhKYzPSY@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, a bit of addition.

Once below saturation, latency and bw are mostly the two sides of the same
coin but just to be sure, here are latency results. The single-threaded sync
IO is run with 1ms interval between IOs.

  taskset 0x8 fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=512 \
	--ioengine=sync --iodepth=1 --runtime=60 --numjobs=1 --time_based \
	--group_reporting --name=iops-test-job --verify=sha512 --thinktime=1ms

SYSTEM

  read: IOPS=480, BW=240KiB/s (246kB/s)(14.1MiB/60001msec)
    clat (usec): min=8, max=401, avg=30.96, stdev= 9.60
     lat (usec): min=8, max=401, avg=31.01, stdev= 9.60
    clat percentiles (usec):
     |  1.00th=[   11],  5.00th=[   13], 10.00th=[   25], 20.00th=[   27],
     | 30.00th=[   28], 40.00th=[   29], 50.00th=[   29], 60.00th=[   30],
     | 70.00th=[   32], 80.00th=[   42], 90.00th=[   44], 95.00th=[   44],
     | 99.00th=[   46], 99.50th=[   46], 99.90th=[   56], 99.95th=[   71],
     | 99.99th=[  253]
   bw (  KiB/s): min=  214, max=  265, per=99.85%, avg=240.29, stdev=11.35, samples=119
   iops        : min=  428, max=  530, avg=480.59, stdev=22.70, samples=119

CPU_STRICT

  read: IOPS=474, BW=237KiB/s (243kB/s)(385KiB/1624msec)
    clat (usec): min=9, max=240, avg=28.00, stdev=11.20
     lat (usec): min=9, max=240, avg=28.05, stdev=11.20
    clat percentiles (usec):
     |  1.00th=[   12],  5.00th=[   26], 10.00th=[   26], 20.00th=[   26],
     | 30.00th=[   27], 40.00th=[   28], 50.00th=[   28], 60.00th=[   28],
     | 70.00th=[   29], 80.00th=[   30], 90.00th=[   31], 95.00th=[   31],
     | 99.00th=[   32], 99.50th=[   50], 99.90th=[  241], 99.95th=[  241],
     | 99.99th=[  241]

CACHE

  read: IOPS=479, BW=240KiB/s (245kB/s)(14.0MiB/60002msec)
    clat (nsec): min=7874, max=75922, avg=13342.34, stdev=6906.53
     lat (nsec): min=7904, max=75952, avg=13386.08, stdev=6906.60
    clat percentiles (nsec):
     |  1.00th=[ 8384],  5.00th=[ 8896], 10.00th=[ 9152], 20.00th=[ 9408],
     | 30.00th=[ 9536], 40.00th=[ 9920], 50.00th=[10432], 60.00th=[10688],
     | 70.00th=[11072], 80.00th=[13632], 90.00th=[27264], 95.00th=[28288],
     | 99.00th=[30592], 99.50th=[30848], 99.90th=[41216], 99.95th=[56064],
     | 99.99th=[74240]
   bw (  KiB/s): min=  204, max=  269, per=99.69%, avg=239.67, stdev=11.02, samples=119
   iops        : min=  408, max=  538, avg=479.34, stdev=22.04, samples=119


It's a bit confusing because fio switched to printing nsecs for CACHE but
CPU_STRICT (per-cpu)'s average completion latency is, expectedly, better
than SYSTEM - 28ms vs. 31ms, but CACHE's is way better at 13.3ms.

Thanks.

-- 
tejun
