Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08326695FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjBNJsR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Feb 2023 04:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBNJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:47:47 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8061F5C7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:47:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 23131642ECB2;
        Tue, 14 Feb 2023 10:47:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id swn-jqLBS7hb; Tue, 14 Feb 2023 10:47:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C36D6642ECCC;
        Tue, 14 Feb 2023 10:47:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uXkoR1TOLuRd; Tue, 14 Feb 2023 10:47:41 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9F80B642ECB2;
        Tue, 14 Feb 2023 10:47:41 +0100 (CET)
Date:   Tue, 14 Feb 2023 10:47:41 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     harshit m mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit m mogalapalli <harshit.m.mogalapalli@gmail.com>,
        error27@gmail.com, hch <hch@lst.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2138680093.127537.1676368061456.JavaMail.zimbra@nod.at>
In-Reply-To: <20230214093801.1267044-1-harshit.m.mogalapalli@oracle.com>
References: <20230214093801.1267044-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH linux-next] ubi: block: Fix a possible use-after-free
 bug in ubiblock_create()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: Fix a possible use-after-free bug in ubiblock_create()
Thread-Index: iOg5GBWw/6+vOMMkTA/Bpi1ap7bSZw==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "harshit m mogalapalli" <harshit.m.mogalapalli@oracle.com>
> Smatch warns:
>	drivers/mtd/ubi/block.c:438 ubiblock_create()
>	warn: '&dev->list' not removed from list
> 
> 'dev' is freed in 'out_free_dev:, but it is still on the list.
> 
> To fix this, delete the list item before freeing.
> 
> Fixes: 91cc8fbcc8c7 ("ubi: block: set BLK_MQ_F_BLOCKING")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Found by static analysis(smatch). Only Compile tested.
> ---
> drivers/mtd/ubi/block.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index f5d036203fe7..763704c8d05c 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -429,6 +429,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
> 	return 0;
> 
> out_remove_minor:
> +	list_del(&dev->list);
> 	idr_remove(&ubiblock_minor_idr, gd->first_minor);
> out_cleanup_disk:
> 	put_disk(dev->gd);

Good catch!

Thanks,
//richard
