Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C690369665B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjBNORf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBNORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:17:33 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6095A24C8F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:17:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E406867373; Tue, 14 Feb 2023 15:10:47 +0100 (CET)
Date:   Tue, 14 Feb 2023 15:10:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@gmail.com, error27@gmail.com, hch@lst.de,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] ubi: block: Fix a possible use-after-free
 bug in ubiblock_create()
Message-ID: <20230214141047.GA13930@lst.de>
References: <20230214093801.1267044-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214093801.1267044-1-harshit.m.mogalapalli@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:38:01AM -0800, Harshit Mogalapalli wrote:
> Smatch warns:
> 	drivers/mtd/ubi/block.c:438 ubiblock_create()
> 	warn: '&dev->list' not removed from list
> 
> 'dev' is freed in 'out_free_dev:, but it is still on the list.
> 
> To fix this, delete the list item before freeing.
> 
> Fixes: 91cc8fbcc8c7 ("ubi: block: set BLK_MQ_F_BLOCKING")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks, this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
