Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D916399D5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 10:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiK0JqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 04:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiK0JqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 04:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC03C11C3D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 01:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669542317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HZriKgT8RvIKDcrqwLOlGsqsyNg3u1Uj/dHSvWpclCY=;
        b=UkrQwa4plW+hi533+nMAjOhXpB8bTmK7ZivpVzFNZd0MtqOKz6+dSIvX2qkv9FTNcJDzYM
        VPdZ3RKxkGpG/qVvgRRaK+Xhb9I7PGDRbDZXcq/1bdBRLXv50AKBGEOlP8QRl5pSNawWPx
        lalI90wLHzpANFKUnAz4i5lKadr7DzE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-bjLNizmdO8O7eqTRldTnRA-1; Sun, 27 Nov 2022 04:45:12 -0500
X-MC-Unique: bjLNizmdO8O7eqTRldTnRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4161E85A588;
        Sun, 27 Nov 2022 09:45:12 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5AC840C2087;
        Sun, 27 Nov 2022 09:45:07 +0000 (UTC)
Date:   Sun, 27 Nov 2022 17:45:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC] scsi: core: remove unsed 'restarts' from scsi_device
Message-ID: <Y4MxnrBmEvehPNOX@T590>
References: <20221118113052.1324140-1-yukuai1@huaweicloud.com>
 <cefdae2e-67e3-b4b4-f569-31db960e991f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cefdae2e-67e3-b4b4-f569-31db960e991f@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 04:54:46PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2022/11/18 19:30, Yu Kuai 写道:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > During code review, I found that 'restarts' is not useful anymore after
> > the following commits:
> > 
> > 1) commit ab3cee3762e5 ("blk-mq: In blk_mq_dispatch_rq_list() "no budget"
> > is a reason to kick")
> > 2) commit d3b38596875d ("blk-mq: run queue no matter whether the request
> > is the last request")
> > 3) commit 673235f91531 ("scsi: core: Fix race between handling STS_RESOURCE
> > and completion")
> > 
> > Now that if get budget ever failed, block layer will make sure to
> > trigger new run queue for the hctx. Hence there is no need to run queue
> > from scsi layer in this case.
> > 
> 
> Does anyone has suggestions about this patch?
> 
> More info why I tried to remove this:
> 
> while testing megaraid with 4 nvme with none elevator, the default
> queue_depth is 128, while I test it with fio 128 jobs and 1 iodepth,
> bw is about 4Gib/s, however, if I test with 128 jobs and 2 iodepth,
> bw is decreased to about 0.8Gib/s, and with this patch applied,
> bw can stay 4Gib/s in the later case.

I will look at this patch next week.

Can you investigate a bit the reason why perf boost is from this patch?

Thanks,
Ming

