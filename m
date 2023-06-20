Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44622736888
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjFTJ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjFTJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D92708;
        Tue, 20 Jun 2023 02:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB0261191;
        Tue, 20 Jun 2023 09:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF94C433C8;
        Tue, 20 Jun 2023 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687254892;
        bh=MGSj0T3Hz1NmRE+DVfowe7rl9N0DCqQccat2XVjZRvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtv8MPc60KOw1Xt9X0ZVsxqPYN8Y3MnXDedkPZ5urhuVuIIowcoyTrZHGoHXweEqy
         GcT0cuvumPbRgL/+HRi9+8RO8agJY8F5WABI4a/f4vHffiG4YGsPIKw55JU60CkXoI
         VFssdd7kcjPefvsVr5TvONZ32/pAQVaTz4ihcFteeOX5poBaxmPW9Kq8wwao5bAHfC
         yUDUlLl7DNaSYDjnKIL5cOWMeK+phnw27mPnlVOMqUuDD5IoMYHPHPvmgkf29Rbefn
         DEcnwXu4wPR9xHl/7g+03sk3XGB1RfqKxpwErRPeMyOyZ/c8dnoWNhMVx6fiuDINdK
         qWnkC6jetUs+Q==
Date:   Tue, 20 Jun 2023 11:54:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dsterba@suse.com, hare@suse.de,
        jinpu.wang@ionos.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2] block: fix wrong mode for blkdev_get_by_dev()
 from disk_scan_partitions()
Message-ID: <20230620-hektar-ansah-4ab1a6108a82@brauner>
References: <20230618140402.7556-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230618140402.7556-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 10:04:02PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> After commit 2736e8eeb0cc ("block: use the holder as indication for
> exclusive opens"), blkdev_get_by_dev() will warn if holder is NULL and
> mode contains 'FMODE_EXCL'.
> 
> holder from blkdev_get_by_dev() from disk_scan_partitions() is always NULL,
> hence it should not use 'FMODE_EXCL', which is broben by the commit. For
> consequence, WARN_ON_ONCE() will be triggered from blkdev_get_by_dev()
> if user scan partitions with device opened exclusively.
> 
> Fix this problem by removing 'FMODE_EXCL' from disk_scan_partitions(),
> as it used to be.
> 
> Reported-by: syzbot+00cd27751f78817f167b@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=00cd27751f78817f167b
> Fixes: 2736e8eeb0cc ("block: use the holder as indication for exclusive opens")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
