Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5AA5E7C38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiIWNsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiIWNsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ED6E7431
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663940916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c25qKkQtr8eg0uMGbc/9kUwAiXIlPBy7C//4rh/Zkj4=;
        b=e44oD4sBQZO8FhVm2nnEn119Y1BwrIqqdiC/qWqvuRkiaoWKIQwMNnLannHjRZgtbSldjM
        9Ppj9WeTwjWxsxuf/ZeTNZ1IyvqGA0RUBQVv7B7WPYwpgRWdzezJt0o6/IV8/0CofiVzlw
        b+ZtjIu9u16gQ7S29XeWJmjUPLYdbbk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-bL9OT4CAPrKPz1CnLhjiWA-1; Fri, 23 Sep 2022 09:48:25 -0400
X-MC-Unique: bL9OT4CAPrKPz1CnLhjiWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 796A985A59D;
        Fri, 23 Sep 2022 13:48:25 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BCD840E0426;
        Fri, 23 Sep 2022 13:48:20 +0000 (UTC)
Date:   Fri, 23 Sep 2022 21:48:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RESEND PATCH V5 4/7] ublk_drv: consider recovery feature in
 aborting mechanism
Message-ID: <Yy25H0pnzOIEYcAY@T590>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
 <20220923061505.52007-5-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923061505.52007-5-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 02:15:02PM +0800, ZiyangZhang wrote:
> With USER_RECOVERY feature enabled, the monitor_work schedules
> quiesce_work after finding a dying ubq_daemon. The monitor_work
> should also abort all rqs issued to userspace before the ubq_daemon is
> dying. The quiesce_work's job is to:
> (1) quiesce request queue.
> (2) check if there is any INFLIGHT rq. If so, we retry until all these
>     rqs are requeued and become IDLE. These rqs should be requeued by
> 	ublk_queue_rq(), task work, io_uring fallback wq or monitor_work.
> (3) complete all ioucmds by calling io_uring_cmd_done(). We are safe to
>     do so because no ioucmd can be referenced now.
> (5) set ub's state to UBLK_S_DEV_QUIESCED, which means we are ready for
>     recovery. This state is exposed to userspace by GET_DEV_INFO.
> 
> The driver can always handle STOP_DEV and cleanup everything no matter
> ub's state is LIVE or QUIESCED. After ub's state is UBLK_S_DEV_QUIESCED,
> user can recover with new process.
> 
> Note: we do not change the default behavior with reocvery feature
> disabled. monitor_work still schedules stop_work and abort inflight
> rqs. And finally ublk_device is released.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

