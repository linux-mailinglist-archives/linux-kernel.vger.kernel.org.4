Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6C0635113
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiKWH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiKWH2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:28:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9D40926
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:28:13 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oxkAv-0000f7-Fn; Wed, 23 Nov 2022 08:28:05 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oxkAs-00011W-Lt; Wed, 23 Nov 2022 08:28:02 +0100
Date:   Wed, 23 Nov 2022 08:28:02 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Li Hua <hucool.lihua@huawei.com>
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com,
        yusongping@huawei.com
Subject: Re: [PATCH v2] ubifs: Fix build errors as symbol undefined
Message-ID: <20221123072802.GC29978@pengutronix.de>
References: <20221121111847.71648-1-hucool.lihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121111847.71648-1-hucool.lihua@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 07:18:47PM +0800, Li Hua wrote:
> With CONFIG_UBIFS_FS_AUTHENTICATION not set, the compiler can assume that
> ubifs_node_check_hash() is never true and drops the call to ubifs_bad_hash().
> Is CONFIG_CC_OPTIMIZE_FOR_SIZE enabled this optimization does not happen anymore.
> 
> So When CONFIG_UBIFS_FS and CONFIG_CC_OPTIMIZE_FOR_SIZE is enabled but
> CONFIG_UBIFS_FS_AUTHENTICATION is not set, the build errors is as followd:
>     ERROR: modpost: "ubifs_bad_hash" [fs/ubifs/ubifs.ko] undefined!
> 
> Fix it by add no-op ubifs_bad_hash() for the CONFIG_UBIFS_FS_AUTHENTICATION=n case.
> 
> Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
> Signed-off-by: Li Hua <hucool.lihua@huawei.com>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  fs/ubifs/ubifs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 478bbbb5382f..2f1f31581094 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -1623,8 +1623,13 @@ static inline int ubifs_check_hmac(const struct ubifs_info *c,
>  	return crypto_memneq(expected, got, c->hmac_desc_len);
>  }
>  
> +#ifdef CONFIG_UBIFS_FS_AUTHENTICATION
>  void ubifs_bad_hash(const struct ubifs_info *c, const void *node,
>  		    const u8 *hash, int lnum, int offs);
> +#else
> +static inline void ubifs_bad_hash(const struct ubifs_info *c, const void *node,
> +				  const u8 *hash, int lnum, int offs) {};
> +#endif
>  
>  int __ubifs_node_check_hash(const struct ubifs_info *c, const void *buf,
>  			  const u8 *expected);
> -- 
> 2.17.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
