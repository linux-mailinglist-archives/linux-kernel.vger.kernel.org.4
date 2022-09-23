Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7CB5E724B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiIWDDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiIWDDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE53B72AF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663902117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOUbwOVwoS4tvADVKdclHC5ioKuaABY326oj+/kvkPI=;
        b=TwEQPOoWNoKZMwcXyxJwilvWEt7dNwkhZUmbtOcARMP18Aa1SCIXaXVniC88qaG+v+RzLI
        /PwuKQknE9lEISuCqmBY9jw+y7TCBz9C6QW2FtTt5EbfLvjotpgfQ1TiJG1NzM4LM1/6yW
        n6/EK/rVmrWRSgHQwcIACsFbiQYa09o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-8jqRBZQ_P3G2OSyJ5Uu1EQ-1; Thu, 22 Sep 2022 23:01:47 -0400
X-MC-Unique: 8jqRBZQ_P3G2OSyJ5Uu1EQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E637E101E14F;
        Fri, 23 Sep 2022 03:01:46 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F23FB2024CBB;
        Fri, 23 Sep 2022 03:01:42 +0000 (UTC)
Date:   Fri, 23 Sep 2022 11:01:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V5 2/7] ublk_drv: define macros for recovery feature and
 check them
Message-ID: <Yy0hkf3lWWxfSzmN@T590>
References: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
 <20220922061734.21625-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922061734.21625-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:17:29PM +0800, ZiyangZhang wrote:
> Define some macros for recovery feature.
> 
> UBLK_S_DEV_QUIESCED implies that ublk_device is quiesced
> and is ready for recovery. This state can be observed by userspace.
> 
> UBLK_F_USER_RECOVERY implies that:
> (1) ublk_drv enables recovery feature. It won't let monitor_work to
>     automatically abort rqs and release the device.
> (2) With a dying ubq_daemon, ublk_drv ends(aborts) rqs issued to
>     userspace(ublksrv) before crash.
> (3) With a dying ubq_daemon, in task work and ublk_queue_rq(),
>     ublk_drv requeues rqs.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

