Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5860DFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiJZLna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiJZLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0255A170
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666784412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7irqz/NvTW4iXVUnlld6jTYNf6TWqWwg41go+5KxLrs=;
        b=UL5xJdTUes6ei5Lrczq9XbpZVmUS5dIs4aMaClcOQ01m4ovxD3AbMptKkfQrnQDBIHy9Sw
        ARkB7KwVtEeg66f6I48u6CLIXxne0sjOkMkGBeZyAnDsEHWQez8p/tWR913TnNAkLjlijj
        G+RTgzxvw7c//gcSNQCK885EXYM3N7Y=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-KmQNtQqdOsez-P3wdPT1Ug-1; Wed, 26 Oct 2022 07:40:09 -0400
X-MC-Unique: KmQNtQqdOsez-P3wdPT1Ug-1
Received: by mail-ua1-f71.google.com with SMTP id a15-20020ab0494f000000b003e052aec9b2so6692455uad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7irqz/NvTW4iXVUnlld6jTYNf6TWqWwg41go+5KxLrs=;
        b=tPjzodSwK5e9t6H648qC8kI3gbS1Hg03GsGzf2YO5riQIZVjj6csJt5AW0JyXCGnBf
         zcxZJsavsGFJ5WUi1gJyx3cUyRHXeqBGp0cszmfjHkVttrn8VsbhFNzmR2PSPhcwFlGR
         RYR3UrHULqy9KFtxP8B6brBnh+P1DEAFPmmJ3rmPOjhyXbqeD0vw25ca/kUD7Ij0FWeN
         2ZKgGDxkvLlGqcd12HLJJe/BSO6+mzFTZuhN/ke3AQqkDXBzRpfnSnPovg9j6ZsMPBRz
         UdA+OSue3Aax+Amp3PShvHh2t3tmEDtgCx1oWdiMcUtz1kMjyN1d1TGsPx681DgJdUvL
         zM2g==
X-Gm-Message-State: ACrzQf3GCHRyrhQPJe2tZ/GEAmPfavC1itYYnCfG5Ka0EcizuajLHdXQ
        cnOOJ+n5VSm3eVmC8A1KmeTHqbtP55xCEma14TknIzYoEjWWMeiEfjkCM5rr8yj4XbVQW9Owi3q
        twX3fAMxZvpI+LueIdMLotWPszuBhu5pkJ4oSPIFC
X-Received: by 2002:ab0:1c52:0:b0:401:762b:f888 with SMTP id o18-20020ab01c52000000b00401762bf888mr12114987uaj.57.1666784409110;
        Wed, 26 Oct 2022 04:40:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Xx/yW9MkoNGJhtGZNvU1HCnJVqOGUKZ9+Ilp9RoMt0HBvwtRIHlnIf5EfLuzSY/J85/XAX7roXuGnIGICkbE=
X-Received: by 2002:ab0:1c52:0:b0:401:762b:f888 with SMTP id
 o18-20020ab01c52000000b00401762bf888mr12114979uaj.57.1666784408893; Wed, 26
 Oct 2022 04:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 26 Oct 2022 19:39:58 +0800
Message-ID: <CAFj5m9+o4Q9o-qYgwn-XLJxOn6h0JjGOscwCOHEZkxzOBCdDGA@mail.gmail.com>
Subject: Re: [PATCH v2] blk-mq: Properly init requests from blk_mq_alloc_request_hctx()
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 6:04 PM John Garry <john.garry@huawei.com> wrote:
>
> Function blk_mq_alloc_request_hctx() is missing zeroing/init of rq->bio,
> biotail, __sector, and __data_len members, which blk_mq_alloc_request()
> has, so duplicate what we do in blk_mq_alloc_request().
>
> Fixes: 1f5bd336b9150 ("blk-mq: add blk_mq_alloc_request_hctx")
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

