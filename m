Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071226884B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjBBQmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBBQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:42:21 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D16B36C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:41:28 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id d13so1308143qvj.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sd/mC2dq5a1izGM43aJJbZ/EByEUvztVR2f3j4qBNU=;
        b=QpmgKAxi7ZuMDu27uWgUOoIA/hxv+PKkwQBVgT/zN6Y7DpzzQTFlDMSHr/+cQ7TE3A
         9T8P03H/OTScMd0pXEAK0o1fW4N5M9OtLtik3vJeZjutN6Mr8J5k86xRCDQa8n4J2g3z
         EkY7zaL16K485gw0Psj4cWOqdvx81vemteoSXyXN43eGpW5ioH6r9PWYTu0MxI9pNuWd
         L+VPPQzF2dREKDMssb9dJLSlhO0rgAh5ToIIbYyJOxGBdQnDdig1kHkOd5WWIwJIONU7
         jFGyJbZG8AqnJ3ZvBjxIr7u3LNOoG9nXAhEKTvldlW6h4cVlDDAl8BmHPuRQmCfNWQWo
         kCzw==
X-Gm-Message-State: AO0yUKURt9d4a5NzoyWb2MzrUGjuN+sMk40xeQj9iexXoBDluPuBLjl3
        LtSfFgdsdS+IK769WvKryFCF
X-Google-Smtp-Source: AK7set+4DZaHe9Eh4KBBEqljbJ8phXN/nzYGBd/kzzrMTPfJ1JNPnHtM97cxGOGqSLCdul79AmXaZg==
X-Received: by 2002:a05:6214:507:b0:53d:a0d9:979d with SMTP id px7-20020a056214050700b0053da0d9979dmr9978905qvb.23.1675356087336;
        Thu, 02 Feb 2023 08:41:27 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a126500b00706b09b16fasm60292qkl.11.2023.02.02.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:41:26 -0800 (PST)
Date:   Thu, 2 Feb 2023 11:41:25 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>, mpatocka@redhat.com
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        dm-devel@redhat.com, Sami Tolvanen <samitolvanen@google.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: dm-verity: Remove WQ_UNBOUND.
Message-ID: <Y9vnte1xP5T+nZ6j@redhat.com>
References: <20230202012348.885402-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202012348.885402-1-nhuck@google.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01 2023 at  8:23P -0500,
Nathan Huckleberry <nhuck@google.com> wrote:

> Setting WQ_UNBOUND increases scheduler latency on ARM64.  This is likely
> due to the asymmetric architecture of ARM64 processors.
> 
> I've been unable to reproduce the results that claim WQ_UNBOUND gives a
> performance boost on x86-64.
> 
> This flag is causing performance issues for multiple subsystems within
> Android.  Notably, the same slowdown exists for decompression with
> EROFS.
> 
> | open-prebuilt-camera  | WQ_UNBOUND | ~WQ_UNBOUND   |
> |-----------------------|------------|---------------|
> | verity wait time (us) | 11746      | 119 (-98%)    |
> | erofs wait time (us)  | 357805     | 174205 (-51%) |
> 
> | sha256 ramdisk random read | WQ_UNBOUND    | ~WQ_UNBOUND |
> |----------------------------|-----------=---|-------------|
> | arm64 (accelerated)        | bw=42.4MiB/s  | bw=212MiB/s |
> | arm64 (generic)            | bw=16.5MiB/s  | bw=48MiB/s  |
> | x86_64 (generic)           | bw=233MiB/s   | bw=230MiB/s |
> 
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/md/dm-verity-target.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index ccf5b852fbf7..020fd2341025 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -1399,8 +1399,8 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  		goto bad;
>  	}
>  
> -	/* WQ_UNBOUND greatly improves performance when running on ramdisk */
> -	wq_flags = WQ_MEM_RECLAIM | WQ_UNBOUND;
> +	wq_flags = WQ_MEM_RECLAIM;
> +
>  	/*
>  	 * Using WQ_HIGHPRI improves throughput and completion latency by
>  	 * reducing wait times when reading from a dm-verity device.
> -- 
> 2.39.1.456.gfc5497dd1b-goog

Hi,

I've discussed with Mikulas, tweaked your patch slightly but accepted
your change, please see:

https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.3&id=6f30cc248507ee96c22ff4c3cbc86099ff12b7a9

Thanks,
Mike
