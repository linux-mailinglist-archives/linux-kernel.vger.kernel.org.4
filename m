Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C8D6C744E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCXAAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB52BF26
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679615986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gl9w/yJfZOXEIR5CEa5hWRjEd6sx1OySB3KBP/TuTQI=;
        b=G9qk1/A8pfuN7T5NiW5UmZs2CvZWsAqjN8AKpMEc3GJDZ2ogd2+hlpsSH+oWfSDN5caAX0
        +pHB9TphsCM0U2yI6PMc+Hqhe4xGaX8/QMpTpks6Olk5QFnj03lFPo4BaTeWmgHt1jyakj
        lRln++U1zplLIp0M53+93DBQwKm5+Xg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-w0s7kIj6P1-X8x_VaDhv3g-1; Thu, 23 Mar 2023 19:59:41 -0400
X-MC-Unique: w0s7kIj6P1-X8x_VaDhv3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21DFF80C8C1;
        Thu, 23 Mar 2023 23:59:41 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D04551FF;
        Thu, 23 Mar 2023 23:59:35 +0000 (UTC)
Date:   Fri, 24 Mar 2023 07:59:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hch@infradead.org, axboe@kernel.dk,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Message-ID: <ZBzn4rJWckKgUBan@ovpn-8-16.pek2.redhat.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322035926.1791317-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:59:26AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
> set, and partition scan will be proceed again when blkdev_get_by_dev()
> is called. However, this will cause a problem that re-assemble partitioned
> raid device will creat partition for underlying disk.
> 
> Test procedure:
> 
> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> sgdisk -n 0:0:+100MiB /dev/md0
> blockdev --rereadpt /dev/sda
> blockdev --rereadpt /dev/sdb
> mdadm -S /dev/md0
> mdadm -A /dev/md0 /dev/sda /dev/sdb
> 
> Test result: underlying disk partition and raid partition can be
> observed at the same time
> 
> Note that this can still happen in come corner cases that
> GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
> device.

That is why I suggest to touch this flag as less as possible, maybe
replace it with one function parameter in future.

> 
> Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

So far, let's move on with the fix:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

