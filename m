Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FBE747CEB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGEGUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGEGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A810EA;
        Tue,  4 Jul 2023 23:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED01612A8;
        Wed,  5 Jul 2023 06:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8C4C433C8;
        Wed,  5 Jul 2023 06:19:55 +0000 (UTC)
Message-ID: <1c74c932-83a1-6b9a-c799-347b25c1979b@xs4all.nl>
Date:   Wed, 5 Jul 2023 08:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] drivers: usb: remove duplicate logical judgments in if
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:GO7007 MPEG CODEC" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230704104017.9535-1-duminjie@vivo.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230704104017.9535-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minjie,

On 04/07/2023 12:40, Minjie Du wrote:
> Fix: delate duplicate judgments
> Does the judgment content of this if
> mean requesting confirmation twice?
> I'm not sure, Could you help check it out?
> Thank you!

From what I can tell it tries to send the reset request a
second time if the first attempt fails. Fair enough.

So let's leave this as-is.

Regards,

	Hans

> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/media/usb/go7007/go7007-usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/go7007/go7007-usb.c b/drivers/media/usb/go7007/go7007-usb.c
> index eeb85981e..c85e48e16 100644
> --- a/drivers/media/usb/go7007/go7007-usb.c
> +++ b/drivers/media/usb/go7007/go7007-usb.c
> @@ -653,8 +653,7 @@ static int go7007_usb_interface_reset(struct go7007 *go)
>  	if (usb->board->flags & GO7007_USB_EZUSB) {
>  		/* Reset buffer in EZ-USB */
>  		pr_debug("resetting EZ-USB buffers\n");
> -		if (go7007_usb_vendor_request(go, 0x10, 0, 0, NULL, 0, 0) < 0 ||
> -		    go7007_usb_vendor_request(go, 0x10, 0, 0, NULL, 0, 0) < 0)
> +		if (go7007_usb_vendor_request(go, 0x10, 0, 0, NULL, 0, 0) < 0)
>  			return -1;
>  
>  		/* Reset encoder again */

