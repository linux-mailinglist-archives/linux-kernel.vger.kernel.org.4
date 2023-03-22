Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE4A6C412A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCVDjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCVDjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC726C22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679456338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acAVed8CDBREmL9QLjhE79J05nR0HTJkM0a3n25AtZk=;
        b=TV+ryhYil6/VVOTFMXtRmg9rMIWPvK3EWOLLiTdfUdt8xC5P7vRHimAyp3tBSDe8dochOg
        JXOEhUpihVdl7Zae1USD7Kf53naE6FHK7+f7ZChHLb7W1Ck5VP2XixAvHEu2TvMnpCmguQ
        Y0Em0v64T3phutn5+8O6F939NNtCU1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-sP62k0_iM_Gk_8g6MhmQQA-1; Tue, 21 Mar 2023 23:38:54 -0400
X-MC-Unique: sP62k0_iM_Gk_8g6MhmQQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44C0C101A54F;
        Wed, 22 Mar 2023 03:38:54 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C60CA2027047;
        Wed, 22 Mar 2023 03:38:47 +0000 (UTC)
Date:   Wed, 22 Mar 2023 11:38:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hare@suse.de, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Changhui Zhong <czhong@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>, ming.lei@redhat.com
Subject: Re: [PATCH -next 0/2] block: fix scan partition for exclusively open
 device again
Message-ID: <ZBp4Ql08g5YvTDAA@ovpn-8-17.pek2.redhat.com>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
 <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <dc7d28bf-35ca-7cde-ffdf-9490177dfdb9@huaweicloud.com>
 <ZBpbGKxPQcs9NYst@ovpn-8-18.pek2.redhat.com>
 <5facd7c1-fa90-99ff-bd08-cdf67fe6c1ab@huaweicloud.com>
 <a8505ded-dadd-9096-4b13-31512a2c703e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8505ded-dadd-9096-4b13-31512a2c703e@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:15:30AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/03/22 10:02, Yu Kuai 写道:
> > Hi,
> > 
> > 在 2023/03/22 9:34, Ming Lei 写道:
> > > On Wed, Mar 22, 2023 at 09:26:07AM +0800, Yu Kuai wrote:
> > > > Hi,
> > > > 
> > > > 在 2023/03/21 19:43, Ming Lei 写道:
> > > > > On Fri, Feb 17, 2023 at 10:21:58AM +0800, Yu Kuai wrote:
> > > > > > From: Yu Kuai <yukuai3@huawei.com>
> > > > > > 
> > > > > > Changes from RFC:
> > > > > >    - remove the patch to factor out GD_NEED_PART_SCAN
> > > > > > 
> > > > > > Yu Kuai (2):
> > > > > >     block: Revert "block: Do not reread partition table on exclusively
> > > > > >       open device"
> > > > > >     block: fix scan partition for exclusively open device again
> > > > > 
> > > > > Hi Yu kuai,
> > > > > 
> > > > > Looks the original issue starts to re-appear now with the two patches:
> > > > > 
> > > > > https://lore.kernel.org/linux-block/20221130135344.2ul4cyfstfs3znxg@quack3/
> > > > > 
> > > > > 
> > > > > And underlying disk partition and raid partition can be observed at the
> > > > > same time.
> > > > > 
> > > > > Can you take a look?
> > > > Yes, thanks for the report. I realize that sda1 adn sdb1 is created
> > > > while raid open sda and sdb excl, and I think this problem should exist
> > > > before this patchset.
> > > 
> > > Looks not reproduced before applying your two patches, that is
> > > exactly what Jan
> > > tried to fix with 36369f46e917 ("block: Do not reread partition
> > > table on exclusively open device").
> > 
> > Hi, Ming
> > 
> > I just tried your test with this patchset reverted, and I can still
> > reporduce the problem myself.
> 
> Oops, I forgot to revert the first patch. It's right the problem can't
> be reporduced.
> > 
> > raid only open this device excl, and disk_scan_partitions is not called:
> > 
> > md_import_device
> >   blkdev_get_by_devo
> > 
> > I need to add some debuginfo to figure out how GD_NEED_PART_SCAN is set
> > for sda after raid is stopped. And this should explain why sda1 is
> > created.
> 
> I found how GD_NEED_PART_SCAN is set now, in patch 2, this is set before
> bd_prepare_to_claim, so preciously faild part scan will still set this
> bit, and following patch shold fix this problem:

Just run quick test, the issue won't be reproduced with your patch, and
the change looks rational too,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

