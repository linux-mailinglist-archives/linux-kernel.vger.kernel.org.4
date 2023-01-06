Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D96605BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjAFRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjAFRdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:33:25 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEE3736E9;
        Fri,  6 Jan 2023 09:33:23 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so2306561plw.11;
        Fri, 06 Jan 2023 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMcDfkI0rlioSp3cevcHgp/4Iw+XQm90p8imIzrlRw8=;
        b=Yzycu3lj0Teez9Xakr7BNa3mIWk3E9hAEauKy0IBLT18vgvEeAyy1hJj8RemL9Jx5L
         R6IFeNfbBASyfRTOAq2QmJS+K2ZQ2kv/g9cZhsLQY9jcwxVWEjn6ZTpfkHwcc3iTmaw7
         AZoUoWeuiutkRKGEDyCE9Hax1892cWAPGnaaIVSoupVptbVykPEbwmU5fYxPAUpS0CbT
         7XIDfFC4PghanMJkJtW0NnrSUM4/vN7hozzmf1/1OYdasrcMjPbJYdpX9B2frbz5joTi
         LstA0vpWZFz2P+n5tsqKSTrgaXaoDluOq4eiB6Dcakd3ek1IJwqbc1D2p7xULQYJCXNH
         0gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMcDfkI0rlioSp3cevcHgp/4Iw+XQm90p8imIzrlRw8=;
        b=3VNqDitOPK7eprBHjd0t09bS+2pc75U6//UZ1aN3ag8XNl4KPCBLEvYqFKwNUEVXDQ
         K0j0996azagVUrfKry3bxWnIiy34DhnbDHSmSx/W680B+QYnMbNhalod4tRAFcDDOerV
         9oqCzweQJdO9oPj9Q2gFN88ZYpLOWalRPhADQRZ+6+v/yV1Bmq0xHvlagnRv93cR0xDR
         SaYYQKiAdRMpkg1wdjbBl1O9/HN4XJvi6ojmPO/50DoGsxzg32YtQ1mfM9hMead1xV6L
         K2vrsUbjQ5bW5OtHQBgemYAo8mtOz55ojXn83VvnwH2+voT1k/XIdQeta5WrA/XTglmu
         fiBQ==
X-Gm-Message-State: AFqh2krgTkNesFNDGCuS4S7SNh1HrRpmUAMFUyljKlGAMuXbHfokoZhg
        yGTItcX+YfXTdIyY/XMY8e0=
X-Google-Smtp-Source: AMrXdXvcLcUVGwQBvGXNpz0c5ypR8tSyiua3MTdcNRrPMkc6HXaM5prd/8mFwlAtM7jmLT6wEoDJ/Q==
X-Received: by 2002:a05:6a20:13a6:b0:af:9c75:6699 with SMTP id w38-20020a056a2013a600b000af9c756699mr93581078pzh.1.1673026402534;
        Fri, 06 Jan 2023 09:33:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7970d000000b00582197fa7b4sm1397020pfg.7.2023.01.06.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:33:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 07:33:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] memcontrol: schedule throttling if we are congested
Message-ID: <Y7hbYPSdLqW++y/p@slm.duckdns.org>
References: <Y7g3L6fntnTtOm63@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7g3L6fntnTtOm63@kili>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(cc'ing Luis, Christoph and Jens and quoting whole body)

On Fri, Jan 06, 2023 at 05:58:55PM +0300, Dan Carpenter wrote:
> Hello Tejun Heo,
> 
> The patch 2cf855837b89: "memcontrol: schedule throttling if we are
> congested" from Jul 3, 2018, leads to the following Smatch static
> checker warning:
> 
> block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context
> 
> The call tree looks like:
> 
> ioc_rqos_merge() <- disables preempt
> __cgroup_throttle_swaprate() <- disables preempt
> -> blkcg_schedule_throttle()
> 
> Here is one of the callers:
> mm/swapfile.c
>   3657          spin_lock(&swap_avail_lock);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Takes spin lock.
> 
>   3658          plist_for_each_entry_safe(si, next, &swap_avail_heads[nid],
>   3659                                    avail_lists[nid]) {
>   3660                  if (si->bdev) {
>   3661                          blkcg_schedule_throttle(si->bdev->bd_disk, true);
>                                 ^^^^^^^^^^^^^^^^^^^^^^^
> Calls blkcg_schedule_throttle().
> 
>   3662                          break;
>   3663                  }
>   3664          }
> 
> block/blk-cgroup.c
>   1851  void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
>   1852  {
>   1853          struct request_queue *q = disk->queue;
>   1854  
>   1855          if (unlikely(current->flags & PF_KTHREAD))
>   1856                  return;
>   1857  
>   1858          if (current->throttle_queue != q) {
>   1859                  if (!blk_get_queue(q))
>   1860                          return;
>   1861  
>   1862                  if (current->throttle_queue)
>   1863                          blk_put_queue(current->throttle_queue);
>                                 ^^^^^^^^^^^^^^
> Sleeps.
> 
>   1864                  current->throttle_queue = q;
>   1865          }
>   1866  
>   1867          if (use_memdelay)
>   1868                  current->use_memdelay = use_memdelay;
>   1869          set_notify_resume(current);
>   1870  }

In general, it's quite unusual for a put operation to require a sleepable
context and I could be missing sth but the actual put / release paths don't
seem to actually need might_sleep(). It seems sprious.

The might_sleep() in put was added by Christoph's 63f93fd6fa57 ("block: mark
blk_put_queue as potentially blocking") which promoted it from release to
put cuz the caller usually can't tell whether its put is the last put.

And that put in release was added by Luis in e8c7d14ac6c3 ("block: revert
back to synchronous request_queue removal") while making the release path
synchronous, the rationale being that releasing asynchronously makes dynamic
device removal / readdition behaviors unpredictable and it also seems to
note that might_sleep() is no longer needed but still kept, which seems a
bit odd to me.

Here's my take on it:

* Let's please not require a sleepable context in a put operation. It's
  unusual, inconvenient and error-prone, and likely to cause its users to
  implement multiple copies of async mechanisms around it.

* A better way to deal with removal / readdition race is flushing release
  operaitons either at the end of removal or before trying to add something
  (you can get fancy w/ flushing only if there's name collision too), not
  making a put path synchronously call release which needs to sleep.

* If might_sleep() is currently not needed, let's please drop it. It just
  makes people scratch their head when reading the code.

Thanks.

-- 
tejun
