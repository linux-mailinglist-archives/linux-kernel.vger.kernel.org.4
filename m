Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395B2631113
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 22:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiKSVRP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Nov 2022 16:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSVRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 16:17:12 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD37193CD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 13:17:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5A59D63E515F;
        Sat, 19 Nov 2022 22:17:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IO2Ydp7Ofn7w; Sat, 19 Nov 2022 22:17:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E79A863E516F;
        Sat, 19 Nov 2022 22:17:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YWV5Vh889S7e; Sat, 19 Nov 2022 22:17:07 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C6E6363E515F;
        Sat, 19 Nov 2022 22:17:07 +0100 (CET)
Date:   Sat, 19 Nov 2022 22:17:07 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        eorge kennedy <eorge.kennedy@oracle.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        syzkaller@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        harshit m mogalapalli <harshit.m.mogalapalli@oracle.com>
Message-ID: <1124560008.256167.1668892627774.JavaMail.zimbra@nod.at>
In-Reply-To: <ae901608-0580-010a-26e3-99d0b704b88b@oracle.com>
References: <ae901608-0580-010a-26e3-99d0b704b88b@oracle.com>
Subject: Re: [PATCH] ubi: ensure that VID header offset + VID header size <=
 alloc, size
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ensure that VID header offset + VID header size <= alloc, size
Thread-Index: 6xZXY6I9/ykjqNmmj3iJooHYp5bcjg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Fixes: 801c135ce73d ("UBI: Unsorted Block Images")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>  drivers/mtd/ubi/build.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index a32050fecabf..53aa4de6b963 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -663,6 +663,12 @@ static int io_init(struct ubi_device *ubi, int
> max_beb_per1024)
>  	ubi->ec_hdr_alsize = ALIGN(UBI_EC_HDR_SIZE, ubi->hdrs_min_io_size);
>  	ubi->vid_hdr_alsize = ALIGN(UBI_VID_HDR_SIZE, ubi->hdrs_min_io_size);
>  
> +	if (ubi->vid_hdr_offset && ((ubi->vid_hdr_offset + UBI_VID_HDR_SIZE) >
> +	    ubi->vid_hdr_alsize)) {
> +		ubi_err(ubi, "VID header offset %d too large.", ubi->vid_hdr_offset);
> +		return -EINVAL;
> +	}
> +

Thanks for fixing this, applied to the fixes branch.
That said, something broke whitespaces in your patch, I applied it manually.
Context lines before and after contain an extra space and caused both
git am and patch to give up.

Thanks,
//richard
