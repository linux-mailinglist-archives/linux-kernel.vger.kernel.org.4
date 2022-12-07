Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC03645EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLGQXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiLGQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:23:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284505288B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:23:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B897D610A4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCB8C433C1;
        Wed,  7 Dec 2022 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670430195;
        bh=5ofuW648j4qVgik7LJj9XY7ye1p2+tfeBtfP6OcjbuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNDs8axrZb0pYmqMNh52GFRMOhbCY4PYZ8VZ2pFZur1DJ3nX6O/zq+q9/ZFjskMaQ
         o8JKVNsTMo9oSdBuZ2/g8JONoKUnhp9f/4MGR+boOcCgjnD98Rey4Yq6MJOff+l0yR
         3peo+CpyPkKqbT4UHfvt3HQ9pt+ZMwdnZUKcFwOQ=
Date:   Wed, 7 Dec 2022 17:23:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aleksandr Burakov <a.burakov@rosalinux.ru>
Cc:     Frank Haverkamp <haver@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] misc: genwqe: card_dev: Array index overflow fix in
 ddcb_cmd_fixups()
Message-ID: <Y5C98NpQr2G1bkvs@kroah.com>
References: <20221207141808.22922-1-a.burakov@rosalinux.ru>
 <20221207141808.22922-2-a.burakov@rosalinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207141808.22922-2-a.burakov@rosalinux.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 05:18:08PM +0300, Aleksandr Burakov wrote:
> &cmd->asiv of size 96 can overflow because its index (asiv_offs + 8)
> can be equal to 96 (0x58 + 0x08) that is out of range.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> Fixes: eaf4722d4645 ("GenWQE Character device and DDCB queue")
> ---
>  drivers/misc/genwqe/card_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
> index 55fc5b80e649..d58ce2622307 100644
> --- a/drivers/misc/genwqe/card_dev.c
> +++ b/drivers/misc/genwqe/card_dev.c
> @@ -867,7 +867,7 @@ static int ddcb_cmd_fixups(struct genwqe_file *cfile, struct ddcb_requ *req)
>  	struct genwqe_ddcb_cmd *cmd = &req->cmd;
>  	struct dma_mapping *m;
>  
> -	for (i = 0, asiv_offs = 0x00; asiv_offs <= 0x58;
> +	for (i = 0, asiv_offs = 0x00; asiv_offs < 0x58;
>  	     i++, asiv_offs += 0x08) {
>  
>  		u64 u_addr;
> -- 
> 2.25.1
> 

Where is patch 1/2 of this series?
