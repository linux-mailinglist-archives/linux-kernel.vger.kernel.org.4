Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065DE6E4157
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjDQHkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjDQHjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA54236
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681717087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QRdnQCKny8giW3OyExxPhuJqL89+ZaGGJFW/ztJq/GQ=;
        b=Hchb+DzdLmaEMJW/XuahMEGmJ/qRwq8KffahtKBOejxVNe6LYzbW1H1+u2/+IJ68l0R8n5
        dTpt60TGimXkJC0R46WZbnYjq6s2D2xckS66GYQF24erkfOq19v6tTHu+XPzJJPmI95o+T
        opcXVCebkUS+VBzuGJZ+AlWw7nV9hEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549--G3PADyWMEmGXGJVJmaYgA-1; Mon, 17 Apr 2023 03:38:03 -0400
X-MC-Unique: -G3PADyWMEmGXGJVJmaYgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 980DE85C1A7;
        Mon, 17 Apr 2023 07:38:02 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AEFB40C6E6E;
        Mon, 17 Apr 2023 07:37:55 +0000 (UTC)
Date:   Mon, 17 Apr 2023 15:37:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Li Feng <fengli@smartx.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, lifeng1519@gmail.com,
        ming.lei@redhat.com
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Message-ID: <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413132941.2489795-1-fengli@smartx.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
> The default worker affinity policy is using all online cpus, e.g. from 0
> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
> have a bad performance.

Can you explain in detail how nvme-tcp performs worse in this situation?

If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
on other non-busy CPUs via taskset, or scheduler is supposed to choose
proper CPUs for you. And usually nvme-tcp device should be saturated
with limited io depth or jobs/cpus.


Thanks, 
Ming

