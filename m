Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3762CD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiKPVxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiKPVxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243786A6B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668635461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6nojB89E1Mh3yFLSu2KzkNkZ/bHQfVswcYDYKdeZ2Q=;
        b=h7iqGBQdJ+mvNY/T6Gn469LYN6B5u5PkcWRH41+jKIggGfpukiQ7eA92QT0JAaDhAB59Gl
        sHQMWpdeJ23cIkGtKYl7/h8+cYXC1msb2TcQU4pMEqT/kEhd3lT7s/+SD0syNBrbOFQU0m
        ZrvqqVHVCHHWIktm2F5R6SVh2prESj8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-Eh2e_YMmOcymeG0zEcWeIw-1; Wed, 16 Nov 2022 16:51:00 -0500
X-MC-Unique: Eh2e_YMmOcymeG0zEcWeIw-1
Received: by mail-qk1-f199.google.com with SMTP id az31-20020a05620a171f00b006fa2cc1b0bfso18970097qkb.23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6nojB89E1Mh3yFLSu2KzkNkZ/bHQfVswcYDYKdeZ2Q=;
        b=YF65UP7fBsq1XxbQ8SfKLZVW5SVCSfs5OYhGEkL7mTomZvRNFMSx870NaHQpoJNgct
         yes4DqRVY+qwaPvJkkmc4CcB884FCQkfdLRXEVkynnjzO+WCxpKPnpwra1DzMVFCHzGS
         LYHQvPbFMOTAlMmvoh7Va6rapzl89BgaCsT9GR3hVODgMPP2HG+vwv24othqrBTYcs4c
         yVELM5H6SKXQwlAOAX8VFpiOt0lfRmNN/r6GfppPjnYuMr0ees/AB3XcWE1K+7T+Mxo7
         s5bhzbt8/kcL3lNiWQelpMBDj2DekJAQ/fI9uoWsMV03GDkAid+GkLu2PKB9EYrJdQdW
         yNSw==
X-Gm-Message-State: ANoB5pk747HddIGe/F+7QfACoayK0v2lXIee2ivsDIdXLpbBk1o9oPoy
        MN/swgYl64yVhGUAhCY8YiAjjeOmI/ZzTbIUZ/eO+UyVjIQ4Uoi0kzYGjmorEEP+PbnrgYxIBkF
        aT3w5EQTKtOjzXyPfaeNjXtQ=
X-Received: by 2002:a05:620a:c43:b0:6fa:6423:65b6 with SMTP id u3-20020a05620a0c4300b006fa642365b6mr14077828qki.324.1668635459740;
        Wed, 16 Nov 2022 13:50:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5o3UcPKD9RkRXo2oJUoXe+j1L0zcdnOEKW/X0guNcC/Xo8sAb4uEao0tfvbnLS9Ws1eXPm+Q==
X-Received: by 2002:a05:620a:c43:b0:6fa:6423:65b6 with SMTP id u3-20020a05620a0c4300b006fa642365b6mr14077821qki.324.1668635459547;
        Wed, 16 Nov 2022 13:50:59 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006fba44843a5sm3063589qkn.52.2022.11.16.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:50:59 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:50:58 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 02/10] dm: remove free_table_devices
Message-ID: <Y3VbQsjmNW4GQHLs@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-3-yukuai1@huaweicloud.com>
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
> free_table_devices just warns and frees all table_device structures when
> the target removal did not remove them.  This should never happen, but
> if it did, just freeing the structure without deleting them from the
> list or cleaning up the resources would not help at all.  So just WARN on
> a non-empty list instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

