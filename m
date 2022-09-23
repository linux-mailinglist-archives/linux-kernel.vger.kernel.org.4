Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D375E7C49
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiIWNu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiIWNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD38132D66
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663941041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1UCrnIiJHXHNqsN3S35cn3dnzyzc2EF3aYigy2M2Wvk=;
        b=arjjdcK4rEnrwb8fv2I/JMPHJBjDh8GmWC1XZsNxCoemIGjT0Ok33wlr1k5zPsg02FKbGZ
        sHmpWoAYbvk7/xV+vnI9v028d4FvzKMmJ1Pq1WimUzTeh2li7UgI/yhi8FgBs9pz08axwr
        smXiOODn4H174PfJKVyokrFt6Maa4e8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-7c4uVgBeMyysQ2vmI9n-Mw-1; Fri, 23 Sep 2022 09:50:39 -0400
X-MC-Unique: 7c4uVgBeMyysQ2vmI9n-Mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56FB3101E157;
        Fri, 23 Sep 2022 13:50:39 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA81E2166B40;
        Fri, 23 Sep 2022 13:50:34 +0000 (UTC)
Date:   Fri, 23 Sep 2022 21:50:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RESEND PATCH V5 6/7] ublk_drv: add START_USER_RECOVERY and
 END_USER_RECOVERY support
Message-ID: <Yy25paEXnUwLnvkp@T590>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
 <20220923061505.52007-7-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923061505.52007-7-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 02:15:04PM +0800, ZiyangZhang wrote:
> START_USER_RECOVERY and END_USER_RECOVERY are two new control commands
> to support user recovery feature.
> 
> After a crash, user should send START_USER_RECOVERY, it will:
> (1) check if (a)current ublk_device is UBLK_S_DEV_QUIESCED which was
>     set by quiesce_work and (b)chardev is released
> (2) reinit all ubqs, including:
>     (a) put the task_struct and reset ->ubq_daemon to NULL.
>     (b) reset all ublk_io.
> (3) reset ub->mm to NULL.
> 
> Then, user should start a new process and send FETCH_REQ on each
> ubq_daemon.
> 
> Finally, user should send END_USER_RECOVERY, it will:
> (1) wait for all new ubq_daemons getting ready.
> (2) update ublksrv_pid
> (3) unquiesce the request queue and expect incoming ublk_queue_rq()
> (4) convert ub's state to UBLK_S_DEV_LIVE
> 
> Note: we can handle STOP_DEV between START_USER_RECOVERY and
> END_USER_RECOVERY. This is helpful to users who cannot start new process
> after sending START_USER_RECOVERY ctrl-cmd.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

