Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56FC693C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBMCir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMCio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A299BB86
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 18:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676255878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QuL61XvFmiacFTLyythNDoZAC7AZvsH4GcjyynvJnMY=;
        b=Np6akfax7ipJBUqV5UrwaehMp4n5f1xD9e07AP4qGcPw38gbgyujcyFNqNXF8g3o8/wokw
        8+/yMFGAAAY8gzhJBnLikDqHqw8v/F/wME110Puya1r/fZxD3ylIqnn28MEAkDz2mPj+tJ
        ZO3K79PQQIMbTXBimhBZfF1Tl5/Kbhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-qdRlb8xTPzGPo5zI2Oc1rQ-1; Sun, 12 Feb 2023 21:37:44 -0500
X-MC-Unique: qdRlb8xTPzGPo5zI2Oc1rQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12FFD101A55E;
        Mon, 13 Feb 2023 02:37:44 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E8A32026D4B;
        Mon, 13 Feb 2023 02:37:38 +0000 (UTC)
Date:   Mon, 13 Feb 2023 10:37:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jim Harris <james.r.harris@intel.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH] block: ublk: check IO buffer based on flag need_get_data
Message-ID: <Y+mibLjCjiDXoPRt@T590>
References: <20230210141356.112321-1-xiaodong.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210141356.112321-1-xiaodong.liu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 09:13:56AM -0500, Liu Xiaodong wrote:
> Currently, uring_cmd with UBLK_IO_FETCH_REQ or
> UBLK_IO_COMMIT_AND_FETCH_REQ is always checked whether
> userspace server has provided IO buffer even flag
> UBLK_F_NEED_GET_DATA is configured.
> 
> This is a excessive check. If UBLK_F_NEED_GET_DATA is
> configured, FETCH_RQ doesn't need to provide IO buffer;
> COMMIT_AND_FETCH_REQ also doesn't need to do that if
> the IO type is not READ.
> 
> Check ub_cmd->addr together with ublk_need_get_data()
> and IO type in ublk_ch_uring_cmd().
> 
> With this fix, userspace server doesn't need to preserve
> buffers for every ublk_io when flag UBLK_F_NEED_GET_DATA
> is configured, in order to save memory.
> 
> Signed-off-by: Liu Xiaodong <xiaodong.liu@intel.com>

Good catch!

Fixes: c86019ff75c1 ("ublk_drv: add support for UBLK_IO_NEED_GET_DATA")
Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

