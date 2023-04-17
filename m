Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA926E420D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjDQIGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjDQIGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63708196
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681718734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64LjpVCxLV+TLB4DlA7ht7RGBF6FWgyYq2+ZXjoxFPQ=;
        b=SmAHlQIZa9+y8fXgpQOwzKZbwqU3VWaU760MPlhKOhwvLemAH8jV8H4BmbocJ594ub7hYX
        MU4Rh2Iy60qHUDIh5qWgVY5WMe7LwbawVuJkEj6hKHkBDw1cPZnBxPfa83CO4NMNTre6id
        h4WnEnHrwnzQEhEvtG8IfNX99JfAVJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-iqveTSncMZGVonA7d7IEsw-1; Mon, 17 Apr 2023 04:05:30 -0400
X-MC-Unique: iqveTSncMZGVonA7d7IEsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40DF985A5B1;
        Mon, 17 Apr 2023 08:05:30 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CFBD14152F6;
        Mon, 17 Apr 2023 08:05:23 +0000 (UTC)
Date:   Mon, 17 Apr 2023 16:05:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Li Feng <lifeng1519@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Message-ID: <ZDz9vv6tbmKyhK7h@ovpn-8-16.pek2.redhat.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
 <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 03:50:46PM +0800, Li Feng wrote:
> 
> 
> > 2023年4月17日 下午3:37，Ming Lei <ming.lei@redhat.com> 写道：
> > 
> > On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
> >> The default worker affinity policy is using all online cpus, e.g. from 0
> >> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
> >> have a bad performance.
> > 
> > Can you explain in detail how nvme-tcp performs worse in this situation?
> > 
> > If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
> > on other non-busy CPUs via taskset, or scheduler is supposed to choose
> > proper CPUs for you. And usually nvme-tcp device should be saturated
> > with limited io depth or jobs/cpus.
> > 
> > 
> > Thanks, 
> > Ming
> > 
> 
> Taskset can’t work on nvme-tcp io-queues, because the worker cpu has decided at the nvme-tcp ‘connect’ stage,
> not the sending io stage. Assume there is only one io-queue, the binding cpu is CPU0, no matter io jobs
> run other cpus.

OK, looks the problem is on queue->io_cpu, see nvme_tcp_queue_request().

But I am wondering why nvme-tcp doesn't queue the io work on the current
cpu? And why is queue->io_cpu introduced? Given blk-mq defines cpu
affinities for each hw queue, driver is supposed to submit IO request
to hardware on the local CPU.

Sagi and Guys, any ideas about introducing queue->io_cpu?


Thanks,
Ming

