Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D15B654B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIMB4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIMB4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF88B52466
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663034172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H19OXg6EPz5UTCCwATfQC0KcwPAzRjXZ1tHwdeetkOA=;
        b=TerZ5sd+ajCOrw8iY9glyw0wJ7nr8OFOsy8nXZZJqqWf3dzLRrNEcxonvV55c6x4xg3u/s
        9y15XwPB/+xEbwzNgbG+nDNKS1OogEr8zBOfsLtFhtfo6m30woTNdGeGaBhliZKfW+cgZp
        +dzbGTKFdycVd/g39lwqULjJLT9aP5w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-iPiUOx5dNDOBcDUyHR6stQ-1; Mon, 12 Sep 2022 21:56:09 -0400
X-MC-Unique: iPiUOx5dNDOBcDUyHR6stQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7050E38164C1;
        Tue, 13 Sep 2022 01:56:08 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42F19C15BA4;
        Tue, 13 Sep 2022 01:56:02 +0000 (UTC)
Date:   Tue, 13 Sep 2022 09:55:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dusty Mabe <dusty@dustymabe.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <Yx/jLTknQm9VeHi4@T590>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590>
 <20220907073324.GB23826@lst.de>
 <Yxr4SD4d0rZ9TZik@T590>
 <20220912071618.GA4971@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912071618.GA4971@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 09:16:18AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 09, 2022 at 04:24:40PM +0800, Ming Lei wrote:
> > On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
> > > On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
> > > > It is a bit hard to associate the above commit with reported issue.
> > > 
> > > So the messages clearly are about something trying to open a device
> > > that went away at the block layer, but somehow does not get removed
> > > in time by udev (which seems to be a userspace bug in CoreOS).  But
> > > even with that we really should not hang.
> > 
> > Xiao Ni provides one script[1] which can reproduce the issue more or less.
> 
> I've run the reproduced 10000 times on current mainline, and while
> it prints one of the autoloading messages per run, I've not actually
> seen any kind of hang.

I can't reproduce the hang too.

What I meant is that new raid disk can be added by mdadm after stopping
the imsm container and raid disk with the autoloading messages printed,
I understand this behavior isn't correct, but I am not familiar with
raid enough.

It might be related with the delay deleting gendisk from wq & md kobj
release handler.

During reboot, if mdadm does this stupid thing without stopping, the hang
could be caused.

I think the root cause is that why mdadm tries to open/add new raid bdev
crazily during reboot.


Thanks, 
Ming

