Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145D35B5537
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiILHTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiILHSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:18:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A0F31DC2;
        Mon, 12 Sep 2022 00:16:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5EA96732D; Mon, 12 Sep 2022 09:16:18 +0200 (CEST)
Date:   Mon, 12 Sep 2022 09:16:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Dusty Mabe <dusty@dustymabe.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <20220912071618.GA4971@lst.de>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com> <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de> <Yxr4SD4d0rZ9TZik@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxr4SD4d0rZ9TZik@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:24:40PM +0800, Ming Lei wrote:
> On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
> > On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
> > > It is a bit hard to associate the above commit with reported issue.
> > 
> > So the messages clearly are about something trying to open a device
> > that went away at the block layer, but somehow does not get removed
> > in time by udev (which seems to be a userspace bug in CoreOS).  But
> > even with that we really should not hang.
> 
> Xiao Ni provides one script[1] which can reproduce the issue more or less.

I've run the reproduced 10000 times on current mainline, and while
it prints one of the autoloading messages per run, I've not actually
seen any kind of hang.
