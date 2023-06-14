Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD672F3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242698AbjFNFBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjFNFBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:01:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1510C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:01:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8934867373; Wed, 14 Jun 2023 07:01:02 +0200 (CEST)
Date:   Wed, 14 Jun 2023 07:01:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, leit@fb.com,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Print capabilities changes just once
Message-ID: <20230614050102.GA10740@lst.de>
References: <20230613175538.331639-1-leitao@debian.org> <ZIjnGiMbih0sjn3g@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjnGiMbih0sjn3g@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:00:58PM -0600, Keith Busch wrote:
> On Tue, Jun 13, 2023 at 10:55:37AM -0700, Breno Leitao wrote:
> > This current dev_info() could be very verbose and being printed very
> > frequently depending on some userspace application sending some specific
> > commands.
> > 
> > Let's turn it into a dev_info_once(), since it is not useful to know
> > about it all the time.
> 
> This looks good to me. Vendors sometimes put unnecessary effects in the
> log, and spamming the same recommendation to repeated operations isn't
> going to be helpful. I expect anyone who knows what they're doing can
> consult the effects log directly and take appropriate action on their
> own.

Hmm, once seems very little.  It might make more sense to do this
once and then skip it until the controller has been reset.
