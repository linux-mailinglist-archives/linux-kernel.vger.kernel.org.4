Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6C6652F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 05:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAKEu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 23:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjAKEuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 23:50:55 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F625F9F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 20:50:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 53F5368BEB; Wed, 11 Jan 2023 05:50:32 +0100 (CET)
Date:   Wed, 11 Jan 2023 05:50:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hector Martin <marcan@marcan.st>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Eric Curtin <ecurtin@redhat.com>, Janne Grunau <j@jannau.net>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: Handle shut down controllers during
 initialization
Message-ID: <20230111045032.GA15520@lst.de>
References: <20230111043614.27087-1-marcan@marcan.st> <20230111043614.27087-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111043614.27087-3-marcan@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 01:36:14PM +0900, Hector Martin wrote:
> According to the spec, controllers need an explicit reset to become
> active again after a controller shutdown. Check for this state in
> nvme_enable_ctrl and issue an explicit disable if required, which will
> trigger the required reset.

I don't think this belongs into nvme_enable_ctrl.  It seems like
nvme-apple is missing the equivalent to the nvme_disable_ctrl call
in nvme_pci_configure_admin_queue, though.
