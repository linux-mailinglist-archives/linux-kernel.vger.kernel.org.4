Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903BF6025F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJRHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJRHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:39:11 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97907A1AE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iW9dXL6VFX/U4TvJJVvpq8/X1w2S20KxSchfam1Hs/I=;
  b=sANx5wj9qEbJsr5P67y520bH84o3V6fM0LNWliWh59HmK6/+6EJcekLY
   ONuwfn0XYvq/neCzp0nTSfZJtH8YgwlIYiO814SjZ/wachGPzKzIFRT6K
   T58yYGewXbGhC51ytYXcw1wKDjyWDN0D5aq2fx6TmJmsaLXIUN6pwgtF8
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,193,1661810400"; 
   d="scan'208";a="65642959"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 09:39:08 +0200
Date:   Tue, 18 Oct 2022 09:39:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH v2] staging: most: dim2: read done_buffers count locally
 from HDM channel
In-Reply-To: <Y05TNQBXLMJMgQ2r@debian-BULLSEYE-live-builder-AMD64>
Message-ID: <1e2a71a9-4ac5-96f3-b875-a063ff62f3ad@inria.fr>
References: <Y05TNQBXLMJMgQ2r@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Oct 2022, Deepak R Varma wrote:

> The done_buffer count is already available in the hdm_channel struct.
> Calling dim_get_channel_state function to source this value out of
> the same structure is unnecessary.
> Further, the second parameter struct dim_ch_state_t to this function
> is filled by using the hdm_channel inside the function. This filled in
> variable is never used in the caller and can be altogether removed.
> So, a call to dim_get_channel_state function in this context also
> deems expensive.

Thanks for the rewrite.

I find "source this value out of" hard to understand.

I would have written something like the following:

The function dim_get_channel_state only serves to initialize the ready and
done_buffers fields of the structure passed as its second argument.  In
service_done_flag, this structure is never used again and the only purpose
of the call is to get the value that is put in the done_buffers field.
But that value is just the done_sw_buffers_number field of the call's
first argument.  So the whole call is useless, and we can just replace it
with an access to this field.

This change implies that the variable st is no longer used, so drop it as
well.

---

If you want to work some more in this code, the name of the type
dim_ch_state_t should not have an _t at the end of it.  It looks like it
used to be a typedef and someone eliminated the typedef but didn't drop
the _t.

julia


>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v2:
>    1. Update patch log message to be more descriptive about the reason for change.
>       Feedback provided by julia.lawall@inria.fr
>
> PLEASE NOTE: I have only built the module on my machine, but have not tested it.
> I am not sure how to test this change. I am willing to test it with appropriate
> guidance provided I have the necessary hardware.
>
>
>  drivers/staging/most/dim2/dim2.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> index ab72e11ac5ab..4c1f27898a29 100644
> --- a/drivers/staging/most/dim2/dim2.c
> +++ b/drivers/staging/most/dim2/dim2.c
> @@ -259,7 +259,6 @@ static void retrieve_netinfo(struct dim2_hdm *dev, struct mbo *mbo)
>  static void service_done_flag(struct dim2_hdm *dev, int ch_idx)
>  {
>  	struct hdm_channel *hdm_ch = dev->hch + ch_idx;
> -	struct dim_ch_state_t st;
>  	struct list_head *head;
>  	struct mbo *mbo;
>  	int done_buffers;
> @@ -271,7 +270,7 @@ static void service_done_flag(struct dim2_hdm *dev, int ch_idx)
>
>  	spin_lock_irqsave(&dim_lock, flags);
>
> -	done_buffers = dim_get_channel_state(&hdm_ch->ch, &st)->done_buffers;
> +	done_buffers = hdm_ch->ch.done_sw_buffers_number;
>  	if (!done_buffers) {
>  		spin_unlock_irqrestore(&dim_lock, flags);
>  		return;
> --
> 2.30.2
>
>
>
>
>
