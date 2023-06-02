Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4169071FA58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjFBGsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjFBGsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:48:24 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E1132;
        Thu,  1 Jun 2023 23:48:23 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso24636201fa.1;
        Thu, 01 Jun 2023 23:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685688501; x=1688280501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJgPRCEge+y0sH530mHviwEHMEfuAv7uh+7KOo6SWIE=;
        b=bZULG3Dkx7KjgNIdDI6km2un7pSxd2DjJS0P5axCrmCCEq77b4OTkM4d+SFxDt05Ya
         2vRihT71Ph5Qbz9vsUDbVSW7MX6OBkq0tvY4oDIMwBfGVDAYhsvcZN7E83aU1YFPWG0q
         MjmJYdr6JgRI9uDzCSWabNnwUtNmf9QDtvg8QuNiZCHrt8hX7S7bJTnHc0NhyvBhU1HE
         Rl0McKznxUS30FfzgETJm5b0aVhh5+XPDKXPRgcUJU3XUZIfi7wpdJEHAndiWoJ+r/kg
         j6NkH8b97nJHyOrqH/yjSBPhvjUdbBAoKtpnhN9YVzd+Jw3Z68HFW3iPIqPbWxDfgawy
         rJ8w==
X-Gm-Message-State: AC+VfDw8c+5JpMalAnEVj0XMTCmrf0Q8Z4x1mVHoDZO1eIgrJJtSVG9v
        4+SRruBxwk6UpTM2//U89n3iEcgIWtg=
X-Google-Smtp-Source: ACHHUZ4JJNqePhxmhh/lzks+zMUV9SInZerYo+3Br5McbzQ0AM0bWBVCMGxJnskqs+AHhVmcuTzafw==
X-Received: by 2002:a2e:a317:0:b0:2ab:16a6:b330 with SMTP id l23-20020a2ea317000000b002ab16a6b330mr892773lje.51.1685688501150;
        Thu, 01 Jun 2023 23:48:21 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id x26-20020aa7cd9a000000b005149461b1e0sm318751edv.25.2023.06.01.23.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 23:48:20 -0700 (PDT)
Message-ID: <ca22d4ad-fd07-2733-a4c4-e6ed9c5ebe3f@kernel.org>
Date:   Fri, 2 Jun 2023 08:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] serial: core: Fix error handling for
 serial_core_ctrl_device_add()
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230602064104.41508-1-tony@atomide.com>
 <20230602064652.GF14287@atomide.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230602064652.GF14287@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 06. 23, 8:46, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [230602 06:41]:
>> Checking for NULL is not enough as serial_base_ctrl_add() uses ERR_PTR().
>>
>> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>   drivers/tty/serial/serial_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3342,7 +3342,7 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>>   	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
>>   	if (!ctrl_dev) {
>>   		new_ctrl_dev = serial_core_ctrl_device_add(port);
>> -		if (!new_ctrl_dev) {
>> +		if (IS_ERR_OR_NULL(new_ctrl_dev)) {
>>   			ret = -ENODEV;
>>   			goto err_unlock;
>>   		}
> 
> Hmm actually we should also change to use ret = PTR_ERR(new_ctrl_dev) here
> instead of translating all the errors to -ENODEV. Will send out v2 version.

Why OR_NULL at all, actually?

-- 
js
suse labs

