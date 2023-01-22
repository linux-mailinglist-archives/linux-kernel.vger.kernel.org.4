Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822EE67718A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjAVScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVSb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:31:59 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878B91BAC3;
        Sun, 22 Jan 2023 10:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674412311; bh=pZYbLu9bebSDoKCfGEX/1j8ZiKjZCw98agjNII8NLOg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=PWKBOAlZOjhTTbujYkNjnQkKBNnXvzcZ3tCmC+epFMVB+r/gNaAnf+z/vlR2jscEA
         GEFxln74sDkfpNIAlxm/RiOTT4rL0p6tjCdp5UUq0/3VQPVUpkp+2RvKcbNcYdjzQ0
         c1MnQ3XY8KeaAJMWxIowYRC/zEfCibzUf5RhfUN4=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 19:31:51 +0100 (CET)
X-EA-Auth: pYwFouFgiBnqX63s88Aa0Ha28O8LCr5CKpkGpHy24mru8pIgBhbNa7r97GyK7VfP0PVzzaqSl/UozqzDarSzIZgyU/4aDhQq
Date:   Mon, 23 Jan 2023 00:01:48 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: csiostor: use *ptr instead of ptr with sizeof
Message-ID: <Y82BFDTF0cQC/goK@ubun2204.myguest.virtualbox.org>
References: <Y7/8VUXJSFXTpYlz@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7/8VUXJSFXTpYlz@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 05:55:57PM +0530, Deepak R Varma wrote:
> The function csio_enqueue_evt() should be passed the actual length of
> the event/message so that it can be fully copied over to the event
> queue. Use the sizeof(*ptr) to get the real message length instead of
> sizeof(ptr).
> Issue identified using the noderef,cocci coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
Requesting a review and feedback comments on this patch proposal please.

Thank you,
./drv

> Please note: The change is compile tested only.
> 
>  drivers/scsi/csiostor/csio_mb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_mb.c b/drivers/scsi/csiostor/csio_mb.c
> index 94810b19e747..4df8a4df4408 100644
> --- a/drivers/scsi/csiostor/csio_mb.c
> +++ b/drivers/scsi/csiostor/csio_mb.c
> @@ -1551,7 +1551,7 @@ csio_mb_isr_handler(struct csio_hw *hw)
>  		 * Enqueue event to EventQ. Events processing happens
>  		 * in Event worker thread context
>  		 */
> -		if (csio_enqueue_evt(hw, CSIO_EVT_MBX, mbp, sizeof(mbp)))
> +		if (csio_enqueue_evt(hw, CSIO_EVT_MBX, mbp, sizeof(*mbp)))
>  			CSIO_INC_STATS(hw, n_evt_drop);
>  
>  		return 0;
> -- 
> 2.34.1
> 
> 
> 


