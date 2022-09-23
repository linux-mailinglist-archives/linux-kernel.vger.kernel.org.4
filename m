Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CAB5E7E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiIWPPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiIWPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B776744
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663946110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/7qErjHQwpjdxeuxG56UOY53/Pb3ceXUixswzrpqTk=;
        b=dcc+DvBRKgad8lC1dd187SCBuxQr8Vl/q4QNaXthITvzGw39F7iRABETO1kwmaO904b3Yq
        FGUZ6mLmIS3GC1sYFZQpPcoURuTHii2d4MoF2VIoPZtdmXzutksR8AjijtfXJgqzEFNsrE
        pVvLDSW85OiZUugpnNevxTnBoAVNh6A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-C0C0B87RMr2FPbWyVWecrw-1; Fri, 23 Sep 2022 11:15:07 -0400
X-MC-Unique: C0C0B87RMr2FPbWyVWecrw-1
Received: by mail-qt1-f199.google.com with SMTP id j25-20020ac84c99000000b0035bb13ed4ffso129487qtv.23
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=i/7qErjHQwpjdxeuxG56UOY53/Pb3ceXUixswzrpqTk=;
        b=ZFwlaCVjs9GdTJ5juExf0CdysUZh7Wly6XILFiTZ6kgRU3L0Xa3rInIlCTdhWkWPGM
         UK0UFOzgBx6wQ+6qhvjxVXEkmqa9iSOc45UWz4/n1n8kKrOhfH/UgPMwtXyuVtJIK1hq
         7dILXSJTRgpkeX8yuI1Q5gpRLgUz0112Q0dE/Q/5bL08NNb55dUnOk4iow5w+LX5+GJu
         6JMQxF6Tt7nb8AKCikin0G+OC8TeMVLn1pYlxEDxb512x1PGgbZGSVLZ3lMyTr1WF04V
         lMd49GmggGzoSogZUS6xURd91RkFvPR2DbR0nNHFRdyCvuZS/lE6OHiVnvTENuTuZ3Z9
         nZug==
X-Gm-Message-State: ACrzQf31ZZg/lJiY09+srUWA9Z7vsaSomSXokrjX1uCo+KSTZi5IchjK
        7H4aNJY2vWh7AW2VSUOwR5d7Ec+oNlmKzM+jSlpXo6wtIAacJjNgGhQPRQ7Zt/P5UwDo/INFitS
        XzsQJzVwVnR8npPZz2RBpbac=
X-Received: by 2002:a05:6214:76b:b0:4ac:be62:d2e5 with SMTP id f11-20020a056214076b00b004acbe62d2e5mr7176244qvz.91.1663946106776;
        Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Jg5JqThdy0P5kS2uSLUoQ3+kfdp9Ppg4QGXjxFRDk5XYyybGVmtH43Lh/lTr6N1EDYoCkpg==
X-Received: by 2002:a05:6214:76b:b0:4ac:be62:d2e5 with SMTP id f11-20020a056214076b00b004acbe62d2e5mr7176213qvz.91.1663946106592;
        Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8468c000000b0035cb9531851sm5432876qto.65.2022.09.23.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:15:05 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 1/8] block: Introduce provisioning primitives
Message-ID: <Yy3NeY02zEMLTdsa@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-2-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-2-sarthakkukreti@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15 2022 at 12:48P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block device that support this capability will export
> a provision limit within their request queues.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/blk-core.c          |  5 ++++
>  block/blk-lib.c           | 55 +++++++++++++++++++++++++++++++++++++++
>  block/blk-merge.c         | 17 ++++++++++++
>  block/blk-settings.c      | 19 ++++++++++++++
>  block/blk-sysfs.c         |  8 ++++++
>  block/bounce.c            |  1 +
>  include/linux/bio.h       |  6 +++--
>  include/linux/blk_types.h |  5 +++-
>  include/linux/blkdev.h    | 16 ++++++++++++
>  9 files changed, 129 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8bb9eef5310e..be79ad68b330 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -57,6 +57,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->misaligned = 0;
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
> +	lim->max_provision_sectors = 0;
>  }
>  EXPORT_SYMBOL(blk_set_default_limits);
>  
> @@ -81,6 +82,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_provision_sectors = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  

Please work through the blk_stack_limits() implementation too (simple
min_not_zero?).

