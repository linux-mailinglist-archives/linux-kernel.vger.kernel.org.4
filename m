Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069925F8AF7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 13:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJILrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 07:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJILrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 07:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97F2D752
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665316038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2G38wtJbBiFB37+C1UdAfE84soGtmhkBVZfHBjD0aU=;
        b=L7wgl760P/AUzp40i4srdrasvtyU51PVrqNQVtdUgWa0uE+E5p47gZx/Vc8+rco9Gf1adw
        n/hjGoXYI2KPHh7UAr2FMySbrZiOvG5HrnrOSEV3qt+ZvbnOFW8Hvovb5bDlQ6nVmr9bLi
        dDbBaK/NkD52gno5nevSMH4BDIPmcbo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-d3tdQJWxPi-hwcLilEe6xw-1; Sun, 09 Oct 2022 07:47:12 -0400
X-MC-Unique: d3tdQJWxPi-hwcLilEe6xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ED0E101A52A;
        Sun,  9 Oct 2022 11:47:12 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A25C9112D164;
        Sun,  9 Oct 2022 11:47:06 +0000 (UTC)
Date:   Sun, 9 Oct 2022 19:47:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     fengwei.yin@intel.com, axboe@kernel.dk, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] blk-wbt: fix that 'rwb->wc' is always set to 1 in
 wbt_init()
Message-ID: <Y0K0tBkL7Q4I0aPT@T590>
References: <20221009101038.1692875-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009101038.1692875-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 06:10:38PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 8c5035dfbb94 ("blk-wbt: call rq_qos_add() after wb_normal is
> initialized") moves wbt_set_write_cache() before rq_qos_add(), which
> is wrong because wbt_rq_qos() is still NULL.
> 
> Fix the problem by removing wbt_set_write_cache() and setting 'rwb->wc'
> directly. Noted that this patch also remove the redundant setting of
> 'rab->wc'.
> 
> Fixes: 8c5035dfbb94 ("blk-wbt: call rq_qos_add() after wb_normal is initialized")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/r/202210081045.77ddf59b-yujie.liu@intel.com
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

