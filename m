Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4974877A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjGEPIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjGEPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF095170B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688569680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CYB3cvLDnc3P98VVJYn8G9DoZ+oTFJfoiNpil4CwPA0=;
        b=WmPZsUzAVwfG3YCVQ3nojq/+4GUob8zHYqyeX12uOm1iDGsJ8pL3wvxU9LOKIHiJOW02bJ
        N8eac0f4rYYwUbqo5v/lFux3AsFqCCCMyNgtL/EKh6gZ/URX/G19QzW4oWC8dM5rOM8fBs
        GRdbWSHWzsQoSTv0xhH2qPkOEp8XDC4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-qCzxabckPx2me5_7gFTaHQ-1; Wed, 05 Jul 2023 11:01:25 -0400
X-MC-Unique: qCzxabckPx2me5_7gFTaHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01A3B185A7BA;
        Wed,  5 Jul 2023 15:01:12 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CF0DC51488;
        Wed,  5 Jul 2023 15:01:07 +0000 (UTC)
Date:   Wed, 5 Jul 2023 23:01:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 1/4] blk-mq: use percpu csd to remote complete instead
 of per-rq csd
Message-ID: <ZKWFrirq9Eemm788@ovpn-8-34.pek2.redhat.com>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev>
 <20230629110359.1111832-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629110359.1111832-2-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 07:03:56PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> If request need to be completed remotely, we insert it into percpu llist,
> and smp_call_function_single_async() if llist is empty previously.
> 
> We don't need to use per-rq csd, percpu csd is enough. And the size of
> struct request is decreased by 24 bytes.
> 
> This way is cleaner, and looks correct, given block softirq is guaranteed to be
> scheduled to consume the list if one new request is added to this percpu list,
> either smp_call_function_single_async() returns -EBUSY or 0.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v2:
>  - Change to use call_single_data_t, which avoid to use 2 cache lines
>    for 1 csd, as suggested by Ming Lei.
>  - Improve the commit log, the explanation is copied from Ming Lei.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

