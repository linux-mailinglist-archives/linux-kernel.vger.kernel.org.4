Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD6682A40
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjAaKQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjAaKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEEF49962
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675160126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAQct07RmXjsPBydkh4gU6qVtTSDWIY2zc/YS0s3Fdw=;
        b=hlXCiSioS3J9LU0VxFCEXPgQcZQ06kJoKIcgMq+2WDdWLl275f1MlWVz175AFlvr435N/Q
        opdwyBRbZwzITopBrACcECmWNiOnhN5BbIcYPmH9LsGogMVjvvrQLF+898XvuqSWzCEVB9
        PCWcGgKFAD1KsOp1MjcT0Qmb96FYJrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Y5BX3Fx4Pweph0Y3k0Y3Yw-1; Tue, 31 Jan 2023 05:15:20 -0500
X-MC-Unique: Y5BX3Fx4Pweph0Y3k0Y3Yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B09B800B23;
        Tue, 31 Jan 2023 10:15:20 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE733140EBF4;
        Tue, 31 Jan 2023 10:15:15 +0000 (UTC)
Date:   Tue, 31 Jan 2023 18:15:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jim Harris <james.r.harris@intel.com>,
        Ben Walker <benjamin.walker@intel.com>
Subject: Re: [PATCH] block: ublk: extending queue_size to fix overflow
Message-ID: <Y9jqLdZauz9mab4t@T590>
References: <20230131070552.115067-1-xiaodong.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131070552.115067-1-xiaodong.liu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:05:52AM -0500, Liu Xiaodong wrote:
> When validating drafted SPDK ublk target, in a case that
> assigning large queue depth to multiqueue ublk device,
> ublk target would run into a weird incorrect state. During
> rounds of review and debug, An overflow bug was found
> in ublk driver.
> 
> In ublk_cmd.h, UBLK_MAX_QUEUE_DEPTH is 4096 which means
> each ublk queue depth can be set as large as 4096. But
> when setting qd for a ublk device,
> sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io)
> will be larger than 65535 if qd is larger than 2728.
> Then queue_size is overflowed, and ublk_get_queue()
> references a wrong pointer position. The wrong content of
> ublk_queue elements will lead to out-of-bounds memory
> access.
> 
> Extend queue_size in ublk_device as "unsigned int".
> 
> Signed-off-by: Liu Xiaodong <xiaodong.liu@intel.com>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e54693204630..6368b56eacf1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -137,7 +137,7 @@ struct ublk_device {
>  
>  	char	*__queues;
>  
> -	unsigned short  queue_size;
> +	unsigned int	queue_size;
>  	struct ublksrv_ctrl_dev_info	dev_info;

Good catch,

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

