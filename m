Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055E6750979
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjGLNTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGLNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:19:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D5E65;
        Wed, 12 Jul 2023 06:19:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67AE967373; Wed, 12 Jul 2023 15:19:25 +0200 (CEST)
Date:   Wed, 12 Jul 2023 15:19:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <20230712131925.GA14596@lst.de>
References: <20230712125455.1986455-1-ming.lei@redhat.com> <20230712125455.1986455-2-ming.lei@redhat.com> <20230712130017.GA12417@lst.de> <ZK6nm2koR+TfeMcs@ovpn-8-25.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK6nm2koR+TfeMcs@ovpn-8-25.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:16:11PM +0800, Ming Lei wrote:
> The problem is that blk_mq_alloc_tag_set() forces to set nr_hw_queues
> as 1 for kdump kernel, that is why blk_mq_max_nr_hw_queues() has to
> return 1 for kdump kernel.

Well, let's fix that first and work from there.  Same argument against
that deep magic applies there as well.

> Thomas, can we disable managed irq for kdump kernel and switch to
> non-managed irq? Then we can avoid driver's change. I'd suggest
> this way if it is possible.

Why the heck would we?

