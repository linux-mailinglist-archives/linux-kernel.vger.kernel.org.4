Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CA668DA29
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjBGOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjBGOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9695E173B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675778872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dazJe4eRoczDrAB2umdWwJtgIaw07ATsk60l3R4rvDY=;
        b=OQY5dT0DGDEh+ENt0leAL5C53ldpH22RN33t+0GQI5k5iHXuLxK4a5QHUXBF56VzpbjOmc
        aDMYZ9QGn0UUz4b563wZVUIpuGfgPcHIZgQmbu+SlfjHIXJohoCGYWnng1FfnUK/ytLQMR
        e9LMaKQWmZ/dbKgfF59sjIY2tRX8F0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-a4yMwfEFPcifl57Zw1mlVQ-1; Tue, 07 Feb 2023 09:07:49 -0500
X-MC-Unique: a4yMwfEFPcifl57Zw1mlVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFC77800B23;
        Tue,  7 Feb 2023 14:07:48 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46306401014C;
        Tue,  7 Feb 2023 14:07:43 +0000 (UTC)
Date:   Tue, 7 Feb 2023 22:07:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH RESEND 2/3] ublk: mention WRITE_ZEROES in comment of
 ublk_complete_rq()
Message-ID: <Y+JbKrbExeQ7uIvC@T590>
References: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
 <20230207070839.370817-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207070839.370817-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:08:38PM +0800, Ziyang Zhang wrote:
> WRITE_ZEROES won't return bytes returned just like FLUSH and DISCARD,
> and we can end it directly. Add missing comment for it in
> ublk_complete_rq().
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 55fccce68a9c..06eddefdf02a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -665,7 +665,7 @@ static void ublk_complete_rq(struct request *req)
>  	}
>  
>  	/*
> -	 * FLUSH or DISCARD usually won't return bytes returned, so end them
> +	 * FLUSH, DISCARD or WRITE_ZEROES usually won't return bytes returned, so end them
>  	 * directly.
>  	 *
>  	 * Both the two needn't unmap.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

