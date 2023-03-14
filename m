Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241016B95D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjCNNRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCNNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:17:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C919EADC34;
        Tue, 14 Mar 2023 06:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EECCB818FF;
        Tue, 14 Mar 2023 13:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBC7C4339B;
        Tue, 14 Mar 2023 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678799640;
        bh=2ZUt1NXLgOTjTAx7wNHlRJpGKUuuaf3lW8mEbMGTGGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxEJ0dFrRRF34KaAyP7K9a1D3/DbnesQpKB0QAybxrexrHR/fhoST3XJExnvUZxXS
         io4WN3TmeUbdRS8v+UJPQi99bycsYarZmRtmksgdhDF076Hj6Rle6F/Pb/eXFIh2Rc
         PNiCrJKCb05Jl+WwSIyJEXY7C65AsFfVz3XFb0DnGVQ8yH7ZpK7y4Yx0ctixnrI/BE
         zruIjfmnIxvKFHQymXyYW4F7f0i1BodEgPl59bQuvjCZ8KG2Uv+vcthHJ9A4Cweb1G
         5oPKedXF2keUMtpMltghVp0bqmoMs+0kt9PFvN4mIovVrUWdfixkInwmhR1NAKj70P
         fcWK00Ye7HcgA==
Date:   Tue, 14 Mar 2023 14:13:56 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] Input: trackpoint - remove unreachable code
Message-ID: <20230314131356.cwb4nd7i43sws75j@intel.intel>
References: <20230314122714.1494260-1-Igor.A.Artemiev@mcst.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314122714.1494260-1-Igor.A.Artemiev@mcst.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Tue, Mar 14, 2023 at 03:27:14PM +0300, Igor Artemiev wrote:
> The trackpoint_sync() function always returnd 0.
> And there is no need to check its result.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2a924d71794c ("Input: trackpoint - only expose supported controls for Elan, ALPS and NXP")
> Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

I don't think it requires the Fixes tag... it's not really
broken.

> ---
>  drivers/input/mouse/trackpoint.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 4a86b3e31d3b..561a4d2d81ff 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -386,9 +386,7 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
>  	was_reset = tp->variant_id == TP_VARIANT_IBM &&
>  		    trackpoint_power_on_reset(&psmouse->ps2dev) == 0;
>  
> -	error = trackpoint_sync(psmouse, was_reset);
> -	if (error)
> -		return error;
> +	trackpoint_sync(psmouse, was_reset);

what worries me here is that if this returns always '0' who tells
me that it will always return '0'?

One day someone might add an error return path and you would miss
it here.

Would it make sense to make the trackpoint_sync() a void function
as well?

Andi

>  
>  	return 0;
>  }
> -- 
> 2.30.2
> 
