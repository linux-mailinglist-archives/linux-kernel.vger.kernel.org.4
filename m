Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46E4724763
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbjFFPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjFFPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80797126
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686064510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vszHrUEa6kS3DS/AWxcqvH/bpU4PkRBR+P9B7StFeyw=;
        b=edgtqbU7TnAKUK+gWXuCrDdVLAe/jYgmYsZH5CNyOP6nfoAEip2Qkxp69j+f1HCGglzm7h
        4qdiAnjsXVctgKrg5Tqe83+TSdLg+5r4cSHWz+hbhyEEw/8baSnT0Gz8HkG7y0UTLkyfiP
        nAwpBts/uMt7Sh03yQbYkUB70MlD+2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-xcj-UP3hNYenCiC9fyN2_g-1; Tue, 06 Jun 2023 11:15:06 -0400
X-MC-Unique: xcj-UP3hNYenCiC9fyN2_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3411C803C84;
        Tue,  6 Jun 2023 15:15:06 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 422072026D49;
        Tue,  6 Jun 2023 15:15:00 +0000 (UTC)
Date:   Tue, 6 Jun 2023 23:14:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "brookxu.cn" <brookxu.cn@gmail.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Message-ID: <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chunguang,

On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
> while removing ctrl. The root cause may due to the state of ctrl changed to
> NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
> nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is

I didn't dig into ctrl state check in these error handler yet, but error
handling is supposed to provide forward progress for any controller state.

Can you explain a bit how switching to DELETING interrupts the above
error handling and breaks the forward progress guarantee?

> freezed and queue is quiescing . Since scan_work may continue to issue IOs to
> load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
> hang in flush_work(&ctrl->scan_work).
> 
> After analyzation, we found that there are mainly two case: 
> 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
>    new IO to load partition table.

Yeah, nvme freeze usage is fragile, and I suggested to move
nvme_start_freeze() from nvme_tcp_teardown_io_queues to
nvme_tcp_configure_io_queues(), such as the posted change on rdma:

https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0

> 2. Since queus is quiescing, requeue timeouted IO may hang in hctx->dispatch
>    queue, leading scan_work waiting for IO completion.

That still looks one problem in related error handling code, which is
supposed to recover and unquiesce queue finally.


Thanks, 
Ming

