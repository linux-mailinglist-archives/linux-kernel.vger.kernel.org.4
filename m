Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE992635C40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiKWLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiKWLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:55:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA5C65;
        Wed, 23 Nov 2022 03:55:18 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36AA56601615;
        Wed, 23 Nov 2022 11:55:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669204517;
        bh=wGEZtLTeZPeK0VlHGG0r8cTHtzmBHhRkskvyyEeF8Ik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hbEH8JPT7PilLf2DAVVEVDOMKY08CG2aj951mgFAevRLQApr3rlh2xn7nCBMYWwEb
         GlBpQQi82dNvjaUV+DHfRAf0mMKugmhP9G8B7Z6SSI+lUqSjx87IvWPFSjsxXsgOeG
         tb99bjnnk+A1j/v7C2KgHbPikf6doE1/xh76PhSAj7CUngdl2KOMgDyUheuWmgqSKQ
         EcQqyPXfncm5dtBnvONUAv/YwkhK28cxKea0c3Rhq25A93l9l0xIS4HEqVjh6JBo64
         VaG+PEKMB5G2fjW2mCWfs3PLdxLcrTXpsjQdDu5YJjzULYJGtDJlRcbkpdh7ymfyD6
         2Om42pvxy4n/g==
Message-ID: <dcd180f6-7769-3bc5-403f-8960e922bb50@collabora.com>
Date:   Wed, 23 Nov 2022 12:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] usb: gadget: f_hid: fix refcount leak on error path
Content-Language: en-US
To:     John Keeping <john@metanate.com>, linux-usb@vger.kernel.org
Cc:     Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20221122123523.3068034-1-john@metanate.com>
 <20221122123523.3068034-3-john@metanate.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20221122123523.3068034-3-john@metanate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 22.11.2022 o 13:35, John Keeping pisze:
> When failing to allocate report_desc, opts->refcnt has already been
> incremented so it needs to be decremented to avoid leaving the options
> structure permanently locked.
> 
> Fixes: 21a9476a7ba8 ("usb: gadget: hid: add configfs support")
> Signed-off-by: John Keeping <john@metanate.com>

I'd personally place the bugfix before patches 1 and 3, but anyway

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/usb/gadget/function/f_hid.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 8b8bbeaa27cb..6be6009f911e 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -1292,6 +1292,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>   						 GFP_KERNEL);
>   		if (!hidg->report_desc) {
>   			put_device(&hidg->dev);
> +			--opts->refcnt;
>   			mutex_unlock(&opts->lock);
>   			return ERR_PTR(-ENOMEM);
>   		}

