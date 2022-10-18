Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52E4602C48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJRNAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJRNAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE40E27CD4;
        Tue, 18 Oct 2022 06:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4928E6153C;
        Tue, 18 Oct 2022 13:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B199C433C1;
        Tue, 18 Oct 2022 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666098045;
        bh=9mCwQDMxzukwjgNJrJ/kqAbnhGTEPmzbhDbM9GD+mlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0D2BNi1dW/pbcc052oKEXurvbiajjF1DYqHssCDm/qLWmjTVOXjzwfOTVXVYI109
         mqQeo8yIRVbcNPraeOgTJxJoc4Vw0rtBD94PKjAZZgme8tbc7ZfhQVuD1mNkZRw95M
         mnflV9oLt/t+gLmQWLu//p96YfucjRS4ePR1JLnQ=
Date:   Tue, 18 Oct 2022 15:00:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@lst.de, axboe@kernel.dk, willy@infradead.org,
        martin.petersen@oracle.com, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: Re: [PATCH RFC 1/2] kobject: add return value for kobject_put()
Message-ID: <Y06je6LiDicUfzto@kroah.com>
References: <20221018131432.434167-1-yukuai3@huawei.com>
 <20221018131432.434167-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018131432.434167-2-yukuai3@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:14:31PM +0800, Yu Kuai wrote:
> The return value will be used in later patch to fix uaf for slave_dir
> and bd_holder_dir in block layer.

Then the user will be incorrect, this is not ok, you should never care
if you are the last "put" on an object at all.  Hint, what happens right
after you call this and get the result?

sorry, but NAK.

greg k-h
