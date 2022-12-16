Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4D64F06A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiLPRcX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Dec 2022 12:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiLPRcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:32:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846D1D0EC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:32:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p6EZB-0001Q6-GC; Fri, 16 Dec 2022 18:32:13 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p6EZ8-004yJk-4f; Fri, 16 Dec 2022 18:32:10 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p6EZ8-000CZO-3B; Fri, 16 Dec 2022 18:32:10 +0100
Message-ID: <354d17d2e1e55b12428fcb50f7cfce9bea81ea29.camel@pengutronix.de>
Subject: Re: [PATCH] media: coda: Add check for dcoda_iram_alloc
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Dec 2022 18:32:09 +0100
In-Reply-To: <20221117065652.44426-1-jiasheng@iscas.ac.cn>
References: <20221117065652.44426-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2022-11-17 at 14:56 +0800, Jiasheng Jiang wrote:
> As the coda_iram_alloc may return NULL pointer,

coda_iram_alloc() may return (phys_addr_t)0, not a NULL pointer.

> it should be better to check the return value
> in order to avoid NULL poineter dereference,
> same as the others.
> 
> Fixes: b313bcc9a467 ("[media] coda: simplify IRAM setup")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/media/platform/chips-media/coda-bit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/chips-media/coda-bit.c b/drivers/media/platform/chips-media/coda-bit.c
> index 2736a902e3df..6d816fd69a17 100644
> --- a/drivers/media/platform/chips-media/coda-bit.c
> +++ b/drivers/media/platform/chips-media/coda-bit.c
> @@ -854,7 +854,7 @@ static void coda_setup_iram(struct coda_ctx *ctx)
>  		/* Only H.264BP and H.263P3 are considered */
>  		iram_info->buf_dbk_y_use = coda_iram_alloc(iram_info, w64);

While this can return 0, if this allocation fails, ...

>  		iram_info->buf_dbk_c_use = coda_iram_alloc(iram_info, w64);

... this one must fail as well.

> -		if (!iram_info->buf_dbk_c_use)

So the buf_dbk_c_use check is enough.

regards
Philipp
