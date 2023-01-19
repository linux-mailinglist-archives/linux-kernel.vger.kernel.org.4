Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75C6731A2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjASGP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjASGPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:15:00 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D73F656FD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:14:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 657DC67373; Thu, 19 Jan 2023 07:14:53 +0100 (CET)
Date:   Thu, 19 Jan 2023 07:14:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Janne Grunau <j@jannau.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
Message-ID: <20230119061452.GA17695@lst.de>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net> <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net> <20230118052450.GA24742@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118052450.GA24742@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, can you chime in if this comment makes sense?  I'd really
like to send the patches off to Jens before rc5.

On Wed, Jan 18, 2023 at 06:24:50AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 07:25:00PM +0100, Janne Grunau wrote:
> > +		/*
> > +		 * Always reset the NVMe controller on shutdown. The reset is
> > +		 * required to shutdown the co-processor cleanly.
> > +		 */
> 
> Hmm.  This comment doesn't seem to match the discussion we had last
> week.  Which would be:
> 
> 		/*
> 		 * NVMe requires a reset before setting up a controller to
> 		 * ensure it is in a clean state.  For NVMe PCIe this is
> 		 * done in the setup path to be able to deal with controllers
> 		 * in any kind of state.  For for Apple devices, the firmware
> 		 * will not be available at that time and the reset will
> 		 * time out.  Thus reset after shutting the NVMe controller
> 		 * down and before shutting the firmware down.
> 		 */
---end quoted text---
