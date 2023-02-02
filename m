Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DA768D15A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBGIRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:17:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F057E39D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675757814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFz64AZt4DpUKZz5wluvLqO1XHEdz9VfA58kPK7PPVA=;
        b=eRouLrxigct94A3swGmRxBDKGl6tBPWCXdvhPspgwLjSgxbQLWJxnUZRvhuEyn8TuwiI9P
        FkbSqkJ/5hSrA90yuz8TpOMrkCNshujWXy4I+rRHfNiQeyGPzsJXZuW6yX+h+ihZhO5C45
        4UieF1soBvnBgelYXzq6r6KomtcNcZM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-LjFJdov4Mgi0HadfswXs2g-1; Tue, 07 Feb 2023 03:16:53 -0500
X-MC-Unique: LjFJdov4Mgi0HadfswXs2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90A2A29AB3F0;
        Tue,  7 Feb 2023 08:16:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B7B8440D9;
        Tue,  7 Feb 2023 08:16:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 3177GgcH004677;
        Tue, 7 Feb 2023 02:17:05 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 312G4Pap021968;
        Thu, 2 Feb 2023 11:04:25 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 2 Feb 2023 11:04:24 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Nathan Huckleberry <nhuck@google.com>
cc:     Mike Snitzer <snitzer@kernel.org>, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, dm-devel@redhat.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH] dm-verity: Remove WQ_UNBOUND.
In-Reply-To: <20230202012348.885402-1-nhuck@google.com>
Message-ID: <alpine.LRH.2.21.2302021052580.21238@file01.intranet.prod.int.rdu2.redhat.com>
References: <20230202012348.885402-1-nhuck@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Feb 2023, Nathan Huckleberry wrote:

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

Hi

If you remove WQ_UNBOUND, you should also change the last argument of 
alloc_workqueue from num_online_cpus() to either 0 or 1. Try both 0 and 1 
and tell us which performs better.

Mikulas

