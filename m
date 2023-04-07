Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF406DA785
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbjDGCLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbjDGCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9506BDC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680833310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9mDbmCDWIZufpdSQOQtCy1IYkjHuQ55FDYgdUqKYCs=;
        b=ZbZSzu4M7ut8LMmFc1nht6a5VOkS/ZojNFvWgH7LOKgYFK8ENpVILvlQMul0dBjkc/6Byi
        9FB1ytd+eziW+X7M+eSgIBc6dhtYodzmJyPHLy/pzHTMOMISvs2pYn8XUpiVIlKZLQhUqN
        APdoF2cjoH1Q/EurRO8VD9Su7Eq0f28=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-MnPaK8BFPJW-M_AVEpvykg-1; Thu, 06 Apr 2023 22:02:09 -0400
X-MC-Unique: MnPaK8BFPJW-M_AVEpvykg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD8973C20EEC;
        Fri,  7 Apr 2023 02:02:08 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF41640C6EC4;
        Fri,  7 Apr 2023 02:02:01 +0000 (UTC)
Date:   Fri, 7 Apr 2023 10:01:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>, ming.lei@redhat.com
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Message-ID: <ZC95kzpiZnD9m7GY@ovpn-8-24.pek2.redhat.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <42cfedca-f233-4d7e-f43b-4b5dd0c97e9e@huaweicloud.com>
 <b3817e92-80ca-8eea-ebdd-f2172f3390c8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3817e92-80ca-8eea-ebdd-f2172f3390c8@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 04:29:43PM -0600, Jens Axboe wrote:
> On 4/5/23 9:42 PM, Yu Kuai wrote:
> > Hi, Jens!
> > 
> > 在 2023/03/22 11:59, Yu Kuai 写道:
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
> >> set, and partition scan will be proceed again when blkdev_get_by_dev()
> >> is called. However, this will cause a problem that re-assemble partitioned
> >> raid device will creat partition for underlying disk.
> >>
> >> Test procedure:
> >>
> >> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> >> sgdisk -n 0:0:+100MiB /dev/md0
> >> blockdev --rereadpt /dev/sda
> >> blockdev --rereadpt /dev/sdb
> >> mdadm -S /dev/md0
> >> mdadm -A /dev/md0 /dev/sda /dev/sdb
> >>
> >> Test result: underlying disk partition and raid partition can be
> >> observed at the same time
> >>
> >> Note that this can still happen in come corner cases that
> >> GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
> >> device.
> >>
> > 
> > Can you apply this patch?
> 
> None of them apply to my for-6.4/block branch...

This patch is bug fix, and probably should aim at 6.3.

Thanks,
Ming

