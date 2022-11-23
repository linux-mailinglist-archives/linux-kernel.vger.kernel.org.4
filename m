Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EBA635CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiKWMU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiKWMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:20:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5EA4045F;
        Wed, 23 Nov 2022 04:20:33 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EE036602A65;
        Wed, 23 Nov 2022 12:20:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669206032;
        bh=xP85nZjJHeSWB0ks9fmx9lnm5pE0xL9ipm/l/npIRW8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VGVWuWN30FM4L26bSIFixrSTGhByEwryghKrzb/gYh4L76dfkZRUc7WOVMhY2a+UH
         1+VFLhkcCHNhGxCG4+okrkxi/uGPha1EyJeN0qXqWeeOmN+pI0U23pDEPkd8wbiDFn
         8rNJZtUkptsiLbBHtScO8AG3D4aeOXfTbsUVAsQDU8EJhKJhKIJKUfML0lIgfnYfiJ
         NhSMB9H5jEva1yxReCUpmUmxKnKGZ8bnD3xfTCbAXK6SnQSDjQs7VnCWqLJvg7lx7z
         j/EAv9zVq5rndtqIwO3Tn7Xi6x8FDKGYHsMoVv/oJ5l9NXMfoNXbKKkfrkvDJfSy7I
         rpDBM3exu7T3w==
Message-ID: <8f51f89e-ff27-1131-0d84-84f7821a8cdf@collabora.com>
Date:   Wed, 23 Nov 2022 13:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
Content-Language: en-US
To:     John Keeping <john@metanate.com>
Cc:     linux-usb@vger.kernel.org,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20221122123523.3068034-1-john@metanate.com>
 <20221122123523.3068034-2-john@metanate.com>
 <723bd024-121d-dd89-7c39-315e93e49c44@collabora.com>
 <Y34MHCPs1kDObB9m@donbot>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <Y34MHCPs1kDObB9m@donbot>
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

W dniu 23.11.2022 o 13:03, John Keeping pisze:
> On Wed, Nov 23, 2022 at 12:52:24PM +0100, Andrzej Pietrasiewicz wrote:
>> Hi John,
>>
>> W dniu 22.11.2022 o 13:35, John Keeping pisze:
>>> The embedded struct cdev does not have its lifetime correctly tied to
>>> the enclosing struct f_hidg, so there is a use-after-free if /dev/hidgN
>>> is held open while the gadget is deleted.
>>>
>>> This can readily be replicated with libusbgx's example programs (for
>>> conciseness - operating directly via configfs is equivalent):
>>>
>>> 	gadget-hid
>>> 	exec 3<> /dev/hidg0
>>> 	gadget-vid-pid-remove
>>> 	exec 3<&-
>>>
>>> Pull the existing device up in to struct f_hidg and make use of the
>>> cdev_device_{add,del}() helpers.  This changes the lifetime of the
>>> device object to match struct f_hidg, but note that it is still added
>>> and deleted at the same time.
>>>
>>> Fixes: 71adf1189469 ("USB: gadget: add HID gadget driver")
>>> Signed-off-by: John Keeping <john@metanate.com>
>>> ---
>>>    drivers/usb/gadget/function/f_hid.c | 52 ++++++++++++++++-------------
>>>    1 file changed, 28 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
>>> index ca0a7d9eaa34..8b8bbeaa27cb 100644
>>> --- a/drivers/usb/gadget/function/f_hid.c
>>> +++ b/drivers/usb/gadget/function/f_hid.c
>>> @@ -71,7 +71,7 @@ struct f_hidg {
>>>    	wait_queue_head_t		write_queue;
>>>    	struct usb_request		*req;
>>> -	int				minor;
>>> +	struct device			dev;
>>>    	struct cdev			cdev;
>>>    	struct usb_function		func;
>>> @@ -84,6 +84,14 @@ static inline struct f_hidg *func_to_hidg(struct usb_function *f)
>>>    	return container_of(f, struct f_hidg, func);
>>>    }
>>> +static void hidg_release(struct device *dev)
>>> +{
>>> +	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
>>> +
>>> +	kfree(hidg->set_report_buf);
>>> +	kfree(hidg);
>>> +}
>>> +
>>
>> I assume the above is supposed to free the hidg memory as a result of
>> put_device() and you free two things here ...
>>
>>>    /*-------------------------------------------------------------------------*/
>>>    /*                           Static descriptors                            */
>>> @@ -904,9 +912,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
>>>    	struct usb_ep		*ep;
>>>    	struct f_hidg		*hidg = func_to_hidg(f);
>>>    	struct usb_string	*us;
>>> -	struct device		*device;
>>>    	int			status;
>>> -	dev_t			dev;
>>>    	/* maybe allocate device-global string IDs, and patch descriptors */
>>>    	us = usb_gstrings_attach(c->cdev, ct_func_strings,
>>> @@ -999,21 +1005,11 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
>>>    	/* create char device */
>>>    	cdev_init(&hidg->cdev, &f_hidg_fops);
>>> -	dev = MKDEV(major, hidg->minor);
>>> -	status = cdev_add(&hidg->cdev, dev, 1);
>>> +	status = cdev_device_add(&hidg->cdev, &hidg->dev);
>>>    	if (status)
>>>    		goto fail_free_descs;
>>> -	device = device_create(hidg_class, NULL, dev, NULL,
>>> -			       "%s%d", "hidg", hidg->minor);
>>> -	if (IS_ERR(device)) {
>>> -		status = PTR_ERR(device);
>>> -		goto del;
>>> -	}
>>> -
>>>    	return 0;
>>> -del:
>>> -	cdev_del(&hidg->cdev);
>>>    fail_free_descs:
>>>    	usb_free_all_descriptors(f);
>>>    fail:
>>> @@ -1244,9 +1240,7 @@ static void hidg_free(struct usb_function *f)
>>>    	hidg = func_to_hidg(f);
>>>    	opts = container_of(f->fi, struct f_hid_opts, func_inst);
>>> -	kfree(hidg->report_desc);
>>> -	kfree(hidg->set_report_buf);
>>> -	kfree(hidg);
>>
>> ... while here 3 things used to be freed. What happens to hidg->report_desc?
> 
> This switched to devm to simplify error handling in hidg_alloc().

Ah, right!

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

