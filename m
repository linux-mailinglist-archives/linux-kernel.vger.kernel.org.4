Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B086150A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKAR1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKAR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:27:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74371BEA0;
        Tue,  1 Nov 2022 10:27:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 616CC6732D; Tue,  1 Nov 2022 18:27:20 +0100 (CET)
Date:   Tue, 1 Nov 2022 18:27:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] blk-mq: update comment for
 blk_mq_quiesce_queue_nowait()
Message-ID: <20221101172720.GA20526@lst.de>
References: <cover.1667314759.git.nickyc975@zju.edu.cn> <489a9322eed1f95f8770752cc715084f1fa961d3.1667314759.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489a9322eed1f95f8770752cc715084f1fa961d3.1667314759.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:11:34PM +0800, Jinlong Chen wrote:
> blk_mq_quiesce_queue_nowait() is now reasonably used by scsi_host_block()
> to avoid calling synchronize_rcu() for each LUN. We should not consider to
> remove it.

I strongly disagree about this being a reasonable use.  What SCSI did
there is a horrible hack that should have never been merged.  The
right thing to do is the per-tag_set quiesce that we've been working
on.
