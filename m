Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45572A945
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 08:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjFJGGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 02:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFJGGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 02:06:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38A33AA7;
        Fri,  9 Jun 2023 23:06:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E611D68BEB; Sat, 10 Jun 2023 08:06:26 +0200 (CEST)
Date:   Sat, 10 Jun 2023 08:06:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: Re: [RFC] block: relax permission for Persistent Reservations ioctl
Message-ID: <20230610060626.GA1595@lst.de>
References: <20230609102122.118800-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609102122.118800-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 06:21:22PM +0800, Jingbo Xu wrote:
> When the shared storage is accessed from containers [1], it's not
> recommended to grant CAP_SYS_ADMIN to containers for access to
> Persistent Reservations in risk of container escape.
> 
> Remove the extra CAP_SYS_ADMIN permission constraint for Persistent
> Reservations ioctl which shall do no harm [2].

I think we still to check that if CAP_SYS_ADMIN is not present,
the file descriptors needs to be open for write, and we're not called
on a partition (the latter should probbaly be always checked,
as a reservation for a partitions doesn't make sense).

But in general I think relaxing this is a good idea, we just need to
be very careful.  Looking at the discussion of unprivileged nvme
command passthrough might be a good start.
