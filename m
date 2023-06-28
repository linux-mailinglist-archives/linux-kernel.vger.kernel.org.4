Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04A740A14
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjF1H5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbjF1Hyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687938840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yLt6oFfC/fSVNXdyS15w+dVWx2GE92WoVxiwpYLXLIU=;
        b=Fa1QDRinZSAsqOQDhji5/56Da4ksWYmMl7NDhYfu4CuksCSBR6GCqnIgLj3PHSdHyrFsPA
        JXXJgCPrNMOMqHhEp6Kq7NIHbQnHkJ7+4R3LGVjxQH6dSwffbOoTcAPZn+eR/eY1NvB9R8
        XtxhCkSFJscEGjIk6Eeq4VnHkNZFnQ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-K7_N336BO_m7VZwNQxyb_g-1; Wed, 28 Jun 2023 03:22:33 -0400
X-MC-Unique: K7_N336BO_m7VZwNQxyb_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3724856F67;
        Wed, 28 Jun 2023 07:22:32 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 831B9111F3B0;
        Wed, 28 Jun 2023 07:22:28 +0000 (UTC)
Date:   Wed, 28 Jun 2023 15:22:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 2/4] blk-flush: count inflight flush_data requests
Message-ID: <ZJvfr345L9krt371@ovpn-8-21.pek2.redhat.com>
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
 <20230627120854.971475-3-chengming.zhou@linux.dev>
 <ZJuzYMeVhP5cthbC@ovpn-8-21.pek2.redhat.com>
 <490fd0d8-c0b3-cc26-c658-da35d52b6b56@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490fd0d8-c0b3-cc26-c658-da35d52b6b56@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:55:49PM +0800, Chengming Zhou wrote:
> On 2023/6/28 12:13, Ming Lei wrote:
> > On Tue, Jun 27, 2023 at 08:08:52PM +0800, chengming.zhou@linux.dev wrote:
> >> From: Chengming Zhou <zhouchengming@bytedance.com>
> >>
> >> The flush state machine use a double list to link all inflight
> >> flush_data requests, to avoid issuing separate post-flushes for
> >> these flush_data requests which shared PREFLUSH.
> >>
> >> So we can't reuse rq->queuelist, this is why we need rq->flush.list
> >>
> >> In preparation of the next patch that reuse rq->queuelist for flush
> >> state machine, we change the double linked list to a u64 counter,
> >> which count all inflight flush_data requests.
> >>
> >> This is ok since we only need to know if there is any inflight
> >> flush_data request, so a u64 counter is good. The only problem I can
> >> think of is that u64 counter may overflow, which should be unlikely happen.
> > 
> > It won't overflow, q->nr_requests is 'unsigned long', which should have
> > been limited to one more reasonable value, such as 2 * BLK_MQ_MAX_DEPTH, so
> > u16 should be big enough in theory.
> 
> Ah, right. q->nr_requests is 'unsigned long' and q->queue_depth is 'unsigned int',
> so 'unsigned long' counter here won't overflow.

Not like q->nr_requests, q->queue_depth usually means the whole queue's depth,
which may cover all hw queue's depth. And it is only used by scsi, but it
should be held in "unsigned short" too.

> 
> Should I change it to smaller 'unsigned short' or just leave it as 'unsigned long' ?
> (Now the size of struct blk_flush_queue is exactly 64 bytes)

You have to limit q->nr_requests first, which may need a bit more work for avoiding
compiling warning or sort of thing. And 64k is big enough for holding per-queue
scheduler request.

Once it is done, it is fine to define this counter as 'unsigned short'.


Thanks,
Ming

