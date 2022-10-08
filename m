Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17D5F83FD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJHHZT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 8 Oct 2022 03:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJHHZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:25:16 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930827FEE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:25:12 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 05AC3160B3B;
        Sat,  8 Oct 2022 07:25:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id D2DD435;
        Sat,  8 Oct 2022 07:24:38 +0000 (UTC)
Message-ID: <0d4febb49ddbae9cd99606a89573a7c832ed0965.camel@perches.com>
Subject: Re: [PATCH v3 1/3] mtd: mtdoops: change printk() to counterpart pr_
 functions
From:   Joe Perches <joe@perches.com>
To:     Ray Zhang <sgzhang@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 08 Oct 2022 00:25:07 -0700
In-Reply-To: <20221007215027.918507-2-sgzhang@google.com>
References: <20221007215027.918507-1-sgzhang@google.com>
         <20221007215027.918507-2-sgzhang@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: rdikuhra3hm9gs98uoatqnofhgfoncdf
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D2DD435
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19E8nTRCD3VMc7PJ9/fiVjjdDZbWqk09gY=
X-HE-Tag: 1665213878-381622
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-07 at 21:50 +0000, Ray Zhang wrote:
> To comply with latest kernel code requirement, change printk() to
> counterpart pr_ functions in mtdoops driver:
> - change printk(INFO) to pr_info()
> - change printk(DEBUG) to pr_debug()
> - change printk(WARNING) to pr_warn()
> - change printk(ERR) to pr_err()
> 
> Note that only if dynamic debugging is enabled or DEBUG is defined,
> printk(KERN_DEBUG) and pr_debug() are equivalent; Otherwise pr_debug()
> is no-op, causing different behavior.

Another thing possible is to add

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

before any #include

> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
[]
> @@ -93,9 +93,9 @@ static int mtdoops_erase_block(struct mtdoops_context *cxt, int offset)
>  
>  	ret = mtd_erase(mtd, &erase);
>  	if (ret) {
> -		printk(KERN_WARNING "mtdoops: erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
> -		       (unsigned long long)erase.addr,
> -		       (unsigned long long)erase.len, mtddev);
> +		pr_warn("mtdoops: erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
> +			(unsigned long long)erase.addr,
> +			(unsigned long long)erase.len, mtddev);

And remove the "mtdoops: " prefixes from all the output formats

		pr_warn("erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
			(unsigned long long)erase.addr,
			(unsigned long long)erase.len, mtddev);

> @@ -120,8 +120,8 @@ static void mtdoops_inc_counter(struct mtdoops_context *cxt)
>  		return;
>  	}
>  
> -	printk(KERN_DEBUG "mtdoops: ready %d, %d (no erase)\n",
> -	       cxt->nextpage, cxt->nextcount);
> +	pr_debug("mtdoops: ready %d, %d (no erase)\n",
> +		 cxt->nextpage, cxt->nextcount);

	pr_debug("ready %d, %d (no erase)\n", cxt->nextpage, cxt->nextcount);

etc...

