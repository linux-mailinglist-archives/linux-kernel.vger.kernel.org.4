Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAFE6C3FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCVBfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCVBfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F92E820
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679448873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLkdy2H+ruuA4UL25SaUZEhvU4tJRBpVJAsfKLpml+U=;
        b=BFmEdz7BDYFn0X+4oZANoDyKB/pjY5swHKAmwkUYQ3BxphcyBPWsDDoT6aYyR7DisVxd1G
        K8OYB1yASQ9rVHmxe82NcbE50I5a+Vyw9KDqLCbPdFzFMzPsbS7IkLlT99a/WDBuLOE8zb
        KZ68Qjt6SeLPYKaft5Ak+Sbbjqvsx2k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-TwrdUqlOP3qyDEKJ_lEd2g-1; Tue, 21 Mar 2023 21:34:29 -0400
X-MC-Unique: TwrdUqlOP3qyDEKJ_lEd2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 396543C0F18C;
        Wed, 22 Mar 2023 01:34:29 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29D772166B29;
        Wed, 22 Mar 2023 01:34:21 +0000 (UTC)
Date:   Wed, 22 Mar 2023 09:34:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hare@suse.de, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>,
        Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH -next 0/2] block: fix scan partition for exclusively open
 device again
Message-ID: <ZBpbGKxPQcs9NYst@ovpn-8-18.pek2.redhat.com>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
 <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <dc7d28bf-35ca-7cde-ffdf-9490177dfdb9@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc7d28bf-35ca-7cde-ffdf-9490177dfdb9@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:26:07AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/03/21 19:43, Ming Lei 写道:
> > On Fri, Feb 17, 2023 at 10:21:58AM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Changes from RFC:
> > >   - remove the patch to factor out GD_NEED_PART_SCAN
> > > 
> > > Yu Kuai (2):
> > >    block: Revert "block: Do not reread partition table on exclusively
> > >      open device"
> > >    block: fix scan partition for exclusively open device again
> > 
> > Hi Yu kuai,
> > 
> > Looks the original issue starts to re-appear now with the two patches:
> > 
> > https://lore.kernel.org/linux-block/20221130135344.2ul4cyfstfs3znxg@quack3/
> > 
> > And underlying disk partition and raid partition can be observed at the
> > same time.
> > 
> > Can you take a look?
> Yes, thanks for the report. I realize that sda1 adn sdb1 is created
> while raid open sda and sdb excl, and I think this problem should exist
> before this patchset.

Looks not reproduced before applying your two patches, that is exactly what Jan
tried to fix with 36369f46e917 ("block: Do not reread partition table on exclusively open device").

The issue is reported by Changhui's block regression test.


Thanks, 
Ming

