Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD11739622
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjFVEH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjFVEH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:07:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A2FE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 21:07:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33A7D68AFE; Thu, 22 Jun 2023 05:57:53 +0200 (CEST)
Date:   Thu, 22 Jun 2023 05:57:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, leit@fb.com,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Message-ID: <20230622035753.GA4736@lst.de>
References: <20230615094903.1341683-1-leitao@debian.org> <ZJMpWaMxKMFE8hmK@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJMpWaMxKMFE8hmK@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:46:17AM -0600, Keith Busch wrote:
> On Thu, Jun 15, 2023 at 02:49:03AM -0700, Breno Leitao wrote:
> >  	if (effects & NVME_CMD_EFFECTS_CCC) {
> > -		dev_info(ctrl->device,
> > +		if (!test_and_set_bit(NVME_CTRL_DIRTY_CAPABILITY,
> > +				      &ctrl->flags)) {
> > +			dev_info(ctrl->device,
> >  "controller capabilities changed, reset may be required to take effect.\n");
> > +		}
> >  	}
> 
> Thanks, patch applied to nvme-6.5.
> 
> A question for Christoph and future consideration: I *think* the
> complications that had the driver stop refreshing the controller
> attributes are largely mitigated by the fact we now handle effects
> after the request is freed. Perhaps I'm missing something. Is there
> a risk in just bringing that feature back into the driver?

No, the main issue was and is that we can't just call
nvme_init_ctrl_finish on a live controller.
