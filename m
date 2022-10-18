Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67B760322C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJRSSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJRSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:18:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DF7E02C;
        Tue, 18 Oct 2022 11:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E708B820EE;
        Tue, 18 Oct 2022 18:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F01C433D7;
        Tue, 18 Oct 2022 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666117084;
        bh=mYGOGutZ4Vo9ucN0Lly1KgID1pVGbynxDNJ2SMsrc98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWRBtFwibDL7vA8S9et14vdl9j53tVVFgZ4kXgQbNRnI7sUffRFTXNaoMeslrqmed
         qkner6nvIaNLRwWzTeIH4MPGXkESN45eZCBWc7ioNMNkyXK/R1YgNBozf+vedJRTT0
         GkS3AKvn18CwSWywZEXs2JkTuZ0RcpipBI72oijQ=
Date:   Tue, 18 Oct 2022 20:18:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, willy@infradead.org,
        martin.petersen@oracle.com, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC 1/2] kobject: add return value for kobject_put()
Message-ID: <Y07t2agdfUeujGE/@kroah.com>
References: <20221018131432.434167-1-yukuai3@huawei.com>
 <20221018131432.434167-2-yukuai3@huawei.com>
 <Y06je6LiDicUfzto@kroah.com>
 <2f962069-8fd9-08df-aa00-062b94569c36@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f962069-8fd9-08df-aa00-062b94569c36@huaweicloud.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:12:08PM +0800, Yu Kuai wrote:
> 
> 
> 在 2022/10/18 21:00, Greg KH 写道:
> > On Tue, Oct 18, 2022 at 09:14:31PM +0800, Yu Kuai wrote:
> > > The return value will be used in later patch to fix uaf for slave_dir
> > > and bd_holder_dir in block layer.
> > 
> > Then the user will be incorrect, this is not ok, you should never care
> > if you are the last "put" on an object at all.  Hint, what happens right
> > after you call this and get the result?
> > 
> 
> I tried to reset the pointer to NULL in patch 2 to prevent uaf.

That is not ok, sorry.

> And the
> whole kobject_put() and pointer reset is protected by a mutex, the mutex
> will be used on the reader side before kobject_get as well. So, in fact,
> I'm protecting them by the mutex...

Still not ok.  You never know who else has a reference on a kobject,
that's the point of reference counted objects.

> I can bypass it by using another reference anyway. But let's see if
> anyone has suggestions on the other patch.
> 
> > sorry, but NAK.
> 
> I know the best way is too refactor the lifecycle of the problematic
> bd_holder_dir/slave_dir, however, I gave that up because this seems
> quite complicated and influence is very huge...

Please fix it up properly, core changes like this should not be needed.

thanks,

greg k-h
