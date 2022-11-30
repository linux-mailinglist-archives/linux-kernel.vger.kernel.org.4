Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2E63DA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiK3Q0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiK3Q0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:26:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675886A0A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669825551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=esffUcF9TlJFELLQVw88/RnS7S6rdsC2lFTOy4sZQrU=;
        b=bwJe/wp+S8bKe9pIGXplljkEFdCBtH0iRAJMKmRZh7VN+p4VaVHgKkkq/67iQGFEE5tCJY
        g0h+/JDwHMpZPPc517KM6MrQInSwR9sDu5eHDagTME7E0NRgaMypB0AUKUZrJcbr17nVZs
        731wBfND9RMJwSetjmz9tuy0kGT5GZQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644---qQa3B1PYe-vzGj38cvlw-1; Wed, 30 Nov 2022 11:25:49 -0500
X-MC-Unique: --qQa3B1PYe-vzGj38cvlw-1
Received: by mail-qv1-f72.google.com with SMTP id w1-20020a056214012100b004c6ecf32001so22488627qvs.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esffUcF9TlJFELLQVw88/RnS7S6rdsC2lFTOy4sZQrU=;
        b=uwTrkstPGQaMIH6zD4dHLPm5SHEtWXcwk//8JlbSIr0KKPyIcytCQ4BAk4DJfRi/nU
         C5hlW5RiHxXyLvEysAccR999THwei7DccSYgqPFsQmDucaZ6ONMNui66KVuEANmpg27c
         aaFzPe+jqqAUKdePHrGgKcMvjqwFX6qojzvZ7oUq/ZBC+T3mVCEzMBfRqwU+gcxoI9kt
         nOn8KjIV9zhfdMO1C+Orjq764SmWX2drNB6kNz5W02mtaGxW0uLD8Qj/aLkyzICTaV0B
         sOXSdyeFTGFAF6+odDaF9YL1zl9pdrBTTFVgnGQNy37YPXk1yr0z8uRaavjHSPQ4LrYb
         u/Gg==
X-Gm-Message-State: ANoB5pnbc5+g2MxY+I23BIVb4nDo1cPsvZggE8XvV0/NZLarxMbTso9C
        Vp0C9zN3yzmWTE2oGjIM4HdvplQdaHQ6sH63P53zF68Wh5h58b93647dkh/SDM1EvrB4HqcXW8s
        d0e84rFPIL8VIbLqF0p/0xhs=
X-Received: by 2002:ae9:c017:0:b0:6fc:65f8:33d9 with SMTP id u23-20020ae9c017000000b006fc65f833d9mr18959919qkk.39.1669825549240;
        Wed, 30 Nov 2022 08:25:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4m9QtWA4pXquhn2sbV3unD2cp+RDJ22Mm7DK2GZ0OJ+Z+oqi1SrApE4E7wPiDLoVb/MS82XQ==
X-Received: by 2002:ae9:c017:0:b0:6fc:65f8:33d9 with SMTP id u23-20020ae9c017000000b006fc65f833d9mr18959902qkk.39.1669825549015;
        Wed, 30 Nov 2022 08:25:49 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006fc5a1d9cd4sm1483667qko.34.2022.11.30.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:25:48 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:25:47 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     zhang.songyi@zte.com.cn
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] dm: remove redundant sz variable
Message-ID: <Y4eEC48JUauAZuio@redhat.com>
References: <202211301535171577902@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211301535171577902@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30 2022 at  2:35P -0500,
zhang.songyi@zte.com.cn <zhang.songyi@zte.com.cn> wrote:

> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Return value from hst_status() directly instead of taking
> this in another redundant variable.
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  drivers/md/dm-ps-historical-service-time.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-ps-historical-service-time.c b/drivers/md/dm-ps-historical-service-time.c
> index 1d82c95d323d..6c8e83ad2662 100644
> --- a/drivers/md/dm-ps-historical-service-time.c
> +++ b/drivers/md/dm-ps-historical-service-time.c
> @@ -237,7 +237,6 @@ static void hst_destroy(struct path_selector *ps)
>  static int hst_status(struct path_selector *ps, struct dm_path *path,
>                      status_type_t type, char *result, unsigned int maxlen)
>  {
> -       unsigned int sz = 0;
>         struct path_info *pi;
> 
>         if (!path) {
> @@ -261,7 +260,7 @@ static int hst_status(struct path_selector *ps, struct dm_path *path,
>                 }
>         }
> 
> -       return sz;
> +       return 0;
>  }
> 
>  static int hst_add_path(struct path_selector *ps, struct dm_path *path,
> --
> 2.15.2
> 

NACK

This sz variable is needed! (see DMEMIT)

