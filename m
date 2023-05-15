Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B900F702AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbjEOLBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjEOLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E5BC;
        Mon, 15 May 2023 04:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3AA862273;
        Mon, 15 May 2023 11:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ABCC433EF;
        Mon, 15 May 2023 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148472;
        bh=UTbvYUhLcNZvirRlxEQga14BRUkmwMsNPRm1uplVRsE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P34Jw2sTEWyH43s0Ac/gRJpFjocUKaGbC38G8e9eh7/5zlB6Gud0RgsCKs+1uDlG9
         oEMRokPgUwFGHwHRY7PO9vtulftH8dYrKOgL9T0eh7I96Up4hd8ebQhtix4lZyhTgX
         pOdq5UkNU4p00x47cKk3F3bE17JmDCS7fgo1bzGJGLIPF2MhCSsQfiS8SkIT/g11Ld
         x63W57dXqMMxve+cvfznWOhYMtWDZjcMEDQiRg7CRtExUdFGZCi202BeduWkbZRW6O
         r40arJPKGWvJJHZLGiO1bQscDGc1HVkM1BR5UzMoxdK3tMHXPFg1dFLU0ghzGqY0oP
         /Ndkg7PMfC0QQ==
Message-ID: <5082d743-54b1-7b4c-432c-dfdce1bb772a@kernel.org>
Date:   Mon, 15 May 2023 14:01:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230515123524.74e7bda3@canb.auug.org.au>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230515123524.74e7bda3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 15/05/2023 05:35, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/dwc3/gadget.c
> 
> between commit:
> 
>   c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
> 
> from the usb.current tree and commit:
> 
>   813f44d57e19 ("usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens")
> 
> from the usb tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 

> diff --cc drivers/usb/dwc3/gadget.c
> index d831f5acf7b5,5965796bc5d5..000000000000
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@@ -2700,21 -2699,6 +2700,26 @@@ static int dwc3_gadget_soft_disconnect(
>   	return ret;
>   }
>   
>  +static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
>  +{
> ++	int	ret;
> ++
>  +	/*
>  +	 * In the Synopsys DWC_usb31 1.90a programming guide section
>  +	 * 4.1.9, it specifies that for a reconnect after a
>  +	 * device-initiated disconnect requires a core soft reset
>  +	 * (DCTL.CSftRst) before enabling the run/stop bit.
>  +	 */
>  +	dwc3_core_soft_reset(dwc);

Please drop above call to dwc3_core_soft_reset().

> ++	ret = dwc3_core_soft_reset(dwc);
> ++	if (ret)
> ++		return ret;
>  +
>  +	dwc3_event_buffers_setup(dwc);
>  +	__dwc3_gadget_start(dwc);
>  +	return dwc3_gadget_run_stop(dwc, true);
>  +}
>  +
>   static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>   {
>   	struct dwc3		*dwc = gadget_to_dwc(g);

-- 
cheers,
-roger
