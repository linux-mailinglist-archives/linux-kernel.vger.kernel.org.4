Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9EE62CCF5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiKPVsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKPVri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853113F78
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668635199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zqBOrG9rli2QJrkKNVbeBDdgpPeZ5Pcyt9IVG+ltwAM=;
        b=hFmqqLwuP9o3QncISRoyYVDCyzkEA6EgdWahz6bSJmfbWVDiL5dScwLg4nTMNzuN7MTYM0
        TJYHsYeqyzEbKFVbipKMKrp1yr9UGN9HppFngHQQrXeAdzxiA8RkLxFZTIbQnfDdH0oDXU
        jSv6gNyS3mlNpht7cWHPAVG1/5f3qtM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-57-EPk6YXnKMBCnwqJ9RYBGFA-1; Wed, 16 Nov 2022 16:46:37 -0500
X-MC-Unique: EPk6YXnKMBCnwqJ9RYBGFA-1
Received: by mail-qv1-f71.google.com with SMTP id l6-20020ad44446000000b004bb60364075so14465707qvt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqBOrG9rli2QJrkKNVbeBDdgpPeZ5Pcyt9IVG+ltwAM=;
        b=F6pb99JyyY4GRO1T4kKy7YikK6RZnM2ihe9t/ksT7up6ilrJ9w99IS/w21+gyildq0
         azWl5/7hFhtgTeQ2mZ7iW/E/zlPaQgKmpwK6txiM69dHA/8zDjAX4mdZTwWIvf6RXGhw
         x/WS4wstyjaDvgKsZURU9FYS9TKzdai222+xR34kytJwg54vB8BGalccaDs/O60zc/1+
         WAUfOJGXblv7T2Xu+wJHVVUaZ3EXiYa8pgcbIiCMfZiDnocEdEHD69I4997fkTeT3Y1w
         fW7MK1tlYiDun7/WvPXltwd4BgWeGwcjrd6sLRF1DhuM+D9wrrhT/8D7lF03q5/pTcPV
         hC/g==
X-Gm-Message-State: ANoB5ploR7qmSv9IQyuwVDoztK+F2p6GJJNCq7cY9WLCwA+8aAK9r9+Y
        MweuOtf4HnOksxMgrPj3+3YOd2XPMqK5MQTB1UaWvLNgIqyZ0tdmDPoGLAdcuah/R8N3k7+0jRw
        akoYwtefgajyXYWHusQQd8c8=
X-Received: by 2002:a05:620a:439c:b0:6f9:9833:1e21 with SMTP id a28-20020a05620a439c00b006f998331e21mr20998702qkp.715.1668635197045;
        Wed, 16 Nov 2022 13:46:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5CNustigt3HWzBTGO59Iu4TDYZJeRnveeOzDy21Xv1w6GMw4lyGw6Oe0HN/e1q0sFig+Vh+Q==
X-Received: by 2002:a05:620a:439c:b0:6f9:9833:1e21 with SMTP id a28-20020a05620a439c00b006f998331e21mr20998686qkp.715.1668635196850;
        Wed, 16 Nov 2022 13:46:36 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a409000b006bb78d095c5sm10888736qko.79.2022.11.16.13.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:46:36 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:46:35 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 04/10] dm: cleanup close_table_device
Message-ID: <Y3VaO4PQo4rRIRBR@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-5-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> Take the list unlink and free into close_table_device so that no half
> torn down table_devices exist.  Also remove the check for a NULL bdev
> as that can't happen - open_table_device never adds a table_device to
> the list that does not have a valid block_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

