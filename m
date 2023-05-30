Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284F571529F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE3AoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjE3AoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:44:07 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B96D6D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:44:05 -0700 (PDT)
Received: (qmail 389211 invoked by uid 1000); 29 May 2023 20:44:05 -0400
Date:   Mon, 29 May 2023 20:44:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Revert "Revert "usb: gadget: udc: core: Prevent
 redundant calls to pullup""
Message-ID: <224b6dd7-03e4-4d49-8dca-d13619367371@rowland.harvard.edu>
References: <20230529234816.3720623-1-badhri@google.com>
 <20230529234816.3720623-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529234816.3720623-2-badhri@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:48:15PM +0000, Badhri Jagan Sridharan wrote:
> This reverts commit 5e1617210aede9f1b91bb9819c93097b6da481f9.
> 
> The regression reported in
> https://lore.kernel.org/all/ZF4bMptC3Lf2Hnee@gerhold.net/ is being
> fixed in
> commit 7d7863db7cc0 ("usb: gadget: udc: core: Offload usb_udc_vbus_handler processing").
> Hence reverting the revert.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/gadget/udc/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 583c339876ab..4641153e9706 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -703,6 +703,9 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
>  		goto out;
>  	}
>  
> +	if (gadget->connected)
> +		goto out;
> +
>  	if (gadget->deactivated || !gadget->udc->started) {
>  		/*
>  		 * If gadget is deactivated we only save new state.

This is silly.  There's no need to make this a separate commit; it 
should be merged in with the preceding patch.  There's no good reason 
for creating a commit that contains a known error.

Alan Stern
