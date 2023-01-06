Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D566001C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjAFMSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjAFMSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:18:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FBE736D7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:18:24 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pDlfs-0004id-1I; Fri, 06 Jan 2023 13:18:16 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pDlfr-00060i-Gv; Fri, 06 Jan 2023 13:18:15 +0100
Date:   Fri, 6 Jan 2023 13:18:15 +0100
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: Handle LPT corruption better in
 ubifs_garbage_collect_leb()
Message-ID: <20230106121815.GA20604@pengutronix.de>
References: <20180704140230.5606-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704140230.5606-1-richard@nod.at>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
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

Hi Richard,

On Wed, Jul 04, 2018 at 04:02:30PM +0200, Richard Weinberger wrote:
> If ubifs_garbage_collect_leb() notes a LPT problem, empty LEB, but
> LPT has it makred as used, an ubifs_assert() is not enough.
> We have to abort GC. Otherwise list_entry() returns an invalid
> scan object and the kernel crashes.
> 
> c: <stable@vger.kernel.org>
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/ubifs/gc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

What happened to this patch? It never made it anywhere. I just stumbled
over this issue and found this patch afterwards.

> 
> diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
> index a03a47cf880d..11c09ce3c795 100644
> --- a/fs/ubifs/gc.c
> +++ b/fs/ubifs/gc.c
> @@ -513,7 +513,13 @@ int ubifs_garbage_collect_leb(struct ubifs_info *c, struct ubifs_lprops *lp)
>  	if (IS_ERR(sleb))
>  		return PTR_ERR(sleb);
>  
> -	ubifs_assert(!list_empty(&sleb->nodes));
> +	if (list_empty(&sleb->nodes)) {
> +		ubifs_err(c, "Bad accouting information, LEB %i is marked as used but no nodes found!",
> +			  lnum);
> +		dump_stack();
> +		return -EUCLEAN;
> +	}

This changes the behaviour. With ubifs_assert() UBIFS goes readonly, but
with this change it stays rw. Is this intended?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
