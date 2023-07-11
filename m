Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E374F790
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjGKRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGKRxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:53:55 -0400
X-Greylist: delayed 3604 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 10:53:53 PDT
Received: from 3.mo560.mail-out.ovh.net (3.mo560.mail-out.ovh.net [46.105.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB64E55
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:53:53 -0700 (PDT)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.156.34])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 45B7327947
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:37:44 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-4bbwg (unknown [10.110.171.111])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9A90E1FE8B;
        Tue, 11 Jul 2023 16:37:42 +0000 (UTC)
Received: from RCM-web10.webmail.mail.ovh.net ([151.80.29.18])
        by ghost-submission-6684bf9d7b-4bbwg with ESMTPSA
        id wnZYIlaFrWQzBQAAcMPekA
        (envelope-from <rafal@milecki.pl>); Tue, 11 Jul 2023 16:37:42 +0000
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 18:37:42 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Yang Rong <yangrong@vivo.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: Re: [PATCH v3] mtd: core: Fix resource leak in a
 for_each_child_of_node() loop
In-Reply-To: <20230711020752.2344-1-yangrong@vivo.com>
References: <20230711020752.2344-1-yangrong@vivo.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ffc8f6162a863179f88304ed8801d44f@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9608429805198093183
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefghfeuiefhiedttedtheefhfeifeffveekvdegteetkeetjedtiedvvdfhgfffffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdduhedurdektddrvdelrddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-11 04:03, Yang Rong wrote:
> Ensure child node references are properly decremented in the error path
>   of this function implementation.

Nitpicking: it's actually a /success/ code path that misses
of_node_put().


> Fixes: 2df11f00100d ("mtd: core: try to find OF node for every MTD 
> partition")
> Signed-off-by: Yang Rong <yangrong@vivo.com>

Acked-by: Rafał Miłecki <rafal@milecki.pl>


> ---
> v2: 
> https://lore.kernel.org/all/20230710061412.2272-1-yangrong@vivo.com/
> The modifications made copared to the previous version are as follows:
> 1.Optimized the expression of the Subject, making it more accurate.
> 2.Optimized the content of the commit message.
> 3.Add the tag "Fixes".
> 
>  drivers/mtd/mtdcore.c | 1 +
>  1 file changed, 1 insertion(+)
>  mode change 100644 => 100755 drivers/mtd/mtdcore.c
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index e00b12aa5ec9..b02cb8b1a38d
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -591,6 +591,7 @@ static void mtd_check_of_node(struct mtd_info *mtd)
>  		if (plen == mtd_name_len &&
>  		    !strncmp(mtd->name, pname + offset, plen)) {
>  			mtd_set_of_node(mtd, mtd_dn);
> +			of_node_put(mtd_dn);
>  			break;
>  		}
>  	}
